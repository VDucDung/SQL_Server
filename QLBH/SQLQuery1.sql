alter function fn_thongke(@TenSP nvarchar(20), @NgayX date)
returns int
as
begin
	if(exists(select * from SANPHAM inner join XUAT on SANPHAM.MaSP = XUAT.MaSP where TenSP = @TenSP and NgayX = @NgayX))
		declare @tienxuat int
		select @tienxuat = (SoLuongX * DonGia) from SANPHAM inner join xuat on SANPHAM.MaSP = XUAT.MaSP
		where TenSP = @TenSP and NgayX =@NgayX
		return @tienxuat 
end
select * from SANPHAM
select * from XUAT
select dbo.fn_thongke('F1 Plus', '02/20/2022')