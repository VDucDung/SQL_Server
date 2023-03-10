create proc DSCL(@tenkhoa nvarchar(20), @soX int)
as
begin
	if(not exists(select * from lop inner join Khoa
		on lop.MaKhoa = Khoa.MaKhoa where TenKhoa = @tenkhoa and SiSo > @soX))
		begin
		print N'Danh sách không có lớp nào'
		rollback tran
		end
	else
		select MaLop, TenLop, SiSo from lop inner join Khoa
		on lop.MaKhoa = Khoa.MaKhoa
		where TenKhoa = @tenkhoa and SiSo > @soX
end
select * from Khoa
select * from Lop
select * from SinhVien
exec DSCL 'QTKD', 20