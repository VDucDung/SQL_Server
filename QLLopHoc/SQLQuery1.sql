create proc SP_NHAPKHOA(@MaKhoa nchar(10), @TenKhoa nvarchar(20), @DienThoai nchar(10))
as
	begin
	if(exists(select * from Khoa where TenKhoa = @TenKhoa))
		print'TenLop'+@TenKhoa+'DaTonTai'
	else
		begin 
			insert into Khoa values(@MaKhoa, @TenKhoa, @DienThoai)
			print(N'Thêm khoa mới thành công')
		end
	end

select * from Khoa
exec SP_NHAPKHOA'K05','KETOAN','09998899'