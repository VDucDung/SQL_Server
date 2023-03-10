alter function fn_SV(@tenkhoa nvarchar(20), @tenlop nvarchar(20))
returns @bang table(
		MaSV nchar(10),
		HoTen nvarchar(20),
		tuoi int
)
as
begin
	insert into @bang select MaSV, HoTen, (YEAR(GETDATE()) - YEAR(NgaySinh)) as N'Tuổi'
	 from SinhVien inner join lop 
	on SinhVien.MaLop = Lop.MaLop inner join Khoa
	on Lop.MaKhoa = Khoa.MaKhoa
	where TenKhoa = @tenkhoa and TenLop = @tenlop
	return 
end
select * from Khoa
select * from Lop
select * from SinhVien
select * from fn_SV('CNTT', 'KTPM')