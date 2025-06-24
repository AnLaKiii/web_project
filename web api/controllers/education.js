import mssql from 'mssql';
import { config } from '../utils/config.js';

//Eğitimleri listele
export const EgitimListele = async (req, res) => {
    try {
        const pool = await mssql.connect(config);

        const result = await pool
            .request()
            .execute('EgitimleriGetir');
        if(result.recordset.length > 0)
            res.status(200).send(result.recordset);          
    
        else{
            return res.status(400).send("Dersler Getirilemedi");
        }
    } catch (error) {
        console.log(error);
        res.status(500).send("Server Hatası");
    }
}

export const EgitimlerimiListele = async (req, res) => {
    let { KullaniciID} = req.query;
    try {
        const pool = await mssql.connect(config);

        const result = await pool
            .request()
            .input('KullaniciID', mssql.UniqueIdentifier, KullaniciID)
            .execute('KullanicininEgitimleriniGetir');
            if(result.recordset.length > 0)
                res.status(200).send(result.recordset);          
      
        else{
            return res.status(400).send("Kayıtlı Ders Yok");
        }
    } catch (error) {
        console.log(error);
        res.status(500).send("Server Hatası");
    }
}