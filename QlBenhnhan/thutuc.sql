alter proc TTTD(@MaKhoa nchar(10))
as
begin
	select KhoaKham.MaKhoa, TenKhoa, sum(SoNgayNV * 80000) as N'Tổng số tiền thu được' from BenhNhan inner join KhoaKham 
	on BenhNhan.MaKhoa = KhoaKham.MaKhoa
	where KhoaKham.MaKhoa = @MaKhoa
	group by KhoaKham.MaKhoa, TenKhoa
end

exec TTTD 'K01'