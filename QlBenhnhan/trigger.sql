alter trigger trg_benhnhan
on BenhNhan for insert
as
begin
	declare @sbn int, @MaKhoa nchar(10), @tenkhoa nvarchar(20), @mabv nchar(10)
	set @MaKhoa = (select MaKhoa from inserted)
	set @sbn = (select SoBenhNhan from KhoaKham where MaKhoa = @MaKhoa)
	set @tenkhoa =(select TenKhoa from KhoaKham where MaKhoa = @MaKhoa)
	set @mabv =(select MaBV from KhoaKham where MaKhoa = @MaKhoa)
	if(@sbn > 100)
	begin
		print N'Số bệnh nhân trong khoa không được vượt quá 100 người'
		return 
	end
	else
		update KhoaKham
		set SoBenhNhan = SoBenhNhan + 1
		where MaKhoa = @MaKhoa
end
select * from BenhNhan
select * from KhoaKham
insert into BenhNhan values('BN06', 'trang', '02/02/2020', N'Nữ', 20, 'K03')