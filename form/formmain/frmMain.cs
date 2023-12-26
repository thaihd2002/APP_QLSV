using DocumentFormat.OpenXml.Wordprocessing;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace QuanLySinhVienCshape
{
    public partial class frmMain : Form
    {
        int panelWidth;
        bool Hidden;
        private string tendangnhap;
        private string loaitk;
        public frmMain(string tendangnhap, string loaitk)
        {
            InitializeComponent();
            panelWidth = panelLeft.Width;
            Hidden = false;
            UpdateTime();
            // Sử dụng một Timer để cập nhật thời gian mỗi giây
            Timer timer = new Timer();
            timer.Interval = 1000; // Đặt khoảng thời gian giữa các lần cập nhật (1 giây trong trường hợp này)
            timer.Tick += Timer_Tick;
            timer.Start();
            this.tendangnhap = tendangnhap;
            this.loaitk = loaitk;
         
        }
        private void Timer_Tick(object sender, EventArgs e)
        {
            // Gọi hàm cập nhật thời gian mỗi lần Timer tick
            UpdateTime();
        }
        private void UpdateTime()
        {
            // Lấy thời gian hiện tại
            DateTime currentTime = DateTime.Now;

            // Hiển thị thời gian trong Label
            lblTime.Text = currentTime.ToString("HH:mm:ss");
        }
        private void frmMain_Load(object sender, EventArgs e)
        {
            string tenNguoiDung = GetTenNguoiDung(tendangnhap);
            lblUserName.Text = tenNguoiDung;
            SetStyle(ControlStyles.DoubleBuffer | ControlStyles.AllPaintingInWmPaint | ControlStyles.UserPaint, true);
            UpdateStyles();
           
            // Phân quyền dựa trên loại tài khoản
            switch (loaitk)
            {
                case "admin":
                    // Code cho tài khoản admin
                    lblUserName.Text = "Admin";
                    lblRole.Text = "Admin";
                    break;

                case "pdt":
                    // Code cho tài khoản phòng đào tạo
                    MessageBox.Show("Đây là phòng đào tạo");
                    lblRole.Text = "Phòng đào tạo";
                    break;

                case "gv":
                    lblRole.Text = "Phòng đào tạo";
                    // Code cho tài khoản giáo viên
                    lblRole.Text = "Giáo viên";
                    break;

                case "sv":
                    // Code cho tài khoản sinh viên
                    lblRole.Text = "Sinh viên";
                    break;

                default:
                    // Xử lý trường hợp khác nếu có
                    break;
            }
            frmWelcome f = new frmWelcome();
            AddForm(f);
            
        }
        private string GetTenNguoiDung(string tendangnhap)
        {
            List<CustomParameter> parameters = new List<CustomParameter>()
    {
        new CustomParameter()
        {
            key = "@tendangnhap",
            value = tendangnhap
        }
    };

            try
            {
                var result = new Database().SelectData("GetTenDangNhap", parameters);
                if (result.Rows.Count > 0)
                {
                    // Lấy giá trị từ cột "TenNguoiDung"
                    return result.Rows[0]["hoten"].ToString();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Lỗi khi lấy tên từ cơ sở dữ liệu.\n" + ex.Message, "Lỗi");
            }

            // Trong trường hợp lỗi hoặc không tìm thấy tên
            return string.Empty;
        }
        private void AddForm(Form f)
        {
            this.pnlContent.Controls.Clear(); 
            f.TopLevel = false;
            f.AutoScroll = true;
            f.FormBorderStyle = FormBorderStyle.None;
            f.Dock = DockStyle.Fill;
            this.Text = f.Text;
            this.pnlContent.Controls.Add(f);
            f.Show();
        }
        private void slidePanel(Button btn)
        {
            panelSide.Height = btn.Height;
            panelSide.Top = btn.Top;
        }
        private void btnthoat_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private void timer1_Tick(object sender, EventArgs e)
        {
            int stepSize = 20;

            if (Hidden)
            {
                int newWidth = Math.Min(panelLeft.Width + stepSize, panelWidth);
                if (newWidth != panelLeft.Width)
                {
                    panelLeft.Width = newWidth;
                }
                else
                {
                    timer1.Stop();
                    Hidden = false;
                }
            }
            else
            {
                int newWidth = Math.Max(panelLeft.Width - stepSize, 55);
                if (newWidth != panelLeft.Width)
                {
                    panelLeft.Width = newWidth;
                }
                else
                {
                    timer1.Stop();
                    Hidden = true;
                }
            }

            this.Refresh(); // Gọi Refresh ở cuối cùng
        }

        private void btnSinhvien_Click(object sender, EventArgs e)
        {
            slidePanel(btnSinhvien);
            var fn = new frmDSSV();
            AddForm(fn);
        }

        private void btnGiaovien_Click(object sender, EventArgs e)
        {
            slidePanel(btnGiaovien);
            var fn = new frmDSGV();
            AddForm(fn);
        }

        private void btnSettings_Click(object sender, EventArgs e)
        {
            this.Dispose();
            var fn = new frmDangnhap();
            fn.ShowDialog();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            timer1.Start();
        }

        private void panel2_Paint(object sender, PaintEventArgs e)
        {

        }

        private void btnTrangchu_Click(object sender, EventArgs e)
        {
            var fn = new frmWelcome();
            AddForm(fn);
        }

        private void btnLophoc_Click(object sender, EventArgs e)
        {
            var fn = new frmDsLopHoc();
            AddForm(fn);
        }

        private void btnLophocphan_Click(object sender, EventArgs e)
        {
            var fn = new frmDsLopHocPhan();
            AddForm(fn);
        }

        private void btnMonhoc_Click(object sender, EventArgs e)
        {
            var fn = new frmDSMH_();
            AddForm(fn);
        }

        private void btnDiem_Click(object sender, EventArgs e)
        {
            var fn = new frmDsDiem();
            AddForm(fn);
        }

        private void btnDiemtb_Click(object sender, EventArgs e)
        {
            var fn = new frmDsDiemTB();
            AddForm(fn);
        }

        private void btnHocbong_Click(object sender, EventArgs e)
        {
            var fn = new frmDsHocBong();
            AddForm(fn);
        }
    }
}
