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
select * from Hang
select * from HDBan
select * from HangBan
--cau 2
create proc pr_TMHB(@MaHD nchar(10), @tenhang nvarchar(20), @dongiaban money, @soluongban int)
as
begin
	declare @MaHang nchar(10)
	set @MaHang = (select MaHang from Hang where TenHang = @tenhang)
	insert into HangBan values(@MaHD, @MaHang, @dongiaban, @soluongban)
end
select * from Hang
select * from HDBan
select * from HangBan
exec pr_TMHB 'HD01', N'Ti vi', '10000000', 7
-- cau3
create function fn_TTHang(@x int, @y int)
returns @bang table(
		MaHang nchar(10),
		TenHang nvarchar(20),
		TongSoLuong int
)
as
begin
	insert into @bang select Hang.MaHang, TenHang, sum(SoLuongBan) as N'Tổng số lượng hàng bán'
	from Hang inner join HangBan on Hang.MaHang = HangBan.MaHang
	inner join HDBan on HangBan.MaHD = HDBan.MaHD
	where DAY(NgayBan) >= @x and DAY(NgayBan) <= @y
	group by Hang.MaHang, TenHang, SoLuongBan
	return 
end
select * from fn_TTHang(2, 3)
--cau4
create trigger trg_HangBan on HangBan for insert 
as
begin
	declare @MaHang nchar(10), @SLB int, @SLC int
	set @MaHang = (select MaHang from inserted)
	set @SLB = (select SoLuongBan from inserted)
	set @SLC = (select SoLuongCo from Hang where MaHang = @MaHang)
	if(@SLB <= @SLC)
		update Hang
		set SoLuongCo = SoLuongCo - @SLB
		where MaHang = @MaHang
	else
	begin
		raiserror('So luong ban vuot qua so luong co', 16, 1)
		rollback tran
	end
end
select * from Hang
select * from HDBan
select * from HangBan
insert into HangBan values('HD01', 'MH03', '10000000', 8)
