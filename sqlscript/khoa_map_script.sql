﻿--1. Thêm cột địa chỉ hiện tại của shipper
use DiChoThue;
go
--thêm cột ViTriHienTai để demo tìm shipper gần nhất.
ALTER TABLE Shipper ADD ViTriHienTai nvarchar(200);
--
select * from DiChoThue.dbo.Shipper;

--thêm một vài shipper
insert into  Shipper  (HoTen, NgaySinh, SoDienThoai, CMND, TinhTrangSucKhoe, ViTriHienTai)
values ('khoaminhi', '1995-03-04', '2938474345', '290384839', '2', N'Tịnh Kỳ, Quang Ngai, Vietnam');
insert into  Shipper  (HoTen, NgaySinh, SoDienThoai, CMND, TinhTrangSucKhoe, ViTriHienTai)
values ('khoaminhi', '1995-03-04', '2938474345', '290384839', '2', N'Tịnh Khê, Quang Ngai, Vietnam');

--thêm cột latitude và longtitude
ALTER TABLE Shipper ADD Latitude float;
ALTER TABLE Shipper ADD Longtitude float;

--
select * from Shipper;

update Shipper set Latitude = 15.192965, Longtitude = 108.889596 where ViTriHienTai like N'%Khê%';
update Shipper set Latitude = 15.205642, Longtitude = 108.916006 where ViTriHienTai like N'%Kỳ%';

--native script
select * from Shipper s where s.ViTriHienTai like N'%Khê%' or s.ViTriHienTai like N'%Kỳ%';

--==================================================

DECLARE @TestVariable AS nVARCHAR(100)= N'Củ cà rốt';
--doi tac ban hang

--
select dt.MaDoiTacBanHang, dt.TenDoiTacBH, dt.SDTDoiTacBH, dc.DiaChi, dc.Latitude, dc.Longtitude
from DoiTacBanHang dt join DiaChiDoitac dc 
	on dt.MaDoiTacBanHang=dc.MaDoiTacBanHang;

--search accoring to product, product category
select d.MaDoiTacBanHang, d.TenDoiTacBH, d.SDTDoiTacBH, d.emailDoiTacBH, d.ngayBatDauBan, dc.DiaChi, 
	dc.Latitude, dc.Longtitude,dc.KhuVuc, s.TenSanPham, dm.TenDanhMuc
from DoiTacBanHang d join DiaChiDoitac dc on d.MaDoiTacBanHang=dc.MaDoiTacBanHang
	join DanhSachChuanBiSanPham ds on ds.MaDoitac = d.MaDoiTacBanHang
	join ChiTietDanhSachSanPham ct on ct.MaDanhSachChuanBi = ds.MaDanhSachChuanBi
	join SanPham s on s.MaSanPham = ct.MaSanPham
	join DanhMuc dm on dm.MaDanhMuc = s.MaDanhMuc
where (s.TenSanPham like @TestVariable and @TestVariable is not null)
;
go

--alter table and insert more data
alter table DiaChiDoiTac add Latitude float;
alter table DiaChiDoiTac add Longtitude float;

--insert
SET IDENTITY_INSERT DoiTacBanHang ON;
insert DoiTacBanHang(MaDoiTacBanHang, emailDoiTacBH, MaSoThue, ngayBatDauBan, SDTDoiTacBH, TenDoiTacBH) 
values(4181234, N'khoaminhi@gmail.com', N'ABCD', '2020-1-1', N'0143424234', N'khoaminhi'),
	(4181235, N'khoaminhi2@gmail.com', N'ABCDF', '2020-1-1', N'0143424236', N'khoaminhi2');

insert DoiTacBanHang(MaDoiTacBanHang, emailDoiTacBH, MaSoThue, ngayBatDauBan, SDTDoiTacBH, TenDoiTacBH) 
values(4181236, N'khoaminhi3@gmail.com', N'ABCD', '2020-1-1', N'0143424234', N'hoang'),
	(4181237, N'khoaminhi21@gmail.com', N'ABCDF', '2020-1-1', N'0143424236', N'trung'),
	(4181238, N'khoaminhi6@gmail.com', N'ABCD', '2020-1-1', N'0143424234', N'khanh'),
	(4181239, N'khoaminhi27@gmail.com', N'ABCDF', '2020-1-1', N'0143424236', N'quang'),
	(41812341, N'khoaminhi8@gmail.com', N'ABCD', '2020-1-1', N'0143424234', N'hai'),
	(41812352, N'khoaminhi29@gmail.com', N'ABCDF', '2020-1-1', N'0143424236', N'banh mi nam can'),
	(41812343, N'khoaminhi65@gmail.com', N'ABCD', '2020-1-1', N'0143424234', N'hong'),
	(41812354, N'khoaminhi287@gmail.com', N'ABCDF', '2020-1-1', N'0143424236', N'khai')
	;
go
SET IDENTITY_INSERT DoiTacBanHang OFF;

SET IDENTITY_INSERT DiaChiDoitac ON;
insert DiaChiDoitac(MaDiaChi, MaDoiTacBanHang, DiaChi, KhuVuc, Latitude, Longtitude)
values(418234, 4181234, N'135 Đ. Trần Hưng Đạo, Phường Cầu Ông Lãnh', 1, 10.767316263803535, 106.69488933045372),
	(418235, 4181235, N'18 Điện Biên Phủ, Đa Kao', 1, 10.791934059695496, 106.69875468229652);
go
insert DiaChiDoitac(MaDiaChi, MaDoiTacBanHang, DiaChi, KhuVuc, Latitude, Longtitude)
values(4182369, 4181236, N'193B Lý Chính Thắng, Võ Thị Sáu', 2, 10.781468010802454, 106.68316603077669),
	(418236, 4181237,    N'Nam Kỳ Khởi Nghĩa, Phường 8', 2, 10.790011, 106.683655),
	(4182361, 4181238,   N'610 Nguyễn Đình Chiểu, Phường 3', 2, 10.769227, 106.681291),
	(4182362, 4181239,   N'Khánh Hội, Phường 4', 3,  10.754222, 106.702049),
	(4182363, 41812341,  N'492 Nguyễn Tất Thành, Phường 18', 3,  10.757101, 106.717795),
	(4182364, 41812352,  N'phường 9', 3,  10.763271, 106.703866),
	(4182365, 41812343,  N'Phạm Thị Ba, Phú Thuận', 4, 10.738088, 106.731995 ),
	(4182366, 41812354,  N'39603-39559 Huỳnh Tấn Phát, Phú Mỹ', 4, 10.706105, 106.737586
 )
go
SET IDENTITY_INSERT DiaChiDoitac OFF;

SET IDENTITY_INSERT DanhSachChuanBiSanPham ON;
insert DanhSachChuanBiSanPham(MaDanhSachChuanBi, MaDoitac, NgayBan, NgayLap)
values(418234, 4181234, '2000-2-1', '2000-1-30'),
	(418235, 4181235, '2000-2-1', '2000-1-30');
go
SET IDENTITY_INSERT DanhSachChuanBiSanPham OFF;

SET IDENTITY_INSERT SanPham ON;
insert SanPham(MaSanPham, MaDanhMuc, TenSanPham, DonGia)
values(418345, 1, N'Củ Khoai', 30000),
	(418346, 1, N'Củ cà rốt', 35000);
go
SET IDENTITY_INSERT SanPham OFF;

update SanPham set MaDoiTacBanHang = 4181234 where MaSanPham=418345;
update SanPham set MaDoiTacBanHang = 4181234 where MaSanPham=418346;

insert ChiTietDanhSachSanPham(MaDanhSachChuanBi, MaSanPham, DonGia, SoLuong)
values(418234, 418345, 30000, 50),
	(418235, 418346,35000, 100);
go

--https://stackjava.com/hibernate/code-vi-du-hibernate-pagination-phan-trang-trong-hibernate.html
