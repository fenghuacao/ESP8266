using Android.Widget;
using Android.OS;
using System.Net.Http;
using System.Threading.Tasks;
using System.Threading;
using Android.Views;

namespace AndroidApp1
{
    [Activity(Label = "@string/app_name", MainLauncher = true)]
    public class MainActivity : Activity
    {
        private TextView tvPosition;
        private SeekBar sbServo;
        private EditText etServerAddress;
        private Button btnConnect;
        private Button btnSend;
        private EditText etManual;
        private Button btn0, btn45, btn90, btn135, btn180;
        private HttpClient httpClient;
        private string serverAddress;

        // 连接状态标志
        private bool isConnected;

        // SeekBar 防抖：用户停止拖拽150ms后才发送请求
        private CancellationTokenSource? debounceCts;

        protected override void OnCreate(Bundle? savedInstanceState)
        {
            base.OnCreate(savedInstanceState);

            SetContentView(Resource.Layout.activity_main);

            // 初始化UI组件
            tvPosition = FindViewById<TextView>(Resource.Id.tvPosition);
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

            // 默认IP留空，加placeholder提示（原默认值192.168.4.1是AP模式IP，与Station模式不符）
            etServerAddress.Hint = "e.g. 192.168.1.100";

            // 初始化HttpClient
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
        }

        /// <summary>
        /// 连接/断开按钮
        /// </summary>
        private async void BtnConnect_Click(object sender, System.EventArgs e)
        {
            // 已连接状态 → 断开
            if (isConnected)
            {
                isConnected = false;
                serverAddress = "";
                btnConnect.Text = "Connect";
                btnConnect.Enabled = true;
                btnConnect.Background?.ClearColorFilter();
                tvPosition.Text = "Position: --°";
                return;
            }

            serverAddress = etServerAddress.Text.Trim();
            if (string.IsNullOrEmpty(serverAddress))
            {
                Toast.MakeText(this, "Please enter server address", ToastLength.Short).Show();
                return;
            }

            btnConnect.Text = "Connecting...";
            btnConnect.Enabled = false;

            try
            {
                using HttpResponseMessage response = await httpClient.GetAsync($"http://{serverAddress}/");

                if (response.IsSuccessStatusCode)
                {
                    isConnected = true;
                    btnConnect.Text = "Disconnect";
                    btnConnect.Enabled = true;
                    btnConnect.Background?.SetColorFilter(
                        Android.Graphics.Color.Green,
                        Android.Graphics.PorterDuff.Mode.Multiply);
                    tvPosition.Text = "Position: --°";
                    Toast.MakeText(this, "Connected successfully!", ToastLength.Short).Show();
                }
                else
                {
                    Toast.MakeText(this, "Connection failed", ToastLength.Short).Show();
                    btnConnect.Text = "Connect";
                    btnConnect.Enabled = true;
                }
            }
            catch (System.Exception ex)
            {
                Toast.MakeText(this, $"Connection error: {ex.Message}", ToastLength.Short).Show();
                btnConnect.Text = "Connect";
                btnConnect.Enabled = true;
            }
        }

        /// <summary>
        /// SeekBar拖拽事件 — 带150ms防抖
        /// </summary>
        private async void SbServo_ProgressChanged(object sender, SeekBar.ProgressChangedEventArgs e)
        {
            if (!e.FromUser || string.IsNullOrEmpty(serverAddress)) return;

            // 取消上一次未发出的请求（只保留最后一次）
            debounceCts?.Cancel();
            debounceCts?.Dispose();
            debounceCts = new CancellationTokenSource();

            try
            {
                // 等150ms，如果期间用户继续拖拽则被取消
                await Task.Delay(150, debounceCts.Token);
                await SetServoPosition(e.Progress);
            }
            catch (TaskCanceledException)
            {
                // 用户仍在拖拽，忽略本次触发
            }
        }

        /// <summary>
        /// 手动输入发送按钮
        /// </summary>
        private async void BtnSend_Click(object sender, System.EventArgs e)
        {
            if (string.IsNullOrEmpty(serverAddress))
            {
                Toast.MakeText(this, "Please connect to server first", ToastLength.Short).Show();
                return;
            }

            string text = etManual.Text.Trim();
            if (int.TryParse(text, out int angle) && angle >= 0 && angle <= 180)
            {
                bool success = await SetServoPosition(angle);
                if (success)
                {
                    sbServo.Progress = angle;
                    etManual.Text = "";
                }
            }
            else
            {
                Toast.MakeText(this, "Please enter valid angle (0-180)", ToastLength.Short).Show();
            }
        }

        /// <summary>
        /// 预设角度按钮（0° / 45° / 90° / 135° / 180°）
        /// </summary>
        private async void MoveServo(int angle)
        {
            if (string.IsNullOrEmpty(serverAddress))
            {
                Toast.MakeText(this, "Please connect to server first", ToastLength.Short).Show();
                return;
            }

            bool success = await SetServoPosition(angle);
            if (success)
            {
                sbServo.Progress = angle;
                etManual.Text = angle.ToString();
            }
        }

        /// <summary>
        /// 发送角度到ESP8266，返回是否成功
        /// </summary>
        private async Task<bool> SetServoPosition(int angle)
        {
            try
            {
                string url = $"http://{serverAddress}/set?angle={angle}";
                using HttpResponseMessage response = await httpClient.GetAsync(url);

                if (response.IsSuccessStatusCode)
                {
                    tvPosition.Text = $"Position: {angle}°";
                    return true;
                }
                else
                {
                    Toast.MakeText(this, "Failed to set position", ToastLength.Short).Show();
                    return false;
                }
            }
            catch (System.Exception ex)
            {
                Toast.MakeText(this, $"Error: {ex.Message}", ToastLength.Short).Show();
                return false;
            }
        }
    }
}
