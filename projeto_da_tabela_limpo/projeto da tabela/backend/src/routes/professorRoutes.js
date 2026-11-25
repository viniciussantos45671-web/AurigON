import { Router } from 'express';
import { obterProfessores } from '../controllers/professorController.js';

const router = Router();
router.get('/', obterProfessores);

export default router;
