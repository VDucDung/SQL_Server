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
create function fn_tongtien(@tenvt nvarchar(50), @ngayban date)
returns int
as
begin
	declare @tongtien int
	set @tongtien= (select sum(DonGiaBan*SLBan) from CTHoaDon where
			MaVT in (select MaVT from VatTu where TenVT=@tenvt)
			AND
			MaHD in (select MaHD from HoaDon where NgayLap=@ngayban) )
	return @tongtien
end
select * from VatTU
select * from CTHoaDon
select * from HoaDon
select dbo.fn_tongtien(N'Thép', '05/02/2022')
select dbo.fn_TongTienBanHang(N'Thép', '05/02/2022')
