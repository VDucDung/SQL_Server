use master
go
create database QLHANG
use QLHANG 
go
create table Hang(
	MaHang nchar(10) primary key,
	TenHang nvarchar(20),
	DVTinh nvarchar(20),
	SLTon int
)
create table HDBan(
	MaHD nchar(10) primary key,
	NgayBan date,
	HoTenKhach nvarchar(30)
)
create table HangBan(
	MaHD nchar(10),
	MaHang nchar(10),
	DonGia money,
	SoLuong int,
	constraint PK_HangBan primary key(MaHD, MaHang),
	constraint FK_HangBan_HDBan foreign key(MaHD) references HDBan(MaHD) on update cascade on delete cascade,
	constraint FK_HangBan_Hang foreign key(MaHang) references Hang(MaHang) on update cascade on delete cascade
)
insert into Hang values
('MH01', N'Ti Vi', N'Chiếc', 40),
('MH02', N'Tủ lạnh', N'Chiếc', 30),
('MH03', N'Máy giặt', N'Chiếc', 20)
insert into HDBan values
('HD1', '02/02/2021', N'Vũ Đức Dũng'),
('HD2', '02/03/2021', N'Vũ Hà Linh'),
('HD3', '02/02/2021', N'Lê Thu Hà')
insert into HangBan values
('HD1', 'MH01', '1000000', 1),
('HD2', 'MH01', '1000000', 1),
('HD3', 'MH02', '2000000', 1),
('HD2', 'MH03', '1000000', 2),
('HD3', 'MH03', '1000000', 1)
select * from Hang
select * from HDBan
select * from HangBan
--cau2
create view vw_TTMH
as
	select Hang.MaHang, TenHang, SoLuong from Hang inner join HangBan
	on Hang.MaHang = HangBan.MaHang
	where SoLuong >= all(select MAX(SoLuong) from HangBan group by SoLuong)
select * from vw_TTMH
--cau3
create function TongTien(@Nam int)
returns int
as
begin
	declare @tongtien int
	select @tongtien=SUM(SoLuong * DonGia) from HangBan inner join HDBan on HangBan.MaHD = HDBan.MaHD
	where YEAR(NgayBan) = @Nam
	return @tongtien
end
select dbo.TongTien(2021) as N'Tổng Tiền'
-- cau4
alter trigger trg_Hang on HangBan
for insert
as
begin
	declare @sl int, @slt int, @MaHang nchar(10), @MaHD nchar(10)
	set @MaHang = (select MaHang from inserted)
	set @MaHD = (select MaHD from inserted)
	set @sl = (select SoLuong from HangBan where MaHang = @MaHang and MaHD = @MaHD)
	set @slt = (select SLTon from Hang where MaHang = @MaHang)
	if(@sl > @slt)
	begin
		raiserror('So luong ban lon hon so luong ton', 16, 1)
		rollback tran
	end
	else
		update Hang
		set SLTon = SLTon - @sl
		where MaHang = @MaHang
end
select * from Hang
select * from HDBan
select * from HangBan
insert into HangBan values('HD1', 'MH02','1000000',2)