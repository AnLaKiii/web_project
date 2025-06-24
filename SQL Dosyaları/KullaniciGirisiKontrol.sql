USE [EgitimPlatformu]
GO

/****** Object:  StoredProcedure [dbo].[KullaniciGirisiKontrol]    Script Date: 30.05.2024 19:41:08 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[KullaniciGirisiKontrol]
    @Email NVARCHAR(50),
    @Sifre NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Sonuc varchar(50);

    IF EXISTS (
        SELECT 1 
        FROM Mail 
        WHERE Mail = @Email AND Sifre = @Sifre
    )
    BEGIN
        SET @Sonuc = (SELECT KullaniciID FROM Mail 
			WHERE Mail = @Email);
    END
    ELSE
    BEGIN
        SET @Sonuc = '';
    END

    SELECT @Sonuc AS Sonuc;
END;
GO

