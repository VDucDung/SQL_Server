alter trigger trg_cnxuat on xuat
for update
as
begin
	declare @Masp nchar(10)
	set @Masp = (select MaSP from inserted)
	if(not exists(select * from XUAT where MaSP = @Masp))
	begin
		raiserror('Loi khong co hang', 16,1)
		rollback tran
	end
	else
		begin
		declare @SoLuongX int
		declare @SoLuong int
		set @SoLuongX = (select SoLuongX from inserted)
		set @SoLuong = (select SoLuong from SANPHAM where MaSP = @Masp)
		if(@SoLuongX >= @SoLuong)
		begin
			raiserror('so luong xuat lon hon so luong hang',16,1)
			rollback tran
			return
		end
		else
		declare @Sl int
		set @Sl = (select soluongx from deleted)
			update SANPHAM 
			set SoLuong = SoLuong - (@SoLuongX-@Sl)
			where MaSP = @Masp
		end
end
select * from SANPHAM
select * from XUAT
update xuat set SoLuongX = SoLuongX - 10 where MaSP = 'SP02'