import { Router } from 'express';
import { obterTurmas } from '../controllers/turmaController.js';

const router = Router();
router.get('/', obterTurmas);

export default router;
