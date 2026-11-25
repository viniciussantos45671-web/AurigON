import { Router } from 'express';
import { listarHorarios, obterGradeCompleta } from '../controllers/horarioController.js';

const router = Router();

// "/completo" precisa vir antes de "/" para não ser confundida com a rota de filtros.
router.get('/completo', obterGradeCompleta);
router.get('/', listarHorarios);

export default router;
