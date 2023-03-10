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