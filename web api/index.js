import express from 'express';
import mssql from 'mssql';
import cors from 'cors';
import {config} from './utils/config.js'
const app = express();
const port = 3001;
import { router as authRouter } from './routes/auth.js';
import { router as cartRouter } from './routes/cart.js';
import { router as accountRouter } from './routes/account.js';
import { router as educationRouter } from './routes/education.js';


// MSSQL bağlantısını oluştur
async function connectDB() {
    try {
        await mssql.connect(config);
        console.log('MSSQL veritabanına bağlandı.');
    } catch (error) {
        console.error('MSSQL bağlantı hatası:', error);
    }
}
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(cors());



app.use('/',authRouter);
app.use('/cart',cartRouter);
app.use('/account',accountRouter);
app.use('/education',educationRouter);


// Bağlantıyı başlat
connectDB().then(() => {
    app.listen(port, () => {
        console.log(`Sunucu ${port} portunda çalışıyor.`);
    });
});
