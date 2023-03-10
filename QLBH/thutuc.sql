alter proc cndl_nhap(
@SoHDN nchar(10), 
@MaSP nchar(10), 
@SoLuongN int,
@DonGiaN money)
as
begin
	if(not exists(select * from SANPHAM where MaSP = @MaSP))
		print N'Sản phẩm không tồn tại'
	else
		begin
		declare @ngaynhap date
		set @ngaynhap = (select NgayN from NHAP where MaSP = @MaSP)
		insert into NHAP values(@SoHDN, @MaSP, @ngaynhap, @SoLuongN, @DonGiaN)
		end
end
select * from NHAP
select * from SANPHAM
exec cndl_nhap '1','SP02',400, 100000 