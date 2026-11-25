// Funções para padronizar as respostas JSON da API.

// Resposta de sucesso: { sucesso: true, total: N, dados: [...] }
export function enviarSucesso(res, dados, status = 200) {
  const corpo = { sucesso: true };
  if (Array.isArray(dados)) corpo.total = dados.length;
  corpo.dados = dados;
  return res.status(status).json(corpo);
}

// Resposta de erro: { sucesso: false, erro: "mensagem" }
export function enviarErro(res, status, mensagem) {
  return res.status(status).json({ sucesso: false, erro: mensagem });
}

// Erro "esperado" da aplicação (ex.: parâmetro inválido), com o código HTTP que deve ser devolvido.
export class ErroApp extends Error {
  constructor(status, mensagem) {
    super(mensagem);
    this.status = status;
  }
}
