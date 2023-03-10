alter trigger trg_CTHoaDon on CTHoaDon
for delete
as
begin
	if((select COUNT(*) from HoaDon) <= 1)
	begin
		print N'Dòng duy nhất của hóa đơn không thể xóa được'
		rollback tran
	end
	else
		begin
		declare @MaVT nchar(10), @MaHD nchar(10), @SLBan int
		set @MaVT = (select MaVT from deleted)
		set @MaHD = (select MaHD from deleted)
		update VatTU 
		set SLCon = SLCon + deleted.SLBan
		from VatTU inner join deleted on VatTU.MaVT = deleted.MaVT
		where VatTU.MaVT = @MaVT and MaHD = @MaHD
		end
end
select * from VatTU
select * from CTHoaDon
select * from HoaDon
insert into CTHoaDon values('HD02', 'VT03', 200000, 15)
delete CTHoaDon where MaVT = 'VT03' and MaHD='HD02'
select COUNT(*) from HoaDon

