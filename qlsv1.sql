USE [master]
GO
/****** Object:  Database [QLSV]    Script Date: 30/11/2023 1:45:30 CH ******/
CREATE DATABASE [QLSV]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QLSV', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\QLSV.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'QLSV_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\QLSV_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [QLSV] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QLSV].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QLSV] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QLSV] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QLSV] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QLSV] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QLSV] SET ARITHABORT OFF 
GO
ALTER DATABASE [QLSV] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [QLSV] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QLSV] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QLSV] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QLSV] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QLSV] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QLSV] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QLSV] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QLSV] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QLSV] SET  DISABLE_BROKER 
GO
ALTER DATABASE [QLSV] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QLSV] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QLSV] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QLSV] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QLSV] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QLSV] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QLSV] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QLSV] SET RECOVERY FULL 
GO
ALTER DATABASE [QLSV] SET  MULTI_USER 
GO
ALTER DATABASE [QLSV] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QLSV] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QLSV] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QLSV] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [QLSV] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [QLSV] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'QLSV', N'ON'
GO
ALTER DATABASE [QLSV] SET QUERY_STORE = OFF
GO
USE [QLSV]
GO
/****** Object:  UserDefinedFunction [dbo].[CheckLopHocExists]    Script Date: 30/11/2023 1:45:30 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[CheckLopHocExists]
(
    @malophoc NVARCHAR(50)
)
RETURNS BIT
AS
BEGIN
    DECLARE @Exists BIT;

    SELECT @Exists = CASE WHEN EXISTS (SELECT 1 FROM dbo.tblLopHoc WHERE malophoc = @malophoc) THEN 1 ELSE 0 END;

    RETURN @Exists;
END;
GO
/****** Object:  Table [dbo].[taikhoan]    Script Date: 30/11/2023 1:45:30 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[taikhoan](
	[tentaikhoan] [varchar](30) NOT NULL,
	[matkhau] [varchar](250) NULL,
 CONSTRAINT [PK_taikhoan] PRIMARY KEY CLUSTERED 
(
	[tentaikhoan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblDeletedSinhVien]    Script Date: 30/11/2023 1:45:30 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblDeletedSinhVien](
	[masinhvien] [varchar](50) NULL,
	[ngayxoa] [datetime] NULL,
	[nguoixoa] [varchar](30) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblDiem]    Script Date: 30/11/2023 1:45:30 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblDiem](
	[ngaytao] [datetime] NULL,
	[nguoitao] [varchar](30) NULL,
	[ngaycapnhat] [datetime] NULL,
	[nguoicapnhat] [varchar](30) NULL,
	[masinhvien] [varchar](50) NOT NULL,
	[malophocphan] [varchar](50) NOT NULL,
	[diemchuyencan] [float] NULL,
	[diemheso1] [float] NULL,
	[diemheso2_1] [float] NULL,
	[diemheso2_2] [float] NULL,
	[diemquatrinh] [float] NULL,
	[diemthi] [float] NULL,
	[diemhocphan] [float] NULL,
 CONSTRAINT [PK_tblDiem] PRIMARY KEY CLUSTERED 
(
	[masinhvien] ASC,
	[malophocphan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblDiemTrungBinh]    Script Date: 30/11/2023 1:45:30 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblDiemTrungBinh](
	[masinhvien] [varchar](50) NOT NULL,
	[hoten] [nvarchar](max) NULL,
	[nsinh] [nvarchar](10) NULL,
	[gioitinh] [nvarchar](3) NULL,
	[lophoc] [nvarchar](max) NULL,
	[makhoa] [nvarchar](max) NULL,
	[diemtrungbinh] [float] NULL,
 CONSTRAINT [PK__tblDiemT__0C8D7038C6ADBADC] PRIMARY KEY CLUSTERED 
(
	[masinhvien] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblGiaoVien]    Script Date: 30/11/2023 1:45:30 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblGiaoVien](
	[ngaytao] [datetime] NULL,
	[nguoitao] [varchar](30) NULL,
	[ngaycapnhat] [datetime] NULL,
	[nguoicapnhat] [varchar](30) NULL,
	[matkhau] [varchar](50) NULL,
	[magiaovien] [varchar](50) NOT NULL,
	[ho] [nvarchar](10) NULL,
	[tendem] [nvarchar](20) NULL,
	[ten] [nvarchar](10) NULL,
	[gioitinh] [tinyint] NULL,
	[ngaysinh] [date] NULL,
	[dienthoai] [varchar](30) NULL,
	[email] [varchar](150) NULL,
	[diachi] [nvarchar](150) NULL,
	[makhoa] [nvarchar](50) NULL,
 CONSTRAINT [PK_tblGiaoVien_magiaovien] PRIMARY KEY CLUSTERED 
(
	[magiaovien] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblKhoa]    Script Date: 30/11/2023 1:45:30 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblKhoa](
	[makhoa] [nvarchar](50) NOT NULL,
	[tenkhoa] [nvarchar](50) NULL,
 CONSTRAINT [PK_tblKhoa] PRIMARY KEY CLUSTERED 
(
	[makhoa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblLopHoc]    Script Date: 30/11/2023 1:45:30 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblLopHoc](
	[ngaytao] [datetime] NULL,
	[nguoitao] [varchar](30) NULL,
	[ngaycapnhat] [datetime] NULL,
	[nguoicapnhat] [varchar](30) NULL,
	[malophoc] [varchar](50) NOT NULL,
	[tenlophoc] [varchar](50) NULL,
	[khoahoc] [varchar](50) NULL,
	[hedaotao] [nvarchar](60) NULL,
	[namnhaphoc] [int] NULL,
	[makhoa] [nvarchar](50) NULL,
	[magiaovien] [varchar](50) NULL,
 CONSTRAINT [PK_tblLopHoc] PRIMARY KEY CLUSTERED 
(
	[malophoc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblLopHocPhan]    Script Date: 30/11/2023 1:45:30 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblLopHocPhan](
	[ngaytao] [datetime] NULL,
	[nguoitao] [varchar](30) NULL,
	[ngaycapnhat] [datetime] NULL,
	[nguoicapnhat] [varchar](30) NULL,
	[malophocphan] [varchar](50) NOT NULL,
	[mamonhoc] [varchar](50) NOT NULL,
	[magiaovien] [varchar](50) NULL,
	[hocky] [int] NULL,
	[nam] [int] NULL,
	[makhoa] [nvarchar](50) NULL,
 CONSTRAINT [PK_tblLopHocPhan] PRIMARY KEY CLUSTERED 
(
	[malophocphan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblMonHoc]    Script Date: 30/11/2023 1:45:30 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblMonHoc](
	[ngaytao] [datetime] NULL,
	[nguoitao] [varchar](30) NULL,
	[ngaycapnhat] [datetime] NULL,
	[nguoicapnhat] [varchar](30) NULL,
	[mamonhoc] [varchar](50) NOT NULL,
	[tenmonhoc] [nvarchar](150) NULL,
	[sotinchi] [int] NULL,
 CONSTRAINT [PK_tblMonHoc] PRIMARY KEY CLUSTERED 
(
	[mamonhoc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblPhongDaoTao]    Script Date: 30/11/2023 1:45:30 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblPhongDaoTao](
	[ngaytao] [datetime] NULL,
	[nguoitao] [varchar](30) NULL,
	[ngaycapnhat] [datetime] NULL,
	[nguoicapnhat] [varchar](30) NULL,
	[manhanvien] [varchar](50) NOT NULL,
	[matkhau] [varchar](50) NULL,
	[ho] [nvarchar](10) NULL,
	[tendem] [nvarchar](20) NULL,
	[ten] [nvarchar](10) NULL,
	[gioitinh] [tinyint] NULL,
	[ngaysinh] [date] NULL,
	[dienthoai] [varchar](30) NULL,
	[email] [varchar](150) NULL,
	[diachi] [nvarchar](150) NULL,
 CONSTRAINT [PK_tblPhongDaoTao] PRIMARY KEY CLUSTERED 
(
	[manhanvien] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblSinhVien]    Script Date: 30/11/2023 1:45:30 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblSinhVien](
	[ngaytao] [datetime] NULL,
	[nguoicapnhat] [varchar](30) NULL,
	[nguoitao] [varchar](30) NULL,
	[ngaycapnhat] [datetime] NULL,
	[masinhvien] [varchar](50) NOT NULL,
	[matkhau] [varchar](50) NULL,
	[ho] [nvarchar](10) NULL,
	[tendem] [nvarchar](20) NULL,
	[ten] [nvarchar](10) NULL,
	[ngaysinh] [date] NULL,
	[gioitinh] [tinyint] NULL,
	[quequan] [nvarchar](150) NULL,
	[diachi] [nvarchar](150) NULL,
	[dienthoai] [varchar](30) NULL,
	[email] [varchar](150) NULL,
	[malophoc] [varchar](50) NOT NULL,
	[hocbong] [nvarchar](50) NULL,
 CONSTRAINT [PK_tblSinhVien] PRIMARY KEY CLUSTERED 
(
	[masinhvien] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[taikhoan] ([tentaikhoan], [matkhau]) VALUES (N'admin', N'admin')
GO
INSERT [dbo].[tblDiem] ([ngaytao], [nguoitao], [ngaycapnhat], [nguoicapnhat], [masinhvien], [malophocphan], [diemchuyencan], [diemheso1], [diemheso2_1], [diemheso2_2], [diemquatrinh], [diemthi], [diemhocphan]) VALUES (CAST(N'2023-11-12T18:39:32.307' AS DateTime), N'SV1100', CAST(N'2023-11-17T15:24:58.533' AS DateTime), N'van', N'SV1100', N'TinA1', 10, 9, 9, 9, 9.29, 10, 9.72)
INSERT [dbo].[tblDiem] ([ngaytao], [nguoitao], [ngaycapnhat], [nguoicapnhat], [masinhvien], [malophocphan], [diemchuyencan], [diemheso1], [diemheso2_1], [diemheso2_2], [diemquatrinh], [diemthi], [diemhocphan]) VALUES (CAST(N'2023-11-12T10:34:16.333' AS DateTime), N'SV1100', CAST(N'2023-11-12T18:25:34.450' AS DateTime), N'van', N'SV1100', N'TinA2', 10, 9, 9, 9, 9.38, 9, 9.15)
INSERT [dbo].[tblDiem] ([ngaytao], [nguoitao], [ngaycapnhat], [nguoicapnhat], [masinhvien], [malophocphan], [diemchuyencan], [diemheso1], [diemheso2_1], [diemheso2_2], [diemquatrinh], [diemthi], [diemhocphan]) VALUES (CAST(N'2023-11-11T11:58:20.053' AS DateTime), N'admin', CAST(N'2023-11-18T15:46:54.593' AS DateTime), N'van', N'SV1100', N'TinA3', 10, 9, 9, 9, 9.38, 9, 9.15)
INSERT [dbo].[tblDiem] ([ngaytao], [nguoitao], [ngaycapnhat], [nguoicapnhat], [masinhvien], [malophocphan], [diemchuyencan], [diemheso1], [diemheso2_1], [diemheso2_2], [diemquatrinh], [diemthi], [diemhocphan]) VALUES (CAST(N'2023-11-12T18:39:48.083' AS DateTime), N'SV1100', CAST(N'2023-11-17T15:43:27.597' AS DateTime), N'van', N'SV1100', N'TinA6', 8, 9, 10, 9, 8.78, 8, 8.31)
INSERT [dbo].[tblDiem] ([ngaytao], [nguoitao], [ngaycapnhat], [nguoicapnhat], [masinhvien], [malophocphan], [diemchuyencan], [diemheso1], [diemheso2_1], [diemheso2_2], [diemquatrinh], [diemthi], [diemhocphan]) VALUES (CAST(N'2023-11-11T12:03:25.880' AS DateTime), N'admin', CAST(N'2023-11-12T18:25:34.450' AS DateTime), N'van', N'SV1101', N'TinA2', 10, 9, 8, 9, 9.13, 8, 8.45)
INSERT [dbo].[tblDiem] ([ngaytao], [nguoitao], [ngaycapnhat], [nguoicapnhat], [masinhvien], [malophocphan], [diemchuyencan], [diemheso1], [diemheso2_1], [diemheso2_2], [diemquatrinh], [diemthi], [diemhocphan]) VALUES (CAST(N'2023-11-12T02:02:19.617' AS DateTime), N'admin', CAST(N'2023-11-18T15:46:54.600' AS DateTime), N'van', N'SV1101', N'TinA3', 10, 8, 9, 9, 9.25, 9, 9.1)
INSERT [dbo].[tblDiem] ([ngaytao], [nguoitao], [ngaycapnhat], [nguoicapnhat], [masinhvien], [malophocphan], [diemchuyencan], [diemheso1], [diemheso2_1], [diemheso2_2], [diemquatrinh], [diemthi], [diemhocphan]) VALUES (CAST(N'2023-11-17T15:41:22.550' AS DateTime), N'SV1101', CAST(N'2023-11-17T15:43:27.600' AS DateTime), N'van', N'SV1101', N'TinA6', 10, 9, 9, 8, 9.22, 9, 9.09)
INSERT [dbo].[tblDiem] ([ngaytao], [nguoitao], [ngaycapnhat], [nguoicapnhat], [masinhvien], [malophocphan], [diemchuyencan], [diemheso1], [diemheso2_1], [diemheso2_2], [diemquatrinh], [diemthi], [diemhocphan]) VALUES (CAST(N'2023-11-12T02:02:45.400' AS DateTime), N'admin', CAST(N'2023-11-18T15:46:54.603' AS DateTime), N'van', N'SV1102', N'TinA3', 10, 8, 9, 8, 9, 6, 7.2)
INSERT [dbo].[tblDiem] ([ngaytao], [nguoitao], [ngaycapnhat], [nguoicapnhat], [masinhvien], [malophocphan], [diemchuyencan], [diemheso1], [diemheso2_1], [diemheso2_2], [diemquatrinh], [diemthi], [diemhocphan]) VALUES (CAST(N'2023-11-12T02:02:53.417' AS DateTime), N'admin', CAST(N'2023-11-18T15:46:54.607' AS DateTime), N'van', N'SV1103', N'TinA3', 10, 8, 9, 9, 9.25, 8, 8.5)
INSERT [dbo].[tblDiem] ([ngaytao], [nguoitao], [ngaycapnhat], [nguoicapnhat], [masinhvien], [malophocphan], [diemchuyencan], [diemheso1], [diemheso2_1], [diemheso2_2], [diemquatrinh], [diemthi], [diemhocphan]) VALUES (CAST(N'2023-11-11T23:35:31.700' AS DateTime), N'SV1108', CAST(N'2023-11-18T15:46:54.607' AS DateTime), N'van', N'SV1108', N'TinA3', 9, 8, 9, 8, 8.63, 8, 8.25)
GO
INSERT [dbo].[tblDiemTrungBinh] ([masinhvien], [hoten], [nsinh], [gioitinh], [lophoc], [makhoa], [diemtrungbinh]) VALUES (N'SV1100', N'Phạm Duy Tân', N'22/05/2002', N'Nam', N'DHTi14A7HN', N'CNTT', 9.15)
INSERT [dbo].[tblDiemTrungBinh] ([masinhvien], [hoten], [nsinh], [gioitinh], [lophoc], [makhoa], [diemtrungbinh]) VALUES (N'SV1101', N'Trần Văn Nam', N'24/07/2002', N'Nam', N'DHTi14A7HN', N'CNTT', 9.1)
GO
INSERT [dbo].[tblGiaoVien] ([ngaytao], [nguoitao], [ngaycapnhat], [nguoicapnhat], [matkhau], [magiaovien], [ho], [tendem], [ten], [gioitinh], [ngaysinh], [dienthoai], [email], [diachi], [makhoa]) VALUES (CAST(N'2019-10-23T20:30:55.670' AS DateTime), N'admin', CAST(N'2023-11-20T20:49:53.477' AS DateTime), N'admin', N'12345', N'GV100', N'Trần', N'Như', N'Cát', 1, CAST(N'1987-01-01' AS Date), N'01245555125255', N'nhucat@gmail.com', N'Thái Bình', N'CNTT')
INSERT [dbo].[tblGiaoVien] ([ngaytao], [nguoitao], [ngaycapnhat], [nguoicapnhat], [matkhau], [magiaovien], [ho], [tendem], [ten], [gioitinh], [ngaysinh], [dienthoai], [email], [diachi], [makhoa]) VALUES (CAST(N'2019-10-23T20:30:55.670' AS DateTime), N'admin', CAST(N'2019-10-27T13:28:36.437' AS DateTime), N'admin', N'12345', N'GV101', N'Bùi', N'Văn', N'Hiếu', 1, CAST(N'1984-01-01' AS Date), N'0955448888', N'buivanhieu@gmail.com', N'Địa chỉ của thầy bùi văn hiếu', N'KT')
INSERT [dbo].[tblGiaoVien] ([ngaytao], [nguoitao], [ngaycapnhat], [nguoicapnhat], [matkhau], [magiaovien], [ho], [tendem], [ten], [gioitinh], [ngaysinh], [dienthoai], [email], [diachi], [makhoa]) VALUES (CAST(N'2019-10-23T20:30:55.670' AS DateTime), N'admin', CAST(N'2019-10-23T20:30:55.670' AS DateTime), N'admin', N'12345', N'GV102', N'Nguyễn', N'Thị Hải', N'Yến', 0, CAST(N'1977-12-11' AS Date), N'09845545888', N'nguyenthihaiyen@gmail.com', N'Địa chỉ của cô hải yến', N'TM')
INSERT [dbo].[tblGiaoVien] ([ngaytao], [nguoitao], [ngaycapnhat], [nguoicapnhat], [matkhau], [magiaovien], [ho], [tendem], [ten], [gioitinh], [ngaysinh], [dienthoai], [email], [diachi], [makhoa]) VALUES (CAST(N'2019-10-23T20:30:55.673' AS DateTime), N'admin', CAST(N'2023-11-20T20:50:03.007' AS DateTime), N'admin', N'12345', N'GV103', N'Đoàn', N'Thị', N'Nhi', 0, CAST(N'1987-10-20' AS Date), N'09113388777', N'quynhnhi@gmail.com', N'Hòa Bình', N'CNTT')
INSERT [dbo].[tblGiaoVien] ([ngaytao], [nguoitao], [ngaycapnhat], [nguoicapnhat], [matkhau], [magiaovien], [ho], [tendem], [ten], [gioitinh], [ngaysinh], [dienthoai], [email], [diachi], [makhoa]) VALUES (CAST(N'2019-10-27T13:28:57.707' AS DateTime), N'admin', CAST(N'2023-10-29T20:09:55.690' AS DateTime), N'admin', NULL, N'GV104', N'Bao', N'Thanh', N'Thiên', 1, CAST(N'1950-01-01' AS Date), N'098232321', N'anhlo23@gmail.com', N'Hà Nội', N'CNTT')
INSERT [dbo].[tblGiaoVien] ([ngaytao], [nguoitao], [ngaycapnhat], [nguoicapnhat], [matkhau], [magiaovien], [ho], [tendem], [ten], [gioitinh], [ngaysinh], [dienthoai], [email], [diachi], [makhoa]) VALUES (CAST(N'2023-10-29T20:10:55.670' AS DateTime), N'admin', CAST(N'2023-10-29T20:10:55.670' AS DateTime), N'admin', NULL, N'GV105', N'Phạm', N'Như ', N'Thanh', 1, CAST(N'1997-02-12' AS Date), N'023213213', N'thanhthanh2312@gmail,com', N'Hòa Bình', N'CNTT')
INSERT [dbo].[tblGiaoVien] ([ngaytao], [nguoitao], [ngaycapnhat], [nguoicapnhat], [matkhau], [magiaovien], [ho], [tendem], [ten], [gioitinh], [ngaysinh], [dienthoai], [email], [diachi], [makhoa]) VALUES (CAST(N'2023-11-20T20:49:24.790' AS DateTime), N'admin', CAST(N'2023-11-20T20:49:24.790' AS DateTime), N'admin', NULL, N'GV4', N'Bùi', N'Văn', N'Công', 1, CAST(N'1975-11-03' AS Date), N'023232432', N'congbui123@gmail.com', N'Hà Nội', N'CNTT')
GO
INSERT [dbo].[tblKhoa] ([makhoa], [tenkhoa]) VALUES (N'CNTT', N'Công Nghệ Thông Tin')
INSERT [dbo].[tblKhoa] ([makhoa], [tenkhoa]) VALUES (N'KT', N' Kinh Tế')
INSERT [dbo].[tblKhoa] ([makhoa], [tenkhoa]) VALUES (N'QTKD', N'Quản Trị Kinh Doanh')
INSERT [dbo].[tblKhoa] ([makhoa], [tenkhoa]) VALUES (N'TM', N'Thương Mại')
GO
INSERT [dbo].[tblLopHoc] ([ngaytao], [nguoitao], [ngaycapnhat], [nguoicapnhat], [malophoc], [tenlophoc], [khoahoc], [hedaotao], [namnhaphoc], [makhoa], [magiaovien]) VALUES (CAST(N'2023-10-26T00:55:22.413' AS DateTime), N'admin', CAST(N'2023-11-10T22:39:31.057' AS DateTime), N'admin', N'KTA6', N'DHKTe14A6HN', N'K14', N'Thạc sĩ', 2020, N'KT', N'GV100')
INSERT [dbo].[tblLopHoc] ([ngaytao], [nguoitao], [ngaycapnhat], [nguoicapnhat], [malophoc], [tenlophoc], [khoahoc], [hedaotao], [namnhaphoc], [makhoa], [magiaovien]) VALUES (CAST(N'2023-11-10T14:22:35.383' AS DateTime), N'admin', CAST(N'2023-11-10T17:22:58.757' AS DateTime), N'admin', N'TinA1', N'DHTi14A1HN', N'K14', N'Giáo sư', 2020, N'CNTT', N'GV101')
INSERT [dbo].[tblLopHoc] ([ngaytao], [nguoitao], [ngaycapnhat], [nguoicapnhat], [malophoc], [tenlophoc], [khoahoc], [hedaotao], [namnhaphoc], [makhoa], [magiaovien]) VALUES (CAST(N'2023-11-10T14:19:51.397' AS DateTime), N'admin', CAST(N'2023-11-10T17:59:56.077' AS DateTime), N'admin', N'TinA2', N'DHTi14A2HN', N'K14', N'Thạc sĩ', 2019, N'CNTT', N'GV105')
INSERT [dbo].[tblLopHoc] ([ngaytao], [nguoitao], [ngaycapnhat], [nguoicapnhat], [malophoc], [tenlophoc], [khoahoc], [hedaotao], [namnhaphoc], [makhoa], [magiaovien]) VALUES (CAST(N'2023-11-10T14:27:09.087' AS DateTime), N'admin', CAST(N'2023-11-10T14:27:09.087' AS DateTime), N'admin', N'TinA3', N'DHTi14A3HN', N'K17', N'Kĩ sư', 2020, N'CNTT', N'GV101')
INSERT [dbo].[tblLopHoc] ([ngaytao], [nguoitao], [ngaycapnhat], [nguoicapnhat], [malophoc], [tenlophoc], [khoahoc], [hedaotao], [namnhaphoc], [makhoa], [magiaovien]) VALUES (CAST(N'2023-10-26T00:52:14.830' AS DateTime), N'admin', CAST(N'2023-11-10T16:18:08.607' AS DateTime), N'admin', N'TinA5', N'DHTi14A5HN', N'K14', N'Kĩ sư', 2020, N'CNTT', N'GV101')
INSERT [dbo].[tblLopHoc] ([ngaytao], [nguoitao], [ngaycapnhat], [nguoicapnhat], [malophoc], [tenlophoc], [khoahoc], [hedaotao], [namnhaphoc], [makhoa], [magiaovien]) VALUES (CAST(N'2023-11-10T14:28:36.573' AS DateTime), N'admin', CAST(N'2023-11-10T14:28:36.573' AS DateTime), N'admin', N'TinA6', N'DHTi14A6HN', N'K14', N'Kĩ sư', 2020, N'CNTT', N'GV100')
INSERT [dbo].[tblLopHoc] ([ngaytao], [nguoitao], [ngaycapnhat], [nguoicapnhat], [malophoc], [tenlophoc], [khoahoc], [hedaotao], [namnhaphoc], [makhoa], [magiaovien]) VALUES (CAST(N'2023-10-26T00:51:34.693' AS DateTime), N'admin', CAST(N'2023-10-30T16:29:02.977' AS DateTime), N'admin', N'TinA7', N'DHTi14A7HN', N'K14', N'Giáo sư', 2020, N'CNTT', N'GV102')
INSERT [dbo].[tblLopHoc] ([ngaytao], [nguoitao], [ngaycapnhat], [nguoicapnhat], [malophoc], [tenlophoc], [khoahoc], [hedaotao], [namnhaphoc], [makhoa], [magiaovien]) VALUES (CAST(N'2023-10-30T16:32:52.710' AS DateTime), N'admin', CAST(N'2023-10-30T16:32:52.710' AS DateTime), N'admin', N'TmA1', N'DHTM16A1HN', N'K16', N'Cử nhân', 2021, N'TM', N'GV102')
INSERT [dbo].[tblLopHoc] ([ngaytao], [nguoitao], [ngaycapnhat], [nguoicapnhat], [malophoc], [tenlophoc], [khoahoc], [hedaotao], [namnhaphoc], [makhoa], [magiaovien]) VALUES (CAST(N'2023-10-30T15:55:43.870' AS DateTime), N'admin', CAST(N'2023-11-10T15:24:18.293' AS DateTime), N'admin', N'TmA3', N'DHTm16A9HN', N'K15', N'Kĩ sư', 2020, N'TM', N'GV103')
GO
INSERT [dbo].[tblLopHocPhan] ([ngaytao], [nguoitao], [ngaycapnhat], [nguoicapnhat], [malophocphan], [mamonhoc], [magiaovien], [hocky], [nam], [makhoa]) VALUES (CAST(N'2023-11-11T15:06:49.657' AS DateTime), N'admin', CAST(N'2023-11-11T15:06:49.657' AS DateTime), N'admin', N'KtA4', N'laptrinhweb', N'GV101', 2, 2020, N'KT')
INSERT [dbo].[tblLopHocPhan] ([ngaytao], [nguoitao], [ngaycapnhat], [nguoicapnhat], [malophocphan], [mamonhoc], [magiaovien], [hocky], [nam], [makhoa]) VALUES (CAST(N'2023-11-12T18:34:56.050' AS DateTime), N'admin', CAST(N'2023-11-12T18:34:56.050' AS DateTime), N'admin', N'TinA1', N'lichsudang', N'GV101', 3, 2020, N'CNTT')
INSERT [dbo].[tblLopHocPhan] ([ngaytao], [nguoitao], [ngaycapnhat], [nguoicapnhat], [malophocphan], [mamonhoc], [magiaovien], [hocky], [nam], [makhoa]) VALUES (CAST(N'2023-11-11T12:02:58.333' AS DateTime), N'admin', CAST(N'2023-11-11T12:02:58.333' AS DateTime), N'admin', N'TinA2', N'laptrinhweb', N'GV100', 3, 2020, N'CNTT')
INSERT [dbo].[tblLopHocPhan] ([ngaytao], [nguoitao], [ngaycapnhat], [nguoicapnhat], [malophocphan], [mamonhoc], [magiaovien], [hocky], [nam], [makhoa]) VALUES (CAST(N'2023-11-11T11:57:00.707' AS DateTime), N'admin', CAST(N'2023-11-11T11:57:00.707' AS DateTime), N'admin', N'TinA3', N'antoanthongtin', N'GV100', 5, 2020, N'CNTT')
INSERT [dbo].[tblLopHocPhan] ([ngaytao], [nguoitao], [ngaycapnhat], [nguoicapnhat], [malophocphan], [mamonhoc], [magiaovien], [hocky], [nam], [makhoa]) VALUES (CAST(N'2023-11-12T02:31:06.650' AS DateTime), N'admin', CAST(N'2023-11-12T02:31:06.650' AS DateTime), N'admin', N'TinA4', N'laptrinhnet', N'GV103', 3, 2020, N'TM')
INSERT [dbo].[tblLopHocPhan] ([ngaytao], [nguoitao], [ngaycapnhat], [nguoicapnhat], [malophocphan], [mamonhoc], [magiaovien], [hocky], [nam], [makhoa]) VALUES (CAST(N'2023-11-12T18:35:39.363' AS DateTime), N'admin', CAST(N'2023-11-12T18:35:39.363' AS DateTime), N'admin', N'TinA5', N'antoanthongtin', N'GV103', 3, 2020, N'CNTT')
INSERT [dbo].[tblLopHocPhan] ([ngaytao], [nguoitao], [ngaycapnhat], [nguoicapnhat], [malophocphan], [mamonhoc], [magiaovien], [hocky], [nam], [makhoa]) VALUES (CAST(N'2023-11-12T18:36:00.513' AS DateTime), N'admin', CAST(N'2023-11-12T18:36:00.513' AS DateTime), N'admin', N'TinA6', N'laptrinhnet', N'GV105', 3, 2020, N'CNTT')
INSERT [dbo].[tblLopHocPhan] ([ngaytao], [nguoitao], [ngaycapnhat], [nguoicapnhat], [malophocphan], [mamonhoc], [magiaovien], [hocky], [nam], [makhoa]) VALUES (CAST(N'2023-11-11T21:26:04.217' AS DateTime), N'admin', CAST(N'2023-11-11T21:26:04.217' AS DateTime), N'admin', N'TmA1', N'laptrinhnet', N'GV101', 3, 2020, N'TM')
GO
INSERT [dbo].[tblMonHoc] ([ngaytao], [nguoitao], [ngaycapnhat], [nguoicapnhat], [mamonhoc], [tenmonhoc], [sotinchi]) VALUES (CAST(N'2019-10-23T20:34:29.503' AS DateTime), N'admin', CAST(N'2019-10-27T13:25:33.687' AS DateTime), N'admin', N'antoanthongtin', N'An toàn thông tin', 3)
INSERT [dbo].[tblMonHoc] ([ngaytao], [nguoitao], [ngaycapnhat], [nguoicapnhat], [mamonhoc], [tenmonhoc], [sotinchi]) VALUES (CAST(N'2023-11-21T10:49:32.407' AS DateTime), N'admin', CAST(N'2023-11-21T10:49:32.407' AS DateTime), N'admin', N'daisotuyentinh', N'Đại số tuyến tính', 3)
INSERT [dbo].[tblMonHoc] ([ngaytao], [nguoitao], [ngaycapnhat], [nguoicapnhat], [mamonhoc], [tenmonhoc], [sotinchi]) VALUES (CAST(N'2023-11-20T21:54:48.177' AS DateTime), N'admin', CAST(N'2023-11-20T21:54:48.177' AS DateTime), N'admin', N'doan1', N'Đồ án 1', 4)
INSERT [dbo].[tblMonHoc] ([ngaytao], [nguoitao], [ngaycapnhat], [nguoicapnhat], [mamonhoc], [tenmonhoc], [sotinchi]) VALUES (CAST(N'2023-11-20T21:57:51.773' AS DateTime), N'admin', CAST(N'2023-11-20T21:57:51.773' AS DateTime), N'admin', N'doan2', N'Đồ án 2', 4)
INSERT [dbo].[tblMonHoc] ([ngaytao], [nguoitao], [ngaycapnhat], [nguoicapnhat], [mamonhoc], [tenmonhoc], [sotinchi]) VALUES (CAST(N'2023-11-09T21:09:11.560' AS DateTime), N'admin', CAST(N'2023-11-20T22:18:37.047' AS DateTime), N'admin', N'laptrinhnet', N'Lập trình .Net', 3)
INSERT [dbo].[tblMonHoc] ([ngaytao], [nguoitao], [ngaycapnhat], [nguoicapnhat], [mamonhoc], [tenmonhoc], [sotinchi]) VALUES (CAST(N'2019-10-27T13:25:58.190' AS DateTime), N'admin', CAST(N'2023-11-20T22:19:57.577' AS DateTime), N'admin', N'laptrinhopp', N'Lập trình hướng đối tượng OOP', 3)
INSERT [dbo].[tblMonHoc] ([ngaytao], [nguoitao], [ngaycapnhat], [nguoicapnhat], [mamonhoc], [tenmonhoc], [sotinchi]) VALUES (CAST(N'2019-10-23T20:34:29.503' AS DateTime), N'admin', CAST(N'2019-10-23T20:34:29.503' AS DateTime), N'admin', N'laptrinhweb', N'Lập trình website bằng mô hình MVC', 3)
INSERT [dbo].[tblMonHoc] ([ngaytao], [nguoitao], [ngaycapnhat], [nguoicapnhat], [mamonhoc], [tenmonhoc], [sotinchi]) VALUES (CAST(N'2019-10-23T20:34:29.503' AS DateTime), N'admin', CAST(N'2019-10-23T20:34:29.503' AS DateTime), N'admin', N'laptrinhwpf', N'Lập trình WPF', 4)
INSERT [dbo].[tblMonHoc] ([ngaytao], [nguoitao], [ngaycapnhat], [nguoicapnhat], [mamonhoc], [tenmonhoc], [sotinchi]) VALUES (CAST(N'2023-10-26T16:48:13.463' AS DateTime), N'admin', CAST(N'2023-10-26T16:49:05.250' AS DateTime), N'admin', N'lichsudang', N'Lịch sử đảng', 2)
INSERT [dbo].[tblMonHoc] ([ngaytao], [nguoitao], [ngaycapnhat], [nguoicapnhat], [mamonhoc], [tenmonhoc], [sotinchi]) VALUES (CAST(N'2019-10-23T20:34:29.503' AS DateTime), N'admin', CAST(N'2019-10-23T20:34:29.503' AS DateTime), N'admin', N'mamonguon', N'Mã nguồn mở', 2)
INSERT [dbo].[tblMonHoc] ([ngaytao], [nguoitao], [ngaycapnhat], [nguoicapnhat], [mamonhoc], [tenmonhoc], [sotinchi]) VALUES (CAST(N'2019-10-23T20:34:29.503' AS DateTime), N'admin', CAST(N'2019-10-23T20:34:29.503' AS DateTime), N'admin', N'phantichthietke', N'Phân tích thiết kế CSDL', 2)
INSERT [dbo].[tblMonHoc] ([ngaytao], [nguoitao], [ngaycapnhat], [nguoicapnhat], [mamonhoc], [tenmonhoc], [sotinchi]) VALUES (CAST(N'2023-11-21T10:46:25.447' AS DateTime), N'admin', CAST(N'2023-11-21T10:46:25.447' AS DateTime), N'admin', N'phapluatdc', N'Pháp luật đại cương', 2)
INSERT [dbo].[tblMonHoc] ([ngaytao], [nguoitao], [ngaycapnhat], [nguoicapnhat], [mamonhoc], [tenmonhoc], [sotinchi]) VALUES (CAST(N'2023-11-21T10:42:05.187' AS DateTime), N'admin', CAST(N'2023-11-21T10:42:05.187' AS DateTime), N'admin', N'quantrihoc', N'Quản trị học', 3)
INSERT [dbo].[tblMonHoc] ([ngaytao], [nguoitao], [ngaycapnhat], [nguoicapnhat], [mamonhoc], [tenmonhoc], [sotinchi]) VALUES (CAST(N'2019-10-23T20:34:29.503' AS DateTime), N'admin', CAST(N'2019-10-23T20:34:29.503' AS DateTime), N'admin', N'thietkeweb', N'Thiết kế web bằng ASP.NET', 4)
INSERT [dbo].[tblMonHoc] ([ngaytao], [nguoitao], [ngaycapnhat], [nguoicapnhat], [mamonhoc], [tenmonhoc], [sotinchi]) VALUES (CAST(N'2023-11-21T10:47:43.037' AS DateTime), N'admin', CAST(N'2023-11-21T10:47:43.037' AS DateTime), N'admin', N'thuctapltcb', N'Thực tập lập trình cơ bản', 4)
INSERT [dbo].[tblMonHoc] ([ngaytao], [nguoitao], [ngaycapnhat], [nguoicapnhat], [mamonhoc], [tenmonhoc], [sotinchi]) VALUES (CAST(N'2023-11-21T10:48:55.140' AS DateTime), N'admin', CAST(N'2023-11-21T10:48:55.140' AS DateTime), N'admin', N'tienganh1', N'Tiếng Anh 1', 4)
INSERT [dbo].[tblMonHoc] ([ngaytao], [nguoitao], [ngaycapnhat], [nguoicapnhat], [mamonhoc], [tenmonhoc], [sotinchi]) VALUES (CAST(N'2023-11-21T10:44:10.063' AS DateTime), N'admin', CAST(N'2023-11-21T10:44:10.063' AS DateTime), N'admin', N'tincoso', N'Tin cơ sở', 3)
INSERT [dbo].[tblMonHoc] ([ngaytao], [nguoitao], [ngaycapnhat], [nguoicapnhat], [mamonhoc], [tenmonhoc], [sotinchi]) VALUES (CAST(N'2019-10-23T20:34:29.500' AS DateTime), N'admin', CAST(N'2019-10-23T20:34:29.500' AS DateTime), N'admin', N'Tindaicuong', N'Tin học đại cương', 2)
INSERT [dbo].[tblMonHoc] ([ngaytao], [nguoitao], [ngaycapnhat], [nguoicapnhat], [mamonhoc], [tenmonhoc], [sotinchi]) VALUES (CAST(N'2023-11-09T21:52:21.257' AS DateTime), N'admin', CAST(N'2023-11-09T21:52:21.257' AS DateTime), N'admin', N'tinhocvanphong', N'Tin học văn phòng', 1)
INSERT [dbo].[tblMonHoc] ([ngaytao], [nguoitao], [ngaycapnhat], [nguoicapnhat], [mamonhoc], [tenmonhoc], [sotinchi]) VALUES (CAST(N'2019-10-23T20:34:29.503' AS DateTime), N'admin', CAST(N'2019-10-23T20:34:29.503' AS DateTime), N'admin', N'toancaocap', N'Toán cao cấp I', 2)
INSERT [dbo].[tblMonHoc] ([ngaytao], [nguoitao], [ngaycapnhat], [nguoicapnhat], [mamonhoc], [tenmonhoc], [sotinchi]) VALUES (CAST(N'2023-11-21T10:47:18.693' AS DateTime), N'admin', CAST(N'2023-11-21T10:47:18.693' AS DateTime), N'admin', N'toangiaitich', N'Toán giải tích', 3)
INSERT [dbo].[tblMonHoc] ([ngaytao], [nguoitao], [ngaycapnhat], [nguoicapnhat], [mamonhoc], [tenmonhoc], [sotinchi]) VALUES (CAST(N'2023-11-21T10:48:13.780' AS DateTime), N'admin', CAST(N'2023-11-21T10:48:13.780' AS DateTime), N'admin', N'triethoc1', N'Triết học Mac - Lênin', 2)
INSERT [dbo].[tblMonHoc] ([ngaytao], [nguoitao], [ngaycapnhat], [nguoicapnhat], [mamonhoc], [tenmonhoc], [sotinchi]) VALUES (CAST(N'2023-11-21T10:47:02.080' AS DateTime), N'admin', CAST(N'2023-11-21T10:47:02.080' AS DateTime), N'admin', N'xacsuatthongke', N'Xác suất thống kê', 3)
INSERT [dbo].[tblMonHoc] ([ngaytao], [nguoitao], [ngaycapnhat], [nguoicapnhat], [mamonhoc], [tenmonhoc], [sotinchi]) VALUES (CAST(N'2023-11-21T10:48:41.227' AS DateTime), N'admin', CAST(N'2023-11-21T10:48:41.227' AS DateTime), N'admin', N'xylytinhieu', N'Xử lý tín hiệu số', 2)
GO
INSERT [dbo].[tblPhongDaoTao] ([ngaytao], [nguoitao], [ngaycapnhat], [nguoicapnhat], [manhanvien], [matkhau], [ho], [tendem], [ten], [gioitinh], [ngaysinh], [dienthoai], [email], [diachi]) VALUES (CAST(N'2023-10-20T21:38:23.383' AS DateTime), N'admin', CAST(N'2023-10-20T21:38:23.383' AS DateTime), N'admin', N'PDT01', N'van123', N'Trịnh', N'Mỹ', N'Huyền', 1, CAST(N'2002-05-20' AS Date), N'09433232', N'nhocvan2202@gmail.com', N'Hà Nội')
INSERT [dbo].[tblPhongDaoTao] ([ngaytao], [nguoitao], [ngaycapnhat], [nguoicapnhat], [manhanvien], [matkhau], [ho], [tendem], [ten], [gioitinh], [ngaysinh], [dienthoai], [email], [diachi]) VALUES (CAST(N'2023-11-02T16:37:22.833' AS DateTime), N'admin', CAST(N'2023-11-02T16:37:22.833' AS DateTime), N'admin', N'PDT02', N'123456', N'Trần', N'Văn', N'Anh', 0, CAST(N'2002-07-04' AS Date), N'83482932', N'vananh22@gmail.com', N'Hà Nội')
GO
INSERT [dbo].[tblSinhVien] ([ngaytao], [nguoicapnhat], [nguoitao], [ngaycapnhat], [masinhvien], [matkhau], [ho], [tendem], [ten], [ngaysinh], [gioitinh], [quequan], [diachi], [dienthoai], [email], [malophoc], [hocbong]) VALUES (CAST(N'2023-10-24T22:48:24.890' AS DateTime), N'admin', N'admin', CAST(N'2023-10-24T22:48:24.890' AS DateTime), N'SV1100', N'12345', N'Phạm', N'Duy', N'Tân', CAST(N'2002-05-22' AS Date), 1, N'Hải Phòng', N'Hà Nội', N'023283243243', N'tan2230@gmai.com', N'TinA7', N'Đạt')
INSERT [dbo].[tblSinhVien] ([ngaytao], [nguoicapnhat], [nguoitao], [ngaycapnhat], [masinhvien], [matkhau], [ho], [tendem], [ten], [ngaysinh], [gioitinh], [quequan], [diachi], [dienthoai], [email], [malophoc], [hocbong]) VALUES (CAST(N'2023-10-25T12:32:16.457' AS DateTime), N'admin', N'admin', CAST(N'2023-10-25T12:32:16.457' AS DateTime), N'SV1101', N'12345', N'Trần', N'Văn', N'Nam', CAST(N'2002-07-24' AS Date), 1, N'Hòa Bình', N'Hà Nội', N'07823728', N'namcon12@gmail.com', N'TinA7', N'Không Đạt')
INSERT [dbo].[tblSinhVien] ([ngaytao], [nguoicapnhat], [nguoitao], [ngaycapnhat], [masinhvien], [matkhau], [ho], [tendem], [ten], [ngaysinh], [gioitinh], [quequan], [diachi], [dienthoai], [email], [malophoc], [hocbong]) VALUES (CAST(N'2023-10-24T22:43:09.063' AS DateTime), N'admin', N'admin', CAST(N'2023-10-24T22:43:09.063' AS DateTime), N'SV1102', N'12345', N'Dương', N'Danh', N'Thái', CAST(N'2002-03-21' AS Date), 1, N'Hải Dương', N'Hà Nội', N'8923282', N'ThaiHD203@gmail.com', N'TinA7', N'Không Đạt')
INSERT [dbo].[tblSinhVien] ([ngaytao], [nguoicapnhat], [nguoitao], [ngaycapnhat], [masinhvien], [matkhau], [ho], [tendem], [ten], [ngaysinh], [gioitinh], [quequan], [diachi], [dienthoai], [email], [malophoc], [hocbong]) VALUES (CAST(N'2023-10-26T01:24:52.550' AS DateTime), N'admin', N'admin', CAST(N'2023-10-26T01:24:52.550' AS DateTime), N'SV1103', N'12345', N'Phạm', N'Văn', N'Chỉnh', CAST(N'2002-07-14' AS Date), 0, N'Quảng Ninh', N'Hà Nội', N'0392382932', N'chinh123@gmail.com', N'KTA6', N'Không Đạt')
INSERT [dbo].[tblSinhVien] ([ngaytao], [nguoicapnhat], [nguoitao], [ngaycapnhat], [masinhvien], [matkhau], [ho], [tendem], [ten], [ngaysinh], [gioitinh], [quequan], [diachi], [dienthoai], [email], [malophoc], [hocbong]) VALUES (CAST(N'2023-11-11T16:05:28.407' AS DateTime), N'admin', N'admin', CAST(N'2023-11-11T16:05:28.407' AS DateTime), N'SV1107', N'12345', N'Ngọ', N'Ăn', N'Cứt', CAST(N'1111-11-11' AS Date), 1, N'Hà tĩnh yêu dấu', N'dsfdsfdsfdfd', N'dsfdsfdsfdsfds', N'sfdsfdsfdsfds', N'TinA3', NULL)
INSERT [dbo].[tblSinhVien] ([ngaytao], [nguoicapnhat], [nguoitao], [ngaycapnhat], [masinhvien], [matkhau], [ho], [tendem], [ten], [ngaysinh], [gioitinh], [quequan], [diachi], [dienthoai], [email], [malophoc], [hocbong]) VALUES (CAST(N'2023-10-20T11:04:40.343' AS DateTime), N'admin', N'admin', CAST(N'2023-10-20T11:04:40.343' AS DateTime), N'SV1108', N'12345', N'Trần ', N'Anh ', N'Văn', CAST(N'2002-02-22' AS Date), 1, N'Hà Nội', N'Hà Nội', N'0981765122', N'nhocvan220202@gmail.com', N'TinA7', N'Không Đạt')
INSERT [dbo].[tblSinhVien] ([ngaytao], [nguoicapnhat], [nguoitao], [ngaycapnhat], [masinhvien], [matkhau], [ho], [tendem], [ten], [ngaysinh], [gioitinh], [quequan], [diachi], [dienthoai], [email], [malophoc], [hocbong]) VALUES (CAST(N'2023-10-21T14:46:14.783' AS DateTime), N'admin', N'admin', CAST(N'2023-10-21T14:46:14.783' AS DateTime), N'SV1109', N'12345', N'Mạc', N'Văn', N'Huy', CAST(N'2002-02-14' AS Date), 0, N'Hải Dương', N'Hà Nội', N'09827327', N'huy@gmail.com', N'TinA7', NULL)
INSERT [dbo].[tblSinhVien] ([ngaytao], [nguoicapnhat], [nguoitao], [ngaycapnhat], [masinhvien], [matkhau], [ho], [tendem], [ten], [ngaysinh], [gioitinh], [quequan], [diachi], [dienthoai], [email], [malophoc], [hocbong]) VALUES (CAST(N'2023-11-20T18:33:37.527' AS DateTime), N'admin', N'admin', CAST(N'2023-11-20T18:33:37.527' AS DateTime), N'SV1110', N'12345', N'Ngô', N'Đức', N'Huy', CAST(N'2002-09-28' AS Date), 0, N'Thái Bình', N'Hà Nội', N'029232323', N'huy12@gmail.com', N'TinA7', NULL)
INSERT [dbo].[tblSinhVien] ([ngaytao], [nguoicapnhat], [nguoitao], [ngaycapnhat], [masinhvien], [matkhau], [ho], [tendem], [ten], [ngaysinh], [gioitinh], [quequan], [diachi], [dienthoai], [email], [malophoc], [hocbong]) VALUES (CAST(N'2023-10-21T15:45:23.557' AS DateTime), N'admin', N'admin', CAST(N'2023-10-21T15:45:23.557' AS DateTime), N'SV1111', N'12345', N'Lê', N'Huy', N'Ngọ', CAST(N'2002-06-14' AS Date), 1, N'Hà Tĩnh', N'Hà Nội', N'092328322', N'ngo292922@gmail.com', N'TinA5', NULL)
INSERT [dbo].[tblSinhVien] ([ngaytao], [nguoicapnhat], [nguoitao], [ngaycapnhat], [masinhvien], [matkhau], [ho], [tendem], [ten], [ngaysinh], [gioitinh], [quequan], [diachi], [dienthoai], [email], [malophoc], [hocbong]) VALUES (CAST(N'2023-11-20T18:57:55.843' AS DateTime), N'admin', N'admin', CAST(N'2023-11-20T18:57:55.843' AS DateTime), N'SV1112', N'12345', N'Nguyễn', N'Tuấn', N'Minh', CAST(N'2002-04-06' AS Date), 1, N'Ninh Bình', N'Hà Nội', N'0232392382', N'minhkhonglun12@gmail.com', N'TinA1', NULL)
INSERT [dbo].[tblSinhVien] ([ngaytao], [nguoicapnhat], [nguoitao], [ngaycapnhat], [masinhvien], [matkhau], [ho], [tendem], [ten], [ngaysinh], [gioitinh], [quequan], [diachi], [dienthoai], [email], [malophoc], [hocbong]) VALUES (CAST(N'2023-11-21T10:56:48.940' AS DateTime), N'admin', N'admin', CAST(N'2023-11-21T10:56:48.940' AS DateTime), N'SV1113', N'12345', N'Phạm', N'Thùy', N'Trang', CAST(N'2002-06-13' AS Date), 0, N'Ninh Bình', N'Hà Nội', N'0923283232', N'trangkute1306@gmail.com', N'TinA1', NULL)
INSERT [dbo].[tblSinhVien] ([ngaytao], [nguoicapnhat], [nguoitao], [ngaycapnhat], [masinhvien], [matkhau], [ho], [tendem], [ten], [ngaysinh], [gioitinh], [quequan], [diachi], [dienthoai], [email], [malophoc], [hocbong]) VALUES (CAST(N'2023-10-24T22:40:10.240' AS DateTime), N'admin', N'admin', CAST(N'2023-10-24T22:40:10.240' AS DateTime), N'SV1114', N'12345', N'Trịnh', N'Mỹ ', N'Huyền', CAST(N'2002-05-20' AS Date), 0, N'Chương Mỹ Hà Nội', N'Hà Nội', N'02839283', N'huyen2002@gmail.com', N'KTA6', NULL)
INSERT [dbo].[tblSinhVien] ([ngaytao], [nguoicapnhat], [nguoitao], [ngaycapnhat], [masinhvien], [matkhau], [ho], [tendem], [ten], [ngaysinh], [gioitinh], [quequan], [diachi], [dienthoai], [email], [malophoc], [hocbong]) VALUES (CAST(N'2023-10-24T22:44:02.240' AS DateTime), N'admin', N'admin', CAST(N'2023-10-24T22:44:02.240' AS DateTime), N'SV1115', N'12345', N'Dương', N'Danh', N'Thái ', CAST(N'2002-03-21' AS Date), 1, N'Hải Dương', N'Hà Nội', N'8923282', N'ThaiHD203@gmail.com', N'TinA5', NULL)
INSERT [dbo].[tblSinhVien] ([ngaytao], [nguoicapnhat], [nguoitao], [ngaycapnhat], [masinhvien], [matkhau], [ho], [tendem], [ten], [ngaysinh], [gioitinh], [quequan], [diachi], [dienthoai], [email], [malophoc], [hocbong]) VALUES (CAST(N'2023-11-22T12:38:40.753' AS DateTime), N'admin', N'admin', CAST(N'2023-11-22T12:38:40.753' AS DateTime), N'SV1116', N'12345', N'Thái', N'Ăn ', N'Cứt', CAST(N'2002-04-13' AS Date), 1, N'Hải Dương Mõm', N'Hà Nội', N'03284884474', N'thaingul123@gmail.com', N'TinA7', NULL)
INSERT [dbo].[tblSinhVien] ([ngaytao], [nguoicapnhat], [nguoitao], [ngaycapnhat], [masinhvien], [matkhau], [ho], [tendem], [ten], [ngaysinh], [gioitinh], [quequan], [diachi], [dienthoai], [email], [malophoc], [hocbong]) VALUES (CAST(N'2023-11-22T12:39:32.440' AS DateTime), N'admin', N'admin', CAST(N'2023-11-22T12:39:32.440' AS DateTime), N'SV1117', N'12345', N'Nguyễn', N'Văn', N'Dương', CAST(N'2002-02-04' AS Date), 1, N'Thái Bình', N'Hà Nội', N'03278237232', N'tinhngu12@gmail.com', N'TinA7', NULL)
INSERT [dbo].[tblSinhVien] ([ngaytao], [nguoicapnhat], [nguoitao], [ngaycapnhat], [masinhvien], [matkhau], [ho], [tendem], [ten], [ngaysinh], [gioitinh], [quequan], [diachi], [dienthoai], [email], [malophoc], [hocbong]) VALUES (CAST(N'2023-10-24T23:02:28.377' AS DateTime), N'admin', N'admin', CAST(N'2023-10-24T23:02:28.377' AS DateTime), N'SV1118', N'12345', N'Trần', N'Thế', N'Học', CAST(N'2002-11-27' AS Date), 0, N'Ninh Bình', N'Hà Nội', N'0238237', N'hoc11@gmai.com', N'TinA5', NULL)
INSERT [dbo].[tblSinhVien] ([ngaytao], [nguoicapnhat], [nguoitao], [ngaycapnhat], [masinhvien], [matkhau], [ho], [tendem], [ten], [ngaysinh], [gioitinh], [quequan], [diachi], [dienthoai], [email], [malophoc], [hocbong]) VALUES (CAST(N'2023-11-22T12:42:55.637' AS DateTime), N'admin', N'admin', CAST(N'2023-11-22T12:42:55.637' AS DateTime), N'SV1125', N'12345', N'Phạm', N'Bích', N'Ngọc', CAST(N'2002-02-14' AS Date), 1, N'Hưng Yên', N'Hà Nội', N'03232232454', N'dsfsdfdsa@gmail.com', N'TinA7', NULL)
GO
ALTER TABLE [dbo].[tblDeletedSinhVien] ADD  CONSTRAINT [DF_tblDeletedSinhVien_ngayxoa]  DEFAULT (getdate()) FOR [ngayxoa]
GO
ALTER TABLE [dbo].[tblDeletedSinhVien] ADD  CONSTRAINT [DF_tblDeletedSinhVien_nguoixoa]  DEFAULT ('admin') FOR [nguoixoa]
GO
ALTER TABLE [dbo].[tblDiem] ADD  CONSTRAINT [DF_tblDiemQuaTrinh_ngaytao]  DEFAULT (getdate()) FOR [ngaytao]
GO
ALTER TABLE [dbo].[tblDiem] ADD  CONSTRAINT [DF_tblDiemQuaTrinh_nguoitao]  DEFAULT ('admin') FOR [nguoitao]
GO
ALTER TABLE [dbo].[tblDiem] ADD  CONSTRAINT [DF_tblDiemQuaTrinh_ngaycapnhat]  DEFAULT (getdate()) FOR [ngaycapnhat]
GO
ALTER TABLE [dbo].[tblDiem] ADD  CONSTRAINT [DF_tblDiem_diemchuyencan]  DEFAULT ((0)) FOR [diemchuyencan]
GO
ALTER TABLE [dbo].[tblDiem] ADD  CONSTRAINT [DF_tblDiem_diemheso1]  DEFAULT ((0)) FOR [diemheso1]
GO
ALTER TABLE [dbo].[tblDiem] ADD  CONSTRAINT [DF_tblDiem_diemheso2_1]  DEFAULT ((0)) FOR [diemheso2_1]
GO
ALTER TABLE [dbo].[tblDiem] ADD  CONSTRAINT [DF_tblDiem_diemheso2_2]  DEFAULT ((0)) FOR [diemheso2_2]
GO
ALTER TABLE [dbo].[tblDiem] ADD  CONSTRAINT [DF_tblDiem_diemquatrinh]  DEFAULT ((0)) FOR [diemquatrinh]
GO
ALTER TABLE [dbo].[tblDiem] ADD  CONSTRAINT [DF_tblDiem_diemthi]  DEFAULT ((0)) FOR [diemthi]
GO
ALTER TABLE [dbo].[tblDiem] ADD  CONSTRAINT [DF_tblDiem_diemhocphan]  DEFAULT ((0)) FOR [diemhocphan]
GO
ALTER TABLE [dbo].[tblGiaoVien] ADD  CONSTRAINT [DF_tblGiaoVien_ngaytao]  DEFAULT (getdate()) FOR [ngaytao]
GO
ALTER TABLE [dbo].[tblGiaoVien] ADD  CONSTRAINT [DF_tblGiaoVien_nguoitao]  DEFAULT ('admin') FOR [nguoitao]
GO
ALTER TABLE [dbo].[tblGiaoVien] ADD  CONSTRAINT [DF_tblGiaoVien_ngaycapnhat]  DEFAULT (getdate()) FOR [ngaycapnhat]
GO
ALTER TABLE [dbo].[tblGiaoVien] ADD  CONSTRAINT [DF_tblGiaoVien_nguoicapnhat]  DEFAULT ('admin') FOR [nguoicapnhat]
GO
ALTER TABLE [dbo].[tblGiaoVien] ADD  CONSTRAINT [DF_tblGiaoVien_gioitinh]  DEFAULT ((1)) FOR [gioitinh]
GO
ALTER TABLE [dbo].[tblLopHoc] ADD  CONSTRAINT [DF_tblLopHoc_ngaytao]  DEFAULT (getdate()) FOR [ngaytao]
GO
ALTER TABLE [dbo].[tblLopHoc] ADD  CONSTRAINT [DF_tblLopHoc_nguoitao]  DEFAULT ('admin') FOR [nguoitao]
GO
ALTER TABLE [dbo].[tblLopHoc] ADD  CONSTRAINT [DF_tblLopHoc_ngaycapnhat]  DEFAULT (getdate()) FOR [ngaycapnhat]
GO
ALTER TABLE [dbo].[tblLopHoc] ADD  CONSTRAINT [DF_tblLopHoc_nguoicapnhat]  DEFAULT ('admin') FOR [nguoicapnhat]
GO
ALTER TABLE [dbo].[tblLopHocPhan] ADD  CONSTRAINT [DF_tblLopHocPhan_ngaytao]  DEFAULT (getdate()) FOR [ngaytao]
GO
ALTER TABLE [dbo].[tblLopHocPhan] ADD  CONSTRAINT [DF_tblLopHocPhan_nguoitao]  DEFAULT ('admin') FOR [nguoitao]
GO
ALTER TABLE [dbo].[tblLopHocPhan] ADD  CONSTRAINT [DF_tblLopHocPhan_ngaycapnhat]  DEFAULT (getdate()) FOR [ngaycapnhat]
GO
ALTER TABLE [dbo].[tblLopHocPhan] ADD  CONSTRAINT [DF_tblLopHocPhan_nguoicapnhat]  DEFAULT ('admin') FOR [nguoicapnhat]
GO
ALTER TABLE [dbo].[tblMonHoc] ADD  CONSTRAINT [DF_tblMonHoc_ngaytao]  DEFAULT (getdate()) FOR [ngaytao]
GO
ALTER TABLE [dbo].[tblMonHoc] ADD  CONSTRAINT [DF_tblMonHoc_nguoitao]  DEFAULT ('admin') FOR [nguoitao]
GO
ALTER TABLE [dbo].[tblMonHoc] ADD  CONSTRAINT [DF_tblMonHoc_ngaycapnhat]  DEFAULT (getdate()) FOR [ngaycapnhat]
GO
ALTER TABLE [dbo].[tblMonHoc] ADD  CONSTRAINT [DF_tblMonHoc_nguoicapnhat]  DEFAULT ('admin') FOR [nguoicapnhat]
GO
ALTER TABLE [dbo].[tblPhongDaoTao] ADD  CONSTRAINT [DF_tblPhongDaoTao_ngaytao]  DEFAULT (getdate()) FOR [ngaytao]
GO
ALTER TABLE [dbo].[tblPhongDaoTao] ADD  CONSTRAINT [DF_tblPhongDaoTao_nguoitao]  DEFAULT ('admin') FOR [nguoitao]
GO
ALTER TABLE [dbo].[tblPhongDaoTao] ADD  CONSTRAINT [DF_tblPhongDaoTao_ngaycapnhat]  DEFAULT (getdate()) FOR [ngaycapnhat]
GO
ALTER TABLE [dbo].[tblPhongDaoTao] ADD  CONSTRAINT [DF_tblPhongDaoTao_nguoicapnhat]  DEFAULT ('admin') FOR [nguoicapnhat]
GO
ALTER TABLE [dbo].[tblSinhVien] ADD  CONSTRAINT [DF_tblSinhVien_ngaytao]  DEFAULT (getdate()) FOR [ngaytao]
GO
ALTER TABLE [dbo].[tblSinhVien] ADD  CONSTRAINT [DF_tblSinhVien_nguoicapnhat]  DEFAULT ('admin') FOR [nguoicapnhat]
GO
ALTER TABLE [dbo].[tblSinhVien] ADD  CONSTRAINT [DF_tblSinhVien_nguoitao]  DEFAULT ('admin') FOR [nguoitao]
GO
ALTER TABLE [dbo].[tblSinhVien] ADD  CONSTRAINT [DF_tblSinhVien_ngaycapnhat]  DEFAULT (getdate()) FOR [ngaycapnhat]
GO
ALTER TABLE [dbo].[tblSinhVien] ADD  CONSTRAINT [DF_tblSinhVien_matkhau]  DEFAULT ((12345)) FOR [matkhau]
GO
ALTER TABLE [dbo].[tblDiem]  WITH CHECK ADD  CONSTRAINT [FK__tblDiemQu__masin__74794A92] FOREIGN KEY([masinhvien])
REFERENCES [dbo].[tblSinhVien] ([masinhvien])
GO
ALTER TABLE [dbo].[tblDiem] CHECK CONSTRAINT [FK__tblDiemQu__masin__74794A92]
GO
ALTER TABLE [dbo].[tblDiem]  WITH CHECK ADD  CONSTRAINT [FK_tblDiem_tblLopHocPhan1] FOREIGN KEY([malophocphan])
REFERENCES [dbo].[tblLopHocPhan] ([malophocphan])
GO
ALTER TABLE [dbo].[tblDiem] CHECK CONSTRAINT [FK_tblDiem_tblLopHocPhan1]
GO
ALTER TABLE [dbo].[tblDiemTrungBinh]  WITH CHECK ADD  CONSTRAINT [FK_tblDiemTrungBinh_tblSinhVien] FOREIGN KEY([masinhvien])
REFERENCES [dbo].[tblSinhVien] ([masinhvien])
GO
ALTER TABLE [dbo].[tblDiemTrungBinh] CHECK CONSTRAINT [FK_tblDiemTrungBinh_tblSinhVien]
GO
ALTER TABLE [dbo].[tblGiaoVien]  WITH CHECK ADD  CONSTRAINT [FK_tblGiaoVien_tblKhoa] FOREIGN KEY([makhoa])
REFERENCES [dbo].[tblKhoa] ([makhoa])
GO
ALTER TABLE [dbo].[tblGiaoVien] CHECK CONSTRAINT [FK_tblGiaoVien_tblKhoa]
GO
ALTER TABLE [dbo].[tblLopHoc]  WITH CHECK ADD  CONSTRAINT [FK_tblLopHoc_tblGiaoVien] FOREIGN KEY([magiaovien])
REFERENCES [dbo].[tblGiaoVien] ([magiaovien])
GO
ALTER TABLE [dbo].[tblLopHoc] CHECK CONSTRAINT [FK_tblLopHoc_tblGiaoVien]
GO
ALTER TABLE [dbo].[tblLopHoc]  WITH CHECK ADD  CONSTRAINT [FK_tblLopHoc_tblKhoa] FOREIGN KEY([makhoa])
REFERENCES [dbo].[tblKhoa] ([makhoa])
GO
ALTER TABLE [dbo].[tblLopHoc] CHECK CONSTRAINT [FK_tblLopHoc_tblKhoa]
GO
ALTER TABLE [dbo].[tblLopHocPhan]  WITH CHECK ADD  CONSTRAINT [FK_tblLopHocPhan_tblGiaoVien] FOREIGN KEY([magiaovien])
REFERENCES [dbo].[tblGiaoVien] ([magiaovien])
GO
ALTER TABLE [dbo].[tblLopHocPhan] CHECK CONSTRAINT [FK_tblLopHocPhan_tblGiaoVien]
GO
ALTER TABLE [dbo].[tblLopHocPhan]  WITH CHECK ADD  CONSTRAINT [FK_tblLopHocPhan_tblKhoa] FOREIGN KEY([makhoa])
REFERENCES [dbo].[tblKhoa] ([makhoa])
GO
ALTER TABLE [dbo].[tblLopHocPhan] CHECK CONSTRAINT [FK_tblLopHocPhan_tblKhoa]
GO
ALTER TABLE [dbo].[tblLopHocPhan]  WITH CHECK ADD  CONSTRAINT [FK_tblLopHocPhan_tblMonHoc] FOREIGN KEY([mamonhoc])
REFERENCES [dbo].[tblMonHoc] ([mamonhoc])
GO
ALTER TABLE [dbo].[tblLopHocPhan] CHECK CONSTRAINT [FK_tblLopHocPhan_tblMonHoc]
GO
ALTER TABLE [dbo].[tblSinhVien]  WITH CHECK ADD  CONSTRAINT [FK_tblSinhVien_tblLopHoc] FOREIGN KEY([malophoc])
REFERENCES [dbo].[tblLopHoc] ([malophoc])
GO
ALTER TABLE [dbo].[tblSinhVien] CHECK CONSTRAINT [FK_tblSinhVien_tblLopHoc]
GO
/****** Object:  StoredProcedure [dbo].[allKhoa]    Script Date: 30/11/2023 1:45:31 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[allKhoa]
	@tukhoa nvarchar(50)
AS
BEGIN
	SET @tukhoa = LOWER(@tukhoa);
	SELECT 
		makhoa,
		tenkhoa
	FROM tblKhoa 
	WHERE  
		makhoa LIKE '%' + @tukhoa + '%' 
		OR tenkhoa LIKE '%' + @tukhoa + '%'
		
		ORDER BY makhoa;
END
GO
/****** Object:  StoredProcedure [dbo].[allLopHoc]    Script Date: 30/11/2023 1:45:31 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[allLopHoc]
	@tukhoa nvarchar(50),
	 @makhoa NVARCHAR(50) = NULL -- Thêm tham số @makhoa mặc định là NULL
AS
BEGIN
	SET @tukhoa = LOWER(@tukhoa);
	SELECT 
		l.malophoc,
		l.tenlophoc,
		l.khoahoc,
		l.hedaotao,
		l.namnhaphoc,
		CONCAT(gv.ho, ' ', COALESCE(gv.tendem, ''), ' ', gv.ten) AS hoten,
		l.makhoa,
		k.tenkhoa
	FROM tblLopHoc l
	INNER JOIN tblKhoa k ON l.makhoa = k.makhoa
	INNER JOIN tblGiaoVien gv ON l.magiaovien = gv.magiaovien
	WHERE  
        (
            @makhoa IS NULL -- Nếu không chọn khoa
            OR l.makhoa = @makhoa -- Lọc theo makhoa nếu có giá trị
        )
        AND (
            l.malophoc LIKE '%' + @tukhoa + '%' 
            OR l.tenlophoc LIKE '%' + @tukhoa + '%' 
            OR l.khoahoc LIKE '%' + @tukhoa + '%'
            OR l.hedaotao LIKE '%' + @tukhoa + '%'
            OR l.namnhaphoc LIKE '%' + @tukhoa + '%'
            OR k.tenkhoa LIKE '%' + @tukhoa + '%'
            OR CONCAT(gv.ho, ' ', COALESCE(gv.tendem, ''), ' ', gv.ten) LIKE '%' + @tukhoa + '%'
        )
    ORDER BY l.malophoc;
END
GO
/****** Object:  StoredProcedure [dbo].[allLopHocPhan]    Script Date: 30/11/2023 1:45:31 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[allLopHocPhan]
	@tukhoa nvarchar(50),
	 @makhoa NVARCHAR(50) = NULL -- Thêm tham số @makhoa mặc định là NULL
AS
BEGIN
	SET @tukhoa = LOWER(@tukhoa);
	SELECT 
		lp.malophocphan,
		lp.mamonhoc,
		m.tenmonhoc,
		lp.magiaovien,
		CONCAT(gv.ho, ' ', COALESCE(gv.tendem, ''), ' ', gv.ten) AS hoten,
		lp.hocky,
		lp.nam,
		lp.makhoa,
		k.tenkhoa
	FROM tblLopHocPhan lp
	INNER JOIN tblKhoa k ON lp.makhoa = k.makhoa
	INNER JOIN tblMonHoc m ON lp.mamonhoc = m.mamonhoc
	INNER JOIN tblGiaoVien gv ON lp.magiaovien = gv.magiaovien
	WHERE  
	(
	  @makhoa IS NULL -- Nếu không chọn khoa
            OR lp.makhoa = @makhoa -- Lọc theo makhoa nếu có giá trị
	) AND 
	   (
	       lp.malophocphan LIKE '%' + @tukhoa + '%' 
		OR lp.mamonhoc LIKE '%' + @tukhoa + '%' 
		OR lp.magiaovien LIKE '%' + @tukhoa + '%'
		OR CONCAT(gv.ho, ' ', COALESCE(gv.tendem, ''), ' ', gv.ten) LIKE '%' + @tukhoa + '%' -- Thêm điều kiện tìm kiếm cho hoten
		OR lp.hocky LIKE '%' + @tukhoa + '%'
		OR lp.nam LIKE '%' + @tukhoa + '%'
		)
		ORDER BY 
		 lp.malophocphan -- Mặc định sắp xếp theo malophoc nếu không có lựa chọn hoặc giá trị không hợp lệ
END
GO
/****** Object:  StoredProcedure [dbo].[chamdiem]    Script Date: 30/11/2023 1:45:31 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[chamdiem]
	@nguoicapnhat NVARCHAR(255),
    @masinhvien NVARCHAR(255),
    @malophocphan NVARCHAR(20),
    @diemchuyencan FLOAT,
    @diemheso1 FLOAT,
    @diemheso2_1 FLOAT,
    @diemheso2_2 FLOAT,
    @diemthi FLOAT
as
begin
	   -- Nếu tồn tại, cập nhật bảng điểm cho sinh viên đó
        UPDATE tblDiem
        SET ngaycapnhat = getdate(),
		    nguoicapnhat = @nguoicapnhat,
            diemchuyencan = @diemchuyencan,
            diemheso1 = @diemheso1,
            diemheso2_1 = @diemheso2_1,
            diemheso2_2 = @diemheso2_2,
            diemthi = @diemthi,
			diemquatrinh = ROUND(((@diemchuyencan * mh.sotinchi) + @diemheso1 + (@diemheso2_1 * 2) + (@diemheso2_2 * 2)) / (mh.sotinchi + 5), 2),
			diemhocphan =ROUND(ROUND(((@diemchuyencan * mh.sotinchi) + @diemheso1 + (@diemheso2_1 * 2) + (@diemheso2_2 * 2)) / (mh.sotinchi + 5), 2) * 0.4 + @diemthi * 0.6, 2)
	   From tblDiem d
	     INNER JOIN tblLopHocPhan lhp ON d.malophocphan = lhp.malophocphan
         INNER JOIN tblMonHoc mh ON lhp.mamonhoc = mh.mamonhoc
        WHERE masinhvien = @masinhvien AND d.malophocphan = @malophocphan;
   -- Lấy số môn học của sinh viên
    DECLARE @SoMonHoc INT;

    SELECT @SoMonHoc = COUNT(DISTINCT malophocphan)
    FROM tblDiem
    WHERE masinhvien = @masinhvien;
	 -- Nếu số môn học >= 3, thực hiện chèn dữ liệu vào tblDiemTrungBinh
    IF @SoMonHoc >= 3
    BEGIN
        -- Sử dụng MERGE để thêm mới hoặc cập nhật dữ liệu trong tblDiemTrungBinh
MERGE INTO tblDiemTrungBinh AS Target
USING (
    SELECT 
        sv.masinhvien,
        CONCAT(sv.ho, ' ', COALESCE(sv.tendem, ''), ' ', sv.ten) AS hoten,
        CONVERT(VARCHAR(10), sv.ngaysinh, 103) AS nsinh,
        CASE WHEN sv.gioitinh = 1 THEN 'Nam' ELSE N'Nữ' END AS gioitinh,
        lh.tenlophoc AS lophoc,
        lhp.makhoa AS makhoa,
        SUM(d.diemhocphan * mh.sotinchi) / SUM(mh.sotinchi) AS diemtrungbinh
    FROM tblDiem d
    INNER JOIN tblSinhVien sv ON d.masinhvien = sv.masinhvien
    INNER JOIN tblLopHocPhan lhp ON d.malophocphan = lhp.malophocphan
    INNER JOIN tblMonHoc mh ON lhp.mamonhoc = mh.mamonhoc
    LEFT JOIN tblLopHoc lh ON sv.malophoc = lh.malophoc -- Sử dụng LEFT JOIN để xử lý khi có sinh viên chưa có lớp học
    WHERE lhp.malophocphan = @malophocphan AND sv.masinhvien = @masinhvien
    GROUP BY sv.masinhvien, sv.ho, sv.tendem, sv.ten, sv.ngaysinh, sv.gioitinh, lh.tenlophoc, lhp.makhoa
) AS Source
ON Target.masinhvien = Source.masinhvien
WHEN MATCHED THEN
    -- Nếu đã tồn tại, cập nhật điểm trung bình
    UPDATE SET 
        hoten = Source.hoten,
        nsinh = Source.nsinh,
        gioitinh = Source.gioitinh,
        lophoc = Source.lophoc,
        makhoa = Source.makhoa,
        diemtrungbinh = Source.diemtrungbinh
WHEN NOT MATCHED THEN
    -- Nếu chưa tồn tại, thêm mới
    INSERT (masinhvien, hoten, nsinh, gioitinh, lophoc, makhoa, diemtrungbinh)
    VALUES (Source.masinhvien, Source.hoten, Source.nsinh, Source.gioitinh, Source.lophoc, Source.makhoa, Source.diemtrungbinh);
    END
	 -- Cập nhật cột hocbong trong tblSinhVien
    UPDATE tblSinhVien
    SET hocbong = CASE
        WHEN EXISTS (
            SELECT 1
            FROM (
                SELECT
                    dtb.masinhvien,
                    dtb.diemtrungbinh,
                    NTILE(10) OVER (PARTITION BY dtb.makhoa ORDER BY dtb.diemtrungbinh DESC) AS PercentileGroup
                FROM tblDiemTrungBinh dtb
                WHERE dtb.diemtrungbinh >= 7.0
                AND dtb.makhoa = (SELECT makhoa FROM tblLopHocPhan WHERE malophocphan = @malophocphan)
            ) AS Subquery
            WHERE Subquery.masinhvien = tblSinhVien.masinhvien
            AND Subquery.PercentileGroup = 1
        ) THEN N'Đạt'
        ELSE N'Không Đạt'
    END
    WHERE masinhvien = @masinhvien;
	if @@ROWCOUNT >0 return 1 -- nếu thực thi thành công trả về 1
	else return 0; -- ngược lại trả về 0
  END
GO
/****** Object:  StoredProcedure [dbo].[CountRecords]    Script Date: 30/11/2023 1:45:31 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CountRecords]
AS
BEGIN
    -- Đếm số sinh viên
    SELECT 'SoSinhVien' AS Type, COUNT(*) AS Count FROM tblSinhVien
    UNION
    -- Đếm số khoa
    SELECT 'SoKhoa' AS Type, COUNT(*) AS Count FROM tblKhoa
    UNION
    -- Đếm số giáo viên
    SELECT 'SoGiaoVien' AS Type, COUNT(*) AS Count FROM tblGiaoVien
    UNION
    -- Đếm số lớp học
    SELECT 'SoLopHoc' AS Type, COUNT(*) AS Count FROM tblLopHoc
    UNION
    -- Đếm số môn học
    SELECT 'SoMonHoc' AS Type, COUNT(*) AS Count FROM tblMonHoc
END
GO
/****** Object:  StoredProcedure [dbo].[dangnhap]    Script Date: 30/11/2023 1:45:31 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[dangnhap]
	@loaitaikhoan nvarchar(10),
	@taikhoan varchar(50),
	@matkhau varchar(50)
as
begin
	if @loaitaikhoan = 'admin'
		select * from taikhoan where tentaikhoan = @taikhoan and matkhau = @matkhau
		else if @loaitaikhoan ='pdt'
		select * from tblPhongDaoTao where cast(manhanvien as varchar(50)) = @taikhoan and matkhau = @matkhau
		else if @loaitaikhoan = 'gv' 
			select * from tblGiaoVien where cast(magiaovien as varchar(50)) = @taikhoan and matkhau = @matkhau
		else select * from tblSinhVien where masinhvien = @taikhoan and matkhau = @matkhau ;
		if @@ROWCOUNT >0
		return 1
		else return 0;
end
GO
/****** Object:  StoredProcedure [dbo].[deleteGV]    Script Date: 30/11/2023 1:45:31 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[deleteGV]
    @magiaovien varchar(50)
AS
BEGIN
    DELETE FROM tblGiaoVien
    WHERE magiaovien = @magiaovien;
    UPDATE tblLopHocPhan SET[magiaovien] = NULL
	WHERE magiaovien = @magiaovien;
    IF @@ROWCOUNT > 0
        RETURN 1; -- Xóa thành công
    ELSE
        RETURN 0; -- Không có bản ghi nào được xóa
END;
GO
/****** Object:  StoredProcedure [dbo].[deleteLH]    Script Date: 30/11/2023 1:45:31 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[deleteLH]
    @malophoc varchar(50)
AS
BEGIN
    DELETE FROM tblLopHoc
    WHERE malophoc = @malophoc;
    UPDATE tblSinhVien SET[malophoc] = NULL
	WHERE malophoc = @malophoc;
    IF @@ROWCOUNT > 0
        RETURN 1; -- Xóa thành công
    ELSE
        RETURN 0; -- Không có bản ghi nào được xóa
END;
GO
/****** Object:  StoredProcedure [dbo].[deleteLHP]    Script Date: 30/11/2023 1:45:31 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[deleteLHP]
    @malophoc varchar(50)
AS
BEGIN
    DELETE FROM tblLopHocPhan
    WHERE malophocphan = @malophoc;
    IF @@ROWCOUNT > 0
        RETURN 1; -- Xóa thành công
    ELSE
        RETURN 0; -- Không có bản ghi nào được xóa
END;
GO
/****** Object:  StoredProcedure [dbo].[deleteMH]    Script Date: 30/11/2023 1:45:31 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[deleteMH]
    @mamonhoc varchar(50)
AS
BEGIN
    DELETE FROM tblMonHoc
    WHERE mamonhoc = @mamonhoc;
    IF @@ROWCOUNT > 0
        RETURN 1; -- Xóa thành công
    ELSE
        RETURN 0; -- Không có bản ghi nào được xóa
END;
GO
/****** Object:  StoredProcedure [dbo].[deleteSV]    Script Date: 30/11/2023 1:45:31 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[deleteSV]
    @masinhvien varchar(50)
AS
BEGIN
    DELETE FROM tblSinhVien
    WHERE masinhvien = @masinhvien;
    INSERT INTO tblDeletedSinhVien (masinhvien) VALUES (@masinhvien);
    IF @@ROWCOUNT > 0
        RETURN 1; -- Xóa thành công
    ELSE
        RETURN 0; -- Không có bản ghi nào được xóa
END;
GO
/****** Object:  StoredProcedure [dbo].[dkyhoc]    Script Date: 30/11/2023 1:45:31 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	CREATE proc [dbo].[dkyhoc]
		@masinhvien varchar(50),
		@malophocphan varchar(50)
	as
	begin
		--vì bảng điểm(tblDiem) chỉ có cột mã lớp học (khóa ngoại) liên kết tới bảng  lớp học(tblLopHoc) <-> không có thông tin môn học
		--> từ mã lớp cần tìm ra được mã môn học ( nằm trong tblLopHoc) dựa vào inner join --> khai báo 1 biến để lấy thông tin môn học, cụ thể là mã môn học
		declare	@v_mamonhoc varchar(50)
		-- lấy mã môn học dựa vào mã lớp
		select @v_mamonhoc = mamonhoc
		from tblLopHocPhan
		where malophocphan = @malophocphan;
		--> insert dữ liệu vào bảng điểm <-> đăng ký môn học
		insert into tblDiem(nguoitao,masinhvien,malophocphan)
		values(@masinhvien,@masinhvien,@malophocphan);--sinh viên đăng ký -> người tạo = mã sinh viên
		--kiểm tra thực thi câu lệnh sql
		if @@ROWCOUNT > 0 return 1 else return 0;
	end
GO
/****** Object:  StoredProcedure [dbo].[GetDanhSachHocBong]    Script Date: 30/11/2023 1:45:31 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetDanhSachHocBong]
    @makhoa NVARCHAR(50)
AS
BEGIN
    SELECT
        sv.masinhvien,
        CONCAT(sv.ho, ' ', COALESCE(sv.tendem, ''), ' ', sv.ten) AS hoten,
        CONVERT(VARCHAR(10), sv.ngaysinh, 103) AS ngaysinh,
        CASE WHEN sv.gioitinh = 1 THEN N'Nam' ELSE N'Nữ' END AS gioitinh,
        lh.tenlophoc,
        tb.diemtrungbinh,
        sv.hocbong
    FROM
        tblSinhVien sv
    INNER JOIN tblLopHoc lh ON sv.malophoc = lh.malophoc
	 INNER JOIN tblKhoa k ON lh.makhoa = k.makhoa
    LEFT JOIN tblDiemTrungBinh tb ON sv.masinhvien = tb.masinhvien
    WHERE
         k.makhoa = @makhoa
        AND sv.hocbong = N'Đạt'  -- Điều kiện để lấy những sinh viên đạt học bổng
    ORDER BY
        lh.tenlophoc,
        sv.ho,
        COALESCE(sv.tendem, ''),
        sv.ten;
END
GO
/****** Object:  StoredProcedure [dbo].[GetDiemHocPhanByLopHoc]    Script Date: 30/11/2023 1:45:31 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetDiemHocPhanByLopHoc]
    @maLopHoc NVARCHAR(50)
AS
BEGIN
    SELECT
        sv.masinhvien,
        CONCAT(sv.ho, ' ', COALESCE(sv.tendem, ''), ' ', sv.ten) AS hoten,
        mh.tenmonhoc,
        d.diemhocphan
    FROM
        tblSinhVien sv
        INNER JOIN tblLopHoc lh ON sv.malophoc = lh.malophoc
        LEFT JOIN tblDiem d ON sv.masinhvien = d.masinhvien
        LEFT JOIN tblLopHocPhan lhp ON lh.malophoc = lhp.malophocphan
        LEFT JOIN tblMonHoc mh ON lhp.mamonhoc = mh.mamonhoc
    WHERE lhp.malophocphan = @maLopHoc
END
GO
/****** Object:  StoredProcedure [dbo].[GetDiemTrungBinhTheoLopHoc]    Script Date: 30/11/2023 1:45:31 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetDiemTrungBinhTheoLopHoc]
    @malophoc NVARCHAR(20)
AS
BEGIN
    SELECT
        sv.masinhvien,
        CONCAT(sv.ho, ' ', COALESCE(sv.tendem, ''), ' ', sv.ten) AS hoten,
        CONVERT(VARCHAR(10), sv.ngaysinh, 103) AS nsinh,
        CASE WHEN sv.gioitinh = 1 THEN 'Nam' ELSE N'Nữ' END AS gioitinh,
		lh.tenlophoc,
        lhp.makhoa,
        SUM(d.diemhocphan * mh.sotinchi) / SUM(mh.sotinchi) AS diemtrungbinh
    FROM
        tblDiem d
        INNER JOIN tblSinhVien sv ON d.masinhvien = sv.masinhvien
        INNER JOIN tblLopHocPhan lhp ON d.malophocphan = lhp.malophocphan
        INNER JOIN tblMonHoc mh ON lhp.mamonhoc = mh.mamonhoc
		 INNER JOIN tblLopHoc lh ON sv.malophoc = lh.malophoc
    WHERE
       lh.malophoc = @malophoc
    GROUP BY
        sv.masinhvien, 
        CONCAT(sv.ho, ' ', COALESCE(sv.tendem, ''), ' ', sv.ten), 
        CONVERT(VARCHAR(10), sv.ngaysinh, 103),
        CASE WHEN sv.gioitinh = 1 THEN 'Nam' ELSE N'Nữ' END,
        lh.tenlophoc,
        lhp.makhoa
    HAVING
        COUNT(DISTINCT d.malophocphan) >= 3
   
END
GO
/****** Object:  StoredProcedure [dbo].[GetLopHoc]    Script Date: 30/11/2023 1:45:31 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetLopHoc]
    @maKhoa NVARCHAR(50)
AS
BEGIN
    SELECT
       lh.malophoc,
	   lh.tenlophoc,
	    lh.makhoa
    FROM
        tblLopHoc lh
    WHERE
        lh.makhoa = @maKhoa
END
GO
/****** Object:  StoredProcedure [dbo].[GetLopHocPhan]    Script Date: 30/11/2023 1:45:31 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetLopHocPhan]
    @maKhoa NVARCHAR(50)
AS
BEGIN
    SELECT
        lhp.malophocphan,
        lhp.mamonhoc,
        mh.tenmonhoc,
        lhp.magiaovien,
       CONCAT(gv.ho, ' ', COALESCE(gv.tendem, ''), ' ', gv.ten) AS hoten
    FROM
        tblLopHocPhan lhp
        INNER JOIN tblMonHoc mh ON lhp.mamonhoc = mh.mamonhoc
        LEFT JOIN tblGiaoVien gv ON lhp.magiaovien = gv.magiaovien
    WHERE
        lhp.makhoa = @maKhoa
END
GO
/****** Object:  StoredProcedure [dbo].[GetMonHocForLopHoc]    Script Date: 30/11/2023 1:45:31 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetMonHocForLopHoc]
    @maLopHoc NVARCHAR(50)
AS
BEGIN
    SELECT DISTINCT
        lh.mamonhoc,
        mh.tenmonhoc,
        mh.sotinchi
    FROM
        tblMonHoc mh
        INNER JOIN tblLopHocPhan lh ON mh.mamonhoc = lh.mamonhoc
    WHERE
        lh.malophocphan = @maLopHoc
END
GO
/****** Object:  StoredProcedure [dbo].[GetSinhVienDiemByLopHocMonHoc]    Script Date: 30/11/2023 1:45:31 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetSinhVienDiemByLopHocMonHoc]
    @maLopHoc NVARCHAR(50),
    @maMonHoc NVARCHAR(50)
AS
BEGIN
    SELECT
        sv.masinhvien,
        CONCAT(sv.ho, ' ', COALESCE(sv.tendem, ''), ' ', sv.ten) AS hoten,
        CONVERT(VARCHAR(10), sv.ngaysinh, 103) AS nsinh,
        CASE WHEN sv.gioitinh = 1 THEN 'Nam' ELSE N'Nữ' END AS gt,
        lhp.malophocphan,
        mh.tenmonhoc,
        d.diemchuyencan,
        d.diemheso1,
        d.diemheso2_1,
        d.diemheso2_2,
        d.diemquatrinh,
        d.diemthi,
        d.diemhocphan
    FROM
        tblDiem d
        INNER JOIN tblSinhVien sv ON d.masinhvien = sv.masinhvien
        INNER JOIN tblLopHocPhan lhp ON d.malophocphan = lhp.malophocphan
        INNER JOIN tblMonHoc mh ON lhp.mamonhoc = mh.mamonhoc
    WHERE
        lhp.malophocphan = @maLopHoc
        AND lhp.mamonhoc = @maMonHoc
END
GO
/****** Object:  StoredProcedure [dbo].[GetTenDangNhap]    Script Date: 30/11/2023 1:45:31 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetTenDangNhap]
    @tendangnhap NVARCHAR(50)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM tblSinhvien WHERE masinhvien = @tendangnhap)
    BEGIN
        SELECT CONCAT(sv.ho, ' ', COALESCE(sv.tendem, ''), ' ', sv.ten) AS hoten
        FROM tblSinhvien sv
        WHERE sv.masinhvien = @tendangnhap;
    END
    ELSE IF EXISTS (SELECT 1 FROM tblGiaovien WHERE magiaovien = @tendangnhap)
    BEGIN
        SELECT CONCAT(gv.ho, ' ', COALESCE(gv.tendem, ''), ' ', gv.ten) AS hoten
        FROM tblGiaovien gv
        WHERE gv.magiaovien = @tendangnhap;
    END
    ELSE IF EXISTS (SELECT 1 FROM tblPhongDaoTao WHERE manhanvien = @tendangnhap)
    BEGIN
        SELECT CONCAT(nv.ho, ' ', COALESCE(nv.tendem, ''), ' ', nv.ten) AS hoten
        FROM tblPhongDaoTao nv
        WHERE nv.manhanvien = @tendangnhap;
    END
    ELSE
    BEGIN
        -- Trả về giá trị mặc định hoặc xử lý tùy thuộc vào yêu cầu của bạn
        SELECT 'Không tồn tại' AS hoten;
    END
END
GO
/****** Object:  StoredProcedure [dbo].[InsertGV]    Script Date: 30/11/2023 1:45:31 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[InsertGV]
	@nguoitao varchar(30),
	@ho nvarchar(10),
	@tendem nvarchar(20), 
	@ten nvarchar(10),
	@gioitinh tinyint,
	@ngaysinh date,
	@email varchar(150),
	@dienthoai varchar(30),
	@diachi nvarchar(150),
	@makhoa nvarchar(50)
as
begin
	insert into tblGiaoVien(nguoitao,magiaovien,ho,tendem,ten,gioitinh,ngaysinh,email,dienthoai,diachi,makhoa)
	values(@nguoitao,'GV' + CAST(next value for giaovienSeq AS VARCHAR(30)) ,@ho,@tendem,@ten,@gioitinh,@ngaysinh,@email,@dienthoai,@diachi,@makhoa);
	if @@ROWCOUNT > 0 return 1 else return 0;
end;
GO
/****** Object:  StoredProcedure [dbo].[insertlophoc]    Script Date: 30/11/2023 1:45:31 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[insertlophoc]
	@nguoitao varchar(30),
	@malophoc varchar(50),
	@tenlophoc varchar(50),
	@khoahoc varchar(50),
	@hedaotao nvarchar(60),
	@namnhaphoc int,
	@makhoa nvarchar(50),
	@magiaovien varchar(50)
as
begin
	insert into tblLopHoc(nguoitao,malophoc,tenlophoc,khoahoc,hedaotao,namnhaphoc,makhoa,magiaovien)
	values(@nguoitao,@malophoc,@tenlophoc,@khoahoc,@hedaotao,@namnhaphoc,@makhoa,@magiaovien);
	if @@ROWCOUNT > 0 return 1 else return 0;
end
GO
/****** Object:  StoredProcedure [dbo].[insertlophocphan]    Script Date: 30/11/2023 1:45:31 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[insertlophocphan]
	@malophoc varchar(50),
	@mamonhoc varchar(50),
	@magiaovien varchar(50),
	@hocky int,
	@nam int,
	@makhoa nvarchar(50)
as
begin
	insert into tblLopHocPhan(malophocphan,mamonhoc,magiaovien,hocky,nam,makhoa)
	values(@malophoc,@mamonhoc,@magiaovien,@hocky,@nam,@makhoa);
	if @@ROWCOUNT > 0 return 1 else return 0;
end
GO
/****** Object:  StoredProcedure [dbo].[insertMH]    Script Date: 30/11/2023 1:45:31 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE procedure [dbo].[insertMH]
	@nguoitao varchar(30),
	@mamonhoc varchar(50),
	@tenmonhoc nvarchar(150),
	@sotinchi int
as
begin
	insert into tblMonHoc(nguoitao,mamonhoc,tenmonhoc,sotinchi)
	values(@nguoitao,@mamonhoc,@tenmonhoc,@sotinchi);
	if @@ROWCOUNT > 0 return 1 else return 0;
end
GO
/****** Object:  StoredProcedure [dbo].[RangeAllSinhVienbyclass]    Script Date: 30/11/2023 1:45:31 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RangeAllSinhVienbyclass]
	@tukhoa nvarchar(50)
AS
BEGIN
	SET @tukhoa = LOWER(LTRIM(RTRIM(@tukhoa)));

	SELECT 
		sv.masinhvien,
		CASE WHEN LEN(sv.tendem) <= 0 THEN CONCAT(sv.ho, ' ', sv.ten)
			ELSE CONCAT(sv.ho, ' ', sv.tendem, ' ', sv.ten) END AS hoten,
		CONVERT(VARCHAR(10), sv.ngaysinh, 103) AS nsinh,
		CASE WHEN sv.gioitinh = 1 THEN 'Nam' ELSE N'Nữ' END AS gt,
		sv.quequan,
		sv.diachi,
		sv.dienthoai,
		sv.email,
		 k.tenkhoa,
		lh.tenlophoc  -- Thêm thông tin lớp học
	FROM tblSinhVien sv
	INNER JOIN tblLopHoc lh ON sv.malophoc = lh.malophoc
	INNER JOIN tblKhoa k ON lh.makhoa = k.makhoa
	WHERE 
		LOWER(sv.ho) LIKE '%' + @tukhoa + '%'
		OR LOWER(sv.tendem) LIKE '%' + @tukhoa + '%'
		OR LOWER(sv.ten) LIKE '%' + @tukhoa + '%'
		OR LOWER(sv.email) LIKE '%' + @tukhoa + '%'
		OR LOWER(sv.diachi) LIKE '%' + @tukhoa + '%'
	ORDER BY lh.malophoc;
END;
GO
/****** Object:  StoredProcedure [dbo].[sapxep]    Script Date: 30/11/2023 1:45:31 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sapxep]
  @sapxep NVARCHAR(50)
as
begin
	if @sapxep = 'makhoa'
		SELECT 
		l.malophoc,
		l.tenlophoc,
		l.khoahoc,
		l.hedaotao,
		l.namnhaphoc,
		CONCAT(gv.ho, ' ', COALESCE(gv.tendem, ''), ' ', gv.ten) AS hoten,
		l.makhoa,
		k.tenkhoa
	FROM tblLopHoc l
	INNER JOIN tblKhoa k ON l.makhoa = k.makhoa
	INNER JOIN tblGiaoVien gv ON l.magiaovien = gv.magiaovien
	 ORDER BY l.makhoa
end
GO
/****** Object:  StoredProcedure [dbo].[selectAllGV]    Script Date: 30/11/2023 1:45:31 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[selectAllGV]
	@tukhoa nvarchar(50),
	@makhoa NVARCHAR(50) 
as
begin
	set @tukhoa = lower(ltrim(rtrim(@tukhoa)));
	select 
		magiaovien,
		case when len(ltrim(rtrim(tendem))) > 0 then concat(ltrim(rtrim(ho)),' ',ltrim(rtrim(tendem)), ' ', ltrim(rtrim(ten)))
		else  concat(ltrim(rtrim(ho)),' ', ltrim(rtrim(ten))) end as hoten,
		convert(varchar(10),ngaysinh,103) as ngaysinh,
		case when gioitinh = 1 then 'Nam' else N'Nữ' end as gt,
		dienthoai,
		email,
		diachi,
		makhoa
	from tblGiaoVien
	where
	(@makhoa IS NULL OR makhoa = @makhoa)
	  AND
	   (
	lower(ho) like '%'+@tukhoa+'%'
	or lower(tendem) like '%'+@tukhoa+'%'
	or lower(ten) like '%'+@tukhoa+'%'
	or lower(ho) like '%'+@tukhoa+'%'
	or lower(email) like '%'+@tukhoa+'%'
	or lower(dienthoai) like '%'+@tukhoa+'%'
	or lower(diachi) like '%'+@tukhoa+'%'
	or lower(magiaovien) like '%'+@tukhoa+'%'
	  )
	order by ten;
end
GO
/****** Object:  StoredProcedure [dbo].[selectAllMonHoc]    Script Date: 30/11/2023 1:45:31 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[selectAllMonHoc]
	@tukhoa nvarchar(50)
as
begin
	set @tukhoa = lower(ltrim(rtrim(@tukhoa)));
	select 
		mamonhoc,
		tenmonhoc,
		sotinchi
	from tblMonHoc
	where mamonhoc like '%'+@tukhoa+'%'
	or lower(tenmonhoc) like '%'+@tukhoa+'%'
	order by tenmonhoc;	
end;
GO
/****** Object:  StoredProcedure [dbo].[SelectAllSinhVien]    Script Date: 30/11/2023 1:45:31 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SelectAllSinhVien]
	@tukhoa nvarchar(50),
	 @malophoc NVARCHAR(50) 

AS
BEGIN
	SET @tukhoa = LOWER(LTRIM(RTRIM(@tukhoa)));

	SELECT 
		sv.masinhvien,
		CONCAT(sv.ho, ' ', COALESCE(sv.tendem, ''), ' ', sv.ten) AS hoten,
		CONVERT(VARCHAR(10), sv.ngaysinh, 103) AS nsinh,
		CASE WHEN sv.gioitinh = 1 THEN 'Nam' ELSE N'Nữ' END AS gt,
		sv.quequan,
		sv.diachi,
		sv.dienthoai,
		sv.email,
	    k.tenkhoa,
		lh.tenlophoc  -- Thêm thông tin lớp học
	FROM tblSinhVien sv
	INNER JOIN tblLopHoc lh ON sv.malophoc = lh.malophoc
	INNER JOIN tblKhoa k ON lh.makhoa = k.makhoa
	WHERE 
	(@malophoc IS NULL OR lh.malophoc = @malophoc)
        AND
        (
            LOWER(sv.email) LIKE '%' + @tukhoa + '%'
            OR LOWER(sv.diachi) LIKE '%' + @tukhoa + '%'
            OR LOWER(sv.dienthoai) LIKE '%' + @tukhoa + '%'
            OR CONVERT(VARCHAR(10), sv.ngaysinh, 103) LIKE '%' + @tukhoa + '%'
            OR sv.masinhvien LIKE '%' + @tukhoa + '%'
            OR lh.tenlophoc LIKE '%' + @tukhoa + '%'
			OR CONCAT(sv.ho, ' ', COALESCE(sv.tendem, ''), ' ', sv.ten) LIKE '%' + @tukhoa + '%'
        )
    ORDER BY sv.masinhvien;
END;
GO
/****** Object:  StoredProcedure [dbo].[selectcbbGV]    Script Date: 30/11/2023 1:45:31 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[selectcbbGV]
@tukhoa nvarchar(50)
as
begin
	set @tukhoa = lower(ltrim(rtrim(@tukhoa)));
	select 
		magiaovien,
		case when len(ltrim(rtrim(tendem))) > 0 then concat(ltrim(rtrim(ho)),' ',ltrim(rtrim(tendem)), ' ', ltrim(rtrim(ten)))
		else  concat(ltrim(rtrim(ho)),' ', ltrim(rtrim(ten))) end as hoten
	from tblGiaoVien
	where
	lower(ho) like '%'+@tukhoa+'%'
	or lower(tendem) like '%'+@tukhoa+'%'
	or lower(ten) like '%'+@tukhoa+'%'
	order by ten;
end
GO
/****** Object:  StoredProcedure [dbo].[selectgv]    Script Date: 30/11/2023 1:45:31 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[selectgv]
	@mgv varchar(50)
as
begin
	select
		ho,tendem,ten,
		gioitinh,convert(varchar(10),ngaysinh,103) as ngsinh,
		dienthoai,email,diachi
	from tblGiaoVien
	where magiaovien = @mgv;
end
GO
/****** Object:  StoredProcedure [dbo].[selectKhoa]    Script Date: 30/11/2023 1:45:31 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[selectKhoa]
	@makhoa varchar(50)
as
begin
	select
		k.tenkhoa
	from tblKhoa k
	where makhoa = @makhoa;
end
GO
/****** Object:  StoredProcedure [dbo].[selectLopHoc]    Script Date: 30/11/2023 1:45:31 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[selectLopHoc]
	@malophoc varchar(50)
as
begin
	select
	    l.malophoc,
		l.tenlophoc,
		l.khoahoc,
		l.hedaotao,
	    l.namnhaphoc,
		l.makhoa,
		l.magiaovien
	from tblLopHoc l
	where malophoc = @malophoc;
end
GO
/****** Object:  StoredProcedure [dbo].[selectLopHocPhan]    Script Date: 30/11/2023 1:45:31 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[selectLopHocPhan]
	@malophoc varchar(50)
as
begin
	select
	    lp.malophocphan,
		lp.mamonhoc,
		lp.magiaovien,
		lp.hocky,
		lp.nam,
		lp.makhoa
	from tblLopHocPhan lp
	where malophocphan = @malophoc;
end
GO
/****** Object:  StoredProcedure [dbo].[selectmh]    Script Date: 30/11/2023 1:45:31 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[selectmh]
	@mamh varchar(50)
as
begin
	select 
	    mamonhoc,
		tenmonhoc,
		sotinchi
	from tblMonHoc
	where mamonhoc = @mamh;
end
GO
/****** Object:  StoredProcedure [dbo].[selectSv]    Script Date: 30/11/2023 1:45:31 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[selectSv]
	@msv varchar(50)
as
begin
	select
		ho,tendem,ten,
		convert(varchar(10),ngaysinh,103) as ngsinh,
		gioitinh,
		quequan,diachi,dienthoai,email,malophoc
	from tblSinhVien
	where masinhvien = @msv;
end
GO
/****** Object:  StoredProcedure [dbo].[ThemMoiSV]    Script Date: 30/11/2023 1:45:31 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ThemMoiSV]
    @ho NVARCHAR(10),
    @tendem NVARCHAR(20),
    @ten NVARCHAR(10),
    @ngaysinh DATE,
    @gioitinh TINYINT,
    @quequan NVARCHAR(150),
    @diachi NVARCHAR(150),
    @dienthoai VARCHAR(30),
    @email VARCHAR(150),
    @malophoc varchar(50)
AS
BEGIN
    DECLARE @newMaso VARCHAR(30);
    -- Lấy mã sinh viên từ bảng tblDeletedSinhVien nếu có
    SELECT TOP 1 @newMaso = masinhvien
    FROM tblDeletedSinhVien
    ORDER BY masinhvien;
    -- Nếu không có mã sinh viên đã xóa, sinh mã mới
    IF @newMaso IS NOT NULL
BEGIN
    -- Sử dụng mã sinh viên đã xóa 
    INSERT INTO tblSinhVien (masinhvien, ho, tendem, ten, ngaysinh, gioitinh, quequan, diachi, dienthoai, email, malophoc)
    VALUES (@newMaso, @ho, @tendem, @ten, @ngaysinh, @gioitinh, @quequan, @diachi, @dienthoai, @email, @malophoc);
    DELETE FROM tblDeletedSinhVien WHERE masinhvien = @newMaso;
	 if @@ROWCOUNT > 0 begin return 1 end
	else begin return 0 end;
END
ELSE
BEGIN
    -- Sinh mã mới
    INSERT INTO tblSinhVien (masinhvien, ho, tendem, ten, ngaysinh, gioitinh, quequan, diachi, dienthoai, email, malophoc)
    VALUES ('SV' + CAST(next value for sinhvienSeq AS VARCHAR(30)), @ho, @tendem, @ten, @ngaysinh, @gioitinh, @quequan, @diachi, @dienthoai, @email, @malophoc);
	if @@ROWCOUNT > 0 begin return 1 end
	else begin return 0 end;
END
END;
GO
/****** Object:  StoredProcedure [dbo].[updateGV]    Script Date: 30/11/2023 1:45:31 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[updateGV]
	@magiaovien varchar(50),
	@nguoicapnhat varchar(30),
	@ho nvarchar(10),
	@tendem nvarchar(20), 
	@ten nvarchar(10),
	@gioitinh tinyint,
	@ngaysinh date,
	@email varchar(150),
	@dienthoai varchar(30),
	@diachi nvarchar(150),
	@makhoa nvarchar(50)
as
begin
	update tblGiaoVien
	set nguoicapnhat = @nguoicapnhat,
		ngaycapnhat = getdate(),
		ho = @ho,tendem = @tendem, ten = @ten,
		gioitinh = @gioitinh,
		ngaysinh = @ngaysinh,
		email = @email,
		dienthoai = @dienthoai, 
		diachi = @diachi,
		makhoa = @makhoa
	where magiaovien = @magiaovien;
	if @@ROWCOUNT > 0 return 1 else return 0;
end;
GO
/****** Object:  StoredProcedure [dbo].[updatelophoc]    Script Date: 30/11/2023 1:45:31 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[updatelophoc]
	@nguoicapnhat varchar(30),
	@malophoc varchar(50),
	@tenlophoc varchar(50),
	@khoahoc varchar(50),
	@hedaotao nvarchar(60),
	@namnhaphoc int,
	@makhoa nvarchar(50),
	@magiaovien varchar(50)
as
begin
	update tblLopHoc
	set
		ngaycapnhat = getdate(),
		nguoicapnhat = @nguoicapnhat,
		tenlophoc = @tenlophoc,
		khoahoc = @khoahoc,
		hedaotao =@hedaotao,
		namnhaphoc = @namnhaphoc,
		makhoa = @makhoa,
		magiaovien = @magiaovien
	where malophoc = @malophoc;
	if @@ROWCOUNT > 0 return 1 else return 0;
end
GO
/****** Object:  StoredProcedure [dbo].[updatelophocphan]    Script Date: 30/11/2023 1:45:31 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[updatelophocphan]
	@malophoc varchar(50),
	@mamonhoc varchar(50),
	@magiaovien varchar(50),
	@hocky int,
	@nam int,
	@makhoa nvarchar(50)
as
begin
	update tblLopHocPhan
	set 
		mamonhoc = @mamonhoc,
		makhoa = @makhoa,
		magiaovien = @magiaovien,
		hocky = @hocky,
		nam = @nam
	where malophocphan = @malophoc;
	if @@ROWCOUNT > 0 return 1 else return 0;
end
GO
/****** Object:  StoredProcedure [dbo].[updateMH]    Script Date: 30/11/2023 1:45:31 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[updateMH]
	@nguoicapnhat varchar(30),
	@mamonhoc varchar(50),
	@tenmonhoc nvarchar(150),
	@sotinchi int
as
begin
	update tblMonHoc
	set
		nguoicapnhat = @nguoicapnhat,
		ngaycapnhat = getdate(),
		tenmonhoc = @tenmonhoc,
		sotinchi = @sotinchi
	where mamonhoc = @mamonhoc;
	if @@ROWCOUNT > 0 return 1 else return 0;
	
end
GO
/****** Object:  StoredProcedure [dbo].[updateSV]    Script Date: 30/11/2023 1:45:31 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[updateSV]
	@masinhvien varchar(50),
	@ho	nvarchar(10),
	@tendem nvarchar(20),
	@ten nvarchar(10),
	@ngaysinh date,
	@gioitinh tinyint,
	@quequan nvarchar(150),
	@diachi nvarchar(150),
	@dienthoai varchar(30),
	@email varchar(150),
	@malophoc varchar(50)
as
begin
	update tblSinhVien
	set 
		ho = @ho,tendem = @tendem,ten=@ten,
		ngaysinh = @ngaysinh,gioitinh = @gioitinh,
		quequan = @quequan, diachi = @diachi,
		dienthoai = @dienthoai, email = @email,
		malophoc = @malophoc
	where masinhvien = @masinhvien;
	if @@ROWCOUNT > 0 begin return 1 end 
	else begin return 0 end;
end;
GO
USE [master]
GO
ALTER DATABASE [QLSV] SET  READ_WRITE 
GO
