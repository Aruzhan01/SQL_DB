USE [AdventureWorksLT2019]
GO
/****** Object:  StoredProcedure [dbo].[FinalProject]    Script Date: 14.03.2024 10:09:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Bauyrzhankyzy Aruzhan
-- Create date: 29/12/2022
-- Description:	АНАЛИТИКА ПО ПОКУПАТЕЛЯМ И ПО ИХ ЗАКАЗАМ 
-- =============================================
ALTER PROCEDURE [dbo].[FinalProject]
AS
SET XACT_ABORT ON
BEGIN TRAN 
	
	SET NOCOUNT ON;
	IF OBJECT_ID(N'tmpCustomer') IS NOT NULL
	DROP TABLE tmpCustomer;

		--Создать таблицу : [CustomerID], [CountryRegion], [ProductID], [OrderQty], [UnitPrice], [OrderCount]
			CREATE TABLE dbo.tmpCustomer
				(
				CustomerID int NOT NULL,
				CountryRegion nvarchar(50) NULL,
				ProductID int NULL,
				OrderQty money NULL,
				UnitPrice money NULL,
				OrderCount money NULL
				)  ON [PRIMARY]

			ALTER TABLE dbo.tmpCustomer ADD CONSTRAINT
				PK_tmpCustomer PRIMARY KEY CLUSTERED 
				(
				CustomerID
				) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

		--обновить в ней все данные
			INSERT INTO [dbo].[tmpCustomer]
					   ([CustomerID]
					   ,[CountryRegion])

			SELECT DISTINCT  SalesLT.Customer.CustomerID, CountryRegion
			FROM SalesLT.Customer 
			LEFT JOIN
			SalesLT.CustomerAddress ON SalesLT.Customer.CustomerID = SalesLT.CustomerAddress.CustomerID
			LEFT JOIN SalesLT.[Address] ON SalesLT.CustomerAddress.AddressID = SalesLT.[Address].AddressID
			WHERE CountryRegion IS NOT NULL 

			UPDATE [tmpCustomer] SET [ProductID] = TMP.ProductID ,
					   [OrderQty] =TMP.OrderQty,
					   [UnitPrice] =TMP.UnitPrice 
			FROM
			(
			SELECT DISTINCT SalesLT.SalesOrderHeader.CustomerID, SalesLT.SalesOrderDetail.ProductID, 
			SUM(SalesLT.SalesOrderDetail.OrderQty) as OrderQty, 
			MAX(SalesLT.SalesOrderDetail.UnitPrice) UnitPrice
			FROM SalesLT.SalesOrderHeader
			INNER JOIN SalesLT.SalesOrderDetail ON SalesLT.SalesOrderHeader.SalesOrderID =  SalesLT.SalesOrderDetail.SalesOrderID
			GROUP BY SalesLT.SalesOrderHeader.CustomerID, SalesLT.SalesOrderDetail.ProductID
			) AS TMP
			WHERE [tmpCustomer].CustomerID = TMP.CustomerID


		--Вычислить и обновить количество заказов по каждому покупателю
			 UPDATE tmpCustomer SET [OrderCount] = TMP.OrderCount
			 FROM
			 (
			 SELECT CustomerID, COUNT(*) as OrderCount FROM SalesLT.SalesOrderHeader
			 GROUP BY CustomerID
			 ) as TMP
			WHERE tmpCustomer.CustomerID = TMP.CustomerID

		--обновление данные по покупателю 29975, добавили ему 10 заказов
			UPDATE tmpCustomer SET OrderCount = 11 WHERE CustomerID = 29975

		COMMIT
		--Выявить долю каждого покупателя по всем его заказам в пределах всей организации и определить рейтинг этого покупателя

			SELECT  *,  Cast(( OrderCount * 100.0 ) /  Sum(OrderCount)OVER() As decimal(5,2)) as [PERCENT]

			 --(OrderCount * 100) / (SELECT SUM(OrderCount) FROM tmpCustomer)
			from tmpCustomer WHERE ProductID is not null
			ORDER BY CustomerID
