alter trigger trg_deleteSV on sinhvien
for delete
as
begin
	declare @masv nchar(10), @malop nchar(10)
	set @masv = (select MaSV from deleted)
	set @malop = (select MaLop from deleted)
	if(not exists(select * from deleted where MaSV = @masv))
	begin
		print N'Sinh viên không tồn tại'
		rollback tran

	end
	else
		update Lop
		set SiSo = SiSo - 1
		from lop
		where MaLop = @malop
end
select * from Khoa
select * from Lop
select * from SinhVien
delete from SinhVien where MaSV = 'SV02'
