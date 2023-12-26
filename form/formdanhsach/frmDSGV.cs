using DocumentFormat.OpenXml.Packaging;
using DocumentFormat.OpenXml.Spreadsheet;
using DocumentFormat.OpenXml;
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
    public partial class frmDSGV : Form
    {
        public frmDSGV()
        {
            InitializeComponent();
        }
        private Database db;
        private void btnTimKiem_Click(object sender, EventArgs e)
        {
            tukhoa = x.Text;
            loadDSGV(maKhoa);
        }
        private string tukhoa = "";
        private void LoadKhoa()
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
        private void loadDSGV(string makhoa)
        {
            string sql = "selectAllGV";
            List<CustomParameter> lstPara = new List<CustomParameter>();
            lstPara.Add(new CustomParameter() {
                key = "@tukhoa",
                value = tukhoa
            });
            lstPara.Add(new CustomParameter()
            {
                key = "@makhoa",
                value = makhoa
            });
            dgvDSGV.DataSource = new Database().SelectData(sql, lstPara);
            dgvDSGV.Columns["magiaovien"].HeaderText = "Mã giáo viên";
            dgvDSGV.Columns["hoten"].HeaderText = "Tên giáo viên";
            dgvDSGV.Columns["ngaysinh"].HeaderText = "Ngày sinh";
            dgvDSGV.Columns["gt"].HeaderText = "Giới tính";
            dgvDSGV.Columns["dienthoai"].HeaderText = "Điện thoại";
            dgvDSGV.Columns["email"].HeaderText = "Email";
            dgvDSGV.Columns["diachi"].HeaderText = "Địa chỉ";
            dgvDSGV.Columns["makhoa"].HeaderText = "Mã khoa";
        }
        private string maKhoa;
        private void cbbdskhoa_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cbbdskhoa.SelectedIndex != -1)
            {
                maKhoa = cbbdskhoa.SelectedValue?.ToString();
                loadDSGV(maKhoa);
                grbchucnang.Enabled = true;
            }
        }

        private void frmDSGV_Load(object sender, EventArgs e)
        {
            db = new Database();
            LoadKhoa();
            loadDSGV(maKhoa);
            grbchucnang.Enabled = false;
        }

        private void btnThemMoi_Click(object sender, EventArgs e)
        {
            new frmGV(null, maKhoa).ShowDialog();
            loadDSGV(maKhoa);
        }

        private void dgvDSGV_CellDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                var mgv = dgvDSGV.Rows[e.RowIndex].Cells["magiaovien"].Value.ToString();
                new frmGV(mgv, maKhoa).ShowDialog();
                loadDSGV(maKhoa);
            }
        }
        private void btnxoa_Click(object sender, EventArgs e)
        {
            if (dgvDSGV.SelectedRows.Count > 0)
            {
                //lấy mã giáo viên được chọn
                var mgv = dgvDSGV.SelectedRows[0].Cells["magiaovien"].Value.ToString();
                //hiện thị thông báo xác nhận xóa
                DialogResult result = MessageBox.Show("Bạn có chắc chắn muốn xóa giáo viên?", "Xác nhận xóa", MessageBoxButtons.OKCancel, MessageBoxIcon.Question);
                //người dùng ấn ok thì thực hiện xóa
                if (result == DialogResult.OK)
                {
                    var sql = "deleteGV";
                    var lstPara = new List<CustomParameter>()
                    {
                        new CustomParameter()
                        {
                            key = "@magiaovien",
                            value = mgv
                        }
                    };
                    var rs = new Database().ExeCute(sql, lstPara);
                    if (rs > 0)
                    {
                        MessageBox.Show("Xóa giáo viên thành công!");
                        loadDSGV(maKhoa); // Load lại danh sách giáo viên sau khi xóa
                    }
                    else
                    {
                        MessageBox.Show("Xóa giáo viên thất bại!");
                    }
                }
                loadDSGV(maKhoa);
            }
            else
            {
                MessageBox.Show("Vui lòng chọn một giáo viên để xóa.", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
        }
        #region xuất excel
        private void btnExcel_Click(object sender, EventArgs e)
        {
            if (dgvDSGV.Rows.Count > 0)
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
                    foreach (DataGridViewColumn column in dgvDSGV.Columns)
                    {
                        Cell cell = CreateTextCell(column.HeaderText);
                        headerRow.AppendChild(cell);
                    }

                    sheetData.AppendChild(headerRow);

                    // Thêm dữ liệu
                    foreach (DataGridViewRow dgvRow in dgvDSGV.Rows)
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
