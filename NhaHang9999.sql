CREATE DATABASE NhaHang9999
GO

USE NhaHang9999
GO
	Type INT NOT NULL  DEFAULT 0 -- 1: admin && 0: staff


CREATE TABLE TableFood
(
	id INT IDENTITY PRIMARY KEY,
	name NVARCHAR(100) NOT NULL DEFAULT N'Bàn chưa có tên',
	status NVARCHAR(100) NOT NULL DEFAULT N'Trống'	-- Trống || Có người
)
GO

CREATE TABLE Account
(
	UserName NVARCHAR(100) PRIMARY KEY,	
	DisplayName NVARCHAR(100) NOT NULL DEFAULT N'Tuan',
	PassWord NVARCHAR(1000) NOT NULL DEFAULT 0,
)
GO


CREATE TABLE Food
(
	id INT IDENTITY PRIMARY KEY,
	name NVARCHAR(100) NOT NULL DEFAULT N'Chưa đặt tên',
	idCategory INT NOT NULL,
	price FLOAT NOT NULL DEFAULT 0
	
	FOREIGN KEY (idCategory) REFERENCES dbo.FoodCategory(id)
)
GO

CREATE TABLE Bill
(
	id INT IDENTITY PRIMARY KEY,
	DateCheckIn DATE NOT NULL DEFAULT GETDATE(),
	DateCheckOut DATE,
CREATE TABLE FoodCategory
(
	id INT IDENTITY PRIMARY KEY,
	name NVARCHAR(100) NOT NULL DEFAULT N'Chưa đặt tên'
)
GO
	idTable INT NOT NULL,
	status INT NOT NULL DEFAULT 0 -- 1: đã thanh toán && 0: chưa thanh toán
	
	FOREIGN KEY (idTable) REFERENCES dbo.TableFood(id)
)
GO

CREATE TABLE BillInfo
(
	id INT IDENTITY PRIMARY KEY,
	idBill INT NOT NULL,
	idFood INT NOT NULL,
	count INT NOT NULL DEFAULT 0
	
	FOREIGN KEY (idBill) REFERENCES dbo.Bill(id),
	FOREIGN KEY (idFood) REFERENCES dbo.Food(id)
)
GO

INSERT INTO dbo.Account
        ( UserName ,
          DisplayName ,
          PassWord ,
          Type
        )
VALUES  ( N'Tuan' , -- UserName - nvarchar(100)
          N'Tuan' , -- DisplayName - nvarchar(100)
          N'1' , -- PassWord - nvarchar(1000)
          1  -- Type - int
        )
INSERT INTO dbo.Account
        ( UserName ,
          DisplayName ,
          PassWord ,
          Type
        )
VALUES  ( N'tam' , -- UserName - nvarchar(100)
          N'tam' , -- DisplayName - nvarchar(100)
          N'1' , -- PassWord - nvarchar(1000)
          0  -- Type - int
        )
GO
SELECT * FROM dbo.Account

create proc USP_GetAccountByUserName
@userName nvarchar(100)
AS 
begin
	select * from dbo.Account where UserName = @userName
end
go
EXEC dbo.USP_GetAccountByUserName @userName = N'Tuan'

SELECT * FROM dbo.Account where UserName = 'Tuan' AND PassWord = '1'

Create proc USP_Login
@userName nvarchar(100), @passWord nvarchar(100)
AS
BEGIN
	SELECT * FROM dbo.Account where UserName = @userName AND PassWord = @passWord
END
GO


----------------------------------------------
CREATE PROC USP_GetAccountByUserName
@userName nvarchar(100)
AS 
BEGIN
	SELECT * FROM dbo.Account WHERE UserName = @userName
END
GO

EXEC dbo.USP_GetAccountByUserName @userName = N'k9' -- nvarchar(100)

GO

CREATE PROC USP_Login
@userName nvarchar(100), @passWord nvarchar(100)
AS
BEGIN
	SELECT * FROM dbo.Account WHERE UserName = @userName AND PassWord = @passWord
END
GO
--------------------------- thêm bàn
DECLARE @i INT = 0
WHILE @i <= 15
BEGIN
	INSERT dbo.TableFood ( name)VALUES  ( N'Bàn' + CAST(@i AS nvarchar(100)))
	SET @i = @i + 1
END
GO
---------------------------------------


SELECT * FROM dbo.BillInfo where idBill = 1

SELECT f.name, bi.count, f.price, f.price*bi.count AS totalPrice FROM dbo.BillInfo AS bi, dbo.Bill AS b, dbo.Food AS f WHERE bi.idBill = b.id AND bi.idFood = f.id AND b.status = 0 AND b.idTable = 4

update dbo.Bill set status = 1 where id = 3 and status = 0

SELECT * FROM dbo.Bill WHERE idTable = 3 and status = 0


Create PROC USP_GetTableList
AS SELECT * FROM dbo.TableFood
GO
UPDATE dbo.TableFood SET STATUS = N'Có người' WHERE id = 10

EXEC dbo.USP_GetTableList
GO
-------------------------------------
-- thêm category
INSERT dbo.FoodCategory
        ( name )
VALUES  ( N'Lẩu'  -- name - nvarchar(100)
          )
INSERT dbo.FoodCategory
        ( name )
VALUES  ( N'Nướng' )
INSERT dbo.FoodCategory
        ( name )
VALUES  ( N'Hấp' )
INSERT dbo.FoodCategory
        ( name )
VALUES  ( N'Chiên' )
INSERT dbo.FoodCategory
        ( name )
VALUES  ( N'Nước' )

-- thêm món ăn
INSERT dbo.Food
        ( name, idCategory, price )
VALUES  ( N'Lẩu Cua Đồng', -- name - nvarchar(100)
          1, -- idCategory - int
          150000)
INSERT dbo.Food
        ( name, idCategory, price )
VALUES  ( N'Gà nướng muối ớt', 1, 50000)
INSERT dbo.Food
        ( name, idCategory, price )
VALUES  ( N'Nghêu Hấp Thái', 2, 45000)
INSERT dbo.Food
        ( name, idCategory, price )
VALUES  ( N'Cơm Chiên Hải Sản', 3, 79000)
INSERT dbo.Food
        ( name, idCategory, price )
VALUES  ( N'Cơm chiên cá mặn', 4, 79000)
INSERT dbo.Food
        ( name, idCategory, price )
VALUES  ( N'7Up', 5, 15000)
INSERT dbo.Food
        ( name, idCategory, price )
VALUES  ( N'Sting', 5, 12000)

-- thêm bill
INSERT	dbo.Bill
        ( DateCheckIn ,
          DateCheckOut ,
          idTable ,
          status
        )
VALUES  ( GETDATE() , -- DateCheckIn - date
          NULL , -- DateCheckOut - date
          3 , -- idTable - int
          0  -- status - int
        )
        
INSERT	dbo.Bill
        ( DateCheckIn ,
          DateCheckOut ,
          idTable ,
          status
        )
VALUES  ( GETDATE() , -- DateCheckIn - date
          NULL , -- DateCheckOut - date
          4, -- idTable - int
          0  -- status - int
        )
INSERT	dbo.Bill
        ( DateCheckIn ,
          DateCheckOut ,
          idTable ,
          status
        )
VALUES  ( GETDATE() , -- DateCheckIn - date
          GETDATE() , -- DateCheckOut - date
          5 , -- idTable - int
          1  -- status - int
        )

-- thêm bill info
INSERT	dbo.BillInfo
        ( idBill, idFood, count )
VALUES  ( 2, -- idBill - int
          1, -- idFood - int
          2  -- count - int
          )
INSERT	dbo.BillInfo
        ( idBill, idFood, count )
VALUES  ( 1, -- idBill - int
          3, -- idFood - int
          4  -- count - int
          )
INSERT	dbo.BillInfo
        ( idBill, idFood, count )
VALUES  ( 2, -- idBill - int
          3, -- idFood - int
          1  -- count - int
          )
INSERT	dbo.BillInfo
        ( idBill, idFood, count )
VALUES  ( 3, -- idBill - int
          1, -- idFood - int
          2  -- count - int
          )
INSERT	dbo.BillInfo
        ( idBill, idFood, count )
VALUES  ( 3, -- idBill - int
          3, -- idFood - int
          2  -- count - int
          )
INSERT	dbo.BillInfo
        ( idBill, idFood, count )
VALUES  ( 3, -- idBill - int
          4, -- idFood - int
          2  -- count - int
          )     
GO
create  proc USP_InsertBill
@idTable INT
AS
BEGIN
	INSERT	dbo.Bill
        ( DateCheckIn ,
          DateCheckOut ,
          idTable ,
          status,
		  discount)
	VALUES  ( GETDATE() , -- DateCheckIn - date
          NULL , -- DateCheckOut - date
          @idTable , -- idTable - int
          0,
		  0-- status - int
        )
END
GO
Create PROC USP_InsertBillInfo
@idBill int, @idFood int, @count int
AS
BEGIN
	DECLARE @isExitsBillInfo int
	DECLARE @foodCount int = 0
	SELECT @isExitsBillInfo = id, @foodCount = count from dbo.BillInfo AS b where idBill = @idBill AND idFood  = @idFood
	IF(@isExitsBillInfo > 0)
	BEGIN
	DECLARE @newCount int = @foodCount + @count 
		if(@newCount >0)
		UPDATE dbo.BillInfo set count = @foodCount + @count where idFood = @idFood
		else 
			DELETE dbo.BillInfo where idBill = @idBill AND idFood = @idFood	
	END
	else
	BEGIN
		INSERT	dbo.BillInfo
        ( idBill, idFood, count )
		VALUES  ( @idBill, -- idBill - int
				  @idFood, -- idFood - int
				 @count -- count - int
          )END
END
GO

UPDATE dbo.Bill set status = 1 where id =1



Alter trigger UTG_UpdateBillInfo
ON dbo.BillInfo for insert , update
AS
BEGIN
	DECLARE @idBill int

	SELECT @idBill = idBill from inserted

	DECLARE @idTable int

	SELECT @idTable = idTable from dbo.Bill where id = @idBill and status = 0

	UPDATE dbo.TableFood set  status = N'Có người'	where id = @idTable
END
GO
Create trigger UTG_UpdateBill
ON dbo.Bill for update 
as 
begin 
	DECLARE @idBill int

	SELECT  @idBill  = id from inserted

	DECLARE @idTable int

	SELECT @idTable = idTable from dbo.Bill where id = @idBill 

	DECLARE @count int = 0 

	select @count = COUNT(*) FROM dbo.Bill where  idTable = @idTable  and status = 0

	if(@count = 0)
		UPDATE dbo.TableFood set status = N'Trống' where id = @idTable

end
go

ALTER table dbo.Bill
ADD discount INT 

UPDATE dbo.Bill set discount = 0

select * from dbo.BillInfo

go
create trigger UTG_UpdateBillInfo
ON dbo.BillInfo for insert , update
AS
BEGIN
	DECLARE @idBill int

	SELECT @idBill = idBill from inserted

	DECLARE @idTable int

	SELECT @idTable = idTable from dbo.Bill where id = @idBill and status = 0

	UPDATE dbo.TableFood set  status = N'Có Người'	where id = @idTable
END
GO

create trigger UTG_UpdateTable 
on dbo.TableFood for update 
as
begin
	declare @idTable int
	declare @status nvarchar(100)

	select @idTable = id, @status = inserted.status from Inserted

	declare @idBill int 
	select @idBill = id from dbo.Bill where idTable = @idTable and status = 0

	declare @countBillInfo int 
	select @countBillInfo = COUNT(*)  from dbo.BillInfo where idBill = @idBill

	if(@countBillInfo > 0 and @status <> N'Có Người' )
		UPDATE dbo.TableFood set status = N'Có Người' where id = @idTable
	else if(@countBillInfo <= 0 and @status <> N'Trống')
		update dbo.TableFood set status = N'Trống' where id = @idTable
END
GO



alter proc USP_SwitchTable 
 @idTable1 int, @idTable2 int
AS BEGIN
	DECLARE @idFirstBill int

	DECLARE @idSeconrdBill int

	SELECT @idSeconrdBill = id FROM dbo.Bill WHERE idTable = @idTable2 AND status = 0
	SELECT @idFirstBill = id FROM dbo.Bill WHERE idTable = @idTable1 AND status = 0

	if(@idFirstBill is null)
	begin
		INSERT	dbo.Bill
        ( DateCheckIn ,
          DateCheckOut ,
          idTable ,
          status
		 )
	VALUES  ( GETDATE() , -- DateCheckIn - date
          NULL , -- DateCheckOut - date
          -- idTable - int
          @idTable1,
		  0-- status - int
        )
	select @idFirstBill = MAX(id) from dbo.Bill where idTable = @idTable1 AND status = 0
	end

	if(@idSeconrdBill is null)
	begin
		INSERT	dbo.Bill
        ( DateCheckIn ,
          DateCheckOut ,
          idTable ,
          status
		 )
	VALUES  ( GETDATE() , -- DateCheckIn - date
          NULL , -- DateCheckOut - date
          -- idTable - int
          @idTable2,
		  0-- status - int
        )
	select @idSeconrdBill = MAX(id) from dbo.Bill where idTable = @idTable2 AND status = 0
	end

	select id into IDBillInfoTable from dbo.BillInfo where idBill = @idSeconrdBill

	update  dbo.BillInfo set idBill = @idSeconrdBill WHERE idBill = @idFirstBill

	update dbo.BillInfo set idBill = @idFirstBill where id in (select * from IDBillInfoTable)

	drop Table IDBillInfoTable 
END
GO

alter table dbo.Bill add totalPrice float

delete dbo.BillInfo
delete dbo.Bill

create proc USP_GetListBillByDate
@checkIn date, @checkOut date
AS
BEGIN
	select t.name as [Tên Bàn], b.totalPrice as [Tổng tiền], DateCheckIn as [Ngày vào], DateCheckOut as [Ngày ra], discount as [Giảm giá] 
	from  dbo.Bill AS b, dbo.TableFood AS t
	where DateCheckIn >= @checkIn AND DateCheckOut <= @checkOut AND b.status = 1
	AND t.id = b.idTable 
END
GO

create proc USP_UpdateAccount
@userName nvarchar(100), @displayName nvarchar(100), @password nvarchar(100), @newPassword nvarchar(100)
AS
BEGIN
	DECLARE @isRightPass int = 0

	select @isRightPass = COUNT(*) FROM dbo.Account where USERName = @userName and PassWord = @password

	if(@isRightPass = 1)
	begin
		if(@newPassword = null or @newPassword = '')
			begin
				update dbo.Account set DisplayName = @displayName where UserName = @userName
			end

			else
				update dbo.Account set DisplayName = @displayName, PassWord = @newPassword where UserName = @userName
			end

END
go

UPDATE dbo.Food SET name = N'', idCategory = 5, price = 0 where id = 4


create trigger UTG_DeleteBillInfo
on dbo.BillInfo for delete
as
begin
	declare @idBillInfo int
	declare @idBill int
	select @idBillInfo = id, @idBill = deleted.idBill from deleted

	declare @idTable int
	select @idTable = idTable From dbo.Bill where id = @idBill

	declare @count int = 0

	select @count = COUNT(*) from dbo.BillInfo as bi, dbo.Bill as b where b.id = bi.idBill and b.id = @idBill and status = 0

	if(@count = 0)
		update dbo.TableFood set status = N'Trống' where id= @idTable
END
GO
CREATE FUNCTION [dbo].[fuConvertToUnsign1] ( @strInput NVARCHAR(4000) ) RETURNS NVARCHAR(4000) AS BEGIN IF @strInput IS NULL RETURN @strInput IF @strInput = '' RETURN @strInput DECLARE @RT NVARCHAR(4000) DECLARE @SIGN_CHARS NCHAR(136) DECLARE @UNSIGN_CHARS NCHAR (136) SET @SIGN_CHARS = N'ăâđêôơưàảãạáằẳẵặắầẩẫậấèẻẽẹéềểễệế ìỉĩịíòỏõọóồổỗộốờởỡợớùủũụúừửữựứỳỷỹỵý ĂÂĐÊÔƠƯÀẢÃẠÁẰẲẴẶẮẦẨẪẬẤÈẺẼẸÉỀỂỄỆẾÌỈĨỊÍ ÒỎÕỌÓỒỔỖỘỐỜỞỠỢỚÙỦŨỤÚỪỬỮỰỨỲỶỸỴÝ' +NCHAR(272)+ NCHAR(208) SET @UNSIGN_CHARS = N'aadeoouaaaaaaaaaaaaaaaeeeeeeeeee iiiiiooooooooooooooouuuuuuuuuuyyyyy AADEOOUAAAAAAAAAAAAAAAEEEEEEEEEEIIIII OOOOOOOOOOOOOOOUUUUUUUUUUYYYYYDD' DECLARE @COUNTER int DECLARE @COUNTER1 int SET @COUNTER = 1 WHILE (@COUNTER <=LEN(@strInput)) BEGIN SET @COUNTER1 = 1 WHILE (@COUNTER1 <=LEN(@SIGN_CHARS)+1) BEGIN IF UNICODE(SUBSTRING(@SIGN_CHARS, @COUNTER1,1)) = UNICODE(SUBSTRING(@strInput,@COUNTER ,1) ) BEGIN IF @COUNTER=1 SET @strInput = SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)-1) ELSE SET @strInput = SUBSTRING(@strInput, 1, @COUNTER-1) +SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)- @COUNTER) BREAK END SET @COUNTER1 = @COUNTER1 +1 END SET @COUNTER = @COUNTER +1 END SET @strInput = replace(@strInput,' ','-') RETURN @strInput END

Select UserName, DisPlayName, Type from dbo.Account


