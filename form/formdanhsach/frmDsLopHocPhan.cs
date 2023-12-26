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
    public partial class frmDsLopHocPhan : Form
    {
        public frmDsLopHocPhan()
        {
            InitializeComponent();
        }
        private string malophoc = "";
        private Database db;   
        private string tukhoa = "";

        private void frmDsLopHocPhan_Load(object sender, EventArgs e)
        {
            this.grbNhapLHP.Enabled = false;
            this.BtnGhi.Enabled = false;
            this.BtnHuy.Enabled = false;
            dgvLopHocPhan.ClearSelection();
            loadDSLH();
            #region loadcbb
            db = new Database();
            List<CustomParameter> lst = new List<CustomParameter>()
            {
                new CustomParameter()
                {
                    key = "@tukhoa",
                    value=""
                }
            };
            //load dữ liệu cho  combobox  
            //danh sách khoa
            cbbdskhoa.DataSource = db.SelectData("allkhoa", lst);
            cbbdskhoa.DisplayMember = "tenkhoa";
            cbbdskhoa.ValueMember = "makhoa";
            cbbdskhoa.SelectedIndex = -1;
            //combobox Khoa
            cbbKhoa.DataSource = db.SelectData("allKhoa", lst);
            cbbKhoa.DisplayMember = "tenkhoa";//thuộc tính hiển thị của combobox
            cbbKhoa.ValueMember = "makhoa";//giá trị (key) của combobox
            cbbKhoa.SelectedIndex = -1;
            cbbmamonhoc.DataSource = db.SelectData("selectAllMonHoc", lst);
            cbbmamonhoc.DisplayMember = "tenmonhoc";//thuộc tính hiển thị của combobox
            cbbmamonhoc.ValueMember = "mamonhoc";//giá trị (key) của combobox
            cbbmamonhoc.SelectedIndex = -1;
            List<CustomParameter> lstgv = new List<CustomParameter>()
            {
                new CustomParameter()
                {
                    key = "@tukhoa",
                    value=""
                },
                new CustomParameter()
                {
                    key = "@makhoa",
                    value=""
                }
            };
            //combobox Giáo Viên
            cbbGiaoVien.DataSource = db.SelectData("selectAllGV", lstgv);
            cbbGiaoVien.DisplayMember = "hoten";
            cbbGiaoVien.ValueMember = "magiaovien";
            cbbGiaoVien.SelectedIndex = -1;//set combobox không chọn giá trị nào  
            #endregion
        }
        private void loadDSLH()
        {
            // Lấy giá trị của cbbdskhoa
            string makhoa = (cbbdskhoa.SelectedValue != null) ? cbbdskhoa.SelectedValue.ToString() : null;
            List<CustomParameter> lstPara = new List<CustomParameter>()
            {
                new CustomParameter()
                {
                    key = "@tukhoa",
                    value = tukhoa
                },
                 new CustomParameter()
                 {
                     key = "@makhoa",
                     value = makhoa
                 }
            };
            //gán tên bảng
           dgvLopHocPhan.DataSource = new Database().SelectData("allLopHocPhan", lstPara);

            //đặt tên cho cột
            dgvLopHocPhan.Columns["malophocphan"].HeaderText = "Mã lớp học";
            dgvLopHocPhan.Columns["mamonhoc"].HeaderText = "Mã môn học";
            dgvLopHocPhan.Columns["tenmonhoc"].HeaderText = "Tên môn học";
            dgvLopHocPhan.Columns["magiaovien"].HeaderText = "Mã giao viên";
            dgvLopHocPhan.Columns["hoten"].HeaderText = "Tên giáo viên";
            dgvLopHocPhan.Columns["hocky"].HeaderText = "Học kỳ";
            dgvLopHocPhan.Columns["nam"].HeaderText = "Năm";
            dgvLopHocPhan.Columns["makhoa"].HeaderText = "Mã khoan";
            dgvLopHocPhan.Columns["tenkhoa"].HeaderText = "Tên khoa";
            dgvLopHocPhan.ClearSelection();
            txtMalophoc.Text = "";
            cbbmamonhoc.SelectedIndex = -1;
            cbbKhoa.SelectedIndex = -1;
            cbbhocki.SelectedIndex = -1;
            cbbNam.SelectedIndex = -1;
            cbbGiaoVien.SelectedIndex = -1;
        }
        private void ShowEditForm(string malophoc)
        {

            if (string.IsNullOrEmpty(malophoc))
            {
                grbNhapLHP.Text = "Nhập thông tin lớp";
            }
            else
            {
               grbNhapLHP.Text = string.IsNullOrEmpty(malophoc) ? "Nhập thông tin lớp" : "Sửa thông tin lớp";
                txtMalophoc.ReadOnly = !string.IsNullOrEmpty(malophoc);
                var r = db.Select("selectLopHocPhan '" + malophoc + "'");
                txtMalophoc.Text = r["malophocphan"].ToString();
                cbbhocki.SelectedIndex = cbbhocki.FindStringExact(r["hocky"].ToString());
                cbbGiaoVien.SelectedValue = r["magiaovien"].ToString();
                cbbmamonhoc.SelectedValue = r["mamonhoc"].ToString();
                cbbNam.SelectedIndex = cbbNam.FindStringExact(r["nam"].ToString());
                cbbKhoa.SelectedValue = r["makhoa"].ToString();
            }
        }
        //hàm kiểm tra textbox
        private bool IsTextBoxEmpty(TextBox textBox, string fieldName)
        {
            if (string.IsNullOrWhiteSpace(textBox.Text))
            {
                MessageBox.Show($"Vui lòng nhập {fieldName}.");
                return true; // TextBox rỗng
            }
            return false; // TextBox không rỗng
        }
        private void cbbdskhoa_SelectedValueChanged(object sender, EventArgs e)
        {
            loadDSLH();
        }

        private void dgvLopHocPhan_CellDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                ShowEditForm(dgvLopHocPhan.Rows[e.RowIndex].Cells["malophocphan"].Value.ToString());
            }
        }
        public void BTNNHAP(string malophoc)
        {
            // Làm mờ Panel chứa DataGridView
            paneldatagritview.Enabled = false;
            // Đặt màu nền và chữ mới khi Enabled là false
            dgvLopHocPhan.DefaultCellStyle.BackColor = SystemColors.Control;
            dgvLopHocPhan.DefaultCellStyle.ForeColor = SystemColors.GrayText;
            // Xóa lựa chọn của dòng nếu có
            dgvLopHocPhan.ClearSelection();
            grbNhapLHP.Enabled = true;

            if (string.IsNullOrEmpty(malophoc))
            {
                grbNhapLHP.Text = "Nhập thông tin lớp";
                txtMalophoc.ReadOnly = false;
            }
            else
            {
                grbNhapLHP.Text = "Sửa thông tin lớp";
                txtMalophoc.ReadOnly = true;

                // Hiển thị thông tin của lớp học cần sửa
                ShowEditForm(malophoc);
            }

            btnThem.Enabled = false;
            BtnSua.Enabled = false;
            BtnXoa.Enabled = false;
            BtnGhi.Enabled = true;
            BtnHuy.Enabled = true;
        }
        public void BTNLUU()
        {

            paneldatagritview.Enabled = true;
            // Khôi phục màu nền và chữ khi Enabled là true
            dgvLopHocPhan.DefaultCellStyle.BackColor = SystemColors.Window;
            dgvLopHocPhan.DefaultCellStyle.ForeColor = SystemColors.ControlText;
            dgvLopHocPhan.ClearSelection();
            grbNhapLHP.Enabled = false;
            btnThem.Enabled = true;
            BtnSua.Enabled = true;
            BtnXoa.Enabled = true;
            BtnGhi.Enabled = false;
            BtnHuy.Enabled = false;

        }

        private void btnThem_Click(object sender, EventArgs e)
        {
            BTNNHAP("");
        }

        private void BtnHuy_Click(object sender, EventArgs e)
        {
            grbNhapLHP.Enabled = false;
            paneldatagritview.Enabled = true;
            // Khôi phục màu nền và chữ khi Enabled là true
            dgvLopHocPhan.DefaultCellStyle.BackColor = SystemColors.Window;
            dgvLopHocPhan.DefaultCellStyle.ForeColor = SystemColors.ControlText;
            dgvLopHocPhan.ClearSelection();
            dgvLopHocPhan.Enabled = false;
            btnThem.Enabled = true;
            BtnSua.Enabled = true;
            BtnXoa.Enabled = true;
            BtnGhi.Enabled = false;
            BtnHuy.Enabled = false;
            loadDSLH();
        }

        private void btnReset_Click(object sender, EventArgs e)
        {
            cbbdskhoa.SelectedIndex = -1;
            grbNhapLHP.Enabled = false;
            loadDSLH();
        }

        private void BtnGhi_Click(object sender, EventArgs e)
        {
            string sql = "";
            string ma = txtMalophoc.Text;
            if (!IsTextBoxEmpty(txtMalophoc, "mã lớp học"))
            {
                //ràng buộc điều kiện
                //phải chọn khoa và giáo viên giảng dạy mới tiếp tục thực hiện các câu lệnh phía dưới
                if (cbbmamonhoc.SelectedIndex < 0)
                {
                    MessageBox.Show("Vui lòng chọn môn học");
                    return;
                }
                if (cbbKhoa.SelectedIndex < 0)
                {
                    MessageBox.Show("Vui lòng chọn khoa");
                    return;
                }
                if (cbbGiaoVien.SelectedIndex < 0)
                {
                    MessageBox.Show("Vui lòng chọn giáo viên");
                    return;
                }
                if (cbbhocki.SelectedIndex < 0)
                {
                    MessageBox.Show("Vui lòng chọn học kì");
                    return;
                }
                if (cbbNam.SelectedIndex < 0)
                {
                    MessageBox.Show("Vui lòng chọn năm");
                    return;
                }
                //kết thúc ràng buộc
                List<CustomParameter> lst = new List<CustomParameter>();
                if (string.IsNullOrEmpty(malophoc))
                {
                    sql = "insertlophocphan";
                    lst.Add(new CustomParameter()
                    {
                        key = "@malophoc",
                        value = ma

                    });
                }
                else
                {
                    sql = "updatelophocphan";    
                    lst.Add(new CustomParameter()
                    {
                        key = "@malophoc",
                        value = malophoc
                    });
                }
                lst.Add(new CustomParameter()
                {
                    key = "@mamonhoc",
                    value = ((DataRowView)cbbmamonhoc.SelectedItem)["mamonhoc"].ToString()

                });
                lst.Add(new CustomParameter()
                {
                    key = "@makhoa",
                    value = ((DataRowView)cbbKhoa.SelectedItem)["makhoa"].ToString()
                });
               
                lst.Add(new CustomParameter()
                {
                    key = "@magiaovien",
                    value = ((DataRowView)cbbGiaoVien.SelectedItem)["magiaovien"].ToString()

                });
                lst.Add(new CustomParameter()
                {
                    key = "@hocky",
                    value = cbbhocki.SelectedItem.ToString()
                });
                lst.Add(new CustomParameter()
                {
                    key = "@nam",
                    value = cbbNam.SelectedItem.ToString()

                });

                var kq = db.ExeCute(sql, lst);
                if (kq == 1)
                {

                    if (string.IsNullOrEmpty(malophoc))
                    {
                        MessageBox.Show("Thêm mới lớp học thành công");
                    }
                    else
                    {
                        MessageBox.Show("Cập nhật lớp học thành công");
                    }

                    loadDSLH();
                    BTNLUU();
                    malophoc = "";

                }
                else
                {
                    MessageBox.Show("Lưu dữ liệu thất bại");

                }
            }
        }

        private void BtnSua_Click(object sender, EventArgs e)
        {
            // Check if a row is selected
            if (dgvLopHocPhan.SelectedRows.Count > 0)
            {
                // Get the selected row's malophoc value
                malophoc = dgvLopHocPhan.SelectedRows[0].Cells["malophocphan"].Value.ToString();
                ShowEditForm(malophoc);
                BTNNHAP(malophoc);
            }
            else
            {
                MessageBox.Show("Vui lòng chọn một lớp học để sửa.", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private void BtnXoa_Click(object sender, EventArgs e)
        {
            if (dgvLopHocPhan.SelectedRows.Count > 0)
            {
                string mlhp = dgvLopHocPhan.SelectedRows[0].Cells["malophocphan"].Value.ToString();

                DialogResult result = MessageBox.Show("Bạn có chắc chắn muốn xóa lớp học ?", "Xác nhận xóa", MessageBoxButtons.OKCancel, MessageBoxIcon.Question);
                if (result == DialogResult.OK)
                {
                    var sql = "deleteLHP";
                    var lstPara = new List<CustomParameter>()
                    {
                        new CustomParameter
                        {
                            key = "@malophoc",
                            value = mlhp
                        }
                    };
                    var rs = new Database().ExeCute(sql, lstPara);
                    if (rs > 0)
                    {
                        MessageBox.Show("Xóa lớp học thành công!");
                        loadDSLH(); // Load lại danh sách sinh viên sau khi xóa
                    }
                    else
                    {
                        MessageBox.Show("Xóa lớp học thất bại!");
                    }
                }
                loadDSLH();
            }
            else
            {
                MessageBox.Show("Vui lòng chọn một lớp học để xóa.", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }

        }

        private void btnThoat_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void BtnTimkiem_Click(object sender, EventArgs e)
        {
            tukhoa = txtTimkiem.Text;
            loadDSLH();
        }
    }
}
