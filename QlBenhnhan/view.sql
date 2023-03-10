create view vw_benhnhan
as
select KhoaKham.MaKhoa, TenKhoa, count(*) as N'Số_người' from KhoaKham inner join BenhNhan on KhoaKham.MaKhoa = BenhNhan.MaKhoa
where GioTinh = N'Nữ'
group by KhoaKham.MaKhoa, TenKhoa
select * from dbo.vw_benhnhan