// Camada de serviço: consulta ao banco (somente SELECT).
import pool from '../config/database.js';

export async function listarProfessores() {
  const [linhas] = await pool.execute(
    'SELECT id_professor AS id, nome FROM professores ORDER BY nome'
  );
  return linhas;
}
