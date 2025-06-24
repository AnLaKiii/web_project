USE [EgitimPlatformu]
GO

/****** Object:  StoredProcedure [dbo].[EgitimleriGetir]    Script Date: 30.05.2024 19:39:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[EgitimleriGetir]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        EgitimID,
        EgitimAdi,
        EgitimFiyati
    FROM 
        Egitim;
END;
GO

