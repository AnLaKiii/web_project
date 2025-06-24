USE [EgitimPlatformu]
GO

/****** Object:  StoredProcedure [dbo].[SepetiOnayla]    Script Date: 30.05.2024 19:43:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SepetiOnayla]
    @KullaniciID UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRANSACTION;

    BEGIN TRY
        -- Sepetteki dersleri Egitimlerim tablosuna ekle
        INSERT INTO Egitimlerim (KullaniciID, EgitimID)
        SELECT DISTINCT KullaniciID, EgitimID
        FROM Sepet
        WHERE KullaniciID = @KullaniciID AND EgitimID IS NOT NULL
          AND NOT EXISTS (
              SELECT 1
              FROM Egitimlerim
              WHERE KullaniciID = @KullaniciID AND EgitimID = Sepet.EgitimID
          );

        -- Sepetteki paketleri Paketlerim tablosuna ekle
        INSERT INTO Paketlerim (KullaniciID, PaketID, BaslangicTarihi)
        SELECT DISTINCT KullaniciID, PaketID, GETDATE()
        FROM Sepet
        WHERE KullaniciID = @KullaniciID AND PaketID IS NOT NULL
          AND NOT EXISTS (
              SELECT 1
              FROM Paketlerim
              WHERE KullaniciID = @KullaniciID AND PaketID = Sepet.PaketID
          );

        -- İşlemi başarılı bir şekilde tamamla
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Hata durumunda işlemi geri al
        ROLLBACK TRANSACTION;

        -- Hata mesajını döndür
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END;
GO

