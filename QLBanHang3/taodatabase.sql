use master
go
create database QLBanHang3
on primary(
	name='QLBanHang3', filename='D:\ngon_ngu_lt\SQL_Server\QLBanHang3\QLBanHang3.mdf', size=8, maxsize= 64, filegrowth=20%
)
log on(
	name='QLBanHang3_log', filename='D:\ngon_ngu_lt\SQL_Server\QLBanHang3\QLBanHang3_log.ldf', size=8, maxsize=64, filegrowth=20%
)
use QLBanHang3
go
create table VatTU(
		MaVT nchar(10) primary key,
		TenVT nvarchar(20),
		DVTinh nvarchar(20),
		SLCon int
)
create table HoaDon(
		MaHD nchar(10) primary key,
		NgayLap date,
		HoTenKhach nvarchar(20)
)
create table CTHoaDon(
		MaHD nchar(10),
		MaVT nchar(10),
		DonGiaBan money,
		SLBan int,
		constraint PK_CTHoaDon primary key(MaHD, MaVT), 
		constraint FK_CTHoaDon_HoaDon foreign key(MaHD) references HoaDon(MaHD) on update cascade on delete cascade,
		constraint FK_CTHoaDon_VaTu foreign key(MaVT) references VatTu(MaVT) on update cascade on delete cascade
)
insert into VatTU values
('VT01', N'Sắt', N'chiếc', 20),
('VT02', N'Thép', N'chiếc', 10),
('VT03', N'Xi Măng', N'chiếc', 20)
insert into HoaDon values
('HD01', '02/02/2022', N'Vũ Dũng'),
('HD02', '02/03/2022', N'Vũ Linh'),
('HD03', '05/02/2022', N'Trần Phương')
insert into CTHoaDon values
('HD01', 'VT01', 100000, 10),
('HD02', 'VT02', 200000, 15),
('HD03', 'VT03', 150000, 10),
('HD02', 'VT01', 100000, 10),
('HD03', 'VT02', 200000, 10)
