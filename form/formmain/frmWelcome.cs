using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Windows.Forms.DataVisualization.Charting;

namespace QuanLySinhVienCshape
{
    public partial class frmWelcome : Form
    {
        private void DrawPieChart(DataTable resultTable)
        {
            // Xóa các Series hiện tại (nếu có)
            chart1.Series.Clear();

            // Tạo một Series mới cho PieChart
            Series series = new Series("Data");
            series.ChartType = SeriesChartType.Pie;

            // Thêm dữ liệu vào Series
            foreach (DataRow row in resultTable.Rows)
            {
                string type = row["Type"].ToString();
                int count = Convert.ToInt32(row["Count"]);

                DataPoint dataPoint = new DataPoint();
                dataPoint.Label = $"{type}: {count}%";
                dataPoint.YValues = new double[] { count };

                series.Points.Add(dataPoint);
            }

            // Thêm Series vào Chart
            chart1.Series.Add(series);

            // Cài đặt một số thuộc tính khác của Chart (tuỳ chọn)
            chart1.Legends.Add(new Legend());
            chart1.Legends[0].Docking = Docking.Bottom;
            chart1.Legends[0].Alignment = StringAlignment.Center;

            // Hiển thị biểu đồ
            chart1.Invalidate();
        }
        private Database db;
        public frmWelcome()
        {
            InitializeComponent();
        }

        private void frmWelcome_Load(object sender, EventArgs e)
        {
            db = new Database();
            // Gọi phương thức để đếm số lượng bản ghi và hiển thị trên các Label
            CountAndDisplayRecords();
        }
        private void CountAndDisplayRecords()
        {
            try
            {
                DataTable resultTable = db.SelectData("CountRecords", new List<CustomParameter>());
                // Vẽ PieChart dựa trên dữ liệu từ DataTable
                DrawPieChart(resultTable);
                foreach (DataRow row in resultTable.Rows)
                {
                    string type = row["Type"].ToString();
                    int count = Convert.ToInt32(row["Count"]);

                    switch (type)
                    {
                        case "SoSinhVien":
                            lblSinhvien.Text = count.ToString();
                            break;
                        case "SoKhoa":
                            lblKhoa.Text = count.ToString();
                            break;
                        case "SoGiaoVien":
                            lblGiaovien.Text = count.ToString();
                            break;
                        case "SoLopHoc":
                            lblLop.Text = count.ToString();
                            break;
                        case "SoMonHoc":
                            LblMonhoc.Text = count.ToString();
                            break;
                    }
                }

            }
            catch (Exception ex)
            {
                MessageBox.Show("Lỗi: " + ex.Message);
            }
        }
 
    }
}
