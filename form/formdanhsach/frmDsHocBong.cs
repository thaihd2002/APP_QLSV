using DocumentFormat.OpenXml;
using DocumentFormat.OpenXml.Packaging;
using DocumentFormat.OpenXml.Spreadsheet;
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
    public partial class frmDsHocBong : Form
    {
        private Database db;
        public frmDsHocBong()
        {
            db = new Database();
            InitializeComponent();
        }

        private void cbbdskhoa_SelectedIndexChanged(object sender, EventArgs e)
        {
           
        }

        private void frmDsHocBong_Load(object sender, EventArgs e)
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
        private void LoadDSForKhoa(string makhoa)
        {
            List<CustomParameter> lstPara = new List<CustomParameter>()
            {
                new CustomParameter() { key= "@makhoa",
                value= makhoa}
            };
            dgvDShocbong.DataSource = new Database().SelectData("GetDanhSachHocBong", lstPara);
            dgvDShocbong.Columns["masinhvien"].HeaderText = "Mã sinh viên";
            dgvDShocbong.Columns["hoten"].HeaderText = "Tên sinh viên";
            dgvDShocbong.Columns["ngaysinh"].HeaderText = "Ngày sinh";
            dgvDShocbong.Columns["tenlophoc"].HeaderText = "Lớp học";
            dgvDShocbong.Columns["diemtrungbinh"].HeaderText = "Điểm trung bình";
            dgvDShocbong.Columns["hocbong"].HeaderText = "Học bổng";
           
        }

        private void BtnBatdau_Click(object sender, EventArgs e)
        {
            if (cbbdskhoa.SelectedIndex != -1)
            {
                string maKhoa = cbbdskhoa.SelectedValue?.ToString();
                LoadDSForKhoa(maKhoa);
            }
        }

        private void BtnThoat_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btnXuatexcel_Click(object sender, EventArgs e)
        {
            if (dgvDShocbong.Rows.Count > 0)
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
                    foreach (DataGridViewColumn column in dgvDShocbong.Columns)
                    {
                        Cell cell = CreateTextCell(column.HeaderText);
                        headerRow.AppendChild(cell);
                    }

                    sheetData.AppendChild(headerRow);

                    // Thêm dữ liệu
                    foreach (DataGridViewRow dgvRow in dgvDShocbong.Rows)
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

    }
}
