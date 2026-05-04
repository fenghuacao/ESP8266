using Android.Widget;
using Android.OS;
using Android.Views;
using Android.Graphics;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Threading;

namespace AndroidApp1
{
    [Activity(Label = "@string/app_name", MainLauncher = true)]
    public class MainActivity : Activity
    {
        // ESP8266 AP模式固定IP（与固件一致）
        private const string SERVER_ADDRESS = "192.168.4.1";

        private TextView tvPosition;
        private TextView tvStatus;
        private TextView tvLog;
        private LinearLayout logPanel;
        private SeekBar sbServo;
        private Button btnSend;
        private EditText etManual;
        private Button btn0, btn45, btn90, btn135, btn180;
        private HttpClient httpClient;

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
            btnSend = FindViewById<Button>(Resource.Id.btnSend);
            etManual = FindViewById<EditText>(Resource.Id.etManual);
            btn0 = FindViewById<Button>(Resource.Id.btn0);
            btn45 = FindViewById<Button>(Resource.Id.btn45);
            btn90 = FindViewById<Button>(Resource.Id.btn90);
            btn135 = FindViewById<Button>(Resource.Id.btn135);
            btn180 = FindViewById<Button>(Resource.Id.btn180);

            httpClient = new HttpClient();

            // 注册事件
            sbServo.ProgressChanged += SbServo_ProgressChanged;
            btnSend.Click += BtnSend_Click;
            btn0.Click += (sender, e) => MoveServo(0);
            btn45.Click += (sender, e) => MoveServo(45);
            btn90.Click += (sender, e) => MoveServo(90);
            btn135.Click += (sender, e) => MoveServo(135);
            btn180.Click += (sender, e) => MoveServo(180);

            // 启动时自动连接ESP8266
            AutoConnectAsync();
        }

        // ============================================================
        // 自动连接（AP模式：IP固定为192.168.4.1）
        // ============================================================

        private async void AutoConnectAsync()
        {
            SetStatus(false);
            tvPosition.Text = "Connecting...";
            logPanel.Visibility = ViewStates.Visible;
            tvLog.Text = "";

            LogMessage($"Connecting to {SERVER_ADDRESS}...");

            // 快速测试连接
            bool ok = await QuickTestAsync();

            if (ok)
            {
                LogMessage($"Connected");
                SetStatus(true);
                tvPosition.Text = "--°";
                await SyncPositionAsync();
            }
            else
            {
                LogMessage($"Failed — check WiFi connection");
                tvPosition.Text = "--°";
                Toast.MakeText(this,
                    $"Cannot reach ESP8266\nConnect to WiFi: ESP8266-Servo",
                    ToastLength.Long).Show();
            }
        }

        private async Task<bool> QuickTestAsync()
        {
            try
            {
                using var cts = new CancellationTokenSource(3000);
                using var response = await httpClient.GetAsync($"http://{SERVER_ADDRESS}/get", cts.Token);
                return response.IsSuccessStatusCode;
            }
            catch { return false; }
        }

        // ============================================================
        // 舵机控制逻辑
        // ============================================================

        private async void SbServo_ProgressChanged(object sender, SeekBar.ProgressChangedEventArgs e)
        {
            if (!e.FromUser) return;

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
            tvPosition.Text = $"{angle}°";
            sbServo.Progress = angle;
            etManual.Text = angle.ToString();

            await SendHttpAngle(angle);
        }

        private async void BtnSend_Click(object sender, System.EventArgs e)
        {
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
                string url = $"http://{SERVER_ADDRESS}/set?angle={angle}";
                using HttpResponseMessage response = await httpClient.GetAsync(url);

                if (!response.IsSuccessStatusCode)
                {
                    Toast.MakeText(this, $"HTTP {(int)response.StatusCode}", ToastLength.Short).Show();
                }
            }
            catch (HttpRequestException)
            {
                Toast.MakeText(this,
                    $"Cannot reach ESP8266\nCheck WiFi: ESP8266-Servo",
                    ToastLength.Long).Show();
            }
            catch (TaskCanceledException)
            {
                Toast.MakeText(this, $"Timeout: no response", ToastLength.Short).Show();
            }
            catch (System.Exception ex)
            {
                Toast.MakeText(this, $"Error: {ex.Message}", ToastLength.Short).Show();
            }
        }

        /// <summary>从ESP8266回读当前角度，同步到滑块和显示</summary>
        private async Task SyncPositionAsync()
        {
            try
            {
                using var cts = new CancellationTokenSource(2000);
                using var response = await httpClient.GetAsync($"http://{SERVER_ADDRESS}/get", cts.Token);

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

        // ============================================================
        // UI辅助方法
        // ============================================================

        private void SetStatus(bool connected)
        {
            if (connected)
            {
                tvStatus.Text = "●";
                tvStatus.SetTextColor(Color.ParseColor("#4CAF50"));
            }
            else
            {
                tvStatus.Text = "○";
                tvStatus.SetTextColor(Color.ParseColor("#999999"));
            }
        }

        private void LogMessage(string msg)
        {
            string timestamp = DateTime.Now.ToString("HH:mm:ss");
            if (tvLog.Text == "")
                tvLog.Text = $"[{timestamp}] {msg}";
            else
                tvLog.Text += $"\n[{timestamp}] {msg}";
        }
    }
}
