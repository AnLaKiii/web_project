USE [EgitimPlatformu]
GO

/****** Object:  StoredProcedure [dbo].[SepettekiUrunleriListele]    Script Date: 30.05.2024 19:43:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SepettekiUrunleriListele]
    @KullaniciID UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    -- Sepetteki dersleri ve paketleri listele
    SELECT 
        S.SepetID,
        S.KullaniciID,
        S.PaketID,
        P.PaketAdi,
        S.EgitimID,
        E.EgitimAdi,
        S.SepetToplamFiyati
    FROM 
        Sepet S
    LEFT JOIN 
        Paketler P ON S.PaketID = P.PaketID
    LEFT JOIN 
        Egitim E ON S.EgitimID = E.EgitimID
    WHERE 
        S.KullaniciID = @KullaniciID;
END;
GO

