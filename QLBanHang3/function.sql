alter function fn_TongTienBanHang(@TenVT nvarchar(20), @NgayBan date)
returns int
as
begin
	declare @TienBanHang int, @MaVT nchar(10)
	set @MaVT = (select VatTU.MaVT from CTHoaDon inner join HoaDon on CTHoaDon.MaHD = HoaDon.MaHD
	inner join VatTU on CTHoaDon.MaVT = VatTU.MaVT
	where TenVT = @TenVT and NgayLap = @NgayBan)
	set @TienBanHang = (select sum(DonGiaBan * SLBan) from CTHoaDon where MaVT = @MaVT)
	return @TienBanHang
end
select * from VatTU
select * from CTHoaDon
select * from HoaDon
select dbo.fn_TongTienBanHang(N'Sắt', '02/02/2022')
