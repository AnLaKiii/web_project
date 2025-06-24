import mssql from 'mssql';
import { config } from '../utils/config.js';

//Sepete ürün ekleme
export const addCart = async (req, res) => {
    let { kullaciciID,egitimID  } = req.body;
    try {
        const pool = await mssql.connect(config);
        const result = await pool
            .request()
            .input('KullaniciID', mssql.UniqueIdentifier, kullaciciID)
            .input('EgitimID', mssql.UniqueIdentifier, egitimID)
            .execute("SepeteDersEkle");
        res.status(200).send("Ürün sepete eklendi");
        
    } catch (error) {
        console.log(error);
        res.status(500).send("Server Hatası");
    }
};
//Sepetteki ürünleri listeleme

export const listCart = async (req, res) => {
    let { userID } = req.query;
    try {
        const pool = await mssql.connect(config);
        const result = await pool
            .request()
            .input('KullaniciID', mssql.UniqueIdentifier, userID)
            .execute("SepettekiUrunleriListele");
        if (result.recordset.length > 0) {
            res.status(200).send(result.recordset);
        }
        else{
            res.status(401).send("Ürün Bulunamadı");
        }
    } catch (error) {
        console.log(error);
        res.status(500).send("Server Hatası");
    }
};

//Sepetteki ürünleri güncelleme
export const updateCart = async (req, res) => {
    let { userID, productID, productQuantity} = req.body;
    try {
        const pool = await mssql.connect(config);
        const result = await pool
            .request()
            .input('userID', mssql.UniqueIdentifier, userID)
            .input('productID', mssql.Int, productID)
            .input('productQuantity', mssql.Int, productQuantity)
            .execute("SP_CartUpdate");
        if(result.recordset[0].isUpdate) res.status(200).send("Ürün sayısı güncellendi");
        else res.status(200).send("Ürün bulunamadı");
    } catch (error) {
        console.log(error);
        res.status(500).send("Server Hatası");
    }
};

//Sepetteki bir ürünü silme
export const deleteCart = async (req, res) => {
    let { userID, productID} = req.body;
    try {
        const pool = await mssql.connect(config);
        const result = await pool
            .request()
            .input('userID', mssql.UniqueIdentifier, userID)
            .input('productID', mssql.Int, productID)
            .execute("SP_CartDelete");
        if(result.recordset[0].isDelete === 1) res.status(200).send("Ürün sepetten silindi");
        else res.status(401).send("Ürün bulunamadı");
    } catch (error) {
        console.log(error);
        res.status(500).send("Server Hatası");
    }
};
export const deleteAllCart = async (req, res) => {
    let { userID } = req.body;
    try {
        const pool = await mssql.connect(config);
        const result = await pool
            .request()
            .input('userID', mssql.UniqueIdentifier, userID)
            .execute("SP_CartAllDelete");
        if(result.recordset[0].isDelete === 1) res.status(200).send("Ürünler sepetten silindi");
        else res.status(401).send("Ürün bulunamadı");
    } catch (error) {
        console.log(error);
        res.status(500).send("Server Hatası");
    }
};