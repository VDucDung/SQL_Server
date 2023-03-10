use master
go
create database QLSinhVien
on primary(
	name='QlSinhVien', filename='D:\ngon_ngu_lt\SQL_Server\QlSinhVien\QLSinhVien.mdf', size=8, maxsize=64, filegrowth=20%
)
log on(
	name='QlSinhVien_log', filename='D:\ngon_ngu_lt\SQL_Server\QlSinhVien\QLSinhVien_log.mdf', size=8, maxsize=64, filegrowth=20%
)
use QlSinhVien
go
create table Khoa(
		MaKhoa nchar(10) primary key,
		TenKhoa nvarchar(20),
		DiaChi nvarchar(20),
		SoDT nchar(20),
		Email nvarchar(20)
)
create table Lop(
		MaLop nchar(10) primary key,
		TenLop nvarchar(20),
		SiSo int,
		MaKhoa nchar(10) foreign key references Khoa(MaKhoa) on update cascade on delete cascade,
		Phong nvarchar(20)
)
create table SinhVien(
		MaSV nchar(10) primary key,
		HoTen nvarchar(20),
		NgaySinh date,
		GioiTinh nvarchar(20),
		MaLop nchar(10) foreign key references Lop(MaLop) on update cascade on delete cascade
)
insert into Khoa values
('K01', N'CNTT', N'Hà Nội', '098765432', 'a@gmail.com'),
('K02', N'QTKD', N'Hà Nội', '092335432', 'b@gmail.com'),
('K03', N'NN', N'Hà Nội', '093954323', 'c@gmail.com')

insert into Lop values
('L01', N'KTPM', 60, 'K01', 'P01'),
('L02', N'QTKD', 60, 'K02', 'P02'),
('L03', N'Ngôn ngữ Trung', 60, 'K03', 'P03')
insert into SinhVien values
('SV01', N'Vũ Dũng', '02/24/2003', N'Nam', 'L01'),
('SV02', N'Vũ Linh', '02/20/2003', N'Nữ', 'L01'),
('SV03', N'Nguyễn Dũng', '02/26/2003', N'Nam', 'L02'),
('SV04', N'Trần Bá', '02/26/2003', N'Nam', 'L03'),
('SV05', N'Vũ Trần', '04/24/2003', N'Nam', 'L03')
select * from Khoa
select * from Lop
select * from SinhVien