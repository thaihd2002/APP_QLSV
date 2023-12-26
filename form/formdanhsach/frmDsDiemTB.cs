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
    public partial class frmDsDiemTB : Form
    {
        public frmDsDiemTB()
        {
            InitializeComponent();
        }
        private Database db;
        private void frmDsDiemTB_Load(object sender, EventArgs e)
        {
            db = new Database();
            LoadLopHoc();
        }
        #region hàm load

        private void LoadLopHoc()
        {
            List<CustomParameter> lst = new List<CustomParameter>()
            {
                new CustomParameter()
                {
                    key = "@tukhoa",
                    value=""
                }
            };
            //comboboxdskhoa
            cbbdskhoa.DataSource = db.SelectData("allkhoa", lst);
            cbbdskhoa.DisplayMember = "tenkhoa";
            cbbdskhoa.ValueMember = "makhoa";
            cbbdskhoa.SelectedIndex = -1;
        }
        private void LoadLopHocForKhoa(string makhoa)
        {
            List<CustomParameter> lstLopHocPara = new List<CustomParameter>()
            {
                new CustomParameter() { key= "@makhoa",
                value= makhoa}
            };
            cbbdslop.DataSource = db.SelectData("GetLopHoc", lstLopHocPara);
            cbbdslop.DisplayMember = "tenlophoc";
            cbbdslop.ValueMember = "malophoc";
            cbbdslop.SelectedIndex = -1;
        }
        #endregion
        private bool isLopHocSelected = false;
        private void cbbdskhoa_SelectedIndexChanged_1(object sender, EventArgs e)
        {
            if (cbbdskhoa.SelectedIndex != -1)
            {
                string maKhoa = cbbdskhoa.SelectedValue?.ToString();
                LoadLopHocForKhoa(maKhoa);
                cbbdslop.SelectedIndex = -1;
                isLopHocSelected = false; // Khi chọn khoa, đặt lại trạng thái lớp học đã chọn
            }
        }
        private void cbbdslop_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cbbdslop.SelectedIndex != -1)
            {
                string maLopHoc = cbbdslop.SelectedValue?.ToString();
                isLopHocSelected = true; // Lớp học đã được chọn
            }
        }

        private void BtnBatdau_Click(object sender, EventArgs e)
        {

        }
        private void LoadDiemTrungBinh(string maLopHoc)
        {
            List<CustomParameter> lstDiemPara = new List<CustomParameter>()
              {
        new CustomParameter() { key = "@malophoc", value = maLopHoc }
               };

            // Load dữ liệu và hiển thị trên giao diện
            DataTable dtDiem = db.SelectData("GetDiemTrungBinhTheoLopHoc", lstDiemPara);
            dgvDiemTB.DataSource = dtDiem;
            dgvDiemTB.Columns["masinhvien"].HeaderText = "Mã sinh viên";
            dgvDiemTB.Columns["hoten"].HeaderText = "Tên sinh viên";
            dgvDiemTB.Columns["nsinh"].HeaderText = "Ngày sinh";
            dgvDiemTB.Columns["gioitinh"].HeaderText = "Giới tính";
            dgvDiemTB.Columns["tenlophoc"].HeaderText = "Lớp học";
            dgvDiemTB.Columns["makhoa"].HeaderText = "Mã khoa";
            dgvDiemTB.Columns["diemtrungbinh"].HeaderText = "Điểm trung bình";
        }
        private void BtnBatdau_Click_1(object sender, EventArgs e)
        {
            if (isLopHocSelected = true)
            {
                string maLopHoc = cbbdslop.SelectedValue?.ToString();
                LoadDiemTrungBinh(maLopHoc);
            }
            else
            {
                MessageBox.Show("Vui lòng chọn lớp học phần trước khi bắt đầu.", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
        }

        private void BtnThoat_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
