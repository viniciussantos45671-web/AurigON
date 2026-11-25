// Camada de serviço: consulta ao banco (somente SELECT).
import pool from '../config/database.js';

export async function listarSalas() {
  const [linhas] = await pool.execute(
    'SELECT id_sala AS id, nome, tipo FROM salas ORDER BY tipo, id_sala'
  );
  return linhas;
}
