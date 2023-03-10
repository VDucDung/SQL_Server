/* Cau 4 */
alter trigger trg_deleteCTHD on CTHoaDon for delete as
begin
	declare @mahd nvarchar(10)
	declare @mavt nvarchar(10)
	select @mahd=MaHD, @mavt=MaVT from deleted

	if((select count(*) from CTHoaDon where MaHD=@mahd)=0 AND (select count(*) from deleted)=1)
	begin
		raiserror(N'Đây là dòng duy nhất của hóa đơn',15,1)
		rollback tran
	end
	else
	begin
		update VatTu set SLCon = SLCon + deleted.SLBan from VatTu
		inner join deleted on deleted.MaVT=VatTu.MaVT
		where deleted.MaVT=VatTu.MaVT
	end
end
--test
select * from VatTU
select * from CTHoaDon

delete from CTHoaDon where MaHD='HD01' and MaVT='VT01'
select * from VatTU
select * from CTHoaDon
--

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
insert into CTHoaDon values('HD03', 'VT03', 200000, 15)
delete CTHoaDon where MaVT = 'VT01' and MaHD='HD01'



go



--loi

delete from CTHoaDon where MaHD='HD02'
go
disable trigger trg_deleteCTHD on CTHoaDon