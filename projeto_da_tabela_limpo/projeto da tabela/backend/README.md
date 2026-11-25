# API de Horários Escolares

Backend somente leitura (Node.js + Express + MySQL2) do Hackathon Prolongado de Banco de Dados 2.
Consulta a grade horária do curso de Desenvolvimento de Sistemas (6 turmas) no banco `aulastabela`.

## Como executar

1. Rode o script `tabela_aulas_ds.sql` no MySQL (cria o banco e popula os dados).
2. (Recomendado) Rode `database/usuario_somente_leitura.sql` para criar um usuário com permissão só de SELECT.
3. Copie `.env.example` para `.env` e preencha `DB_USER`, `DB_PASSWORD` e `DB_NAME`.
4. Instale e inicie:

```bash
npm install
npm run dev      # desenvolvimento (nodemon)
npm start        # produção
```

## Estrutura

```
src/
├── config/database.js        pool de conexões MySQL2 (lê o .env)
├── routes/                   define as URLs e chama os controllers
├── controllers/              recebe a requisição, valida e devolve a resposta
├── services/                 consultas SQL (parametrizadas) ao banco
├── middlewares/tratadorErros.js  tratamento centralizado de erros e rota 404
├── utils/resposta.js         respostas JSON padronizadas e ErroApp
├── utils/validadores.js      validação dos parâmetros de filtro
└── app.js                    configuração do Express e inicialização
```

## Modelo do banco utilizado

| Tabela | Chave primária | Observações |
|---|---|---|
| turmas | id_turma | nome |
| professores | id_professor | nome |
| disciplinas | id_disciplina | nome |
| salas | id_sala | nome, tipo (`Sala` ou `Laboratório`) |
| dias_aula | id_dia | 1=Segunda ... 5=Sexta |
| grade_horaria | (turma_id, grupo, dia_id, hora_inicio) | FKs para as 5 tabelas acima; `professor_id` pode ser NULL; `grupo` = A, B ou Inteira |

A consulta de horários faz `JOIN` de `grade_horaria` com turmas, dias_aula, disciplinas e salas, e `LEFT JOIN` com professores (aulas sem professor continuam aparecendo).

## Endpoints

| Método | Rota | Descrição |
|---|---|---|
| GET | /api/health | Verifica API e conexão com o banco |
| GET | /api/horarios | Lista horários, com filtros opcionais e combináveis |
| GET | /api/horarios/completo | Grade completa agrupada por turma → dia → aulas |
| GET | /api/turmas | Lista turmas |
| GET | /api/professores | Lista professores |
| GET | /api/salas | Lista salas e laboratórios |

### Filtros de `/api/horarios`

| Parâmetro | Valor | Exemplo |
|---|---|---|
| turma | id da turma | `?turma=2` |
| professor | id do professor | `?professor=5` |
| dia | segunda, terca, quarta, quinta, sexta (ou 1 a 5) | `?dia=segunda` |
| sala | id da sala/laboratório | `?sala=19` |
| grupo | A, B ou Inteira | `?grupo=A` |

Filtros podem ser combinados: `/api/horarios?turma=2&professor=5&dia=segunda`.

### Formato das respostas

```json
{ "sucesso": true, "total": 2, "dados": [ { "turma": "1º DA", "grupo": "A", "dia": "Segunda",
  "hora_inicio": "07:00", "hora_fim": "07:50", "disciplina": "BD",
  "professor": "Tiago G. Pascotto", "sala": "Sala 1", "tipo_sala": "Sala", "...": "ids" } ] }
```

Erros: `{ "sucesso": false, "erro": "mensagem" }`

| Código | Quando |
|---|---|
| 200 | Consulta realizada (lista vazia quando nada é encontrado) |
| 400 | Parâmetro inválido (ex.: `?dia=domingo`, `?turma=abc`) |
| 404 | Rota inexistente |
| 500 | Erro interno (detalhes só no log do servidor) |

## Segurança

- Todas as consultas usam parâmetros (`?`), o que evita SQL Injection.
- Credenciais ficam no `.env` (fora do Git).
- Usuário do banco com apenas `SELECT`; a API só expõe rotas GET.
- CORS configurável por `CORS_ORIGIN`.
- Erros internos não expõem detalhes ao cliente.

## Como testar

```bash
curl http://localhost:3000/api/health
curl http://localhost:3000/api/turmas
curl "http://localhost:3000/api/horarios?turma=1&dia=segunda"
curl "http://localhost:3000/api/horarios?sala=19"
curl http://localhost:3000/api/horarios/completo
curl "http://localhost:3000/api/horarios?dia=domingo"   # deve retornar 400
```
