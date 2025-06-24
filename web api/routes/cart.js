import { Router } from "express";
import { addCart, listCart, updateCart, deleteCart, deleteAllCart } from "../controllers/cart.js";
export const router = Router();


router.post("/",addCart);
router.get("/",listCart);
router.put("/",updateCart);
router.delete("/",deleteCart);
router.delete("/all",deleteAllCart);