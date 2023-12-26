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
    public partial class frmDsLopHoc : Form
    {
        public frmDsLopHoc()
        {
            InitializeComponent();
        }
        private string malophoc = "";
        private Database db;
        private string nguoithuchien = "admin";
        private string tukhoa = "";
        private void frmDsLopHoc_Load(object sender, EventArgs e)
        {
            this.grbNhapSV.Enabled = false;
            this.BtnGhi.Enabled = false;
            this.BtnHuy.Enabled = false;
            dgvLopHoc.ClearSelection();
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
            //combobox Khoa
            cbbKhoa.DataSource = db.SelectData("allKhoa", lst);
            cbbKhoa.DisplayMember = "tenkhoa";//thuộc tính hiển thị của combobox
            cbbKhoa.ValueMember = "makhoa";//giá trị (key) của combobox
            cbbKhoa.SelectedIndex = -1;
            //comboboxdskhoa
            cbbdskhoa.DataSource = db.SelectData("allkhoa", lst);
            cbbdskhoa.DisplayMember = "tenkhoa";
            cbbdskhoa.ValueMember = "makhoa";
            cbbdskhoa.SelectedIndex = -1;
            //combobox Giáo Viên
            cbbGiaoVien.DataSource = db.SelectData("selectcbbGV", lst);
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
            dgvLopHoc.DataSource = new Database().SelectData("allLopHoc", lstPara);

            //đặt tên cho cột
            dgvLopHoc.Columns["malophoc"].HeaderText = "Mã lớp học";
            dgvLopHoc.Columns["tenlophoc"].HeaderText = "Tên lớp học";
            dgvLopHoc.Columns["khoahoc"].HeaderText = "Khóa học";
            dgvLopHoc.Columns["hedaotao"].HeaderText = "Hệ đào tạo";
            dgvLopHoc.Columns["namnhaphoc"].HeaderText = "Năm nhập học";
            dgvLopHoc.Columns["hoten"].HeaderText = "Giáo viên";
            dgvLopHoc.Columns["makhoa"].HeaderText = "Mã khoa";
            dgvLopHoc.Columns["tenkhoa"].HeaderText = "Tên khoa";
            dgvLopHoc.ClearSelection();
            txtMalophoc.Text = "";
            txtTenlophoc.Text = "";
            cbbKhoa.SelectedIndex = -1;
            cbbKhoahoc.SelectedIndex = -1;
            cbbHedaotao.SelectedIndex = -1;
            cbbNamnhaphoc.SelectedIndex = -1;
            cbbGiaoVien.SelectedIndex = -1;
           
        }
        private void ShowEditForm(string malophoc)
        {
           
            if (string.IsNullOrEmpty(malophoc))
            {
                grbNhapSV.Text = "Nhập thông tin lớp";
            }
            else
            {
                grbNhapSV.Text = string.IsNullOrEmpty(malophoc) ? "Nhập thông tin lớp" : "Sửa thông tin lớp";
                txtMalophoc.ReadOnly = !string.IsNullOrEmpty(malophoc);
                var r = db.Select("selectLopHoc '" + malophoc + "'");
                txtMalophoc.Text = r["malophoc"].ToString();
                txtTenlophoc.Text = r["tenlophoc"].ToString();
                // Giả sử r["khoahoc"], r["hedaotao"], và r["namnhaphoc"] là các giá trị bạn muốn chọn.
                // Tìm chỉ mục của mục có giá trị được chỉ định và đặt nó làm mục đã chọn.
                cbbKhoahoc.SelectedIndex = cbbKhoahoc.FindStringExact(r["khoahoc"].ToString());
                cbbHedaotao.SelectedIndex = cbbHedaotao.FindStringExact(r["hedaotao"].ToString());
                cbbNamnhaphoc.SelectedIndex = cbbNamnhaphoc.FindStringExact(r["namnhaphoc"].ToString());
                cbbGiaoVien.SelectedValue = r["magiaovien"].ToString();
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
        private void dgvLopHoc_CellDoubleClick_1(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                ShowEditForm(dgvLopHoc.Rows[e.RowIndex].Cells["malophoc"].Value.ToString());
            }
        }
        private void cbbdskhoa_SelectedValueChanged(object sender, EventArgs e)
        {
            loadDSLH();
        }

        public void BTNNHAP(string malophoc)
        {
            // Làm mờ Panel chứa DataGridView
            paneldatagritview.Enabled = false;
            // Đặt màu nền và chữ mới khi Enabled là false
            dgvLopHoc.DefaultCellStyle.BackColor = SystemColors.Control;
            dgvLopHoc.DefaultCellStyle.ForeColor = SystemColors.GrayText;
            // Xóa lựa chọn của dòng nếu có
            dgvLopHoc.ClearSelection();
            grbNhapSV.Enabled = true;

            if (string.IsNullOrEmpty(malophoc))
            {
                grbNhapSV.Text = "Nhập thông tin lớp";
                txtMalophoc.ReadOnly = false;
            }
            else
            {
                grbNhapSV.Text = "Sửa thông tin lớp";
                txtMalophoc.ReadOnly = true;

                // Hiển thị thông tin của lớp học cần sửa
                ShowEditForm(malophoc);
            }

            btnThem.Enabled = false;
            BtnSua.Enabled = false;
            btnxoa.Enabled = false;
            BtnGhi.Enabled = true;
            BtnHuy.Enabled = true;
        }

        public void BTNLUU()
        {
        
            paneldatagritview.Enabled = true;
            // Khôi phục màu nền và chữ khi Enabled là true
            dgvLopHoc.DefaultCellStyle.BackColor = SystemColors.Window;
            dgvLopHoc.DefaultCellStyle.ForeColor = SystemColors.ControlText;
            dgvLopHoc.ClearSelection();
            grbNhapSV.Enabled = false;
            btnThem.Enabled = true;
            BtnSua.Enabled = true;
            btnxoa.Enabled = true;
            BtnGhi.Enabled = false;
            BtnHuy.Enabled = false;
      
        }
        private void btnThem_Click(object sender, EventArgs e)
        { 
            BTNNHAP("");
        }

        private void BtnHuy_Click(object sender, EventArgs e)
        {
            paneldatagritview.Enabled = true;
            // Khôi phục màu nền và chữ khi Enabled là true
            dgvLopHoc.DefaultCellStyle.BackColor = SystemColors.Window;
            dgvLopHoc.DefaultCellStyle.ForeColor = SystemColors.ControlText;
            dgvLopHoc.ClearSelection();
            grbNhapSV.Enabled = false;
            btnThem.Enabled = true;
            BtnSua.Enabled = true;
            btnxoa.Enabled = true;
            BtnGhi.Enabled = false;
            BtnHuy.Enabled = false;
            loadDSLH();
        }

        private void btnreset_Click(object sender, EventArgs e)
        {
            cbbdskhoa.SelectedIndex = -1;
            loadDSLH();
        }

        private void BtnGhi_Click(object sender, EventArgs e)
        {
            string sql = "";
            string ma = txtMalophoc.Text;
            string ten = txtTenlophoc.Text;
            if (!IsTextBoxEmpty(txtMalophoc, "mã lớp học") && !IsTextBoxEmpty(txtTenlophoc, "tên lớp học"))
            {
                //ràng buộc điều kiện
                //phải chọn khoa và giáo viên giảng dạy mới tiếp tục thực hiện các câu lệnh phía dưới
                if (cbbKhoa.SelectedIndex < 0)
                {
                    MessageBox.Show("Vui lòng chọn khoa");
                    return;
                }
                if (cbbKhoahoc.SelectedIndex < 0)
                {
                    MessageBox.Show("Vui lòng chọn khóa học");
                    return;
                }
                if (cbbHedaotao.SelectedIndex < 0)
                {
                    MessageBox.Show("Vui lòng chọn hệ đào tạo");
                    return;
                }
                if (cbbNamnhaphoc.SelectedIndex < 0)
                {
                    MessageBox.Show("Vui lòng chọn năm nhập học");
                    return;
                }
                if (cbbGiaoVien.SelectedIndex < 0)
                {
                    MessageBox.Show("Vui lòng chọn giáo viên");
                    return;
                }
                //kết thúc ràng buộc
                List<CustomParameter> lst = new List<CustomParameter>();
                if (string.IsNullOrEmpty(malophoc))
                {
                    sql = "insertLopHoc";
                    lst.Add(new CustomParameter()
                    {
                        key = "@nguoitao",
                        value = nguoithuchien
                    });
                    lst.Add(new CustomParameter()
                    {
                        key = "@malophoc",
                        value = ma

                    });
                }
                else
                {
                    sql = "updateLopHoc";
                    lst.Add(new CustomParameter()
                    {
                        key = "@nguoicapnhat",
                        value = nguoithuchien
                    });
                    lst.Add(new CustomParameter()
                    {
                        key = "@malophoc",
                        value = malophoc
                    });
                }
                lst.Add(new CustomParameter()
                {
                    key = "@makhoa",
                    value = ((DataRowView)cbbKhoa.SelectedItem)["makhoa"].ToString()
                });
                lst.Add(new CustomParameter()
                {
                    key = "@tenlophoc",
                    value = ten

                });
                lst.Add(new CustomParameter()
                {
                    key = "@khoahoc",
                    value = cbbKhoahoc.SelectedItem.ToString()

                });
                lst.Add(new CustomParameter()
                {
                    key = "@hedaotao",
                    value = cbbHedaotao.SelectedItem.ToString()

                });
                lst.Add(new CustomParameter()
                {
                    key = "@namnhaphoc",
                    value = cbbNamnhaphoc.SelectedItem.ToString()

                });
                lst.Add(new CustomParameter()
                {
                    key = "@magiaovien",
                    value = ((DataRowView)cbbGiaoVien.SelectedItem)["magiaovien"].ToString()
                });

                var kq = db.ExeCute(sql, lst);
                if (kq ==1)
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
            if (dgvLopHoc.SelectedRows.Count > 0)
            {
                // Get the selected row's malophoc value
                malophoc = dgvLopHoc.SelectedRows[0].Cells["malophoc"].Value.ToString();
                ShowEditForm(malophoc);
                BTNNHAP(malophoc);
            }
            else
            {
                MessageBox.Show("Vui lòng chọn một lớp học để sửa.", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        } 
        private void btnxoa_Click(object sender, EventArgs e)
        {
            if (dgvLopHoc.SelectedRows.Count > 0)
            {
                string mgv = dgvLopHoc.SelectedRows[0].Cells["malophoc"].Value.ToString();

                DialogResult result = MessageBox.Show("Bạn có chắc chắn muốn xóa lớp học ?", "Xác nhận xóa", MessageBoxButtons.OKCancel, MessageBoxIcon.Question);
                if (result == DialogResult.OK)
                {
                    var sql = "deleteLH";
                    var lstPara = new List<CustomParameter>()
                    {
                        new CustomParameter
                        {
                            key = "@malophoc",
                            value = mgv
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
        private void btnthoat_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btnTimKiem_Click(object sender, EventArgs e)
        {
            tukhoa = txtTimKiem.Text;
            loadDSLH();
        }
    }
}
