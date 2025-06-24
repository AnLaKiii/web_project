import { Router } from "express";
import { EgitimListele, EgitimlerimiListele} from "../controllers/education.js";
export const router = Router();


router.get("/",EgitimListele);
router.get("/detail",EgitimlerimiListele);