create function fn_tHangSX(@MaSP nchar(10))
returns nvarchar(20)
as
begin
	declare @ten nvarchar(20)
	set @ten = (select TenHang from HangSX inner join SanPham 
					on HangSX.MaHangSX = SanPham.MaHangSX
					where MaSP = @MaSP)
	return @ten
end
select * from SanPham;
select dbo.fn_tHangSX('SP05');