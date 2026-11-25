import { listarProfessores } from '../services/professorService.js';
import { enviarSucesso } from '../utils/resposta.js';

// GET /api/professores
export async function obterProfessores(req, res, next) {
  try {
    return enviarSucesso(res, await listarProfessores());
  } catch (erro) {
    return next(erro);
  }
}
