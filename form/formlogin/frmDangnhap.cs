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
    public partial class frmDangnhap : Form
    {
        public frmDangnhap()
        {
            InitializeComponent();
    
        }
        public string tendangnhap = "";
        public string loaitk;
        private void btnThoat_Click(object sender, EventArgs e)
        {
            this.Close();
        }
        private string DetermineAccountType(string tendangnhap)
        {
            // Thực hiện xác định loại tài khoản dựa trên tên đăng nhập
            // Sử dụng StringComparison.OrdinalIgnoreCase để so sánh không phân biệt chữ hoa/chữ thường
            if (tendangnhap.StartsWith("admin", StringComparison.OrdinalIgnoreCase))
            {
                return "admin";
            }
            else if (tendangnhap.StartsWith("pdt", StringComparison.OrdinalIgnoreCase))
            {
                return "pdt";
            }
            else if (tendangnhap.StartsWith("gv", StringComparison.OrdinalIgnoreCase))
            {
                return "gv";
            }
            else
            {
                return "sv";
            }
        }
        private void frmDangnhap_Load(object sender, EventArgs e)
        {
            this.BeginInvoke(new Action(() =>
            {
                txtTendangnhap.Focus();
            }));
            this.KeyPreview = true;
            this.KeyDown += frmDangnhap_KeyDown;
        }
        private void btnLogin_Click(object sender, EventArgs e)
        {
            #region ktra_rbuoc
            //kiểm tra ràng buộc
            if (string.IsNullOrEmpty(txtTendangnhap.Text))
            {
                MessageBox.Show("Vui lòng nhập tài khoản", "Tài khoản không được để trống");
                txtTendangnhap.Select();
                return;
            }

            if (string.IsNullOrEmpty(txtMatkhau.Text))
            {
                MessageBox.Show("Vui lòng nhập mật khẩu", "Mật khẩu không thể để trống");
                return;
            }
            #endregion

            tendangnhap = txtTendangnhap.Text;

            string loaitk = DetermineAccountType(tendangnhap);

            if (string.IsNullOrEmpty(loaitk))
            {
                MessageBox.Show("Tài khoản không hợp lệ", "Lỗi đăng nhập");
                return;
            }

            List<CustomParameter> lst = new List<CustomParameter>()
    {
        new CustomParameter()
        {
            key = "@loaitaikhoan",
            value = loaitk
        },
        new CustomParameter()
        {
            key = "@taikhoan",
            value = txtTendangnhap.Text
        },
        new CustomParameter()
        {
            key = "@matkhau",
            value = txtMatkhau.Text
        },
    };
            try
            {
                var rs = new Database().SelectData("dangnhap", lst);
                if (rs.Rows.Count >= 0)
                {
                    // Tạo instance của frmMain và truyền dữ liệu đăng nhập
                    var frmMain = new frmMain(tendangnhap, loaitk);
                    // Ẩn frmDangnhap
                    this.Hide();
                    // Hiển thị frmMain
                    frmMain.ShowDialog();
                }
                else
                {
                    MessageBox.Show("Vui lòng kiểm tra lại tên đăng nhập hoặc mật khẩu", "Tài khoản hoặc mật khẩu không hợp lệ");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Lỗi khi thực hiện đăng nhập.\n" + ex.Message, "Lỗi đăng nhập");
            }
        }

        private void frmDangnhap_KeyDown(object sender, KeyEventArgs e)
        {
            // Kiểm tra xem phím Enter đã được nhấn hay không
            if (e.KeyCode == Keys.Enter)
            {
                // Gọi hàm xử lý khi nhấn Enter
                btnLogin_Click(sender, e);
            }
        }

        private void btnthoat_Click_1(object sender, EventArgs e)
        {
            Application.Exit();
        }
    }
}
