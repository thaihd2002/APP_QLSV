using DocumentFormat.OpenXml.Packaging;
using DocumentFormat.OpenXml;
using DocumentFormat.OpenXml.Spreadsheet;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace QuanLySinhVienCshape
{
    public partial class frmDSSV : Form
    {
        public frmDSSV()
        {
            InitializeComponent();

        }
        private string tukhoa = "";
        private Database db;
        private void Cbsapxep_KeyPress(object sender, KeyPressEventArgs e)
        {
            e.Handled = true; // Ngăn chặn việc nhập liệu
        }
        private void frmDSSV_Load(object sender, EventArgs e)
        {
            db = new Database();
            LoadLopHoc();
            grbchucnang.Enabled = false;
        }
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
            dgvLop.DataSource = new Database().SelectData("GetLopHoc", lstLopHocPara);
            dgvLop.Columns["malophoc"].HeaderText = "Mã Lớp ";
            dgvLop.Columns["tenlophoc"].HeaderText = "Tên Lớp ";
            dgvLop.Columns["makhoa"].HeaderText = "Mã khoa";
        }
        private void cbbdskhoa_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cbbdskhoa.SelectedIndex != -1)
            {
                string maKhoa = cbbdskhoa.SelectedValue?.ToString();
                LoadLopHocForKhoa(maKhoa);
            }
        }
        private string maLop;
        private void dgvLop_CellDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            if (dgvLop.SelectedRows.Count > 0)
            {
                maLop = dgvLop.SelectedRows[0].Cells["malophoc"].Value.ToString();
                LoadDSSV(maLop);
                dgvSinhVien.ClearSelection();
                grbchucnang.Enabled = true;
            }
            else
            {
                MessageBox.Show("Vui lòng chọn một lớp để hiển thị sinh viên.", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
        }
        private void LoadDSSV( string maLop) 
        {   
            //load toàn bộ danh sách sinh viên khi form được load
            List<CustomParameter> lstPara = new List<CustomParameter>();
            lstPara.Add(new CustomParameter()
            {
                key = "@tukhoa",
                value = tukhoa
            });
            lstPara.Add(new CustomParameter()
            {
                key = "@malophoc",
                value = maLop
            });
            dgvSinhVien.DataSource = new Database().SelectData("SelectAllSinhVien", lstPara);
            dgvSinhVien.Columns["masinhvien"].HeaderText = "Mã SV";
            dgvSinhVien.Columns["hoten"].HeaderText = "Họ tên";
            dgvSinhVien.Columns["nsinh"].HeaderText = "Ngày sinh";
            dgvSinhVien.Columns["gt"].HeaderText = "Giới tính";
            dgvSinhVien.Columns["quequan"].HeaderText = "Quê quán";
            dgvSinhVien.Columns["diachi"].HeaderText = "Địa chỉ";
            dgvSinhVien.Columns["email"].HeaderText = "Email";
            dgvSinhVien.Columns["dienthoai"].HeaderText = "Điện thoại";
            dgvSinhVien.Columns["tenkhoa"].HeaderText = "Tên khoa";
            dgvSinhVien.Columns["tenlophoc"].HeaderText = "Lớp học";
            SortDataGridView();
        }
        private void btnreset_Click(object sender, EventArgs e)
        {
            cbbsapxepsv.SelectedItem = null;
            tukhoa = "";
            x.Text = "";
            LoadDSSV(maLop);
        }
        private void btnThemmoi_Click(object sender, EventArgs e)
        {
            new frmSinhVien(null,maLop).ShowDialog();//nếu thêm mới sinh viên -> mã sinh viên = null
            LoadDSSV(maLop);//load lại danh sách sinh viên khi thêm thành công <-> form frmSinhVien đc đóng
        }
        private void btnTimkiem_Click(object sender, EventArgs e)
        {
            tukhoa = x.Text;
            LoadDSSV(maLop);
        }
        private void btnXoa_Click(object sender, EventArgs e)
        {
            // Kiểm tra xem có dòng nào được chọn không
            if (dgvSinhVien.SelectedRows.Count > 0)
            {
                // Lấy mã sinh viên từ dòng được chọn
                var msv = dgvSinhVien.SelectedRows[0].Cells["masinhvien"].Value.ToString();
                // Hiển thị thông báo xác nhận xóa
                DialogResult result = MessageBox.Show("Bạn có chắc chắn muốn xóa sinh viên?", "Xác nhận xóa", MessageBoxButtons.OKCancel, MessageBoxIcon.Question);

                // Nếu người dùng ấn OK, thực hiện xóa
                if (result == DialogResult.OK)
                {
                    var sql = "deleteSV";
                    var lstPara = new List<CustomParameter>()
                    {
                        new CustomParameter
                        {
                            key = "@masinhvien",
                            value = msv
                        }
                    };
                    var rs = new Database().ExeCute(sql, lstPara);
                    if (rs > 0)
                    {
                        MessageBox.Show("Xóa sinh viên thành công!");
                        LoadDSSV(maLop); // Load lại danh sách sinh viên sau khi xóa
                    }
                    else
                    {
                        MessageBox.Show("Xóa sinh viên thất bại!");
                    }
                }
                LoadDSSV(maLop);
            }
            else
            {
                MessageBox.Show("Vui lòng chọn một sinh viên để xóa.", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
        }
        private void dgvSinhVien_CellDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            //ý tưởng: khi double click vào sinh viên trên datagridview
            //sẽ hiện ra form cập nhật thông tin sinh viên
            //để cập nhật được sinh viên
            //ta cần lấy được mã sinh viên
            if (e.RowIndex >= 0)
            {
                var msv = dgvSinhVien.Rows[e.RowIndex].Cells["masinhvien"].Value.ToString();
                //cần truyền mã sinh viên này vào form sinh viên
                new frmSinhVien(msv,maLop).ShowDialog();
                //sau khi form frmSinhVien đc đóng lại 
                //cần load lại danh sách sinh viên
                LoadDSSV(maLop);
            }
        }
        private void cbbsapxepsv_SelectedValueChanged(object sender, EventArgs e)
        {
            SortDataGridView();
        }
        #region hàm sắp xếp
        private void SortDataGridView()
        {
            // Kiểm tra xem có dữ liệu để sắp xếp không
            if (dgvSinhVien.Rows.Count == 0 || dgvSinhVien.Columns.Count == 0)
            {
                return;
            }
            // Lấy tên cột cần sắp xếp
            string columnName = string.Empty;
            switch (cbbsapxepsv.Text)
            {
                case "Tên Sinh Viên":
                    columnName = "hoten";
                    break;
                case "Giới Tính":
                    columnName = "gt";
                    break;
                case "Quê Quán":
                    columnName = "quequan";
                    break;
                case "Địa Chỉ":
                    columnName = "diachi";
                    break;
            }
            // Kiểm tra xem cột cần sắp xếp có tồn tại không
            if (dgvSinhVien.Columns.Contains(columnName))
            {
                // Sắp xếp dữ liệu theo cột và hướng sắp xếp tùy thuộc vào nhu cầu của bạn
                dgvSinhVien.Sort(dgvSinhVien.Columns[columnName], ListSortDirection.Ascending);
            }
        }

        #endregion
        #region xuất excel
        private void btnExcel_Click(object sender, EventArgs e)
        {
            if (dgvSinhVien.Rows.Count > 0)
            {
                SaveFileDialog saveDialog = new SaveFileDialog();
                saveDialog.Filter = "Excel Files|*.xlsx";
                saveDialog.Title = "Chọn nơi lưu tệp Excel";

                if (saveDialog.ShowDialog() == DialogResult.OK)
                {
                    ExportToExcel(saveDialog.FileName);
                    MessageBox.Show("Xuất Excel thành công!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
            }
            else
            {
                MessageBox.Show("Không có dữ liệu để xuất Excel.", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
        }
        private void ExportToExcel(string filePath)
        {
            try
            {
                using (SpreadsheetDocument spreadsheetDocument = SpreadsheetDocument.Create(filePath, SpreadsheetDocumentType.Workbook))
                {
                    WorkbookPart workbookPart = spreadsheetDocument.AddWorkbookPart();
                    workbookPart.Workbook = new Workbook();

                    WorksheetPart worksheetPart = workbookPart.AddNewPart<WorksheetPart>();
                    SheetData sheetData = new SheetData();
                    worksheetPart.Worksheet = new Worksheet(sheetData);

                    Sheets sheets = spreadsheetDocument.WorkbookPart.Workbook.AppendChild<Sheets>(new Sheets());
                    Sheet sheet = new Sheet() { Id = spreadsheetDocument.WorkbookPart.GetIdOfPart(worksheetPart), SheetId = 1, Name = "Sheet1" };
                    sheets.Append(sheet);

                    // Thêm hàng mới chứa tiêu đề từ Label
                    Row titleRow = new Row();
                    Cell titleCell = CreateTextCell(labelTentieude.Text);
                    titleRow.AppendChild(titleCell);
                    sheetData.AppendChild(titleRow);

                    // Thêm hàng tiêu đề
                    Row headerRow = new Row();
                    foreach (DataGridViewColumn column in dgvSinhVien.Columns)
                    {
                        Cell cell = CreateTextCell(column.HeaderText);
                        headerRow.AppendChild(cell);
                    }

                    sheetData.AppendChild(headerRow);

                    // Thêm dữ liệu
                    foreach (DataGridViewRow dgvRow in dgvSinhVien.Rows)
                    {
                        Row row = new Row();

                        foreach (DataGridViewCell cell in dgvRow.Cells)
                        {
                            Cell textCell = CreateTextCell(cell.Value?.ToString());
                            row.AppendChild(textCell);
                        }

                        sheetData.AppendChild(row);
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Xuất Excel thất bại. Lỗi: {ex.Message}", "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }
        private Cell CreateTextCell(string text)
        {
            return new Cell(new CellValue(text)) { DataType = new EnumValue<CellValues>(CellValues.String) };
        }
        #endregion
    }
}
