alter proc LTTK(@TuTuoi int, @DenTuoi int)
as
begin
	select MaSV, HoTen, NgaySinh, TenLop, TenKhoa, (YEAR(GETDATE()) - YEAR(NgaySinh)) as N'Tuổi'
	 from SinhVien inner join lop 
	on SinhVien.MaLop = Lop.MaLop inner join Khoa
	on Lop.MaKhoa = Khoa.MaKhoa
	group by MaSV, HoTen, NgaySinh, TenLop, TenKhoa
	having (YEAR(GETDATE()) - YEAR(NgaySinh)) >= @TuTuoi and (YEAR(GETDATE()) - YEAR(NgaySinh)) <= @DenTuoi

end

exec LTTK 19, 21 