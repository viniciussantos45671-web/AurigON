-- CRIAR O BANCO DE DADOS E POSTERIORMENTE CADA ENTIDADE

CREATE DATABASE aulastabela;
USE aulastabela;

-- CRIAR AS ENTIDADES QUE PEDIU, E AS INFORMAÇÕES NECESSARIAS DENTRO DE CADA UM

CREATE TABLE turmas (
    id_turma INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE professores (
    id_professor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE disciplinas (
    id_disciplina INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL UNIQUE
);

--  O ENUM SÓ ACEITA SALA/LABORATORIO
CREATE TABLE salas (
    id_sala INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL UNIQUE,
    tipo ENUM('Sala','Laboratório') NOT NULL DEFAULT 'Sala'
);

CREATE TABLE dias_aula (
    id_dia TINYINT PRIMARY KEY,
    nome VARCHAR(15) NOT NULL UNIQUE
);

-- LIGA AS TABELAS ACIMA

CREATE TABLE grade_horaria (
    turma_id INT NOT NULL,
    -- AQUI PODE DIVIDIR TURMA A, B, OU A SALA INTEIRA
    grupo ENUM('A','B','Inteira') NOT NULL DEFAULT 'Inteira',
    -- TEM AULAS SEM PROFESSOR, ENTÃO PODE SER NULL
    professor_id INT NULL,
    disciplina_id INT NOT NULL,
    sala_id INT NOT NULL,
    dia_id TINYINT NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fim TIME NOT NULL,

    FOREIGN KEY (turma_id) REFERENCES turmas(id_turma),
    FOREIGN KEY (professor_id) REFERENCES professores(id_professor),
    FOREIGN KEY (disciplina_id) REFERENCES disciplinas(id_disciplina),
    FOREIGN KEY (sala_id) REFERENCES salas(id_sala),
    FOREIGN KEY (dia_id) REFERENCES dias_aula(id_dia),

    CHECK (hora_fim > hora_inicio),
    PRIMARY KEY (turma_id, grupo, dia_id, hora_inicio),
    
    -- deixar cada um unico ai, pra evitar repetição que não faz sentido 
    UNIQUE (professor_id, dia_id, hora_inicio),
    
    UNIQUE (sala_id, dia_id, hora_inicio)
);

-- AQUI IREI ADICIONAR OS DADOS/INFORMAÇÕES DA TABELA DA ETEC PRO BANCO DE DADOS

INSERT INTO turmas (nome) VALUES
    ('1º DA'),
    ('2º DA'),
    ('3º DA'),
    ('1º DB'),
    ('2º DB'),
    ('3º DB');

INSERT INTO professores (nome) VALUES
('Tiago G. Pascotto'),
('Danilo K. dos S. Araujo'),
('Joao E. T. Martins'),
('Bruno Cano'),
('Silvio A. Pêra'),
('Vanessa A. G. Giron'),
('Aleteia V. M. Souto'),
('Célide T. da Silva'),
('Talyta C. A. Rubio'),
('Cassio M. L. de Aquino'),
('Paola C. de Oliveira'),
('Lara C. Dable'),
('Sandra R. S. de Oliveira'),
('Marcelo P. Brot'),
('Jose A. de Campo'),
('Fernanda C. Medeiros'),
('Ricardo F. Palhares'),
('Vinicius B. M. Guidio'),
('Renata F. Ferrari'),
('Andre S. Maia'),
('Henrique D. Pastor'),
('Marcos V. R. Vital'),
('Vivaldo R. Silva'),
('Maria de L. B. Fuentes'),
('Davi Vilar'),
('Joao P. T. de Siles'),
('Marilene A. Viana'),
('Ruth do Carmo'),
('Regina C. P. Ramos'),
('Moyses B. Filho'),
('Leandro B. de Souza'),
('Juarez B. de S. Junior'),
('Alícia V. Lima'),
('Gustavo M. G. Martins'),
('Luis T. V. Festino'),
('Marcio Bergamin'),
('Fabiano de A. Machado'),
('Raphael de A. N. Gomes'),
('Veruska M. de Sousa'),
('Miriam F. R. Couto'),
('Marcelo P. Broti'),
('Rhanyel E. A. R. G. de Lima'),
('Valdeci B. Mangianelli'),
('Ricardo S. Arruda'),
('Gabriel P. de G. Alves'),
('Luiz A. de Lima'),
('Jose A. do Amaral');

INSERT INTO disciplinas (nome) VALUES
    ('Matemática'),
    ('Português'),
    ('História'),
    ('Geografia'),
    ('Ciências'),
    ('Inglês'),
    ('Educação Física'),
    ('Artes'),
    ('BD'),
    ('PTIC'),
    ('SEIT'),
    ('quimica'),
    ('LI'),
    ('biologia'),
    ('PA'),
    ('CPRT'),
    ('fisica'),
    ('PW'),
    ('DS'),
    ('etica'),
    ('PAM'),
    ('IPSSI'),
    ('filosofia'),
    ('SE'),
    ('PAM II'),
    ('QTS'),
    ('PDTCC'),
    ('sociologia'),
    ('PWII'),
    ('PWIII'),
    ('BDII'),
    ('ECO');

INSERT INTO salas (nome, tipo) VALUES
    ('Sala 1', 'Sala'),
    ('Sala 2', 'Sala'),
    ('Sala 3', 'Sala'),
    ('Sala 4', 'Sala'),
    ('Sala 5', 'Sala'),
    ('Sala 6', 'Sala'),
    ('Sala 7', 'Sala'),
    ('Sala 8', 'Sala'),
    ('Sala 9', 'Sala'),
    ('Sala 10', 'Sala'),
    ('Sala 11', 'Sala'),
    ('Sala 12', 'Sala'),
    ('Sala 13', 'Sala'),
    ('Sala 14', 'Sala'),
    ('Sala 15', 'Sala'),
    ('Sala 16', 'Sala'),
    ('Sala 17', 'Sala'),
    ('Sala 18', 'Sala'),
    ('lab 1', 'Laboratório'),
    ('lab 2', 'Laboratório'),
    ('lab 3', 'Laboratório'),
    ('lab 4', 'Laboratório'),
    ('lab 5', 'Laboratório'),
    ('lab 6', 'Laboratório'),
    ('lab 7', 'Laboratório'),
    ('lab 8', 'Laboratório'),
    ('sala intermediaria', 'Sala'),
    ('sala terrea', 'Sala');

INSERT INTO dias_aula (id_dia, nome) VALUES
    (1, 'Segunda'),
    (2, 'Terça'),
    (3, 'Quarta'),
    (4, 'Quinta'),
    (5, 'Sexta');

-- tabela temporaria pra uma conexão entre os dados que aqui colocamos e o id, ou seja, organizar cada dado onde deve estar
-- armazenando os dados gerais dos horarios por agora
 
CREATE TEMPORARY TABLE grade_nomes (
    turma VARCHAR(50),
    grupo VARCHAR(10),
    professor VARCHAR(100),
    disciplina VARCHAR(100),
    sala VARCHAR(50),
    dia VARCHAR(15),
    hora_inicio TIME,
    hora_fim TIME
);

 -- vamos inserir todas os dados da tabela pra cá
 
INSERT INTO grade_nomes (turma, grupo, professor, disciplina, sala, dia, hora_inicio, hora_fim) VALUES
    -- 1º DA
    ('1º DA', 'A', 'Tiago G. Pascotto', 'BD', 'Sala 1', 'Segunda', '07:00', '07:50'),
    ('1º DA', 'B', 'Danilo K. dos S. Araujo', 'BD', 'lab 1', 'Segunda', '07:00', '07:50'),
    ('1º DA', 'A', 'Tiago G. Pascotto', 'BD', 'Sala 1', 'Segunda', '07:50', '08:40'),
    ('1º DA', 'B', 'Danilo K. dos S. Araujo', 'BD', 'lab 1', 'Segunda', '07:50', '08:40'),
    ('1º DA', 'Inteira', 'Joao E. T. Martins', 'Matemática', 'Sala 1', 'Segunda', '08:40', '09:30'),
    ('1º DA', 'Inteira', 'Joao E. T. Martins', 'Matemática', 'Sala 1', 'Segunda', '09:45', '10:35'),
    ('1º DA', 'Inteira', 'Bruno Cano', 'PTIC', 'Sala 1', 'Segunda', '10:35', '11:25'),
    ('1º DA', 'Inteira', 'Bruno Cano', 'PTIC', 'Sala 1', 'Segunda', '11:25', '12:15'),
    ('1º DA', 'Inteira', 'Silvio A. Pêra', 'História', 'Sala 1', 'Terça', '07:00', '07:50'),
    ('1º DA', 'Inteira', 'Silvio A. Pêra', 'História', 'Sala 1', 'Terça', '07:50', '08:40'),
    ('1º DA', 'Inteira', 'Vanessa A. G. Giron', 'Português', 'Sala 1', 'Terça', '08:40', '09:30'),
    ('1º DA', 'Inteira', 'Vanessa A. G. Giron', 'Português', 'Sala 1', 'Terça', '09:45', '10:35'),
    ('1º DA', 'A', 'Aleteia V. M. Souto', 'SEIT', 'Sala 1', 'Terça', '10:35', '11:25'),
    ('1º DA', 'B', 'Célide T. da Silva', 'SEIT', 'lab 1', 'Terça', '10:35', '11:25'),
    ('1º DA', 'A', 'Aleteia V. M. Souto', 'SEIT', 'Sala 1', 'Terça', '11:25', '12:15'),
    ('1º DA', 'B', 'Célide T. da Silva', 'SEIT', 'lab 1', 'Terça', '11:25', '12:15'),
    ('1º DA', 'Inteira', 'Talyta C. A. Rubio', 'Artes', 'Sala 1', 'Quarta', '07:00', '07:50'),
    ('1º DA', 'Inteira', 'Talyta C. A. Rubio', 'Artes', 'Sala 1', 'Quarta', '07:50', '08:40'),
    ('1º DA', 'Inteira', 'Cassio M. L. de Aquino', 'Geografia', 'Sala 1', 'Quarta', '08:40', '09:30'),
    ('1º DA', 'Inteira', 'Cassio M. L. de Aquino', 'Geografia', 'Sala 1', 'Quarta', '09:45', '10:35'),
    ('1º DA', 'Inteira', 'Paola C. de Oliveira', 'quimica', 'Sala 1', 'Quarta', '10:35', '11:25'),
    ('1º DA', 'Inteira', 'Paola C. de Oliveira', 'quimica', 'Sala 1', 'Quarta', '11:25', '12:15'),
    ('1º DA', 'Inteira', 'Lara C. Dable', 'LI', 'Sala 1', 'Quinta', '07:00', '07:50'),
    ('1º DA', 'Inteira', 'Lara C. Dable', 'LI', 'Sala 1', 'Quinta', '07:50', '08:40'),
    ('1º DA', 'Inteira', 'Sandra R. S. de Oliveira', 'biologia', 'Sala 1', 'Quinta', '08:40', '09:30'),
    ('1º DA', 'A', 'Tiago G. Pascotto', 'PA', 'Sala 1', 'Quinta', '09:45', '10:35'),
    ('1º DA', 'B', 'Aleteia V. M. Souto', 'PA', 'lab 1', 'Quinta', '09:45', '10:35'),
    ('1º DA', 'A', 'Tiago G. Pascotto', 'PA', 'Sala 1', 'Quinta', '10:35', '11:25'),
    ('1º DA', 'B', 'Aleteia V. M. Souto', 'PA', 'lab 1', 'Quinta', '10:35', '11:25'),
    ('1º DA', 'A', 'Tiago G. Pascotto', 'PA', 'Sala 1', 'Quinta', '11:25', '12:15'),
    ('1º DA', 'B', 'Aleteia V. M. Souto', 'PA', 'lab 1', 'Quinta', '11:25', '12:15'),
    ('1º DA', 'Inteira', 'Marcelo P. Broti', 'CPRT', 'Sala 1', 'Quinta', '14:40', '15:30'),
    ('1º DA', 'Inteira', 'Jose A. de Campo', 'fisica', 'Sala 1', 'Sexta', '07:00', '07:50'),
    ('1º DA', 'Inteira', 'Jose A. de Campo', 'fisica', 'Sala 1', 'Sexta', '07:50', '08:40'),
    ('1º DA', 'Inteira', 'Sandra R. S. de Oliveira', 'biologia', 'Sala 1', 'Sexta', '08:40', '09:30'),
    ('1º DA', 'Inteira', 'Tiago G. Pascotto', 'PW', 'Sala 1', 'Sexta', '09:45', '10:35'),
    ('1º DA', 'Inteira', 'Tiago G. Pascotto', 'PW', 'Sala 1', 'Sexta', '10:35', '11:25'),
    ('1º DA', 'Inteira', 'Tiago G. Pascotto', 'PW', 'Sala 1', 'Sexta', '11:25', '12:15'),
    ('1º DA', 'Inteira', NULL, 'Educação Física', 'Sala 1', 'Sexta', '13:15', '14:05'),
    ('1º DA', 'Inteira', NULL, 'Educação Física', 'Sala 1', 'Sexta', '14:05', '14:55'),
    -- 2º DA
    ('2º DA', 'A', 'Davi Vilar', 'DS', 'Sala 2', 'Segunda', '07:00', '07:50'),
    ('2º DA', 'B', 'Joao P. T. de Siles', 'DS', 'lab 2', 'Segunda', '07:00', '07:50'),
    ('2º DA', 'A', 'Davi Vilar', 'DS', 'Sala 2', 'Segunda', '07:50', '08:40'),
    ('2º DA', 'B', 'Joao P. T. de Siles', 'DS', 'lab 2', 'Segunda', '07:50', '08:40'),
    ('2º DA', 'A', 'Davi Vilar', 'DS', 'Sala 2', 'Segunda', '08:40', '09:30'),
    ('2º DA', 'B', 'Joao P. T. de Siles', 'DS', 'lab 2', 'Segunda', '08:40', '09:30'),
    ('2º DA', 'Inteira', 'Marilene A. Viana', 'ECO', 'Sala 2', 'Segunda', '09:45', '10:35'),
    ('2º DA', 'Inteira', 'Ruth do Carmo', 'Português', 'Sala 2', 'Segunda', '10:35', '11:25'),
    ('2º DA', 'Inteira', 'Ruth do Carmo', 'Português', 'Sala 2', 'Segunda', '11:25', '12:15'),
    ('2º DA', 'A', 'Tiago G. Pascotto', 'PWII', 'Sala 2', 'Terça', '07:00', '07:50'),
    ('2º DA', 'B', 'Célide T. da Silva', 'PWII', 'lab 2', 'Terça', '07:00', '07:50'),
    ('2º DA', 'A', 'Tiago G. Pascotto', 'PWII', 'Sala 2', 'Terça', '07:50', '08:40'),
    ('2º DA', 'B', 'Célide T. da Silva', 'PWII', 'lab 2', 'Terça', '07:50', '08:40'),
    ('2º DA', 'Inteira', 'Silvio A. Pêra', 'História', 'Sala 2', 'Terça', '08:40', '09:30'),
    ('2º DA', 'Inteira', 'Silvio A. Pêra', 'História', 'Sala 2', 'Terça', '09:45', '10:35'),
    ('2º DA', 'Inteira', 'Regina C. P. Ramos', 'Educação Física', 'Sala 2', 'Terça', '10:35', '11:25'),
    ('2º DA', 'Inteira', 'Regina C. P. Ramos', 'Educação Física', 'Sala 2', 'Terça', '11:25', '12:15'),
    ('2º DA', 'Inteira', 'Sandra R. S. de Oliveira', 'biologia', 'Sala 2', 'Quarta', '07:00', '07:50'),
    ('2º DA', 'Inteira', 'Sandra R. S. de Oliveira', 'biologia', 'Sala 2', 'Quarta', '07:50', '08:40'),
    ('2º DA', 'Inteira', 'Joao E. T. Martins', 'Matemática', 'Sala 2', 'Quarta', '08:40', '09:30'),
    ('2º DA', 'Inteira', 'Ruth do Carmo', 'Português', 'Sala 2', 'Quarta', '09:45', '10:35'),
    ('2º DA', 'Inteira', 'Moyses B. Filho', 'quimica', 'Sala 2', 'Quarta', '10:35', '11:25'),
    ('2º DA', 'Inteira', 'Moyses B. Filho', 'quimica', 'Sala 2', 'Quarta', '11:25', '12:15'),
    ('2º DA', 'Inteira', 'Moyses B. Filho', 'fisica', 'Sala 2', 'Quinta', '07:00', '07:50'),
    ('2º DA', 'Inteira', 'Moyses B. Filho', 'fisica', 'Sala 2', 'Quinta', '07:50', '08:40'),
    ('2º DA', 'Inteira', 'Joao E. T. Martins', 'Matemática', 'Sala 2', 'Quinta', '08:40', '09:30'),
    ('2º DA', 'Inteira', 'Joao E. T. Martins', 'Matemática', 'Sala 2', 'Quinta', '09:45', '10:35'),
    ('2º DA', 'A', 'Davi Vilar', 'BDII', 'Sala 2', 'Quinta', '10:35', '11:25'),
    ('2º DA', 'B', 'Célide T. da Silva', 'BDII', 'lab 2', 'Quinta', '10:35', '11:25'),
    ('2º DA', 'A', 'Davi Vilar', 'BDII', 'Sala 2', 'Quinta', '11:25', '12:15'),
    ('2º DA', 'B', 'Célide T. da Silva', 'BDII', 'lab 2', 'Quinta', '11:25', '12:15'),
    ('2º DA', 'Inteira', 'Leandro B. de Souza', 'Inglês', 'Sala 2', 'Sexta', '07:00', '07:50'),
    ('2º DA', 'Inteira', 'Leandro B. de Souza', 'Inglês', 'Sala 2', 'Sexta', '07:50', '08:40'),
    ('2º DA', 'A', 'Jose A. do Amaral', 'PAM', 'Sala 2', 'Sexta', '08:40', '09:30'),
    ('2º DA', 'B', 'Célide T. da Silva', 'PAM', 'lab 2', 'Sexta', '08:40', '09:30'),
    ('2º DA', 'A', 'Jose A. do Amaral', 'PAM', 'Sala 2', 'Sexta', '09:45', '10:35'),
    ('2º DA', 'B', 'Célide T. da Silva', 'PAM', 'lab 2', 'Sexta', '09:45', '10:35'),
    ('2º DA', 'Inteira', NULL, 'Geografia', 'Sala 2', 'Sexta', '10:35', '11:25'),
    ('2º DA', 'Inteira', NULL, 'Geografia', 'Sala 2', 'Sexta', '11:25', '12:15'),
    -- 3º DA
    ('3º DA', 'A', 'Juarez B. de S. Junior', 'IPSSI', 'Sala 3', 'Segunda', '07:00', '07:50'),
    ('3º DA', 'B', 'Bruno Cano', 'IPSSI', 'lab 3', 'Segunda', '07:00', '07:50'),
    ('3º DA', 'A', 'Juarez B. de S. Junior', 'IPSSI', 'Sala 3', 'Segunda', '07:50', '08:40'),
    ('3º DA', 'B', 'Bruno Cano', 'IPSSI', 'lab 3', 'Segunda', '07:50', '08:40'),
    ('3º DA', 'Inteira', 'Sandra R. S. de Oliveira', 'biologia', 'Sala 3', 'Segunda', '08:40', '09:30'),
    ('3º DA', 'Inteira', 'Sandra R. S. de Oliveira', 'biologia', 'Sala 3', 'Segunda', '09:45', '10:35'),
    ('3º DA', 'Inteira', 'Alícia V. Lima', 'filosofia', 'Sala 3', 'Segunda', '10:35', '11:25'),
    ('3º DA', 'Inteira', 'Alícia V. Lima', 'filosofia', 'Sala 3', 'Segunda', '11:25', '12:15'),
    ('3º DA', 'Inteira', 'Gustavo M. G. Martins', 'Português', 'Sala 3', 'Terça', '07:00', '07:50'),
    ('3º DA', 'Inteira', 'Gustavo M. G. Martins', 'Português', 'Sala 3', 'Terça', '07:50', '08:40'),
    ('3º DA', 'Inteira', 'Aleteia V. M. Souto', 'SE', 'Sala 3', 'Terça', '08:40', '09:30'),
    ('3º DA', 'Inteira', 'Aleteia V. M. Souto', 'SE', 'Sala 3', 'Terça', '09:45', '10:35'),
    ('3º DA', 'Inteira', 'Joao E. T. Martins', 'Matemática', 'Sala 3', 'Terça', '10:35', '11:25'),
    ('3º DA', 'Inteira', 'Joao E. T. Martins', 'Matemática', 'Sala 3', 'Terça', '11:25', '12:15'),
    ('3º DA', 'Inteira', 'Joao P. T. de Siles', 'PAM II', 'Sala 3', 'Quarta', '07:00', '07:50'),
    ('3º DA', 'Inteira', 'Joao P. T. de Siles', 'PAM II', 'Sala 3', 'Quarta', '07:50', '08:40'),
    ('3º DA', 'Inteira', 'Luis T. V. Festino', 'Geografia', 'Sala 3', 'Quarta', '08:40', '09:30'),
    ('3º DA', 'Inteira', 'Luis T. V. Festino', 'Geografia', 'Sala 3', 'Quarta', '09:45', '10:35'),
    ('3º DA', 'A', 'Marcio Bergamin', 'QTS', 'Sala 3', 'Quarta', '10:35', '11:25'),
    ('3º DA', 'B', 'Tiago G. Pascotto', 'QTS', 'lab 3', 'Quarta', '10:35', '11:25'),
    ('3º DA', 'A', 'Marcio Bergamin', 'QTS', 'Sala 3', 'Quarta', '11:25', '12:15'),
    ('3º DA', 'B', 'Tiago G. Pascotto', 'QTS', 'lab 3', 'Quarta', '11:25', '12:15'),
    ('3º DA', 'A', 'Davi Vilar', 'PDTCC', 'Sala 3', 'Quinta', '07:00', '07:50'),
    ('3º DA', 'B', 'Célide T. da Silva', 'PDTCC', 'lab 3', 'Quinta', '07:00', '07:50'),
    ('3º DA', 'A', 'Davi Vilar', 'PDTCC', 'Sala 3', 'Quinta', '07:50', '08:40'),
    ('3º DA', 'B', 'Célide T. da Silva', 'PDTCC', 'lab 3', 'Quinta', '07:50', '08:40'),
    ('3º DA', 'A', 'Davi Vilar', 'PDTCC', 'Sala 3', 'Quinta', '08:40', '09:30'),
    ('3º DA', 'B', 'Célide T. da Silva', 'PDTCC', 'lab 3', 'Quinta', '08:40', '09:30'),
    ('3º DA', 'Inteira', 'Gustavo M. G. Martins', 'Português', 'Sala 3', 'Quinta', '09:45', '10:35'),
    ('3º DA', 'Inteira', 'Leandro B. de Souza', 'LI', 'Sala 3', 'Quinta', '10:35', '11:25'),
    ('3º DA', 'Inteira', 'Leandro B. de Souza', 'LI', 'Sala 3', 'Quinta', '11:25', '12:15'),
    ('3º DA', 'Inteira', 'Joao E. T. Martins', 'Matemática', 'Sala 3', 'Sexta', '07:00', '07:50'),
    ('3º DA', 'Inteira', 'Joao E. T. Martins', 'Matemática', 'Sala 3', 'Sexta', '07:50', '08:40'),
    ('3º DA', 'Inteira', 'Alícia V. Lima', 'sociologia', 'Sala 3', 'Sexta', '08:40', '09:30'),
    ('3º DA', 'Inteira', 'Alícia V. Lima', 'sociologia', 'Sala 3', 'Sexta', '09:45', '10:35'),
    ('3º DA', 'Inteira', 'Joao P. T. de Siles', 'PWIII', 'Sala 3', 'Sexta', '10:35', '11:25'),
    ('3º DA', 'Inteira', 'Joao P. T. de Siles', 'PWIII', 'Sala 3', 'Sexta', '11:25', '12:15'),
    -- 1º DB
    ('1º DB', 'Inteira', 'Fernanda C. Medeiros', 'biologia', 'Sala 4', 'Segunda', '13:00', '13:50'),
    ('1º DB', 'Inteira', 'Fernanda C. Medeiros', 'biologia', 'Sala 4', 'Segunda', '13:50', '14:40'),
    ('1º DB', 'Inteira', 'Ricardo F. Palhares', 'SEIT', 'Sala 4', 'Segunda', '14:40', '15:30'),
    ('1º DB', 'Inteira', 'Ricardo F. Palhares', 'SEIT', 'Sala 4', 'Segunda', '15:45', '16:35'),
    ('1º DB', 'Inteira', NULL, 'História', 'Sala 4', 'Segunda', '16:35', '17:25'),
    ('1º DB', 'Inteira', NULL, 'História', 'Sala 4', 'Segunda', '17:25', '18:15'),
    ('1º DB', 'Inteira', 'Marcelo P. Broti', 'CPRT', 'Sala 4', 'Terça', '09:45', '10:35'),
    ('1º DB', 'Inteira', 'Vinicius B. M. Guidio', 'Português', 'Sala 4', 'Terça', '13:00', '13:50'),
    ('1º DB', 'Inteira', 'Vinicius B. M. Guidio', 'Português', 'Sala 4', 'Terça', '13:50', '14:40'),
    ('1º DB', 'Inteira', 'Paola C. de Oliveira', 'quimica', 'Sala 4', 'Terça', '14:40', '15:30'),
    ('1º DB', 'Inteira', 'Paola C. de Oliveira', 'quimica', 'Sala 4', 'Terça', '15:45', '16:35'),
    ('1º DB', 'Inteira', 'Ricardo F. Palhares', 'PTIC', 'Sala 4', 'Terça', '16:35', '17:25'),
    ('1º DB', 'Inteira', 'Ricardo F. Palhares', 'PTIC', 'Sala 4', 'Terça', '17:25', '18:15'),
    ('1º DB', 'Inteira', 'Jose A. de Campo', 'fisica', 'Sala 4', 'Quarta', '13:00', '13:50'),
    ('1º DB', 'Inteira', 'Jose A. de Campo', 'fisica', 'Sala 4', 'Quarta', '13:50', '14:40'),
    ('1º DB', 'A', 'Renata F. Ferrari', 'BD', 'Sala 4', 'Quarta', '14:40', '15:30'),
    ('1º DB', 'B', 'Andre S. Maia', 'BD', 'lab 4', 'Quarta', '14:40', '15:30'),
    ('1º DB', 'A', 'Renata F. Ferrari', 'BD', 'Sala 4', 'Quarta', '15:45', '16:35'),
    ('1º DB', 'B', 'Andre S. Maia', 'BD', 'lab 4', 'Quarta', '15:45', '16:35'),
    ('1º DB', 'Inteira', NULL, 'Geografia', 'Sala 4', 'Quarta', '16:35', '17:25'),
    ('1º DB', 'Inteira', NULL, 'Geografia', 'Sala 4', 'Quarta', '17:25', '18:15'),
    ('1º DB', 'A', 'Andre S. Maia', 'PA', 'Sala 4', 'Quinta', '13:00', '13:50'),
    ('1º DB', 'B', 'Aleteia V. M. Souto', 'PA', 'lab 4', 'Quinta', '13:00', '13:50'),
    ('1º DB', 'A', 'Andre S. Maia', 'PA', 'Sala 4', 'Quinta', '13:50', '14:40'),
    ('1º DB', 'B', 'Aleteia V. M. Souto', 'PA', 'lab 4', 'Quinta', '13:50', '14:40'),
    ('1º DB', 'A', 'Andre S. Maia', 'PA', 'Sala 4', 'Quinta', '14:40', '15:30'),
    ('1º DB', 'B', 'Aleteia V. M. Souto', 'PA', 'lab 4', 'Quinta', '14:40', '15:30'),
    ('1º DB', 'A', 'Andre S. Maia', 'PW', 'Sala 4', 'Quinta', '15:45', '16:35'),
    ('1º DB', 'B', 'Henrique D. Pastor', 'PW', 'lab 4', 'Quinta', '15:45', '16:35'),
    ('1º DB', 'A', 'Andre S. Maia', 'PW', 'Sala 4', 'Quinta', '16:35', '17:25'),
    ('1º DB', 'B', 'Henrique D. Pastor', 'PW', 'lab 4', 'Quinta', '16:35', '17:25'),
    ('1º DB', 'A', 'Andre S. Maia', 'PW', 'Sala 4', 'Quinta', '17:25', '18:15'),
    ('1º DB', 'B', 'Henrique D. Pastor', 'PW', 'lab 4', 'Quinta', '17:25', '18:15'),
    ('1º DB', 'Inteira', NULL, 'Educação Física', 'Sala 4', 'Sexta', '10:20', '11:10'),
    ('1º DB', 'Inteira', NULL, 'Educação Física', 'Sala 4', 'Sexta', '11:10', '12:00'),
    ('1º DB', 'Inteira', 'Marcos V. R. Vital', 'LI', 'Sala 4', 'Sexta', '13:00', '13:50'),
    ('1º DB', 'Inteira', 'Marcos V. R. Vital', 'LI', 'Sala 4', 'Sexta', '13:50', '14:40'),
    ('1º DB', 'Inteira', 'Vivaldo R. Silva', 'Artes', 'Sala 4', 'Sexta', '14:40', '15:30'),
    ('1º DB', 'Inteira', 'Vivaldo R. Silva', 'Artes', 'Sala 4', 'Sexta', '15:45', '16:35'),
    ('1º DB', 'Inteira', 'Maria de L. B. Fuentes', 'Matemática', 'Sala 4', 'Sexta', '16:35', '17:25'),
    ('1º DB', 'Inteira', 'Maria de L. B. Fuentes', 'Matemática', 'Sala 4', 'Sexta', '17:25', '18:15'),
    -- 2º DB
    ('2º DB', 'Inteira', 'Fabiano de A. Machado', 'História', 'Sala 5', 'Segunda', '13:00', '13:50'),
    ('2º DB', 'Inteira', 'Fabiano de A. Machado', 'História', 'Sala 5', 'Segunda', '13:50', '14:40'),
    ('2º DB', 'Inteira', 'Gustavo M. G. Martins', 'Português', 'Sala 5', 'Segunda', '14:40', '15:30'),
    ('2º DB', 'Inteira', 'Joao E. T. Martins', 'Matemática', 'Sala 5', 'Segunda', '15:45', '16:35'),
    ('2º DB', 'Inteira', 'Raphael de A. N. Gomes', 'fisica', 'Sala 5', 'Segunda', '16:35', '17:25'),
    ('2º DB', 'Inteira', 'Raphael de A. N. Gomes', 'fisica', 'Sala 5', 'Segunda', '17:25', '18:15'),
    ('2º DB', 'A', 'Davi Vilar', 'BDII', 'Sala 5', 'Terça', '13:00', '13:50'),
    ('2º DB', 'B', 'Bruno Cano', 'BDII', 'lab 5', 'Terça', '13:00', '13:50'),
    ('2º DB', 'A', 'Davi Vilar', 'BDII', 'Sala 5', 'Terça', '13:50', '14:40'),
    ('2º DB', 'B', 'Bruno Cano', 'BDII', 'lab 5', 'Terça', '13:50', '14:40'),
    ('2º DB', 'A', 'Tiago G. Pascotto', 'PWII', 'Sala 5', 'Terça', '14:40', '15:30'),
    ('2º DB', 'B', 'Ricardo F. Palhares', 'PWII', 'lab 5', 'Terça', '14:40', '15:30'),
    ('2º DB', 'A', 'Tiago G. Pascotto', 'PWII', 'Sala 5', 'Terça', '15:45', '16:35'),
    ('2º DB', 'B', 'Ricardo F. Palhares', 'PWII', 'lab 5', 'Terça', '15:45', '16:35'),
    ('2º DB', 'Inteira', 'Joao E. T. Martins', 'Matemática', 'Sala 5', 'Terça', '16:35', '17:25'),
    ('2º DB', 'Inteira', 'Joao E. T. Martins', 'Matemática', 'Sala 5', 'Terça', '17:25', '18:15'),
    ('2º DB', 'Inteira', 'Veruska M. de Sousa', 'Inglês', 'Sala 5', 'Quarta', '13:00', '13:50'),
    ('2º DB', 'Inteira', 'Veruska M. de Sousa', 'Inglês', 'Sala 5', 'Quarta', '13:50', '14:40'),
    ('2º DB', 'Inteira', 'Marcio Bergamin', 'PAM', 'Sala 5', 'Quarta', '14:40', '15:30'),
    ('2º DB', 'Inteira', 'Marcio Bergamin', 'PAM', 'Sala 5', 'Quarta', '15:45', '16:35'),
    ('2º DB', 'Inteira', 'Miriam F. R. Couto', 'Geografia', 'Sala 5', 'Quarta', '16:35', '17:25'),
    ('2º DB', 'Inteira', 'Miriam F. R. Couto', 'Geografia', 'Sala 5', 'Quarta', '17:25', '18:15'),
    ('2º DB', 'A', 'Henrique D. Pastor', 'DS', 'Sala 5', 'Quinta', '13:00', '13:50'),
    ('2º DB', 'B', 'Ricardo F. Palhares', 'DS', 'lab 5', 'Quinta', '13:00', '13:50'),
    ('2º DB', 'A', 'Henrique D. Pastor', 'DS', 'Sala 5', 'Quinta', '13:50', '14:40'),
    ('2º DB', 'B', 'Ricardo F. Palhares', 'DS', 'lab 5', 'Quinta', '13:50', '14:40'),
    ('2º DB', 'A', 'Henrique D. Pastor', 'DS', 'Sala 5', 'Quinta', '14:40', '15:30'),
    ('2º DB', 'B', 'Ricardo F. Palhares', 'DS', 'lab 5', 'Quinta', '14:40', '15:30'),
    ('2º DB', 'Inteira', 'Marcelo P. Broti', 'ECO', 'Sala 5', 'Quinta', '15:45', '16:35'),
    ('2º DB', 'Inteira', 'Rhanyel E. A. R. G. de Lima', 'Educação Física', 'Sala 5', 'Quinta', '16:35', '17:25'),
    ('2º DB', 'Inteira', 'Rhanyel E. A. R. G. de Lima', 'Educação Física', 'Sala 5', 'Quinta', '17:25', '18:15'),
    ('2º DB', 'Inteira', 'Paola C. de Oliveira', 'quimica', 'Sala 5', 'Sexta', '13:00', '13:50'),
    ('2º DB', 'Inteira', 'Paola C. de Oliveira', 'quimica', 'Sala 5', 'Sexta', '13:50', '14:40'),
    ('2º DB', 'Inteira', 'Fernanda C. Medeiros', 'biologia', 'Sala 5', 'Sexta', '14:40', '15:30'),
    ('2º DB', 'Inteira', 'Fernanda C. Medeiros', 'biologia', 'Sala 5', 'Sexta', '15:45', '16:35'),
    ('2º DB', 'Inteira', 'Gustavo M. G. Martins', 'Português', 'Sala 5', 'Sexta', '16:35', '17:25'),
    ('2º DB', 'Inteira', 'Gustavo M. G. Martins', 'Português', 'Sala 5', 'Sexta', '17:25', '18:15'),
    -- 3º DB
    ('3º DB', 'A', 'Bruno Cano', 'SE', 'Sala 6', 'Segunda', '13:00', '13:50'),
    ('3º DB', 'B', 'Ricardo F. Palhares', 'SE', 'lab 6', 'Segunda', '13:00', '13:50'),
    ('3º DB', 'A', 'Bruno Cano', 'SE', 'Sala 6', 'Segunda', '13:50', '14:40'),
    ('3º DB', 'B', 'Ricardo F. Palhares', 'SE', 'lab 6', 'Segunda', '13:50', '14:40'),
    ('3º DB', 'Inteira', 'Valdeci B. Mangianelli', 'Geografia', 'Sala 6', 'Segunda', '14:40', '15:30'),
    ('3º DB', 'Inteira', 'Valdeci B. Mangianelli', 'Geografia', 'Sala 6', 'Segunda', '15:45', '16:35'),
    ('3º DB', 'Inteira', 'Joao E. T. Martins', 'Matemática', 'Sala 6', 'Segunda', '16:35', '17:25'),
    ('3º DB', 'Inteira', 'Joao E. T. Martins', 'Matemática', 'Sala 6', 'Segunda', '17:25', '18:15'),
    ('3º DB', 'A', 'Aleteia V. M. Souto', 'IPSSI', 'Sala 6', 'Terça', '13:00', '13:50'),
    ('3º DB', 'B', 'Célide T. da Silva', 'IPSSI', 'lab 6', 'Terça', '13:00', '13:50'),
    ('3º DB', 'A', 'Aleteia V. M. Souto', 'IPSSI', 'Sala 6', 'Terça', '13:50', '14:40'),
    ('3º DB', 'B', 'Célide T. da Silva', 'IPSSI', 'lab 6', 'Terça', '13:50', '14:40'),
    ('3º DB', 'Inteira', 'Fernanda C. Medeiros', 'biologia', 'Sala 6', 'Terça', '14:40', '15:30'),
    ('3º DB', 'Inteira', 'Fernanda C. Medeiros', 'biologia', 'Sala 6', 'Terça', '15:45', '16:35'),
    ('3º DB', 'Inteira', 'Ricardo S. Arruda', 'sociologia', 'Sala 6', 'Terça', '16:35', '17:25'),
    ('3º DB', 'Inteira', 'Ricardo S. Arruda', 'sociologia', 'Sala 6', 'Terça', '17:25', '18:15'),
    ('3º DB', 'A', 'Davi Vilar', 'PWIII', 'Sala 6', 'Quarta', '13:00', '13:50'),
    ('3º DB', 'B', 'Luiz A. de Lima', 'PWIII', 'lab 6', 'Quarta', '13:00', '13:50'),
    ('3º DB', 'A', 'Davi Vilar', 'PWIII', 'Sala 6', 'Quarta', '13:50', '14:40'),
    ('3º DB', 'B', 'Luiz A. de Lima', 'PWIII', 'lab 6', 'Quarta', '13:50', '14:40'),
    ('3º DB', 'A', 'Davi Vilar', 'QTS', 'Sala 6', 'Quarta', '14:40', '15:30'),
    ('3º DB', 'B', 'Luiz A. de Lima', 'QTS', 'lab 6', 'Quarta', '14:40', '15:30'),
    ('3º DB', 'A', 'Davi Vilar', 'QTS', 'Sala 6', 'Quarta', '15:45', '16:35'),
    ('3º DB', 'B', 'Luiz A. de Lima', 'QTS', 'lab 6', 'Quarta', '15:45', '16:35'),
    ('3º DB', 'Inteira', 'Joao E. T. Martins', 'Matemática', 'Sala 6', 'Quarta', '16:35', '17:25'),
    ('3º DB', 'Inteira', 'Joao E. T. Martins', 'Matemática', 'Sala 6', 'Quarta', '17:25', '18:15'),
    ('3º DB', 'Inteira', 'Vinicius B. M. Guidio', 'Português', 'Sala 6', 'Quinta', '13:00', '13:50'),
    ('3º DB', 'Inteira', 'Vinicius B. M. Guidio', 'Português', 'Sala 6', 'Quinta', '13:50', '14:40'),
    ('3º DB', 'Inteira', 'Vinicius B. M. Guidio', 'Português', 'Sala 6', 'Quinta', '14:40', '15:30'),
    ('3º DB', 'A', 'Davi Vilar', 'PDTCC', 'Sala 6', 'Quinta', '15:45', '16:35'),
    ('3º DB', 'B', 'Ricardo F. Palhares', 'PDTCC', 'lab 6', 'Quinta', '15:45', '16:35'),
    ('3º DB', 'A', 'Davi Vilar', 'PDTCC', 'Sala 6', 'Quinta', '16:35', '17:25'),
    ('3º DB', 'B', 'Ricardo F. Palhares', 'PDTCC', 'lab 6', 'Quinta', '16:35', '17:25'),
    ('3º DB', 'A', 'Davi Vilar', 'PDTCC', 'Sala 6', 'Quinta', '17:25', '18:15'),
    ('3º DB', 'B', 'Ricardo F. Palhares', 'PDTCC', 'lab 6', 'Quinta', '17:25', '18:15'),
    ('3º DB', 'A', 'Bruno Cano', 'PAM II', 'Sala 6', 'Sexta', '13:00', '13:50'),
    ('3º DB', 'B', 'Ricardo F. Palhares', 'PAM II', 'lab 6', 'Sexta', '13:00', '13:50'),
    ('3º DB', 'A', 'Bruno Cano', 'PAM II', 'Sala 6', 'Sexta', '13:50', '14:40'),
    ('3º DB', 'B', 'Ricardo F. Palhares', 'PAM II', 'lab 6', 'Sexta', '13:50', '14:40'),
    ('3º DB', 'Inteira', 'Alícia V. Lima', 'filosofia', 'Sala 6', 'Sexta', '14:40', '15:30'),
    ('3º DB', 'Inteira', 'Alícia V. Lima', 'filosofia', 'Sala 6', 'Sexta', '15:45', '16:35'),
    ('3º DB', 'Inteira', 'Veruska M. de Sousa', 'LI', 'Sala 6', 'Sexta', '16:35', '17:25'),
    ('3º DB', 'Inteira', 'Veruska M. de Sousa', 'LI', 'Sala 6', 'Sexta', '17:25', '18:15');

-- aqui conectamos dados de uma tabela em outra, dados relacionais, que aparecem em 2 tabelas

INSERT INTO grade_horaria (turma_id, grupo, professor_id, disciplina_id, sala_id, dia_id, hora_inicio, hora_fim)
SELECT t.id_turma, n.grupo, p.id_professor, d.id_disciplina, s.id_sala, dd.id_dia, n.hora_inicio, n.hora_fim
FROM grade_nomes n
JOIN turmas t        ON t.nome = n.turma
JOIN disciplinas d   ON d.nome = n.disciplina
JOIN salas s         ON s.nome = n.sala
JOIN dias_aula dd    ON dd.nome = n.dia
LEFT JOIN professores p ON p.nome = n.professor;

DROP TEMPORARY TABLE grade_nomes;

-- aqui pra ver a tabela com dados simplificados, ao inves dos ids

CREATE VIEW vw_grade_horaria AS
SELECT t.nome AS turma,
       g.grupo,
       dd.nome AS dia,
       g.hora_inicio,
       g.hora_fim,
       d.nome AS disciplina,
       p.nome AS professor,
       s.nome AS sala,
       s.tipo AS tipo_sala
FROM grade_horaria g
JOIN turmas t        ON t.id_turma = g.turma_id
JOIN dias_aula dd    ON dd.id_dia = g.dia_id
JOIN disciplinas d   ON d.id_disciplina = g.disciplina_id
JOIN salas s         ON s.id_sala = g.sala_id
LEFT JOIN professores p ON p.id_professor = g.professor_id
ORDER BY t.id_turma, g.dia_id, g.hora_inicio, g.grupo;


SELECT * FROM turmas;
SELECT * FROM professores;
SELECT * FROM disciplinas;
SELECT * FROM salas;
SELECT * FROM dias_aula;
SELECT * FROM vw_grade_horaria;

