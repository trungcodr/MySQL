create database QuanLyPhongGym;
use QuanLyPhongGym;

create table HoiVien(
	HoiVienId int primary key auto_increment,
    HoTen varchar(100) not null,
    NgaySinh date,
    GioiTinh enum ('Nam', 'Nu', 'Khac'),
    DiaChi varchar(200),
    SDT varchar(10),
    Email varchar(100),
    NgayDangKy date
);

CREATE TABLE NhanVien (
    NhanVienID INT AUTO_INCREMENT PRIMARY KEY,
		HoTen VARCHAR(100) NOT NULL,
    NgaySinh DATE,
    GioiTinh ENUM('Nam', 'Nữ', 'Khác'),
    SDT VARCHAR(15),
    Email VARCHAR(100),
    ChucVu VARCHAR(50)
);

CREATE TABLE GoiTap (
    GoiTapID INT AUTO_INCREMENT PRIMARY KEY,
    TenGoiTap VARCHAR(100) NOT NULL,
    MoTa TEXT,
    Gia DECIMAL(10, 2) NOT NULL
);

CREATE TABLE DichVu (
    DichVuID INT AUTO_INCREMENT PRIMARY KEY,
    TenDichVu VARCHAR(100) NOT NULL,
    MoTa TEXT,
    Gia DECIMAL(10, 2) NOT NULL
);

CREATE TABLE ThietBi (
    ThietBiID INT AUTO_INCREMENT PRIMARY KEY,
    TenThietBi VARCHAR(100) NOT NULL,
    MoTa TEXT,
    TinhTrang ENUM('Tốt', 'Hỏng', 'Đang sửa chữa') NOT NULL
);

CREATE TABLE HoiVien_GoiTap (
	ID int primary key auto_increment,
    HoiVienID INT,
    GoiTapID INT,
    NgayBatDau DATE NOT NULL,
    NgayKetThuc DATE NOT NULL,
    unique(HoiVienID,GoiTapID,NgayBatDau),
    FOREIGN KEY (HoiVienID) REFERENCES HoiVien(HoiVienID),
    FOREIGN KEY (GoiTapID) REFERENCES GoiTap(GoiTapID)
);

CREATE TABLE HoiVien_DichVu (
	ID int primary key auto_increment,
    HoiVienID INT,
    DichVuID INT,
    NgayDangKy DATE NOT NULL,
    unique (HoiVienID, DichVuID, NgayDangKy),
    FOREIGN KEY (HoiVienID) REFERENCES HoiVien(HoiVienID),
    FOREIGN KEY (DichVuID) REFERENCES DichVu(DichVuID)
);

CREATE TABLE LichTap (
    LichTapID INT AUTO_INCREMENT PRIMARY KEY,
    HoiVienID INT,
    NhanVienID INT,
    ThoiGianBatDau DATETIME NOT NULL,
    ThoiGianKetThuc DATETIME NOT NULL,
    GhiChu TEXT,
    FOREIGN KEY (HoiVienID) REFERENCES HoiVien(HoiVienID),
    FOREIGN KEY (NhanVienID) REFERENCES NhanVien(NhanVienID)
);

CREATE TABLE ThanhToan (
    ThanhToanID INT AUTO_INCREMENT PRIMARY KEY,
    HoiVienID INT,
    SoTien DECIMAL(10, 2) NOT NULL,
    NgayThanhToan DATE NOT NULL,
    PhuongThucThanhToan VARCHAR(50),
    MoTa TEXT,
    FOREIGN KEY (HoiVienID) REFERENCES HoiVien(HoiVienID)
);
alter table ThanhToan
add TrangThai enum ('Da thanh toan', 'Chua thanh toan');
CREATE TABLE BaoCaoSuCo (
    BaoCaoID INT AUTO_INCREMENT PRIMARY KEY,
    ThietBiID INT,
    NhanVienID INT,
    NgayBaoCao DATE NOT NULL,
    MoTaSuCo TEXT,
    FOREIGN KEY (ThietBiID) REFERENCES ThietBi(ThietBiID),
    FOREIGN KEY (NhanVienID) REFERENCES NhanVien(NhanVienID)
);

