// Ponto de entrada: configura o Express, registra as rotas e inicia o servidor.
import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';

import pool from './config/database.js';
import horarioRoutes from './routes/horarioRoutes.js';
import turmaRoutes from './routes/turmaRoutes.js';
import professorRoutes from './routes/professorRoutes.js';
import salaRoutes from './routes/salaRoutes.js';
import { tratarRotaNaoEncontrada, tratarErros } from './middlewares/tratadorErros.js';
import { enviarSucesso } from './utils/resposta.js';

dotenv.config();

const app = express();

// CORS: define quais sites (frontends) podem chamar a API. Configurado no .env (CORS_ORIGIN).
const origensPermitidas = (process.env.CORS_ORIGIN || '*').split(',').map((o) => o.trim());
app.use(
  cors({
    origin: origensPermitidas.includes('*') ? '*' : origensPermitidas,
    methods: ['GET'], // API somente leitura
  })
);

// Verifica se a API está no ar e se consegue falar com o banco.
app.get('/api/health', async (req, res, next) => {
  try {
    await pool.query('SELECT 1');
    return enviarSucesso(res, { status: 'ok', banco: 'conectado' });
  } catch (erro) {
    return next(erro);
  }
});

app.use('/api/horarios', horarioRoutes);
app.use('/api/turmas', turmaRoutes);
app.use('/api/professores', professorRoutes);
app.use('/api/salas', salaRoutes);

// Sempre por último: rota inexistente (404) e tratamento de erros.
app.use(tratarRotaNaoEncontrada);
app.use(tratarErros);

const PORTA = Number(process.env.PORT) || 3000;
app.listen(PORTA, () => {
  console.log(`API de horários rodando em http://localhost:${PORTA}/api`);
});

export default app;
