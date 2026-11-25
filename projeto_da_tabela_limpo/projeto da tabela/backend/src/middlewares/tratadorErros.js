// Tratamento centralizado de erros: todo erro lançado nos controllers/services cai aqui.
import { enviarErro } from '../utils/resposta.js';

// Rota que não existe -> 404
export function tratarRotaNaoEncontrada(req, res) {
  return enviarErro(res, 404, `Rota não encontrada: ${req.method} ${req.originalUrl}`);
}

// Erros em geral. O Express reconhece este middleware pelos 4 parâmetros (erro, req, res, next).
// eslint-disable-next-line no-unused-vars
export function tratarErros(erro, req, res, next) {
  // Erro esperado (ex.: parâmetro inválido): devolve a mensagem com o código HTTP correto.
  if (erro.status && erro.status < 500) {
    return enviarErro(res, erro.status, erro.message);
  }
  // Erro inesperado: os detalhes técnicos ficam só no terminal do servidor, nunca vão para o cliente.
  console.error('[ERRO]', erro);
  return enviarErro(res, 500, 'Erro interno do servidor.');
}
