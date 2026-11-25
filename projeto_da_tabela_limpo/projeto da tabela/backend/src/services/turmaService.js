// Camada de serviço: consulta ao banco (somente SELECT).
import pool from '../config/database.js';

export async function listarTurmas() {
  const [linhas] = await pool.execute(
    'SELECT id_turma AS id, nome FROM turmas ORDER BY id_turma'
  );
  return linhas;
}
