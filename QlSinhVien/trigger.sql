alter trigger trg_sv
on sinhvien for insert
as
begin
	declare @masv nchar(10), @ss int, @malop nchar(10)
	set @masv = (select MaSV from inserted)
	select @ss = SiSo from lop inner join SinhVien
	on lop.MaLop = SinhVien.MaLop
	where MaSV = @masv
	set @malop = (select MaLop from SinhVien
	where MaSV = @masv)
	if(@ss > 60)
	begin
		print N'Sĩ số không được vượt quá 60 người một lớp'
		rollback tran
		return 
	end
	else
		update Lop
		set SiSo = SiSo + 1
		where MaLop = @malop
end
select * from Khoa
select * from Lop
select * from SinhVien
insert into SinhVien values('SV08', N'Đại Dương', '2/2/2002','Nam','L02')
update lop
set SiSo = 40