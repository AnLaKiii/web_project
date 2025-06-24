import { Router } from "express";
import { getInfo, surname, email, phone, password } from "../controllers/account.js";
export const router = Router();


router.get("/",getInfo);
router.put("/surname",surname);
router.put("/email",email);
router.put("/phone",phone);
router.put("/password",password);