create database QLBH
on primary (
	name = 'QLBH', filename='D:\ngon_ngu_lt\SQL_Server\QuanLyBanHang.mdf', size = 8, maxsize=unlimited, filegrowth=64
)
log on (
	name='QLBH_log', filename='D:\ngon_ngu_lt\SQL_Server\QuanLyBanHang.ldf', size = 8, maxsize=unlimited, filegrowth=64
)
use QLBH
go
create table SANPHAM(
		MaSP nchar(10) primary key,
		TenSP nvarchar(20),
		SoLuong int,
		DonGia money,
		MauSac nvarchar(20)
)
create table NHAP(
		SoHDN nchar(10),
		MaSP nchar(10),
		NgayN date,
		SoLuongN int, 
		DonGiaN money,
		constraint PK_NHAP primary key(SoHDN, MaSP),
		constraint FK_NHAP_SANPHAM foreign key(MaSP) references SANPHAM(MaSP) on update cascade on delete cascade
)
create table XUAT(
		SoHDX nchar(10),
		MaSP nchar(10),
		NgayX date,
		SoLuongX int,
		constraint PK_XUAT primary key(SoHDX, MaSP),
		constraint FK_XUAT_SANPHAM foreign key(MaSP) references SANPHAM(MaSP) on update cascade on delete cascade 
)
insert into XUAT values
		(N'HDX1', N'SP01', '2/20/2022', 70),
		(N'HDX2',  N'SP02', '2/21/2021', 40),
		(N'HDX3',  N'SP03', '2/23/2022', 100)
		
select * from SANPHAM
		
select * from NHAP
		
select * from XUAT

--- Tao Ham
create function SL_SanPham(@NgayXuat date)
returns @Bang table(
	MaSP nchar(10), TenSP nvarchar(20), 
	MauSac nvarchar(20), SoLuongX int, 
	DonGia money, TienBan int
) 
as
	begin 
		insert into @bang 
					select SANPHAM.MaSP, TenSP, MauSac, SoLuongX, DonGia, (SoLuongX * DonGia) as TienBan from SANPHAM
					inner join XUAT on SANPHAM.MaSP = XUAT.MaSP
					where NgayX = @NgayXuat
		return 
	end

	select * from SL_SanPham('2/20/2022')
-- tao thu tuc
alter proc Upp_date(
	@SoHDN nchar(10),
	@MaSP nchar(10),
	@SoLuongN int,
	@DonGiaN money,
	@flag int output
)
as
	begin
		if(not exists(select * from SANPHAM where MaSP = @MaSP))
			set @flag = 1;
		else 
		begin
			update
			NHAP set SoHDN = @SoHDN,
					MaSP = @MaSP,
					SoLuongN = @SoLuongN,
					DonGiaN = @DonGiaN
			where SoHDN = @SoHDN
			set @flag =0
		end
		return @flag
	end
	select * from NHAP
declare @flag int
exec Upp_date 'HDN7', 'SP07', 1000, 100000,@flag output
select @flag