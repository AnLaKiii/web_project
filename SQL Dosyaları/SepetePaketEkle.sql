USE [EgitimPlatformu]
GO

/****** Object:  StoredProcedure [dbo].[SepetePaketEkle]    Script Date: 30.05.2024 19:43:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SepetePaketEkle]
    @KullaniciID UNIQUEIDENTIFIER,
    @PaketID UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @PaketAdi NVARCHAR(50);
    DECLARE @PaketFiyati MONEY;
    DECLARE @SepetID UNIQUEIDENTIFIER;
    DECLARE @YeniToplamFiyat MONEY;

    BEGIN TRANSACTION;

    BEGIN TRY
        -- Paketin adını ve fiyatını al
        SELECT @PaketAdi = PaketAdi, @PaketFiyati = PaektFiyati
        FROM Paketler
        WHERE PaketID = @PaketID;

        -- Sepet tablosuna yeni bir sepet ekle
        SET @SepetID = NEWID();
        INSERT INTO Sepet (SepetID, KullaniciID, PaketID, SepetToplamFiyati)
        VALUES (@SepetID, @KullaniciID, @PaketID, @PaketFiyati);

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

