// Validação dos parâmetros recebidos na URL (query string).
// Quando o valor é inválido, lança um ErroApp 400 que o tratador de erros transforma em resposta.
import { ErroApp } from './resposta.js';

// Nome do dia (sem acento, minúsculo) -> id na tabela dias_aula
const DIAS = {
  segunda: 1,
  terca: 2,
  quarta: 3,
  quinta: 4,
  sexta: 5,
};

// Texto digitado (sem acento, minúsculo) -> valor do ENUM da coluna "grupo"
const GRUPOS = { a: 'A', b: 'B', inteira: 'Inteira' };

// Remove acentos, deixa minúsculo e tira o sufixo "-feira" (ex.: "Terça-feira" -> "terca")
const normalizar = (texto) =>
  String(texto)
    .normalize('NFD')
    .replace(/[̀-ͯ]/g, '')
    .toLowerCase()
    .replace(/-feira$/, '')
    .trim();

// Aceita um número inteiro positivo. Se o parâmetro não foi enviado, devolve undefined (sem filtro).
export function validarId(valor, nomeParametro) {
  if (valor === undefined || valor === '') return undefined;
  if (!/^\d+$/.test(String(valor)) || Number(valor) < 1) {
    throw new ErroApp(400, `Parâmetro "${nomeParametro}" inválido: informe um id numérico positivo.`);
  }
  return Number(valor);
}

// Aceita o nome do dia (segunda, terca/terça, quarta, quinta, sexta) ou um número de 1 a 5.
export function validarDia(valor) {
  if (valor === undefined || valor === '') return undefined;
  const texto = normalizar(valor);
  const id = /^[1-5]$/.test(texto) ? Number(texto) : DIAS[texto];
  if (!id) {
    throw new ErroApp(400, 'Parâmetro "dia" inválido: use segunda, terca, quarta, quinta, sexta ou um número de 1 a 5.');
  }
  return id;
}

// Aceita A, B ou Inteira (maiúsculas ou minúsculas).
export function validarGrupo(valor) {
  if (valor === undefined || valor === '') return undefined;
  const grupo = GRUPOS[normalizar(valor)];
  if (!grupo) {
    throw new ErroApp(400, 'Parâmetro "grupo" inválido: use A, B ou Inteira.');
  }
  return grupo;
}
