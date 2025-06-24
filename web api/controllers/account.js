import mssql from 'mssql';
import md5 from 'md5';
import { config } from '../utils/config.js';


    export const getInfo = async (req, res) => {
        let { userID } = req.query;
        try {
            const pool = await mssql.connect(config);
            const result = await pool
                .request()
                .input('KullaniciID', mssql.UniqueIdentifier, userID)
                .execute("KullaniciBilgileriniGetirByID");
            if(result.recordset.length > 0) res.status(200).send(result.recordset[0]);
            else res.status(401).send("Kullanıcı bulunamadı");
        } catch (error) {
            console.log(error);
            res.status(500).send("Server Hatası");
        }
    };

//Soyisim güncelleme
export const surname = async (req, res) => {
    let { userID, surname } = req.body;
    try {
        const pool = await mssql.connect(config);
        const result = await pool
            .request()
            .input('KullaniciID', mssql.UniqueIdentifier, userID)
            .input('Soyad', mssql.VarChar, surname)
            .execute("KullaniciBilgileriniGuncelle");
        if(result.recordset[0].isUpdate === 1) res.status(200).send("Kullanıcı soy ismi değiştirildi");
        else res.status(401).send("Kullanıcı bulunamadı");
    } catch (error) {
        console.log(error);
        res.status(500).send("Server Hatası");
    }
};

//email güncelleme
export const email = async (req, res) => {
    let { userID, email } = req.body;
    try {
        const pool = await mssql.connect(config);
        const result = await pool
            .request()
            .input('KullaniciID', mssql.UniqueIdentifier, userID)
            .input('Mail', mssql.VarChar, email)
            .execute("KullaniciBilgileriniGuncelle");
        if(result.recordset[0].isUpdate === 1) res.status(200).send("Kullanıcı email değiştirildi");
        else res.status(401).send("Kullanıcı bulunamadı");
    } catch (error) {
        console.log(error);
        res.status(500).send("Server Hatası");
    }
};

//telefon güncelleme
export const phone = async (req, res) => {
    let { userID, phone } = req.body;
    try {
        const pool = await mssql.connect(config);
        const result = await pool
            .request()
            .input('KullaniciID', mssql.UniqueIdentifier, userID)
            .input('Telefon', mssql.VarChar, phone)
            .execute("KullaniciBilgileriniGuncelle");
        if(result.recordset[0].isUpdate === 1) res.status(200).send("Kullanıcı telefon numarası değiştirildi");
        else res.status(401).send("Kullanıcı bulunamadı");
    } catch (error) {
        console.log(error);
        res.status(500).send("Server Hatası");
    }
};


export const password = async (req, res) => {
    let { userID, password, newPassword } = req.body;
    try {
        password = md5(password);
        newPassword = md5(newPassword);
        const pool = await mssql.connect(config);
        const result = await pool
            .request()
            .input('KullaniciID', mssql.UniqueIdentifier, userID)
            .input('password', mssql.VarChar, password)
            .input('newPassword', mssql.VarChar, newPassword)
            .execute("KullaniciBilgileriniGuncelle");
        if(result.recordset[0].isUpdate === 1) res.status(200).send("Parola değiştirildi değiştirildi");
        else res.status(401).send("Parola doğru değil");
    } catch (error) {
        console.log(error);
        res.status(500).send("Server Hatası");
    }
};
