create proc NhapHD(
		@SoHD nchar(10),
		@MaBN nchar(10),
		@TenKhoa nvarchar(20),
		@SoNgay int
)
as
	begin
		if(not exists(select * from Khoa where TenKhoa = @TenKhoa))
			print N'Không tồn tại khoa này'
		else
		begin	
			declare @maKhoa nchar(10)
			select @maKhoa = MaKhoa from Khoa where TenKhoa = @TenKhoa
			insert into HoaDon values(@SoHD, @MaBN,@maKhoa, @SoNgay)
		end
	end
select * from HoaDon
select * from Khoa
exec NhapHD 'HD07', 'BN02', N'Thần Kinh', 20