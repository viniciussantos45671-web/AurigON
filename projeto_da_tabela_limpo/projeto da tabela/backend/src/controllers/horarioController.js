// Controller: recebe a requisição, valida os parâmetros, chama o service e devolve a resposta.
import { buscarHorarios, buscarGradeCompleta } from '../services/horarioService.js';
import { validarId, validarDia, validarGrupo } from '../utils/validadores.js';
import { enviarSucesso } from '../utils/resposta.js';

// GET /api/horarios?turma=&professor=&dia=&sala=&grupo=
export async function listarHorarios(req, res, next) {
  try {
    const filtros = {
      turma: validarId(req.query.turma, 'turma'),
      professor: validarId(req.query.professor, 'professor'),
      dia: validarDia(req.query.dia),
      sala: validarId(req.query.sala, 'sala'),
      grupo: validarGrupo(req.query.grupo),
    };
    const horarios = await buscarHorarios(filtros);
    return enviarSucesso(res, horarios);
  } catch (erro) {
    return next(erro); // repassa para o tratador de erros
  }
}

// GET /api/horarios/completo
export async function obterGradeCompleta(req, res, next) {
  try {
    const grade = await buscarGradeCompleta();
    return enviarSucesso(res, grade);
  } catch (erro) {
    return next(erro);
  }
}
