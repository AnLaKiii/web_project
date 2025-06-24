USE [EgitimPlatformu]
GO

/****** Object:  StoredProcedure [dbo].[DersIceriginiGetir]    Script Date: 30.05.2024 19:39:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[DersIceriginiGetir]
    @DersID UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        E.EgitimID,
        E.EgitimAdi,
        E.EgitimFiyati,
        EK.DersIcerigi
    FROM 
        Egitim E
    INNER JOIN 
        EgitimKonuları EK ON E.EgitimID = EK.EgitimID
    WHERE 
        E.EgitimID = @DersID;
END;
GO

