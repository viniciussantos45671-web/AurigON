import { listarTurmas } from '../services/turmaService.js';
import { enviarSucesso } from '../utils/resposta.js';

// GET /api/turmas
export async function obterTurmas(req, res, next) {
  try {
    return enviarSucesso(res, await listarTurmas());
  } catch (erro) {
    return next(erro);
  }
}
