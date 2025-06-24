USE [EgitimPlatformu]
GO

/****** Object:  StoredProcedure [dbo].[SepeteDersEkle]    Script Date: 30.05.2024 19:42:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SepeteDersEkle]
    @KullaniciID UNIQUEIDENTIFIER,
    @EgitimID UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @EgitimAdi NVARCHAR(50);
    DECLARE @EgitimFiyati MONEY;
    DECLARE @SepetID UNIQUEIDENTIFIER;
    DECLARE @YeniToplamFiyat MONEY;

    BEGIN TRANSACTION;

    BEGIN TRY
        -- Dersin adını ve fiyatını al
        SELECT @EgitimAdi = EgitimAdi, @EgitimFiyati = EgitimFiyati
        FROM Egitim
        WHERE EgitimID = @EgitimID;

        -- Sepet tablosuna yeni bir sepet ekle
        SET @SepetID = NEWID();
        INSERT INTO Sepet (SepetID, KullaniciID, EgitimID, SepetToplamFiyati)
        VALUES (@SepetID, @KullaniciID, @EgitimID, @EgitimFiyati);

        -- Kullanıcının sepetindeki toplam fiyatı güncelle
        SELECT @YeniToplamFiyat = SUM(SepetToplamFiyati)
        FROM Sepet
        WHERE KullaniciID = @KullaniciID;

        UPDATE Sepet
        SET SepetToplamFiyati = @YeniToplamFiyat
        WHERE SepetID = @SepetID;

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

