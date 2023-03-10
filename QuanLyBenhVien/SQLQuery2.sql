alter function fn_TienTT(@maBN nchar(10))
returns int
as
	begin
			declare @tien int;
			select @tien = (tienNgay * SoNgay) from khoa inner join HoaDon on Khoa.MaKhoa = HoaDon.maKhoa
			where maBN = @maBN
		return @tien
		
	end
select dbo.fn_TienTT('BN01')