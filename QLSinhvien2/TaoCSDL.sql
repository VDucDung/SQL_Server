use master
go
create database QLSinhVien2
use QLSinhVien2
go
create table Khoa(
		MaKhoa nchar(10) primary key,
		TenKhoa nvarchar(20),
		NgayThanhLap date
)
create table Lop(
		MaLop nchar(10) primary key,
		TenLop nvarchar(20),
		SiSo int,
		MaKhoa nchar(10) foreign key references Khoa(MaKhoa) on update cascade on delete cascade
)
create table SinhVien(
		MaSV nchar(10) primary key,
		HoTen nvarchar(20),
		NgaySinh date,
		MaLop nchar(10) foreign key references Lop(MaLop) on update cascade on delete cascade
)
insert into Khoa values
('K01', N'CNTT', '02/02/2000'),
('K02', N'QTKD', '02/04/2000'),
('K03', N'Cơ Khí', '02/03/2000')
insert into Lop values
('L01', 'KTPM', 30, 'K01'),
('L02', N'Quản Trị Kinh doanh', 40, 'K02'),
('L03', N'Cơ Khí', 40, 'K03')
insert into SinhVien values
('SV01', N'Vũ Dũng', '02/24/2003', 'L01'),
('SV02', N'Vũ Linh', '08/24/2003', 'L02'),
('SV03', N'Trần Danh', '03/25/2003', 'L03'),
('SV04', N'Lê Bá', '03/25/2003', 'L02'),
('SV05', N'Danh Dũng', '01/22/2003', 'L01')
select * from Khoa
select * from Lop
select * from SinhVien