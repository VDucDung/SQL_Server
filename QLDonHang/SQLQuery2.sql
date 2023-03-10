﻿use master
go
create database QLDonHang
on primary(
	name = 'QLBanHang', filename='D:\ngon_ngu_lt\SQL_Server\QLDonHang.mdf', size=8, maxsize=64, filegrowth=20%
)
log on(
	name = 'QLBanHang_log', filename='D:\ngon_ngu_lt\SQL_Server\QLDonHang.ldf', size=8, maxsize=64, filegrowth=20%
)
create table Hang(
		Mahang nchar(10) primary key,
		Tenhang nvarchar(20),
		Soluong int,
		Giaban money
)
create table Hoadon(
		Mahd nchar(10) primary key,
		Mahang nchar(10),
		Soluongban int,
		Ngayban date
		constraint FK_Hoadon_Hang foreign key(Mahang) references Hang(Mahang) on update cascade on delete cascade
)
insert into Hang values 
			('H01', N'Điều hòa', 20, 10000000),
			('H02', N'Máy giạt', 40, 7000000),
			('H03', N'Máy tính', 30, 10000000)
insert into Hoadon values 
			('HD01','H01', 20, '2/20/2022'),
			('HD02','H03', 30, '2/22/2022'),
			('HD03','H02', 15, '2/24/2022')

alter trigger trg_hoadon on Hoadon for insert as
begin
	declare @mahang nchar(10)
	set @mahang = (select Mahang from inserted)
	if(not exists(select * from Hang where Mahang = @mahang))
		print N'Mã hàng không tồn tại'
	else
		begin 
		declare @sl int 
		declare @slb int
		set @sl = (select Soluong from Hang where Mahang = @mahang)
		set @slb = (select Soluongban from inserted)
		if(@sl < @slb)
			print N'Số lượng bán lớn hơn số lượng hàng'
		else
			update Hang 
			set Soluong = Soluong - @slb
			from Hang
			where Mahang = @mahang
		end
end

insert into Hoadon values(
	'HD06','H02',20,'2022-03-20'
)
select * from Hoadon
select * from Hang