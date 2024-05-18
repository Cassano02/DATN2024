DROP DATABASE IF EXISTS `MockProject_Database`;
CREATE DATABASE IF NOT EXISTS `MockProject_Database`;
USE `MockProject_Database`;

/* _____________________________________________________________________ CÁC BẢNG LIÊN QUAN TỚI TÀI KHOẢN _________________________________________________________*/
DROP TABLE IF EXISTS `TaiKhoan`;
CREATE TABLE IF NOT EXISTS `TaiKhoan` (
    `MaTaiKhoan`  			INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `MatKhau` 				NVARCHAR(255) 											NOT NULL,
    `TrangThai`     		BOOLEAN                 								NOT NULL    DEFAULT false,
    `NgayTao`				DATETIME                 								NOT NULL 	DEFAULT NOW(),
	`Quyen`       			ENUM("ADMIN","USER")  	NOT NULL 	DEFAULT "USER"
);

DROP TABLE IF EXISTS `RegistrationToken`;
CREATE TABLE IF NOT EXISTS  `RegistrationToken` (
    `Id`  					INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	`token`	 				CHAR(36) 			NOT NULL 	UNIQUE,
	`MaTaiKhoan` 			INT UNSIGNED 		NOT NULL,
	`HanSuDung` 			DATETIME 			NOT NULL,
	FOREIGN KEY (`MaTaiKhoan`) 	REFERENCES `TaiKhoan`(`MaTaiKhoan`)
);

DROP TABLE IF EXISTS `JWTToken`;
CREATE TABLE IF NOT EXISTS `JWTToken` (
    `MaToken`  					INT UNSIGNED AUTO_INCREMENT,
    `Token` 					NVARCHAR(255) 											NOT NULL,
    `HanSuDung`     			DATETIME                 								NOT NULL,
    `MaTaiKhoan`				INT UNSIGNED,
    FOREIGN KEY (`MaTaiKhoan`) 	REFERENCES `TaiKhoan`(`MaTaiKhoan`),
    PRIMARY KEY (`MaToken`, `MaTaiKhoan`)

);

DROP TABLE IF EXISTS `NguoiDung`;
CREATE TABLE IF NOT EXISTS `NguoiDung` (
    `MaNguoiDung`  				INT UNSIGNED PRIMARY KEY,
    `HoTen` 					NVARCHAR(255) 			NOT NULL,
    `SoDienThoai` 				NVARCHAR(20) 			NOT NULL,
    `Email` 					NVARCHAR(255) 			NOT NULL		UNIQUE,
	FOREIGN KEY (`MaNguoiDung`) REFERENCES `TaiKhoan`(`MaTaiKhoan`)
);
#
# DROP TABLE IF EXISTS `DiaChi`;
# CREATE TABLE IF NOT EXISTS `DiaChi` (
#     `MaDiaChi`			INT UNSIGNED 	AUTO_INCREMENT PRIMARY KEY,
# 	`MaNguoiDung`  		INT UNSIGNED 	NOT NULL,
#     `QuocGia` 			NVARCHAR(255) 	NOT NULL,
#     `Tinh` 				NVARCHAR(255) 	NOT NULL,
#     `Quan` 				NVARCHAR(255) 	NOT NULL,
#     `Phuong` 			NVARCHAR(255) 	NOT NULL,
#     `SoNha` 			NVARCHAR(255) 	NOT NULL,
#     `TrangThaiMacDinh` 	BOOLEAN 		NOT NULL DEFAULT 0,
#     `TrangThaiTonTai` 	BOOLEAN 		NOT NULL DEFAULT 1,
#     FOREIGN KEY (`MaNguoiDung`) REFERENCES `NguoiDung`(`MaNguoiDung`)
# );

/* _____________________________________________________________________ CÁC BẢNG LIÊN QUAN TỚI SẢN PHẨM _________________________________________________________*/


DROP TABLE IF EXISTS `LoaiSanPham`;
CREATE TABLE IF NOT EXISTS `LoaiSanPham` (
    `MaLoaiSanPham` 	INT UNSIGNED 	PRIMARY KEY 	AUTO_INCREMENT,
    `TenLoaiSanPham` 	NVARCHAR(255) 	NOT NULL 		UNIQUE
);


# DROP TABLE IF EXISTS `ThuongHieu`;
# CREATE TABLE IF NOT EXISTS `ThuongHieu` (
#     `MaThuongHieu` 		INT UNSIGNED 	PRIMARY KEY 	AUTO_INCREMENT,
#     `TenThuongHieu` 	NVARCHAR(255) 	NOT NULL 		UNIQUE
# );


DROP TABLE IF EXISTS `SanPham`;
CREATE TABLE IF NOT EXISTS `SanPham` (
    `MaSanPham` 			INT  UNSIGNED 			PRIMARY KEY AUTO_INCREMENT,
    `TenSanPham` 			NVARCHAR(255) 			NOT NULL 	UNIQUE,
    `Gia` 					INT UNSIGNED 			NOT NULL,
    `SoLuongConLai`	 		INT UNSIGNED 			NOT NULL 	DEFAULT 0,
	`TrangThai` 			BOOLEAN 				NOT NULL    DEFAULT true,
	`SoLuot` 				NVARCHAR(255) 			NOT NULL,
    `MoTaChiTiet` 			TEXT					NOT NULL,
    `CongDung`				TEXT					NOT NULL,
    `ThanhPhan`				TEXT					NOT NULL,
	`MaThuongHieu` 			INT UNSIGNED 			NOT NULL,
    `MaLoaiSanPham` 		INT UNSIGNED 			NOT NULL,
    FOREIGN KEY (`MaLoaiSanPHam`) REFERENCES `LoaiSanPham`(`MaLoaiSanPham`)

);

DROP TABLE IF EXISTS `AnhMinhHoa`;
CREATE TABLE IF NOT EXISTS `AnhMinhHoa` (
    `MaSanPham` 		INT UNSIGNED			NOT NULL,
    `URL`				NVARCHAR(255) 			NOT NULL,
	FOREIGN KEY (`MaSanPham`) REFERENCES `SanPham`(`MaSanPham`),
    PRIMARY KEY (`MaSanPham`,`URL`)
);

/* _____________________________________________________________________ CÁC BẢNG LIÊN QUAN TỚI SỰ KIỆN _________________________________________________________*/







/* _____________________________________________________________________ CÁC BẢNG LIÊN QUAN TỚI ĐÁNH GÍA _________________________________________________________*/

DROP TABLE IF EXISTS `DanhGia`;
CREATE TABLE IF NOT EXISTS `DanhGia` (
    `MaTaiKhoan` 					INT  UNSIGNED			NOT NULL,
    `MaSanPham` 					INT  UNSIGNED			NOT NULL,
    `ThoiGian` 						DATETIME				NOT NULL,
    `SoSao`							TINYINT UNSIGNED 		NOT NULL,
    `BinhLuan`						TEXT  					NOT NULL,
	PRIMARY KEY (`MaTaiKhoan`, `MaSanPham`),
	FOREIGN KEY (`MaSanPham`) 		REFERENCES `SanPham`(`MaSanPham`),
	FOREIGN KEY (`MaTaiKhoan`) 		REFERENCES `TaiKhoan`(`MaTaiKhoan`)
);







/* _____________________________________________________________________ CÁC BẢNG LIÊN QUAN TỚI NGHIEP VU NHAP KHO _________________________________________________________*/







/* _____________________________________________________________________ CÁC BẢNG LIÊN QUAN TỚI NGHIEP VU MUA HÀNG _________________________________________________________*/

DROP TABLE IF EXISTS `GioHang`;
CREATE TABLE IF NOT EXISTS  `GioHang` (
    `DonGia` 						INT UNSIGNED NOT NULL,
	`SoLuong` 						INT UNSIGNED NOT NULL,
    `ThanhTien` 					INT UNSIGNED NOT NULL,
    `MaTaiKhoan` 					INT UNSIGNED NOT NULL,
    `MaSanPham` 					INT UNSIGNED NOT NULL,
    FOREIGN KEY ( `MaTaiKhoan` ) 	REFERENCES `TaiKhoan`( `MaTaiKhoan` ),
	FOREIGN KEY ( `MaSanPham` 	) 	REFERENCES `SanPham`( `MaSanPham` 	),
    PRIMARY KEY ( `MaTaiKhoan` , `MaSanPham`)
);


DROP TABLE IF EXISTS `DichVuVanChuyen`;
CREATE TABLE IF NOT EXISTS `DichVuVanChuyen`(
	`MaDichVu`  		INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	`TenDichVu` 		NVARCHAR(255) 		NOT NULL 	UNIQUE
);

DROP TABLE IF EXISTS `DonHang`;
CREATE TABLE IF NOT EXISTS `DonHang`(
	`MaDonHang`  			INT UNSIGNED 		PRIMARY KEY AUTO_INCREMENT,
    `NgayDat` 				DATETIME 			NOT NULL,
    `TongGiaTri` 			INT UNSIGNED 		NOT NULL,

    `MaKhachHang` 			INT UNSIGNED 		NOT NULL,
	`MaDiaChi` 				INT UNSIGNED 		NOT NULL,

    `PhuongThucThanhToan` 	INT UNSIGNED 		NOT NULL,
    `DichVuVanChuyen`   	INT UNSIGNED 		NOT NULL,

	FOREIGN KEY (`MaKhachHang`) 		REFERENCES `TaiKhoan`(`MaTaiKhoan`),

	FOREIGN KEY (`DichVuVanChuyen`) 	REFERENCES `DichVuVanChuyen`(`MaDichVu`)
);

DROP TABLE IF EXISTS `TrangThaiDonHang`;
CREATE TABLE IF NOT EXISTS `TrangThaiDonHang`(
    `TrangThai` 	        	ENUM ("ChoDuyet", "DaDuyet", "Huy", "DangGiao" , "GiaoThanhCong") 	NOT NULL 	DEFAULT "ChoDuyet",
    `NgayCapNhat` 	        	DATETIME 															NOT NULL	DEFAULT NOW(),
	`MaDonHang`  		    	INT UNSIGNED														NOT NULL	,
	FOREIGN KEY (`MaDonHang`) 	REFERENCES `DonHang`(`MaDonHang`),
    PRIMARY KEY(`MaDonHang`, `TrangThai`)
);


DROP TABLE IF EXISTS `CTDH`;
CREATE TABLE IF NOT EXISTS  `CTDH` (
	`SoLuong`           	INT UNSIGNED    NOT NULL,
    `ThanhTien`         	INT UNSIGNED    NOT NULL,
    `DonGia`            	INT UNSIGNED    NOT NULL,
    `MaDonHang`         	INT UNSIGNED,
    `MaSanPham`         	INT UNSIGNED,
    FOREIGN KEY (`MaDonHang`) REFERENCES `DonHang`(`MaDonHang`),
	FOREIGN KEY (`MaSanPham`) REFERENCES `SanPham`(`MaSanPham`),
    PRIMARY KEY (`MaDonHang`, `MaSanPham`)
);


