use master
go
create database QLHang2
use QLHang2
go
create table Hang(
	MaHang nchar(10) primary key,
	TenHang nvarchar(20),
	SoLuongCo int
)
create table HDBan(
	MaHD nchar(10) primary key,
	NgayBan date,
	HoTenKhachHang nvarchar(20)
)
create table HangBan(
	MaHD nchar(10),
	MaHang nchar(10),
	DonGiaBan money,
	SoLuongBan int,
	constraint PK_HangBan primary key(MaHD, MaHang),
	constraint FK_HangBan_Hang foreign key(MaHang) references Hang(MaHang) on update cascade on delete cascade,
	constraint FK_HangBan_HDBan foreign key(MaHD) references HDBan(MaHD) on update cascade on delete cascade,
)
insert into Hang values
('MH01', N'Máy Tính', 100),
('MH02', N'Ti vi', 100),
('MH03', N'Tủ lạnh', 100)
insert into HDBan values
('HD01', '02/03/2023', N'Vũ Đức Dũng'),
('HD02', '02/04/2023', N'Vũ Hà Linh'),
('HD03', '02/05/2023', N'Vũ Văn Dũng')
insert into HangBan values
('HD01', 'MH01', '10000000', 5),
('HD02', 'MH02', '10000000', 3),
('HD03', 'MH03', '9000000', 5),
('HD02', 'MH01', '10000000', 5),
('HD03', 'MH02', '10000000', 5)
