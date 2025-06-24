import mssql from 'mssql';
import md5 from 'md5';
import { config } from '../utils/config.js';

export const register = async (req, res) => {
    let { name, surname, phone ,email, password } = req.body;
    try {
        const pool = await mssql.connect(config);
        password = md5(password);

        const result = await pool
            .request()
            .input('Name', mssql.NVarChar, name)
            .input('Soyad', mssql.NVarChar, surname)
            .input('Telefon', mssql.BigInt, phone)
            .input('Mail', mssql.NVarChar, email)
            .input('Sifre', mssql.NVarChar, password)
            .execute('KullaniciEkle');
        
            if(result.recordset[0].success > 0)
                res.status(200).send("Kullanıcı kayıt oldu");          
      
        else{
            return res.status(400).send("Bu Kullanıcı Zaten Kayıtlı");
        }
    } catch (error) {
        console.log(error);
        res.status(500).send("Server Hatası");
    }
}




export const login = async (req, res) => {
    let { email, password } = req.body;
    try {
        console.log(email, password)
        password = md5(password);
        const pool = await mssql.connect(config);
        const result = await pool
            .request()
            .input('Email', mssql.NVarChar, email)
            .input('Sifre', mssql.NVarChar, password)
            .execute('KullaniciGirisiKontrol');
            console.log(result.recordset)
        if (result.recordset[0].Sonuc !== '-1') {
            res.status(200).send(result.recordset[0]);
        } else {
            res.status(401).send("Kullanıcı Adı veya Şifre Yanlış");
        }
    } catch (error) {
        console.log(error);
        res.status(500).send("Server Hatası");
    }
}

