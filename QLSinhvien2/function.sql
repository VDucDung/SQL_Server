alter function fn_dsvs(@makhoa nchar(10), @tenlop nvarchar(20))
returns @bang table
				(MaSV nchar(10), HoTen nvarchar(20), tuoi int)
as
begin
		insert into @bang 
			select MaSV, HoTen, (year(GETDATE()) - YEAR(NgaySinh)) from SinhVien
		inner join lop on SinhVien.MaLop = Lop.MaLop
		where MaKhoa =@makhoa and TenLop = @tenlop
		return 
end
select * from Khoa
select * from Lop
select * from SinhVien
select * from fn_dsvs('K02', N'QTKD')
