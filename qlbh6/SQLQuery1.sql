use master
go
create database QLbanhang6
use QLbanhang6
go
create table CONGTY(
	MaCT nchar(10) primary key,
	TenCT nvarchar(20),
	trangthai nvarchar(20),
	ThanhPho nvarchar(20)
)
create table SANPHAM(
	MaSP nchar(10) primary key,
	TenSP nvarchar(20),
	mausac nvarchar(20),
	soluong int,
	giaban money
)
create table CUNGUNG(
	MaCT nchar(10),
	MaSP nchar(10),
	SoluongCungung int,
	ngaycungung date
)
insert into CONGTY values
('CT01', 'Apple', N'đang hoạt động', N'Hà Nội'),
('CT02', 'Samsung', N'đang hoạt động', N'Bắc Ninh'),
('CT03', 'Oppo', N'đang hoạt động', N'Hà Nội')
insert into SANPHAM values
('SP01', N'Iphone xs', N'Đỏ', 100, '10000000'),
('SP02', N'Samsung a52s', N'Xanh', 100, '9000000'),
('SP03', N'Opp0 a32', N'Đen', 100, '7000000')
insert into CUNGUNG values
('CT01', 'SP01', 10, '02/20/2023'),
('CT02', 'SP01', 10, '02/25/2023'),
('CT03', 'SP02', 10, '02/21/2023'),
('CT02', 'SP03', 10, '02/20/2023'),
('CT01', 'SP03', 10, '02/20/2023')
select * from CONGTY
select * from SANPHAM
select * from CUNGUNG
--cau2
create function TTSP_CONGTY(@tenct nvarchar(20), @ngaycungung date)
returns @bang table(
		TenSP nvarchar(20),
		mausac nvarchar(20),
		soluong int,
		giaban money
)
as
begin
	insert into @bang select TenSP, mausac, soluong, giaban from SANPHAM inner join CUNGUNG
	on SANPHAM.MaSP = CUNGUNG.MaSP inner join CONGTY on CUNGUNG.MaCT = CONGTY.MaCT
	where TenCT = @tenct and ngaycungung = @ngaycungung
	return 
end
select * from TTSP_CONGTY('Apple', '02/20/2023')
--cau3
create proc ThemMoi_CUNGUNG(@tenct nvarchar(20), @tensp nvarchar(20), @soluongcungung int, @ngaycungung date)
as
begin
	declare @mact nchar(10), @masp nchar(10)
	set @mact = (select MaCT from CONGTY where TenCT = @tenct)
	set @masp = (select MaSP from SANPHAM where TenSP = @tensp)
	insert into CUNGUNG values(@mact, @masp, @soluongcungung, @ngaycungung)
end
exec ThemMoi_CUNGUNG 'Apple', N'Iphone xs', 10, '02/26/2023'
select * from CUNGUNG
--cau 4
alter trigger trg_CUNGUNG on CUNGUNG for update
as
begin
	declare @masp nchar(10), @slcunew int, @slcu int, @sl int, @mact nchar(10)
	set @masp = (select MaSP from inserted)
	set @mact = (select MaCT from inserted)
	set @slcunew = (select SoluongCungung from inserted)
	set @slcu = (select SoluongCungung from deleted)
	set @sl = (select SoLuong from SANPHAM where MaSP = @masp)
	if(@slcunew - @slcu <= @sl)
		update SANPHAM
		set soluong = soluong - (@slcunew - @slcu)
		where MaSP = @masp
	else
	begin
		print N'Số lượng cung ứng mới vướt quá số lượng sản phẩm'
		rollback tran
	end
end
alter trigger trg_CUNGUNG on CUNGUNG for update
as
begin
	declare @slcunew int, @slcu int, @mct nchar(10), @sl int, @msp nchar(10)
	set @slcunew = (select SoluongCungung from inserted)
	set @msp = (select MaSP from inserted)
	set @sl = (select SoLuong from SANPHAM where MaSP = @msp)
	set @slcu = (select SoluongCungung from deleted)
	if(@slcunew - @slcu <= @sl)
		update SANPHAM
		set SoLuong = SoLuong - (@slcunew - @slcu)
		where MaSP = @msp
	else
	begin
		print N'Số lượng cung ứng mới vượt quá số lượng có'
		rollback tran
	end
end
select * from SANPHAM
select * from CUNGUNG
update CUNGUNG
set SoluongCungung = SoluongCungung + 1
where MaCT = 'CT02' and MaSP = 'SP03'  