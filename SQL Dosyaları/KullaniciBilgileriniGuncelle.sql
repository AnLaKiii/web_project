USE [EgitimPlatformu]
GO

/****** Object:  StoredProcedure [dbo].[KullaniciBilgileriniGuncelle]    Script Date: 30.05.2024 19:40:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[KullaniciBilgileriniGuncelle]
    @KullaniciID UNIQUEIDENTIFIER,
    @YeniAdi NVARCHAR(25) = NULL,
    @YeniSoyad NVARCHAR(25) = NULL,
    @YeniTelefon BIGINT = NULL,
    @YeniMail NVARCHAR(50) = NULL,
    @YeniSifre NVARCHAR(50) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRANSACTION;

    BEGIN TRY
        -- Kullanıcı tablosundaki bilgileri güncelle
        UPDATE Kullanici
        SET 
            Name = ISNULL(@YeniAdi, Name),
            Soyad = ISNULL(@YeniSoyad, Soyad),
            Telefon = ISNULL(@YeniTelefon, Telefon)
        WHERE KullaniciID = @KullaniciID;

        -- Mail tablosundaki bilgileri güncelle
        UPDATE Mail
        SET 
            Mail = ISNULL(@YeniMail, Mail),
            Sifre = ISNULL(@YeniSifre, Sifre)
        WHERE KullaniciID = @KullaniciID;

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

