use master
go
create database QLKHO
use QLKHO
go
create table Ton(
	MaVT nchar(10) primary key,
	TenVT nvarchar(20),
	SoLuongT int
)
create table Nhap(
	SoHDN nchar(10),
	MaVT nchar(10),
	SoLuongN int,
	DonGiaN money,
	NgayN date,
	constraint PK_Nhap primary key(SoHDN, MaVT),
	constraint FK_Nhap_Ton foreign key(MaVT) references Ton(MaVT) on update cascade on delete cascade
)
create table Xuat(
	SoHDX nchar(10),
	MaVT nchar(10),
	SoLuongX int,
	DonGiaX money,
	NgayX date,
	constraint PK_Xuat primary key(SoHDX, MaVT),
	constraint FK_Nhap_Xuat foreign key(MaVT) references Ton(MaVT) on update cascade on delete cascade
)
insert into Ton values
('VT01', N'bút bi', 100),
('VT02', N'bút chì', 100),
('VT03', N'bút mực', 100),
('VT04', N'Tẩy', 100)
insert into Nhap values
('HDN01', 'VT01', 200, '3000', '02/02/2022'),
('HDN02', 'VT02', 150, '2000', '02/03/2022'),
('HDN03', 'VT03', 200, '3000', '02/02/2022')
insert into Xuat values
('HDX01', 'VT01', 100, '4000', '02/03/2023'),
('HDX02', 'VT02', 50, '3000', '02/03/2023'),
('HDX03', 'VT03', 100, '4000', '02/03/2023')
select * from Nhap
select * from Xuat
select * from Ton
--cau2
alter function fn_TienNhap(@maVT nchar(10), @ngaynhap date)
returns @bang table(
		NgayN date,
		MaVT nchar(10),
		TenVT nvarchar(20),
		TienNhap int
)
as 
begin
	declare @sohdn nchar(10)
	set @sohdn = (select SoHDN from Nhap where MaVT = @maVT and DAY(NgayN) = DAY(@ngaynhap))
	insert into @bang select NgayN, Nhap.MaVT, TenVT, (SoLuongN * DonGiaN) as N'Tiền nhập' from nhap
	inner join Ton on Nhap.MaVT = Ton.MaVT 
	where Ton.MaVT = @maVT and DAY(NgayN) = DAY(@ngaynhap) and SoHDN = @sohdn
	return 
end
select * from Nhap
select * from fn_TienNhap('VT01', '02/02/2022')
--cau3
alter function fn_TONGslx(@tenvt nvarchar(20), @ngayxuat date)
returns int
as
begin
	declare @tongslx int, @mavt nchar(10)
	set @mavt = (select MaVT from Ton where TenVT = @tenvt)
	set @tongslx= (select sum(SoLuongX) as N'Số lượng xuất' from Xuat 
	where DAY(NgayX) = Day(@ngayxuat) and MaVT = @mavt
	group by SoLuongX)
	
	return @tongslx
end
select * from Nhap
select * from Xuat
select * from Ton
select dbo.fn_TONGslx(N'bút bi', '02/03/2023')
--cau4
create trigger trg_xuat on xuat for insert
as
begin
	declare @MaVT nchar(10), @SLX int, @SLT int
	set @MaVT = (select MaVT from inserted)
	set @SLX = (select SoLuongX from inserted)
	set @SLT = (select SoLuongT from Ton where MaVT = @MaVT)
	if(@SLX <= @SLT)
		update Ton
		set SoLuongT = SoLuongT - @SLX
		where MaVT = @MaVT
	else
		begin
			print N'Hãy kiểm tra lại mã VT hoặc số lượng xuất'
			rollback tran
		end
end
select * from Nhap
select * from Xuat
select * from Ton
insert into Xuat values ('HDX04', 'VT03', 20, '4000', '2/3/2023')