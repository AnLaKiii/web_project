USE [EgitimPlatformu]
GO

/****** Object:  StoredProcedure [dbo].[KullaniciKayitKontrol]    Script Date: 30.05.2024 19:41:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[KullaniciKayitKontrol]
    @Name NVARCHAR(25),
    @Soyad NVARCHAR(25),
    @Telefon BIGINT,
    @Mail NVARCHAR(50),
    @Sifre NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Sonuc BIT;

    IF EXISTS (
        SELECT 1 
        FROM Mail 
        WHERE Mail = @Mail
    )
    BEGIN
        -- E-posta zaten mevcut
        SET @Sonuc = 0;
    END
    ELSE
    BEGIN
        BEGIN TRANSACTION;

        BEGIN TRY
            -- Yeni Kullanıcı ID oluştur
            DECLARE @KullaniciID UNIQUEIDENTIFIER = NEWID();

            -- Kullanıcı bilgilerini Kullanici tablosuna ekle
            INSERT INTO Kullanici (KullaniciID, Name, Soyad, Telefon)
            VALUES (@KullaniciID, @Name, @Soyad, @Telefon);

            -- Kullanıcı mail ve şifresini Mail tablosuna ekle
            INSERT INTO Mail (KullaniciID, Mail, Sifre)
            VALUES (@KullaniciID, @Mail, @Sifre);

            -- İşlemi başarılı bir şekilde tamamla
            COMMIT TRANSACTION;
            SET @Sonuc = 1;
        END TRY
        BEGIN CATCH
            -- Hata durumunda işlemi geri al
            ROLLBACK TRANSACTION;

            -- Hata mesajını döndür
            DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
            RAISERROR (@ErrorMessage, 16, 1);
            SET @Sonuc = 0;
        END CATCH
    END

    SELECT @Sonuc AS Sonuc;
END;
GO

