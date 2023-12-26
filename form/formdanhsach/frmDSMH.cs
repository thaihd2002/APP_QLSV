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
    public partial class frmDSMH_ : Form
    {
        public frmDSMH_()
        {
            InitializeComponent();
        }
        private Database db;
        private string mamonhoc = "";
        private string nguoithuchien = "admin";
        private string tukhoa = "";
        private void LoadDSMH()
        {
            List<CustomParameter> lstPara = new List<CustomParameter>();
            lstPara.Add(new CustomParameter()
            {
                key = "@tukhoa",
                value = tukhoa
            });
            dgvMonHoc.DataSource = new Database().SelectData("selectAllMonHoc",lstPara);
            dgvMonHoc.Columns["mamonhoc"].HeaderText = "Mã MH";
            dgvMonHoc.Columns["tenmonhoc"].HeaderText = "Tên môn học";
            dgvMonHoc.Columns["sotinchi"].HeaderText = "Số TC";
            txtMaMH.Text = "";
            txtTenMH.Text = "";
            txtSoTC.Text = "";
        }

        private void frmDSMH__Load(object sender, EventArgs e)
        {
            db = new Database();
            LoadDSMH();
            grbNhapMH.Enabled = false;
            dgvMonHoc.ClearSelection();
        }

        private void btnTimKiem_Click(object sender, EventArgs e)
        {
            tukhoa = txtTimKiem.Text;
            LoadDSMH();
        }

        private void btnxoa_Click(object sender, EventArgs e)
        {
            if (dgvMonHoc.SelectedRows.Count > 0)
            {
                string mmh = dgvMonHoc.SelectedRows[0].Cells["mamonhoc"].Value.ToString();

                DialogResult result = MessageBox.Show("Bạn có chắc chắn muốn xóa môn học ?", "Xác nhận xóa", MessageBoxButtons.OKCancel, MessageBoxIcon.Question);
                if (result == DialogResult.OK)
                {
                    var sql = "deleteMH";
                    var lstPara = new List<CustomParameter>()
                    {
                        new CustomParameter
                        {
                            key = "@mamonhoc",
                            value = mmh
                        }
                    };
                    var rs = new Database().ExeCute(sql, lstPara);
                    if (rs > 0)
                    {
                        MessageBox.Show("Xóa môn học thành công!");
                        LoadDSMH(); // Load lại danh sách sinh viên sau khi xóa
                    }
                    else
                    {
                        MessageBox.Show("Xóa môn học thất bại!");
                    }
                }
               LoadDSMH();
            }
            else
            {
                MessageBox.Show("Vui lòng chọn một môn học để xóa.", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }

        }

        private void panelthemthongtin_Paint(object sender, PaintEventArgs e)
        {

        }
        public void BTNNHAP(string mamonhoc)
        {
            // Làm mờ Panel chứa DataGridView
            paneldgv.Enabled = false;
            // Đặt màu nền và chữ mới khi Enabled là false
            dgvMonHoc.DefaultCellStyle.BackColor = SystemColors.Control;
            dgvMonHoc.DefaultCellStyle.ForeColor = SystemColors.GrayText;
            // Xóa lựa chọn của dòng nếu có
            dgvMonHoc.ClearSelection();
            grbNhapMH.Enabled = true;

            if (string.IsNullOrEmpty(mamonhoc))
            {
                grbNhapMH.Text = "Nhập thông tin môn học";
                txtMaMH.ReadOnly = false;
            }
            else
            {
                grbNhapMH.Text = "Sửa thông tin môn học";
                txtMaMH.ReadOnly = true;

                // Hiển thị thông tin của lớp học cần sửa
                ShowEditForm(mamonhoc);
            }
            txtMaMH.Select();
            btnThem.Enabled = false;
            BtnSua.Enabled = false;
            btnxoa.Enabled = false;
            BtnGhi.Enabled = true;
            BtnHuy.Enabled = true;
        }
        private void ShowEditForm(string mamonhoc)
        {

            if (string.IsNullOrEmpty(mamonhoc))
            {
                grbNhapMH.Text = "Nhập thông tin lớp";
            }
            else
            {
                grbNhapMH.Text = string.IsNullOrEmpty(mamonhoc) ? "Nhập thông tin lớp" : "Sửa thông tin lớp";
                txtMaMH.ReadOnly = !string.IsNullOrEmpty(mamonhoc);
                var r = new Database().Select("exec selectMH '" + mamonhoc + "'");
                txtMaMH.Text = r["mamonhoc"].ToString();
                txtTenMH.Text = r["tenmonhoc"].ToString();
                txtSoTC.Text = r["sotinchi"].ToString();
            }
        }
        private void btnThem_Click(object sender, EventArgs e)
        {
            BTNNHAP("");
        }

        public void BTNLUU()
        {

            paneldgv.Enabled = true;
            // Khôi phục màu nền và chữ khi Enabled là true
            dgvMonHoc.DefaultCellStyle.BackColor = SystemColors.Window;
            dgvMonHoc.DefaultCellStyle.ForeColor = SystemColors.ControlText;
            dgvMonHoc.ClearSelection();
            grbNhapMH.Enabled = false;
            btnThem.Enabled = true;
            BtnSua.Enabled = true;
            btnxoa.Enabled = true;
            BtnGhi.Enabled = false;
            BtnHuy.Enabled = false;

        }
        private void BtnGhi_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(txtMaMH.Text))
            {
                MessageBox.Show("Mã môn học không được để trống");
                txtMaMH.Select();
                return;
            }

            if (string.IsNullOrEmpty(txtTenMH.Text))
            {
                MessageBox.Show("Tên môn học không được để trống");
                txtTenMH.Select();
                return;
            }
            try
            {
                var stc = int.Parse(txtSoTC.Text);
                if (stc <= 0)
                {
                    MessageBox.Show("Số tín chỉ phải lớn hơn 0");
                    txtSoTC.Select();
                    return;
                }
            }
            catch
            {
                MessageBox.Show("Số tín chỉ phải là kiểu số nguyên");
                txtSoTC.Select();
                return;
            }

            string sql = "";
            string ma = txtMaMH.Text;
                List<CustomParameter> lst = new List<CustomParameter>();
                if (string.IsNullOrEmpty(mamonhoc))
                {
                    sql = "insertMH";
                    lst.Add(new CustomParameter()
                    {
                        key = "@nguoitao",
                        value = nguoithuchien
                    });
                    lst.Add(new CustomParameter()
                    {
                        key = "@mamonhoc",
                        value = ma

                    });
                }
                else
                {
                    sql = "updateMH";
                    lst.Add(new CustomParameter()
                    {
                        key = "@nguoicapnhat",
                        value = nguoithuchien
                    });
                    lst.Add(new CustomParameter()
                    {
                        key = "@mamonhoc",
                        value = mamonhoc
                    });
                }
                lst.Add(new CustomParameter()
                {
                    key = "@tenmonhoc",
                    value = txtTenMH.Text
                });
                lst.Add(new CustomParameter()
                {
                    key = "@sotinchi",
                    value = txtSoTC.Text

                });
                var kq = db.ExeCute(sql, lst);
                if (kq == 1)
                {

                    if (string.IsNullOrEmpty(mamonhoc))
                    {
                        MessageBox.Show("Thêm mới môn học thành công");
                    }
                    else
                    {
                        MessageBox.Show("Cập nhật môn học thành công");
                    }

                LoadDSMH();
                    BTNLUU();
                    mamonhoc = "";

                }
                else
                {
                    MessageBox.Show("Lưu dữ liệu thất bại");

                }
           
        }

        private void BtnSua_Click(object sender, EventArgs e)
        {
            // Check if a row is selected
            if (dgvMonHoc.SelectedRows.Count > 0)
            {
                // Get the selected row's malophoc value
                mamonhoc = dgvMonHoc.SelectedRows[0].Cells["mamonhoc"].Value.ToString();
                ShowEditForm(mamonhoc);
                BTNNHAP(mamonhoc);  
            }
            else
            {
                MessageBox.Show("Vui lòng chọn một lớp học để sửa.", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }

        }

        private void BtnHuy_Click(object sender, EventArgs e)
        {
            paneldgv.Enabled = true;
            // Khôi phục màu nền và chữ khi Enabled là true
            dgvMonHoc.DefaultCellStyle.BackColor = SystemColors.Window;
            dgvMonHoc.DefaultCellStyle.ForeColor = SystemColors.ControlText;
            dgvMonHoc.ClearSelection();
            grbNhapMH.Enabled = false;
            btnThem.Enabled = true;
            BtnSua.Enabled = true;
            btnxoa.Enabled = true;
            BtnGhi.Enabled = false;
            BtnHuy.Enabled = false;
            LoadDSMH();
        }
        private void btnthoat_Click(object sender, EventArgs e)
        {
            this.Close();
        }
        private void btnExcel_Click(object sender, EventArgs e)
        {
            if (dgvMonHoc.Rows.Count > 0)
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
                    foreach (DataGridViewColumn column in dgvMonHoc.Columns)
                    {
                        Cell cell = CreateTextCell(column.HeaderText);
                        headerRow.AppendChild(cell);
                    }

                    sheetData.AppendChild(headerRow);

                    // Thêm dữ liệu
                    foreach (DataGridViewRow dgvRow in dgvMonHoc.Rows)
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
