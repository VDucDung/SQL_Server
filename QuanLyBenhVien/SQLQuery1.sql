create database QLBenhVien
on primary(
name='QLBenhVien', filename='D:\ngon_ngu_lt\SQL_Server\QuanLyBenhVien.mdf', size=8, maxsize=64, filegrowth=20%)
log on(
name='QLBenhVien_log', filename='D:\ngon_ngu_lt\SQL_Server\QuanLyBenhVien.ldf', size=8, maxsize=64, filegrowth=20%)
use QLBenhVien
go
create table BenhNhan(
		MaBN nchar(10) primary key,
		TenBN nvarchar(20),
		GioiTinh nvarchar(20),
		SoDT nchar(20),
		Email nvarchar(20)
)
create table Khoa(
		MaKhoa nchar(10) primary key,
		TenKhoa nvarchar(20),
		diachi nvarchar(20),
		tienNgay money,
		TongBenhNhan int
)
create table HoaDon(
		SoHD nchar(10) primary key,
		maBN nchar(10),
		maKhoa nchar(10),
		SoNgay int,
		constraint FK_HoaDon_BenhNhan foreign key(maBN) references BenhNhan(maBN) on update cascade on delete cascade,
		constraint FK_HoaDon_Khoa foreign key(MaKhoa) references Khoa(MaKhoa) on update cascade on delete cascade
)

insert into BenhNhan values
			('BN01','Giang', 'Nam','098765399', 'giang@gmail.com'),
			('BN02', N'Dũng', 'Nam', '099888788', 'dung@gmail.com'),
			('BN03', N'Hạnh', N'Nữ', '098676544', 'hanh@gmail.com')
insert into Khoa values
			('K01',N'Nội', N'Hà Nội',200000, 100),
			('K02', N'Ngoại', N'Hà Nội', 100000, 70),
			('K03', N'Thần kinh', N'Bắc Ninh', 300000, 40)
insert into HoaDon values
			('HD01',N'BN01', N'K01',20),
			('HD02', N'BN02', N'K01', 30),
			('HD03', N'BN03', N'K02', 15),
			('HD04', N'BN02', N'K03', 20),
			('HD05', N'BN03', N'K02', 30)

select * from BenhNhan
select * from Khoa
select * from HoaDon