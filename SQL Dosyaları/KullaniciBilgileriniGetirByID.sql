USE [EgitimPlatformu]
GO

/****** Object:  StoredProcedure [dbo].[KullaniciBilgileriniGetirByID]    Script Date: 30.05.2024 19:40:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[KullaniciBilgileriniGetirByID]
    @KullaniciID UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        K.KullaniciID,
        K.Name,
        K.Soyad,
        K.Telefon,
        M.Mail,
        M.Sifre
    FROM 
        Kullanici K
    INNER JOIN 
        Mail M ON K.KullaniciID = M.KullaniciID
    WHERE 
        K.KullaniciID = @KullaniciID;
END;
GO

