USE [EgitimPlatformu]
GO

/****** Object:  StoredProcedure [dbo].[KullanicininEgitimleriniGetir]    Script Date: 30.05.2024 19:42:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[KullanicininEgitimleriniGetir]
    @KullaniciID UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        E.EgitimID,
        E.EgitimAdi,
        E.EgitimFiyati,
        EK.DersIcerigi
    FROM 
        Egitimlerim K
    INNER JOIN 
        Egitim E ON K.EgitimID = E.EgitimID
    INNER JOIN 
        EgitimKonuları EK ON E.EgitimID = EK.EgitimID
    WHERE 
        K.KullaniciID = @KullaniciID;
END;
GO

