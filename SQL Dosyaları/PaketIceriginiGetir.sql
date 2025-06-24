USE [EgitimPlatformu]
GO

/****** Object:  StoredProcedure [dbo].[PaketIceriginiGetir]    Script Date: 30.05.2024 19:42:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[PaketIceriginiGetir]
    @PaketID UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        P.PaketID,
        P.PaketAdi,
        P.PaektFiyati,
        PB.PaketOzellik1,
        PB.PaketOzellik2
    FROM 
        Paketler P
    INNER JOIN 
        PaketBilgileri PB ON P.PaketID = PB.PaketID
    WHERE 
        P.PaketID = @PaketID;
END;
GO

