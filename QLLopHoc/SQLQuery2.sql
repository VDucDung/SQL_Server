create proc SP_NKHOA(@MaKhoa nchar(10), @TenKhoa nvarchar(20), @DienThoai nchar(10), @KQ int output)
as
	begin
		if(exists(select * from Khoa where MaKhoa = @MaKhoa))
			set @KQ = 1
		else
			begin
				insert into Khoa values(@MaKhoa, @TenKhoa, @DienThoai)
				set @KQ = 0
			end
		return @KQ 
	end
select * from Khoa
declare @KetQua int
exec SP_NKHOA'k07','KHMT','09998899',@KetQua output
select @KetQua