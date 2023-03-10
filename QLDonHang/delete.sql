use QLDonHang
go
create trigger trg_xoadonhang
on Hoadon
for delete 
as
	begin
		update Hang set Soluong = Soluong + deleted.Soluongban
		from Hang inner join deleted
		on Hang.mahang = deleted.mahang
	end

select * from Hang
select * from Hoadon
delete from Hoadon where Mahd = 'HD03'