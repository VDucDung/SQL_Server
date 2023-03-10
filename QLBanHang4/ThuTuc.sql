create proc pro_tongluongVT(@thang int, @nam int, @soluong int output)
as
begin
	set @soluong = (select sum(SLBan) from CTHoaDon 
					where MaHD in (select MaHD from HoaDon where MONTH(NgayLap)=@thang AND YEAR(NgayLap)=@nam))
	return
end

go
--
alter proc TSLVT(@thang nvarchar(20), @nam nvarchar(20))
as
begin
	if(not exists(select * from CTHoaDon inner join HoaDon on CTHoaDon.MaHD = HoaDon.MaHD 
	where MONTH(NgayLap) = @thang and YEAR(NgayLap) = @nam))
	begin
		print N'Tháng nhập vào hoặc năm nhập vào không đúng'
		rollback tran
	end
	else
	begin
	declare @TongSL nvarchar(20)
	set @TongSL = (select SUM(SlBan) from CTHoaDon inner join HoaDon on CTHoaDon.MaHD = HoaDon.MaHD 
	where MONTH(NgayLap) = @thang and YEAR(NgayLap) = @nam)
		print N'Tổng vật tư bán trong tháng ' + @thang + '-' + @nam + ' là: ' + @TongSL 
	end
end
select * from VatTU
select * from CTHoaDon
select * from HoaDon
exec TSLVT '2', '2022'
--test
declare @month int
set @month = 2
declare @year int
set @year = 2022
declare @sl int

exec pro_tongluongVT @month, @year, @sl output

print N'Tổng số lượng vật tư bán trong tháng '+convert(varchar(2),@month)+'-'+convert(varchar(4),@year)+' là: '+convert(varchar(20),@sl)
go