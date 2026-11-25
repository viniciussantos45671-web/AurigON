import { Router } from 'express';
import { obterSalas } from '../controllers/salaController.js';

const router = Router();
router.get('/', obterSalas);

export default router;
