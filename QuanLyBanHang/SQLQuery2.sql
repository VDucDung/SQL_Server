create database QLBanHang
on primary(
	name = 'QLBanHang_Dat',
	filename = 'D:\ngon_ngu_lt\SQL_Server\QuanLyBanHang\QLBanHang.mdf',
	Size = 2MB,
	Maxsize = 10MB,
	filegrowth = 20%
	)
log On(
	name = 'QLBanHang_Log',
	filename = 'D:\ngon_ngu_lt\SQL_Server\QuanLyBanHang\QLBanHang.ldf',
	Size = 1MB,
	Maxsize = 5MB,
	filegrowth = 20%
	)
use master
go
if(exists(select * from sysdatabases where name = 'QLBanHang'))
	drop database QLBanHang
