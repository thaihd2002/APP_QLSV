namespace QuanLySinhVienCshape
{
    partial class frmDSGV
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle1 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle2 = new System.Windows.Forms.DataGridViewCellStyle();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(frmDSGV));
            this.labelTentieude = new System.Windows.Forms.Label();
            this.panel4 = new System.Windows.Forms.Panel();
            this.dgvDSGV = new System.Windows.Forms.DataGridView();
            this.panel3 = new System.Windows.Forms.Panel();
            this.panel2 = new System.Windows.Forms.Panel();
            this.paneldgv = new System.Windows.Forms.Panel();
            this.label11 = new System.Windows.Forms.Label();
            this.panelthongbao = new System.Windows.Forms.Panel();
            this.cbbdskhoa = new ReaLTaiizor.DungeonComboBox();
            this.labelKhoa = new System.Windows.Forms.Label();
            this.panelkhoa = new System.Windows.Forms.Panel();
            this.groupBoxthongtin = new System.Windows.Forms.GroupBox();
            this.label4 = new System.Windows.Forms.Label();
            this.x = new System.Windows.Forms.TextBox();
            this.btnTimkiem = new System.Windows.Forms.Button();
            this.btnreset = new System.Windows.Forms.Button();
            this.btnThemmoi = new System.Windows.Forms.Button();
            this.btnXoa = new System.Windows.Forms.Button();
            this.grbchucnang = new System.Windows.Forms.GroupBox();
            this.btnExcel = new System.Windows.Forms.Button();
            this.panel1 = new System.Windows.Forms.Panel();
            this.panelthongtin = new System.Windows.Forms.Panel();
            this.panel4.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvDSGV)).BeginInit();
            this.panel3.SuspendLayout();
            this.panel2.SuspendLayout();
            this.paneldgv.SuspendLayout();
            this.panelthongbao.SuspendLayout();
            this.panelkhoa.SuspendLayout();
            this.groupBoxthongtin.SuspendLayout();
            this.grbchucnang.SuspendLayout();
            this.panel1.SuspendLayout();
            this.panelthongtin.SuspendLayout();
            this.SuspendLayout();
            // 
            // labelTentieude
            // 
            this.labelTentieude.AutoSize = true;
            this.labelTentieude.Font = new System.Drawing.Font("Segoe UI", 14.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(163)));
            this.labelTentieude.Location = new System.Drawing.Point(699, 8);
            this.labelTentieude.Name = "labelTentieude";
            this.labelTentieude.Size = new System.Drawing.Size(188, 25);
            this.labelTentieude.TabIndex = 39;
            this.labelTentieude.Text = "Danh sách giáo viên";
            // 
            // panel4
            // 
            this.panel4.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(210)))), ((int)(((byte)(210)))), ((int)(((byte)(210)))));
            this.panel4.Controls.Add(this.labelTentieude);
            this.panel4.Dock = System.Windows.Forms.DockStyle.Top;
            this.panel4.Location = new System.Drawing.Point(0, 0);
            this.panel4.Name = "panel4";
            this.panel4.Size = new System.Drawing.Size(1329, 40);
            this.panel4.TabIndex = 0;
            // 
            // dgvDSGV
            // 
            this.dgvDSGV.AllowUserToAddRows = false;
            this.dgvDSGV.AllowUserToDeleteRows = false;
            this.dgvDSGV.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.Fill;
            this.dgvDSGV.BackgroundColor = System.Drawing.SystemColors.ControlLightLight;
            this.dgvDSGV.BorderStyle = System.Windows.Forms.BorderStyle.None;
            dataGridViewCellStyle1.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle1.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(0)))), ((int)(((byte)(192)))), ((int)(((byte)(192)))));
            dataGridViewCellStyle1.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(163)));
            dataGridViewCellStyle1.ForeColor = System.Drawing.Color.White;
            dataGridViewCellStyle1.SelectionBackColor = System.Drawing.Color.Red;
            dataGridViewCellStyle1.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle1.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
            this.dgvDSGV.ColumnHeadersDefaultCellStyle = dataGridViewCellStyle1;
            this.dgvDSGV.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            dataGridViewCellStyle2.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle2.BackColor = System.Drawing.Color.White;
            dataGridViewCellStyle2.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(163)));
            dataGridViewCellStyle2.ForeColor = System.Drawing.Color.Black;
            dataGridViewCellStyle2.SelectionBackColor = System.Drawing.Color.FromArgb(((int)(((byte)(128)))), ((int)(((byte)(255)))), ((int)(((byte)(128)))));
            dataGridViewCellStyle2.SelectionForeColor = System.Drawing.Color.Black;
            dataGridViewCellStyle2.WrapMode = System.Windows.Forms.DataGridViewTriState.False;
            this.dgvDSGV.DefaultCellStyle = dataGridViewCellStyle2;
            this.dgvDSGV.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dgvDSGV.EnableHeadersVisualStyles = false;
            this.dgvDSGV.Location = new System.Drawing.Point(0, 0);
            this.dgvDSGV.MultiSelect = false;
            this.dgvDSGV.Name = "dgvDSGV";
            this.dgvDSGV.ReadOnly = true;
            this.dgvDSGV.RowTemplate.Height = 30;
            this.dgvDSGV.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dgvDSGV.Size = new System.Drawing.Size(1329, 388);
            this.dgvDSGV.TabIndex = 31;
            this.dgvDSGV.CellDoubleClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dgvDSGV_CellDoubleClick);
            // 
            // panel3
            // 
            this.panel3.Controls.Add(this.dgvDSGV);
            this.panel3.Dock = System.Windows.Forms.DockStyle.Fill;
            this.panel3.Location = new System.Drawing.Point(0, 40);
            this.panel3.Name = "panel3";
            this.panel3.Size = new System.Drawing.Size(1329, 388);
            this.panel3.TabIndex = 1;
            // 
            // panel2
            // 
            this.panel2.Controls.Add(this.panel3);
            this.panel2.Controls.Add(this.panel4);
            this.panel2.Dock = System.Windows.Forms.DockStyle.Fill;
            this.panel2.Location = new System.Drawing.Point(0, 0);
            this.panel2.Name = "panel2";
            this.panel2.Size = new System.Drawing.Size(1329, 428);
            this.panel2.TabIndex = 2;
            // 
            // paneldgv
            // 
            this.paneldgv.Controls.Add(this.panel2);
            this.paneldgv.Dock = System.Windows.Forms.DockStyle.Fill;
            this.paneldgv.Location = new System.Drawing.Point(0, 181);
            this.paneldgv.Name = "paneldgv";
            this.paneldgv.Size = new System.Drawing.Size(1329, 428);
            this.paneldgv.TabIndex = 3;
            // 
            // label11
            // 
            this.label11.AutoSize = true;
            this.label11.Font = new System.Drawing.Font("Segoe UI", 18F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(163)));
            this.label11.Location = new System.Drawing.Point(12, 4);
            this.label11.Name = "label11";
            this.label11.Size = new System.Drawing.Size(248, 32);
            this.label11.TabIndex = 0;
            this.label11.Text = "QUẢN LÝ GIÁO VIÊN";
            // 
            // panelthongbao
            // 
            this.panelthongbao.BackColor = System.Drawing.Color.White;
            this.panelthongbao.Controls.Add(this.label11);
            this.panelthongbao.Dock = System.Windows.Forms.DockStyle.Top;
            this.panelthongbao.Location = new System.Drawing.Point(0, 0);
            this.panelthongbao.Name = "panelthongbao";
            this.panelthongbao.Size = new System.Drawing.Size(1329, 39);
            this.panelthongbao.TabIndex = 28;
            // 
            // cbbdskhoa
            // 
            this.cbbdskhoa.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(246)))), ((int)(((byte)(246)))), ((int)(((byte)(246)))));
            this.cbbdskhoa.ColorA = System.Drawing.Color.FromArgb(((int)(((byte)(246)))), ((int)(((byte)(132)))), ((int)(((byte)(85)))));
            this.cbbdskhoa.ColorB = System.Drawing.Color.FromArgb(((int)(((byte)(231)))), ((int)(((byte)(108)))), ((int)(((byte)(57)))));
            this.cbbdskhoa.ColorC = System.Drawing.Color.FromArgb(((int)(((byte)(242)))), ((int)(((byte)(241)))), ((int)(((byte)(240)))));
            this.cbbdskhoa.ColorD = System.Drawing.Color.FromArgb(((int)(((byte)(253)))), ((int)(((byte)(252)))), ((int)(((byte)(252)))));
            this.cbbdskhoa.ColorE = System.Drawing.Color.FromArgb(((int)(((byte)(239)))), ((int)(((byte)(237)))), ((int)(((byte)(236)))));
            this.cbbdskhoa.ColorF = System.Drawing.Color.FromArgb(((int)(((byte)(180)))), ((int)(((byte)(180)))), ((int)(((byte)(180)))));
            this.cbbdskhoa.ColorG = System.Drawing.Color.FromArgb(((int)(((byte)(119)))), ((int)(((byte)(119)))), ((int)(((byte)(118)))));
            this.cbbdskhoa.ColorH = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(222)))), ((int)(((byte)(220)))));
            this.cbbdskhoa.ColorI = System.Drawing.Color.FromArgb(((int)(((byte)(250)))), ((int)(((byte)(249)))), ((int)(((byte)(249)))));
            this.cbbdskhoa.Cursor = System.Windows.Forms.Cursors.Hand;
            this.cbbdskhoa.DrawMode = System.Windows.Forms.DrawMode.OwnerDrawFixed;
            this.cbbdskhoa.DropDownHeight = 100;
            this.cbbdskhoa.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cbbdskhoa.Font = new System.Drawing.Font("Segoe UI", 10F);
            this.cbbdskhoa.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(76)))), ((int)(((byte)(76)))), ((int)(((byte)(97)))));
            this.cbbdskhoa.FormattingEnabled = true;
            this.cbbdskhoa.HoverSelectionColor = System.Drawing.Color.Empty;
            this.cbbdskhoa.IntegralHeight = false;
            this.cbbdskhoa.ItemHeight = 20;
            this.cbbdskhoa.Location = new System.Drawing.Point(110, 9);
            this.cbbdskhoa.Name = "cbbdskhoa";
            this.cbbdskhoa.Size = new System.Drawing.Size(220, 26);
            this.cbbdskhoa.StartIndex = 0;
            this.cbbdskhoa.TabIndex = 40;
            this.cbbdskhoa.SelectedIndexChanged += new System.EventHandler(this.cbbdskhoa_SelectedIndexChanged);
            // 
            // labelKhoa
            // 
            this.labelKhoa.AutoSize = true;
            this.labelKhoa.Font = new System.Drawing.Font("Segoe UI", 14.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(163)));
            this.labelKhoa.Location = new System.Drawing.Point(49, 9);
            this.labelKhoa.Name = "labelKhoa";
            this.labelKhoa.Size = new System.Drawing.Size(57, 25);
            this.labelKhoa.TabIndex = 39;
            this.labelKhoa.Text = "Khoa";
            // 
            // panelkhoa
            // 
            this.panelkhoa.Controls.Add(this.cbbdskhoa);
            this.panelkhoa.Controls.Add(this.labelKhoa);
            this.panelkhoa.Dock = System.Windows.Forms.DockStyle.Top;
            this.panelkhoa.Location = new System.Drawing.Point(3, 21);
            this.panelkhoa.Name = "panelkhoa";
            this.panelkhoa.Size = new System.Drawing.Size(361, 44);
            this.panelkhoa.TabIndex = 0;
            // 
            // groupBoxthongtin
            // 
            this.groupBoxthongtin.Controls.Add(this.panelkhoa);
            this.groupBoxthongtin.Dock = System.Windows.Forms.DockStyle.Left;
            this.groupBoxthongtin.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(163)));
            this.groupBoxthongtin.Location = new System.Drawing.Point(0, 39);
            this.groupBoxthongtin.Name = "groupBoxthongtin";
            this.groupBoxthongtin.Size = new System.Drawing.Size(367, 142);
            this.groupBoxthongtin.TabIndex = 29;
            this.groupBoxthongtin.TabStop = false;
            this.groupBoxthongtin.Text = "thông tin";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(163)));
            this.label4.Location = new System.Drawing.Point(13, 23);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(66, 17);
            this.label4.TabIndex = 29;
            this.label4.Text = "Tìm kiếm";
            // 
            // x
            // 
            this.x.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(163)));
            this.x.Location = new System.Drawing.Point(16, 45);
            this.x.Multiline = true;
            this.x.Name = "x";
            this.x.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
            this.x.Size = new System.Drawing.Size(193, 36);
            this.x.TabIndex = 23;
            // 
            // btnTimkiem
            // 
            this.btnTimkiem.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(0)))), ((int)(((byte)(102)))), ((int)(((byte)(204)))));
            this.btnTimkiem.FlatAppearance.BorderSize = 0;
            this.btnTimkiem.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnTimkiem.ForeColor = System.Drawing.Color.White;
            this.btnTimkiem.Image = ((System.Drawing.Image)(resources.GetObject("btnTimkiem.Image")));
            this.btnTimkiem.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.btnTimkiem.Location = new System.Drawing.Point(221, 45);
            this.btnTimkiem.Name = "btnTimkiem";
            this.btnTimkiem.Size = new System.Drawing.Size(97, 36);
            this.btnTimkiem.TabIndex = 24;
            this.btnTimkiem.Text = "Tìm kiếm";
            this.btnTimkiem.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            this.btnTimkiem.UseVisualStyleBackColor = false;
            this.btnTimkiem.Click += new System.EventHandler(this.btnTimKiem_Click);
            // 
            // btnreset
            // 
            this.btnreset.Location = new System.Drawing.Point(428, 95);
            this.btnreset.Name = "btnreset";
            this.btnreset.Size = new System.Drawing.Size(100, 36);
            this.btnreset.TabIndex = 27;
            this.btnreset.Text = "Reset";
            this.btnreset.UseVisualStyleBackColor = true;
            // 
            // btnThemmoi
            // 
            this.btnThemmoi.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(0)))), ((int)(((byte)(184)))), ((int)(((byte)(86)))));
            this.btnThemmoi.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnThemmoi.ForeColor = System.Drawing.Color.White;
            this.btnThemmoi.Location = new System.Drawing.Point(16, 95);
            this.btnThemmoi.Name = "btnThemmoi";
            this.btnThemmoi.Size = new System.Drawing.Size(97, 36);
            this.btnThemmoi.TabIndex = 25;
            this.btnThemmoi.Text = "Thêm mới";
            this.btnThemmoi.UseVisualStyleBackColor = false;
            this.btnThemmoi.Click += new System.EventHandler(this.btnThemMoi_Click);
            // 
            // btnXoa
            // 
            this.btnXoa.BackColor = System.Drawing.Color.Red;
            this.btnXoa.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnXoa.ForeColor = System.Drawing.Color.White;
            this.btnXoa.Location = new System.Drawing.Point(143, 95);
            this.btnXoa.Name = "btnXoa";
            this.btnXoa.Size = new System.Drawing.Size(97, 36);
            this.btnXoa.TabIndex = 26;
            this.btnXoa.Text = "Xóa";
            this.btnXoa.UseVisualStyleBackColor = false;
            this.btnXoa.Click += new System.EventHandler(this.btnxoa_Click);
            // 
            // grbchucnang
            // 
            this.grbchucnang.Controls.Add(this.label4);
            this.grbchucnang.Controls.Add(this.x);
            this.grbchucnang.Controls.Add(this.btnTimkiem);
            this.grbchucnang.Controls.Add(this.btnreset);
            this.grbchucnang.Controls.Add(this.btnExcel);
            this.grbchucnang.Controls.Add(this.btnThemmoi);
            this.grbchucnang.Controls.Add(this.btnXoa);
            this.grbchucnang.Dock = System.Windows.Forms.DockStyle.Fill;
            this.grbchucnang.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(163)));
            this.grbchucnang.Location = new System.Drawing.Point(0, 0);
            this.grbchucnang.Name = "grbchucnang";
            this.grbchucnang.Size = new System.Drawing.Size(962, 142);
            this.grbchucnang.TabIndex = 30;
            this.grbchucnang.TabStop = false;
            this.grbchucnang.Text = "Chức năng";
            // 
            // btnExcel
            // 
            this.btnExcel.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(0)))), ((int)(((byte)(190)))), ((int)(((byte)(255)))));
            this.btnExcel.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnExcel.ForeColor = System.Drawing.Color.White;
            this.btnExcel.Location = new System.Drawing.Point(290, 95);
            this.btnExcel.Name = "btnExcel";
            this.btnExcel.Size = new System.Drawing.Size(97, 36);
            this.btnExcel.TabIndex = 25;
            this.btnExcel.Text = "Xuất excel";
            this.btnExcel.UseVisualStyleBackColor = false;
            this.btnExcel.Click += new System.EventHandler(this.btnExcel_Click);
            // 
            // panel1
            // 
            this.panel1.Controls.Add(this.grbchucnang);
            this.panel1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.panel1.Location = new System.Drawing.Point(367, 39);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(962, 142);
            this.panel1.TabIndex = 30;
            // 
            // panelthongtin
            // 
            this.panelthongtin.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(191)))), ((int)(((byte)(205)))), ((int)(((byte)(219)))));
            this.panelthongtin.Controls.Add(this.panel1);
            this.panelthongtin.Controls.Add(this.groupBoxthongtin);
            this.panelthongtin.Controls.Add(this.panelthongbao);
            this.panelthongtin.Dock = System.Windows.Forms.DockStyle.Top;
            this.panelthongtin.Location = new System.Drawing.Point(0, 0);
            this.panelthongtin.Name = "panelthongtin";
            this.panelthongtin.Size = new System.Drawing.Size(1329, 181);
            this.panelthongtin.TabIndex = 2;
            // 
            // frmDSGV
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1329, 609);
            this.Controls.Add(this.paneldgv);
            this.Controls.Add(this.panelthongtin);
            this.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(163)));
            this.Margin = new System.Windows.Forms.Padding(4);
            this.Name = "frmDSGV";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Danh sách giáo viên";
            this.Load += new System.EventHandler(this.frmDSGV_Load);
            this.panel4.ResumeLayout(false);
            this.panel4.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvDSGV)).EndInit();
            this.panel3.ResumeLayout(false);
            this.panel2.ResumeLayout(false);
            this.paneldgv.ResumeLayout(false);
            this.panelthongbao.ResumeLayout(false);
            this.panelthongbao.PerformLayout();
            this.panelkhoa.ResumeLayout(false);
            this.panelkhoa.PerformLayout();
            this.groupBoxthongtin.ResumeLayout(false);
            this.grbchucnang.ResumeLayout(false);
            this.grbchucnang.PerformLayout();
            this.panel1.ResumeLayout(false);
            this.panelthongtin.ResumeLayout(false);
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Label labelTentieude;
        private System.Windows.Forms.Panel panel4;
        private System.Windows.Forms.DataGridView dgvDSGV;
        private System.Windows.Forms.Panel panel3;
        private System.Windows.Forms.Panel panel2;
        private System.Windows.Forms.Panel paneldgv;
        private System.Windows.Forms.Label label11;
        private System.Windows.Forms.Panel panelthongbao;
        private ReaLTaiizor.DungeonComboBox cbbdskhoa;
        private System.Windows.Forms.Label labelKhoa;
        private System.Windows.Forms.Panel panelkhoa;
        private System.Windows.Forms.GroupBox groupBoxthongtin;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.TextBox x;
        private System.Windows.Forms.Button btnTimkiem;
        private System.Windows.Forms.Button btnreset;
        private System.Windows.Forms.Button btnThemmoi;
        private System.Windows.Forms.Button btnXoa;
        private System.Windows.Forms.GroupBox grbchucnang;
        private System.Windows.Forms.Button btnExcel;
        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.Panel panelthongtin;
    }
}