using Android.Widget;
using Android.OS;
using Android.Content;
using Android.Views;
using Android.Graphics;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Threading;
using System.Net.NetworkInformation;
using System.Net.Sockets;

namespace AndroidApp1
{
    [Activity(Label = "@string/app_name", MainLauncher = true)]
    public class MainActivity : Activity
    {
        private const string PREF_NAME = "ESP8266_control";
        private const string PREF_KEY_ADDR = "server_address";

        private TextView tvPosition;
        private TextView tvStatus;
        private TextView tvLog;
        private LinearLayout logPanel;
        private SeekBar sbServo;
        private EditText etServerAddress;
        private Button btnConnect;
        private Button btnSend;
        private EditText etManual;
        private Button btn0, btn45, btn90, btn135, btn180;
        private HttpClient httpClient;
        private string serverAddress = "";

        // SeekBar 防抖
        private CancellationTokenSource? debounceCts;

        protected override void OnCreate(Bundle? savedInstanceState)
        {
            base.OnCreate(savedInstanceState);

            SetContentView(Resource.Layout.activity_main);

            // 初始化UI组件
            tvPosition = FindViewById<TextView>(Resource.Id.tvPosition);
            tvStatus = FindViewById<TextView>(Resource.Id.tvStatus);
            tvLog = FindViewById<TextView>(Resource.Id.tvLog);
            logPanel = FindViewById<LinearLayout>(Resource.Id.logPanel);
            sbServo = FindViewById<SeekBar>(Resource.Id.sbServo);
            etServerAddress = FindViewById<EditText>(Resource.Id.etServerAddress);
            btnConnect = FindViewById<Button>(Resource.Id.btnConnect);
            btnSend = FindViewById<Button>(Resource.Id.btnSend);
            etManual = FindViewById<EditText>(Resource.Id.etManual);
            btn0 = FindViewById<Button>(Resource.Id.btn0);
            btn45 = FindViewById<Button>(Resource.Id.btn45);
            btn90 = FindViewById<Button>(Resource.Id.btn90);
            btn135 = FindViewById<Button>(Resource.Id.btn135);
            btn180 = FindViewById<Button>(Resource.Id.btn180);

            httpClient = new HttpClient();

            // 注册事件
            btnConnect.Click += BtnConnect_Click;
            sbServo.ProgressChanged += SbServo_ProgressChanged;
            btnSend.Click += BtnSend_Click;
            btn0.Click += (sender, e) => MoveServo(0);
            btn45.Click += (sender, e) => MoveServo(45);
            btn90.Click += (sender, e) => MoveServo(90);
            btn135.Click += (sender, e) => MoveServo(135);
            btn180.Click += (sender, e) => MoveServo(180);

            // 启动时自动发现并连接ESP8266
            AutoSetupAsync();
        }

        // ============================================================
        // 自动发现：第一次自动扫描，之后直接使用已保存IP
        // ============================================================

        private async void AutoSetupAsync()
        {
            // 1) 优先尝试已保存的IP（最快路径）
            var prefs = GetSharedPreferences(PREF_NAME, FileCreationMode.Private);
            string saved = prefs.GetString(PREF_KEY_ADDR, "");
            LogMessage($"Saved IP: {saved}");

            if (!string.IsNullOrEmpty(saved))
            {
                btnConnect.Text = "Testing...";
                LogMessage($"Testing saved IP: {saved}");
                if (await QuickTestAsync(saved))
                {
                    LogMessage($"Connected: {saved}");
                    ApplyAddress(saved);
                    await SyncPositionAsync();
                    return;
                }
                LogMessage($"Saved IP unreachable, scanning...");
            }

            // 2) 没有已保存IP或已失效 → 扫描局域网
            SetStatus(false);
            tvPosition.Text = "Scan...";
            btnConnect.Text = "Scan";
            btnConnect.Enabled = false;
            logPanel.Visibility = ViewStates.Visible;
            tvLog.Text = "";  // 清空上次日志

            string? found = await DiscoverServoAsync();

            btnConnect.Enabled = true;

            if (found != null)
            {
                LogMessage($"Auto-connected: {found}");
                prefs.Edit().PutString(PREF_KEY_ADDR, found).Apply();
                ApplyAddress(found);
                await SyncPositionAsync();
                Toast.MakeText(this, $"Auto-connected: {found}", ToastLength.Short).Show();
            }
            else
            {
                tvPosition.Text = "--°";
                btnConnect.Text = "Set";
                SetStatus(false);
                LogMessage("Scan failed — enter IP manually");
                Toast.MakeText(this, "Cannot find ESP8266, enter IP manually", ToastLength.Long).Show();
            }
        }

        /// <summary>快速测试已保存IP是否仍然有效</summary>
        private async Task<bool> QuickTestAsync(string ip)
        {
            try
            {
                using var cts = new CancellationTokenSource(1500);
                using var response = await httpClient.GetAsync($"http://{ip}/", cts.Token);
                return response.IsSuccessStatusCode;
            }
            catch { return false; }
        }

        /// <summary>扫描局域网，寻找ESP8266设备</summary>
        private async Task<string?> DiscoverServoAsync()
        {
            string? subnet = GetLocalSubnet();
            if (subnet == null)
            {
                // 无法自动检测子网，试常见网段
                return await TryCommonSubnetsAsync();
            }

            return await ScanSubnetAsync(subnet);
        }

        /// <summary>通过 .NET API 获取手机本地IP，推断子网</summary>
        private string? GetLocalSubnet()
        {
            try
            {
                foreach (var ni in NetworkInterface.GetAllNetworkInterfaces())
                {
                    if (ni.OperationalStatus != OperationalStatus.Up) continue;
                    if (ni.NetworkInterfaceType == NetworkInterfaceType.Loopback) continue;

                    foreach (var addr in ni.GetIPProperties().UnicastAddresses)
                    {
                        if (addr.Address.AddressFamily == AddressFamily.InterNetwork &&
                            !IPAddress.IsLoopback(addr.Address))
                        {
                            string ip = addr.Address.ToString();
                            int dot = ip.LastIndexOf('.');
                            if (dot > 0) return ip.Substring(0, dot);
                        }
                    }
                }
            }
            catch { }
            return null;
        }

        /// <summary>扫描指定子网的所有254个地址</summary>
        private async Task<string?> ScanSubnetAsync(string subnet)
        {
            LogMessage($"Scanning {subnet}.x ...");

            using var cts = new CancellationTokenSource();
            var tasks = new List<Task<string?>>();
            int completedCount = 0;

            for (int i = 1; i <= 254; i++)
            {
                string ip = $"{subnet}.{i}";
                tasks.Add(TryConnectAsync(ip, cts.Token));
            }

            // 逐批等待，找到第一个就取消其余
            while (tasks.Count > 0)
            {
                var completed = await Task.WhenAny(tasks);
                tasks.Remove(completed);

                string? result = await completed;
                completedCount++;

                // 每20个IP报告一次进度
                if (completedCount % 20 == 0)
                {
                    LogMessage($"  {subnet}.x {completedCount}/254");
                }

                if (result != null)
                {
                    LogMessage($"  Found: {result}");
                    cts.Cancel();   // 通知其余请求立即放弃
                    return result;
                }
            }

            LogMessage($"  No device found");
            return null;
        }

        /// <summary>尝试连接单个IP，判断是否为ESP8266舵机服务器</summary>
        private async Task<string?> TryConnectAsync(string ip, CancellationToken ct)
        {
            try
            {
                // 每个IP单独超时300ms，同时受外部ct控制
                using var timeout = new CancellationTokenSource(300);
                using var linked = CancellationTokenSource.CreateLinkedTokenSource(ct, timeout.Token);

                // 请求 /get 端点，返回有效角度即视为找到设备
                using var response = await httpClient.GetAsync($"http://{ip}/get", linked.Token);
                if (!response.IsSuccessStatusCode) return null;

                string body = (await response.Content.ReadAsStringAsync()).Trim();
                if (int.TryParse(body, out int angle) && angle >= 0 && angle <= 180)
                    return ip;
            }
            catch { }

            return null;
        }

        /// <summary>无法检测子网时的后备方案：尝试常用网段</summary>
        private async Task<string?> TryCommonSubnetsAsync()
        {
            LogMessage("Cannot detect subnet, trying common ranges...");
            string[] commonSubnets = { "192.168.1", "192.168.0", "192.168.31", "10.0.0" };
            foreach (var subnet in commonSubnets)
            {
                string? result = await ScanSubnetAsync(subnet);
                if (result != null) return result;
            }
            return null;
        }

        // ============================================================
        // IP地址管理
        // ============================================================

        private void SetStatus(bool connected, string? statusText = null)
        {
            if (connected)
            {
                tvStatus.Text = "●";
                tvStatus.SetTextColor(Color.ParseColor("#4CAF50")); // 绿色
            }
            else
            {
                tvStatus.Text = "○";
                tvStatus.SetTextColor(Color.ParseColor("#999999")); // 灰色
            }
        }

        /// <summary>向底部日志追加一行</summary>
        private void LogMessage(string msg)
        {
            string timestamp = DateTime.Now.ToString("HH:mm:ss");
            if (tvLog.Text == "")
                tvLog.Text = $"[{timestamp}] {msg}";
            else
                tvLog.Text += $"\n[{timestamp}] {msg}";
        }

        /// <summary>从 ESP8266 回读当前角度，同步到滑块和显示</summary>
        private async Task SyncPositionAsync()
        {
            try
            {
                using var cts = new CancellationTokenSource(2000);
                using var response = await httpClient.GetAsync($"http://{serverAddress}/get", cts.Token);

                if (response.IsSuccessStatusCode)
                {
                    string body = (await response.Content.ReadAsStringAsync()).Trim();
                    if (int.TryParse(body, out int angle) && angle >= 0 && angle <= 180)
                    {
                        tvPosition.Text = $"{angle}°";
                        sbServo.Progress = angle;
                        etManual.Text = angle.ToString();
                    }
                }
            }
            catch { }
        }

        private void ApplyAddress(string addr)
        {
            serverAddress = addr;
            etServerAddress.Text = addr;
            btnConnect.Text = "OK ✓";
            btnConnect.Background?.SetColorFilter(
                Color.Green, PorterDuff.Mode.Multiply);
            SetStatus(true);
        }

        private async void BtnConnect_Click(object sender, System.EventArgs e)
        {
            string addr = etServerAddress.Text.Trim();
            if (string.IsNullOrEmpty(addr))
            {
                Toast.MakeText(this, "Please enter ESP8266 IP", ToastLength.Short).Show();
                return;
            }
            GetSharedPreferences(PREF_NAME, FileCreationMode.Private)
                .Edit().PutString(PREF_KEY_ADDR, addr).Apply();
            ApplyAddress(addr);
            await SyncPositionAsync();
        }

        // ============================================================
        // 舵机控制逻辑
        // ============================================================

        private async void SbServo_ProgressChanged(object sender, SeekBar.ProgressChangedEventArgs e)
        {
            if (!e.FromUser || string.IsNullOrEmpty(serverAddress)) return;

            tvPosition.Text = $"{e.Progress}°";

            debounceCts?.Cancel();
            debounceCts?.Dispose();
            debounceCts = new CancellationTokenSource();

            try
            {
                await Task.Delay(150, debounceCts.Token);
                await SendHttpAngle(e.Progress);
            }
            catch (TaskCanceledException) { }
        }

        private async void MoveServo(int angle)
        {
            if (string.IsNullOrEmpty(serverAddress))
            {
                Toast.MakeText(this, "Please set ESP8266 IP first", ToastLength.Short).Show();
                return;
            }

            tvPosition.Text = $"{angle}°";
            sbServo.Progress = angle;
            etManual.Text = angle.ToString();

            await SendHttpAngle(angle);
        }

        private async void BtnSend_Click(object sender, System.EventArgs e)
        {
            if (string.IsNullOrEmpty(serverAddress))
            {
                Toast.MakeText(this, "Please set ESP8266 IP first", ToastLength.Short).Show();
                return;
            }

            string text = etManual.Text.Trim();
            if (int.TryParse(text, out int angle) && angle >= 0 && angle <= 180)
            {
                tvPosition.Text = $"{angle}°";
                sbServo.Progress = angle;

                await SendHttpAngle(angle);
                etManual.Text = "";
            }
            else
            {
                Toast.MakeText(this, "Please enter valid angle (0-180)", ToastLength.Short).Show();
            }
        }

        private async Task SendHttpAngle(int angle)
        {
            try
            {
                string url = $"http://{serverAddress}/set?angle={angle}";
                using HttpResponseMessage response = await httpClient.GetAsync(url);

                if (!response.IsSuccessStatusCode)
                {
                    Toast.MakeText(this, $"HTTP {(int)response.StatusCode}", ToastLength.Short).Show();
                }
            }
            catch (HttpRequestException)
            {
                Toast.MakeText(this,
                    $"Cannot reach {serverAddress}\nCheck: ① Same WiFi? ② ESP powered?",
                    ToastLength.Long).Show();
            }
            catch (TaskCanceledException)
            {
                Toast.MakeText(this, $"Timeout: {serverAddress} no response", ToastLength.Short).Show();
            }
            catch (System.Exception ex)
            {
                Toast.MakeText(this, $"Error: {ex.Message}", ToastLength.Short).Show();
            }
        }
    }
}
