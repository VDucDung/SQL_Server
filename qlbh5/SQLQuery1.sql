use master
go
create database QLbanhang5
use QLbanhang5
go
create table CONGTY(
	MaCongTy nchar(10) primary key,
	TenCongTy nvarchar(20),
	DiaChi nvarchar(20)
)
create table SANPHAM(
	MaSanPham nchar(10) primary key,
	TenSanPham nvarchar(20),
	SoLuongCo int,
	GiaBan money
)
create table CUNGUNG(
	MaCongTy nchar(10),
	MaSanPham nchar(10),
	SoluongCungung int,
	constraint PK_CUNGUNG primary key(MaCongTy, MaSanPham),
	constraint FK_CUNGUNG_CONGTY foreign key(MaCongTy) references CONGTY(MaCongTy) on update cascade on delete cascade,
	constraint FK_CUNGUNG_SANPHAM foreign key(MaSanPham) references SANPHAM(MaSanPham) on update cascade on delete cascade
)
insert into CONGTY values
('CT01', 'Oppo', N'Hà Nội'),
('CT02', N'Samsung', N'Hàn quốc'),
('CT03', N'Apple', N'Mỹ')
insert into SANPHAM values
('SP01', N'Oppo A52', 100, '4000000'),
('SP02', N'Samsung j7', 100, '7000000'),
('SP03', N'Iphone 8 plus', 100, '9000000')
insert into CUNGUNG values
('CT01', 'SP01', 20),
('CT02', 'SP01', 20),
('CT02', 'SP02', 10),
('CT03', 'SP02', 15),
('CT03', 'SP03', 15)
select * from CONGTY
select * from SANPHAM
select * from CUNGUNG
-- cau2
create function TenSP(@TenCongTy nvarchar(20))
returns @bang table(
		TenSanPham nvarchar(20),
		SoluongCungung int,
		GiaBan money,
		TongTien int
)
as
begin
	insert into @bang select TenSanPham, SoluongCungUng, GiaBan, SUM(SoluongCungung * GiaBan) as N'Tổng tiền'
	from SANPHAM inner join CUNGUNG on SANPHAM.MaSanPham = CUNGUNG.MaSanPham
	inner join CONGTY on CUNGUNG.MaCongTy = CONGTY.MaCongTy
	where TenCongTy = @TenCongTy
	group by TenSanPham, SoluongCungUng, GiaBan
	return 
end
select * from TenSP('Apple')
--cau3
create proc Them_CT(@mact nchar(10), @tenct nvarchar(20), @diachi nvarchar(20))
as
begin
	if(exists(select * from CONGTY where MaCongTy = @mact))
	begin
		print N'Công ty đã tồn tại'
		rollback tran
	end
	else
		insert into CONGTY values(@mact, @tenct, @diachi)
end
select * from CONGTY
exec Them_CT'CT04', 'Xiaomi', N'Trung quốc'
--cau4
alter trigger trg_CUNGUNG on CUNGUNG for update
as
begin
	declare @slcunew int, @slcu int, @mct nchar(10), @sl int, @msp nchar(10)
	set @slcunew = (select SoluongCungung from inserted)
	set @msp = (select MaSanPham from inserted)
	set @sl = (select SoLuongCo from SANPHAM where MaSanPham = @msp)
	set @slcu = (select SoluongCungung from deleted)
	if(@slcunew - @slcu <= @sl)
		update SANPHAM
		set SoLuongCo = SoLuongCo - (@slcunew - @slcu)
		where MaSanPham = @msp
	else
	begin
		print N'Số lượng cung ứng mới vượt quá số lượng có'
		rollback tran
	end
end
select * from CONGTY
select * from SANPHAM
select * from CUNGUNG
update CUNGUNG
set SoluongCungung = SoluongCungung - 1
where MaCongTy = 'CT01' and MaSanPham = 'SP01'