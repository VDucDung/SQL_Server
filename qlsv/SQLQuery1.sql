use master
go
create database QLSinhVien3
use QLSinhVien3
go
create table Khoa(
	MaKhoa nchar(10) primary key,
	TenKhoa nvarchar(20),
	SoDienThoai nvarchar(11)
)

create table Lop(
	MaLop nchar(10) primary key,
	TenLop nvarchar(20),
	SiSo int,
	MaKhoa nchar(10) foreign key references Khoa(MaKhoa) on update cascade on delete cascade
)
create table SinhVien(
	MaSV nchar(10) primary key,
	HoTen nvarchar(20),
	GioiTinh nvarchar(10),
	NgaySinh date,
	MaLop nchar(10) foreign key references Lop(MaLop) on update cascade on delete cascade
)
insert into Khoa values
('K01', 'CNTT', '098767212'),
('K02', 'QTKD', '098767214'),
('K03', N'Cơ khí', '098767215')
insert into Lop values
('L01', 'KTPM', 30, 'K01'),
('L02', 'QTKD', 30, 'K02'),
('L03', N'Cơ Khí', 30, 'K03')
insert into SinhVien values
('SV01', N'Dũng', N'Nam', '02/24/2003', 'L01'),
('SV02', N'Linh', N'Nữ', '02/10/2003', 'L02'),
('SV03', N'Quang', N'Nam', '02/25/2003', 'L03'),
('SV04', N'Giang', N'Nam', '05/24/2003', 'L01'),
('SV05', N'Bảo', N'Nam', '02/26/2003', 'L03')
select * from Khoa
select * from Lop
select * from SinhVien
--cau 2
alter function fn_DSKhoa(@tenkhoa nvarchar(20))
returns @bang table(
		MaLop nchar(10),
		TenLop nvarchar(20),
		SiSo int
)
as
	begin
		declare @makhoa nchar(10)
		set @makhoa = (select makhoa from Khoa where TenKhoa = @tenkhoa)
		insert into @bang select MaLop, TenLop, SiSo from Lop 
		where MaKhoa = @makhoa
	return 
	end
select * from fn_DSKhoa(N'QTKD')

-- cau3
alter proc them_sinhvien(@masv nchar(10), @hoten nvarchar(20), @ngaysinh date, @gioitinh nvarchar(20), @tenlop nvarchar(20))
as
begin
	if(exists(select * from SinhVien where MaSV = @masv))
		begin
		print N'Sinh viên này đã tồn tại'
		rollback tran
		end
	else
		begin
		declare @malop nchar(10)
		set @malop = (select malop from lop where TenLop = @tenlop)
		insert into SinhVien values(@masv, @hoten, @gioitinh, @ngaysinh, @malop)
		end
end
select * from Lop
select * from SinhVien
exec them_sinhvien'SV08', N'Ly', '03/30/2000', N'Nam', 'KTPM'
-- c4
create trigger trg_sinhvien on sinhvien
for update
as
begin
	declare @siso int, @malop nchar(10), @malopnew nchar(10)
	set @malop = (select malop from inserted)
	set @malopnew = (select malop from deleted)
	set @siso = (select SiSo from lop where MaLop = @malop)
	if(@siso >= 80)
		begin
		raiserror('Lop da vuot qua 80 nguoi', 16,1)
		rollback tran
		end
	else
		begin
		update lop
		set SiSo = SiSo + 1
		where MaLop = @malop
		update lop
		set SiSo = SiSo - 1
		where MaLop = @malopnew
		end
end
select * from Khoa
select * from Lop
select * from SinhVien
update SinhVien
set MaLop = 'L01'
where MaLop = 'L02'
