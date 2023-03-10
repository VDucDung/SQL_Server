alter trigger trg_hoadon
on hoadon for insert
as
begin
	declare @MaKhoa nchar(10)
	set @MaKhoa = (select Makhoa from inserted)
	if(not exists(select * from Khoa where maKhoa = @MaKhoa))
	begin
		raiserror('khoa khong ton tai', 16, 1)
		rollback tran
	end
	else
	begin
		update Khoa
		set TongBenhNhan = TongBenhNhan - 1
		where MaKhoa = @MaKhoa
	end
end
select * from HoaDon
select * from Khoa
insert into HoaDon values('HD11', 'BN02','K03',25)
update Khoa
set TongBenhNhan = 40
where MaKhoa = 'K03'