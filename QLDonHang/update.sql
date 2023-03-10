use QLDonHang
go
alter trigger trg_capnhapdonhang
on Hoadon
for update
as
	begin
		declare @dhtruoc int
		declare @dhsau int
		declare @mahang nchar(10)
		set @mahang = (select mahang from inserted)
		select @dhtruoc = deleted.Soluongban from deleted
		select @dhsau = inserted.Soluongban from inserted
		update Hang set Soluong = Soluong - (@dhsau - @dhtruoc)
		where Mahang = @mahang
	end

select * from Hang
select * from Hoadon
update Hoadon set Soluongban = Soluongban + 10 where Mahang = 'H03'

disable trigger trg_capnhapdonhang on Hoadon
enable trigger trg_capnhapdonhang on Hoadon