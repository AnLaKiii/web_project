USE [EgitimPlatformu]
GO

/****** Object:  StoredProcedure [dbo].[PaketTarihiniGuncelle]    Script Date: 30.05.2024 19:42:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[PaketTarihiniGuncelle]
    @KullaniciID UNIQUEIDENTIFIER,
    @PaketID UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @BaslangicTarihi DATE = GETDATE();
    DECLARE @BitisTarihi DATE = DATEADD(MONTH, 1, @BaslangicTarihi);

    BEGIN TRANSACTION;

    BEGIN TRY
        -- Paketlerim tablosunda kullanıcının paketinin başlangıç ve bitiş tarihlerini güncelle
        UPDATE Paketlerim
        SET 
            BaslangicTarihi = @BaslangicTarihi,
            BitisTarihi = @BitisTarihi  
        WHERE 
            KullaniciID = @KullaniciID AND PaketID = @PaketID;

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

