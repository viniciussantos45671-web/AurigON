// Camada de serviço: aqui ficam as consultas SQL ao banco. Não conhece req/res (HTTP).
import pool from '../config/database.js';

// Consulta base: junta a grade_horaria com todas as tabelas relacionadas.
// professores usa LEFT JOIN porque professor_id pode ser NULL (aulas sem professor, ex.: Educação Física).
// TIME_FORMAT deixa o horário como "07:00" em vez de "07:00:00".
const SELECT_HORARIOS = `
  SELECT
    t.id_turma      AS turma_id,
    t.nome          AS turma,
    g.grupo,
    dd.id_dia       AS dia_id,
    dd.nome         AS dia,
    TIME_FORMAT(g.hora_inicio, '%H:%i') AS hora_inicio,
    TIME_FORMAT(g.hora_fim, '%H:%i')    AS hora_fim,
    d.id_disciplina AS disciplina_id,
    d.nome          AS disciplina,
    p.id_professor  AS professor_id,
    p.nome          AS professor,
    s.id_sala       AS sala_id,
    s.nome          AS sala,
    s.tipo          AS tipo_sala
  FROM grade_horaria g
  JOIN turmas t        ON t.id_turma = g.turma_id
  JOIN dias_aula dd    ON dd.id_dia = g.dia_id
  JOIN disciplinas d   ON d.id_disciplina = g.disciplina_id
  JOIN salas s         ON s.id_sala = g.sala_id
  LEFT JOIN professores p ON p.id_professor = g.professor_id
`;

// Ordem cronológica: turma, dia da semana, horário e grupo.
const ORDENACAO = 'ORDER BY t.id_turma, g.dia_id, g.hora_inicio, g.grupo';

// Cada filtro possível e a condição SQL correspondente.
// O valor nunca é colocado direto no texto do SQL: vai como parâmetro (?), o que evita SQL Injection.
const CONDICOES = {
  turma: 'g.turma_id = ?',
  professor: 'g.professor_id = ?',
  dia: 'g.dia_id = ?',
  sala: 'g.sala_id = ?',
  grupo: 'g.grupo = ?',
};

// Busca horários aplicando apenas os filtros que foram informados (todos opcionais e combináveis).
export async function buscarHorarios(filtros = {}) {
  const condicoes = [];
  const valores = [];

  for (const [campo, condicao] of Object.entries(CONDICOES)) {
    if (filtros[campo] !== undefined) {
      condicoes.push(condicao);
      valores.push(filtros[campo]);
    }
  }

  const where = condicoes.length ? `WHERE ${condicoes.join(' AND ')}` : '';
  const [linhas] = await pool.execute(`${SELECT_HORARIOS} ${where} ${ORDENACAO}`, valores);
  return linhas;
}

// Grade completa organizada em: turma -> dias -> aulas (em ordem de horário).
// Facilita para o frontend montar a tabela semanal de cada turma.
export async function buscarGradeCompleta() {
  const aulas = await buscarHorarios();
  const turmas = new Map();

  for (const aula of aulas) {
    if (!turmas.has(aula.turma_id)) {
      turmas.set(aula.turma_id, { turma_id: aula.turma_id, turma: aula.turma, dias: new Map() });
    }
    const turma = turmas.get(aula.turma_id);

    if (!turma.dias.has(aula.dia_id)) {
      turma.dias.set(aula.dia_id, { dia_id: aula.dia_id, dia: aula.dia, aulas: [] });
    }

    // Remove da aula os dados de turma e dia, que já estão no nível acima.
    const { turma_id, turma: _turma, dia_id, dia: _dia, ...dadosDaAula } = aula;
    turma.dias.get(aula.dia_id).aulas.push(dadosDaAula);
  }

  return [...turmas.values()].map((turma) => ({
    ...turma,
    dias: [...turma.dias.values()],
  }));
}
