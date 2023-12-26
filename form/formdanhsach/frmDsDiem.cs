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
    public partial class frmDsDiem : Form
    {
        private string taikhoan;
       
        public frmDsDiem()
        {
            InitializeComponent();
           
        }
        private Database db;
        private void frmDsDiem_Load(object sender, EventArgs e)
        {
            BtnCapnhat.Enabled = false;
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
            cbbdslop.DataSource = db.SelectData("GetLopHocPhan", lstLopHocPara);
            cbbdslop.DisplayMember = "malophocphan";
            cbbdslop.ValueMember = "malophocphan";
            cbbdslop.SelectedIndex= -1;
        }
        private void LoadMonHocForLopHoc(string maLopHocPhan)
        {
            List<CustomParameter> lstMonHocPara = new List<CustomParameter>
              {
        new CustomParameter() { key = "@maLopHoc", value = maLopHocPhan }
              };

            dgvMonhoc.DataSource = db.SelectData("GetMonHocForLopHoc", lstMonHocPara);
            // Đặt tên hiển thị cho các cột trong DataGridView nếu cần
            dgvMonhoc.Columns["mamonhoc"].HeaderText = "Mã Môn Học";
            dgvMonhoc.Columns["tenmonhoc"].HeaderText = "Tên Môn Học";
            dgvMonhoc.Columns["sotinchi"].HeaderText = "Số tín chỉ";

            // Đặt thuộc tính chỉ đọc cho DataGridView nếu cần
            dgvMonhoc.ReadOnly = true;
            // Không chọn bất kỳ dòng nào
            dgvMonhoc.ClearSelection();

        }
        private DataTable GetSinhVienDiemByLopHocMonHoc(string maLopHocPhan, string maMonHoc)
        {
            List<CustomParameter> lstPara = new List<CustomParameter>
    {
        new CustomParameter() { key = "@maLopHoc", value = maLopHocPhan },
        new CustomParameter() { key = "@maMonHoc", value = maMonHoc }
    };

            return new Database().SelectData("GetSinhVienDiemByLopHocMonHoc", lstPara);
        }
        private void LoadDSSV(string maLopHocPhan, string maMonHoc)
        {
            dgvDiem.DataSource = GetSinhVienDiemByLopHocMonHoc(maLopHocPhan, maMonHoc);
            // Các dòng tiếp theo để đổi tên cột và sắp xếp dữ liệu trong DataGridView
            dgvDiem.Columns["masinhvien"].HeaderText = "Mã SV";
            dgvDiem.Columns["hoten"].HeaderText = "Họ tên";
            dgvDiem.Columns["nsinh"].HeaderText = "Ngày sinh";
            dgvDiem.Columns["gt"].HeaderText = "Giới tính";
            dgvDiem.Columns["malophocphan"].HeaderText = "Lớp học";
            dgvDiem.Columns["tenmonhoc"].HeaderText = "Môn học";
            dgvDiem.Columns["diemchuyencan"].HeaderText = "Điểm chuyên cần";
            dgvDiem.Columns["diemheso1"].HeaderText = "Điểm hệ số 1";
            dgvDiem.Columns["diemheso2_1"].HeaderText = "Điểm hệ số 2_1";
            dgvDiem.Columns["diemheso2_2"].HeaderText = "Điểm hệ số 2_2";
            dgvDiem.Columns["diemquatrinh"].HeaderText = "Điểm quá trình";
            dgvDiem.Columns["diemthi"].HeaderText = "Điểm thi";
            dgvDiem.Columns["diemhocphan"].HeaderText = "Điểm học phần";

            //set thuộc tính cho phép chỉnh sửa cho  cột điểm lần 1 và lần 2 và điểm thi điểm chuyên cần
            for (int i = 0; i <= 5; i++)// không cho sửa 5 cột phía trước
            {
                dgvDiem.Columns[i].ReadOnly = true;
            }
            dgvDiem.Columns[10].ReadOnly = true;
            dgvDiem.Columns[12].ReadOnly = true;

        }
        #endregion
        private bool isLopHocSelected = false;
        private void cbbdskhoa_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cbbdskhoa.SelectedIndex != -1)
            {
                string maKhoa = cbbdskhoa.SelectedValue?.ToString();
                LoadLopHocForKhoa(maKhoa);
                cbbdslop.SelectedIndex = -1;
                isLopHocSelected = false; // Khi chọn khoa, đặt lại trạng thái lớp học đã chọn
                dgvMonhoc.DataSource = null; // Xóa dữ liệu trong dgvmonhoc khi chọn khoa

            }
        }

        private void cbbdslop_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cbbdslop.SelectedIndex != -1)
            {
                string maLopHocPhan = cbbdslop.SelectedValue?.ToString();
                LoadMonHocForLopHoc(maLopHocPhan);
                isLopHocSelected = true; // Lớp học đã được chọn
            }
        }

        private void BtnBatdau_Click(object sender, EventArgs e)
        {
            if (isLopHocSelected && dgvMonhoc.SelectedRows.Count > 0)
            {
                string maMonHoc = dgvMonhoc.SelectedRows[0].Cells["mamonhoc"].Value.ToString();
                string maLopHocPhan = cbbdslop.SelectedValue?.ToString();
                LoadDSSV(maLopHocPhan, maMonHoc);
                BtnBatdau.Enabled = false;
                BtnCapnhat.Enabled = true;
            }
            else
                MessageBox.Show("Vui lòng chọn môn học","Thông báo",MessageBoxButtons.OK,MessageBoxIcon.Error);
        }

        private void BtnThoat_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void BtnCapnhat_Click(object sender, EventArgs e)
        {
            taikhoan = "van";
            string maMonHoc = dgvMonhoc.SelectedRows[0].Cells["mamonhoc"].Value.ToString();
            string maLopHocPhan = cbbdslop.SelectedValue?.ToString();
            if (string.IsNullOrEmpty(maMonHoc) || string.IsNullOrEmpty(maLopHocPhan))
            {
                MessageBox.Show("Vui lòng chọn lớp học và môn học trước khi lưu bảng điểm.");
                return;
            }
            //ý tưởng: khi click vào button này thì các điểm được chấm trên datagridview dgvDSSV sẽ được cập nhật vào csdl ( bảng tblDiem)
            if (DialogResult.Yes ==
                    MessageBox.Show("Bạn muốn lưu bảng điểm?", "Xác nhận thao tác", MessageBoxButtons.YesNo, MessageBoxIcon.Question))
            {
                //storedprocedure chamdiem chỉ chấm cho 1 sinh viên
                //nhưng trên datagridview chúng ta có nhiều sinh viên
                //để có thể lưu hết bảng điểm
                //chúng ta cần duyệt hết các dòng dữ liệu trên datagridview <=> dùng vòng lặp
                var db = new Database();
                List<CustomParameter> lstPara;

                //bắt đầu duyệt
                int chk = 1;
                foreach (DataGridViewRow r in dgvDiem.Rows)
                {
                    lstPara = new List<CustomParameter>();
                    lstPara.Add(new CustomParameter()
                    {
                        key = "@nguoicapnhat",
                        value = taikhoan
                    });
                    lstPara.Add(new CustomParameter()
                    {
                        key = "@masinhvien",
                        value = r.Cells["masinhvien"].Value.ToString()
                    });

                    lstPara.Add(new CustomParameter()
                    {
                        key = "@malophocphan",
                        value = maLopHocPhan
                    });
                    lstPara.Add(new CustomParameter()
                    {
                        key = "@diemchuyencan",
                        value = r.Cells["diemchuyencan"].Value.ToString()
                    });
                    lstPara.Add(new CustomParameter()
                    {
                        key = "@diemheso1",
                        value = r.Cells["diemheso1"].Value.ToString()
                    });
                    lstPara.Add(new CustomParameter()
                    {
                        key = "@diemheso2_1",
                        value = r.Cells["diemheso2_1"].Value.ToString()
                    });
                    lstPara.Add(new CustomParameter()
                    {
                        key = "@diemheso2_2",
                        value = r.Cells["diemheso2_2"].Value.ToString()
                    });
                    lstPara.Add(new CustomParameter()
                    {
                        key = "@diemthi",
                        value = r.Cells["diemthi"].Value.ToString()
                    });
                    //thực thi truy vấn
                    chk = db.ExeCute("chamdiem", lstPara);
                    if (chk == 0)//nếu chấm điểm thất bại
                    {
                        MessageBox.Show("Chấm điểm thất bại");
                        break;//thoát khỏi vòng lặp luôn mà không chạy các lần còn lại
                    }
                }//kết thúc duyệt

                if (chk>=1)
                {
                    MessageBox.Show("Lưu bảng điểm thành công");
                    BtnCapnhat.Enabled = false;
                    BtnBatdau.Enabled = true;
                }

            }
            if (!string.IsNullOrEmpty(maMonHoc) && !string.IsNullOrEmpty(maLopHocPhan))
            {
                LoadDSSV(maLopHocPhan, maMonHoc);
            }

        }

        private void btnreset_Click(object sender, EventArgs e)
        {
            BtnBatdau.Enabled = true;
        }
    }
   
}

