alter trigger trg_nhap
on nhap for insert
as
begin
	declare @masp nchar(10)
	set @masp = (select MaSP from inserted)
	if(not exists(select * from SANPHAM where MaSP = @masp))
		begin
		print N'Sản phẩm không tồn tại'
		rollback tran
		end
	else
		begin 
		declare @dgn money
		declare @dg money
		set @dgn = (select DonGiaN from inserted where MaSP = @masp)
		set @dg = (select DonGia from SANPHAM where MaSP = @masp)
		if(@dgn >= @dg)
		begin
			print N'Đơn giá nhập lớn hơn đơn giá'
			rollback tran
			return 
		end
		else
			declare @sln int
			set @sln = (select SoLuongN from inserted where MaSP = @masp)
			update SANPHAM 
			set SoLuong = SoLuong + @sln
			where MaSP = @masp
		end
end
select * from NHAP
select * from SANPHAM
insert into NHAP values('HDN9', 'SP02', '2/4/2021', 100, 22200000.00)
