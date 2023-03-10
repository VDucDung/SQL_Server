use master
go
create database QLBenhnhan
on primary(
	name='QLbenhnhan', filename='D:\ngon_ngu_lt\SQL_Server\QlBenhnhan\QLbenhnhan.mdf', size =8, maxsize=64, filegrowth=20%
)
log on(
	name='QLbenhnhan_log', filename='D:\ngon_ngu_lt\SQL_Server\QlBenhnhan\QLbenhnhanLog.ldf', size =8, maxsize=64, filegrowth=20%
)
use QLBenhnhan
go
create table BenhVien(
		MaBV nchar(10) primary key,
		TenBV nvarchar(20)
)
create table KhoaKham(
		MaKhoa nchar(10) primary key,
		TenKhoa nvarchar(20), 
		SoBenhNhan int,
		MaBV nchar(10) foreign key references BenhVien(MaBV) on update cascade on delete cascade
)
create table BenhNhan(
		MaBN nchar(10) primary key,
		HoTen nvarchar(20),
		NgaySinh date,
		GioTinh nchar(10),
		SoNgayNV int,
		MaKhoa nchar(10) foreign key references KHoaKham(MaKHoa) on update cascade on delete cascade
)

insert into BenhVien values('BV01', N'Nha Khoa'),('BV02', N'Đông y'),('BV03', N'Phương Liễu')
insert into KhoaKham values
('K01',N'Răng hàm mặt',20,'BV01'),
('K02',N'nội',10,'BV02'),
('K03',N'Ngoại',20,'BV03')
insert into BenhNhan values
('BN01', N'Vũ Linh','08/05/2017',N'Nữ',20, 'K01'),
('BN02', N'Vũ Dũng','08/05/2013',N'Nam',20, 'K02'),
('BN03', N'Vũ Hà','08/05/2016',N'Nữ',15, 'K03'),
('BN04', N'Nguyễn Hà','08/05/2014',N'Nữ',25, 'K03'),
('BN05', N'Trần Danh','08/05/2012',N'Nữ',15, 'K01')
select * from BenhNhan
select * from BenhVien
select * from KhoaKham