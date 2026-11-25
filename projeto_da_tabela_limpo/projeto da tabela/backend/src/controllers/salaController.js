import { listarSalas } from '../services/salaService.js';
import { enviarSucesso } from '../utils/resposta.js';

// GET /api/salas
export async function obterSalas(req, res, next) {
  try {
    return enviarSucesso(res, await listarSalas());
  } catch (erro) {
    return next(erro);
  }
}
