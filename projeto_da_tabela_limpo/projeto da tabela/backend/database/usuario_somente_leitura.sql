-- Usuário MySQL com permissão apenas de leitura (SELECT) para a API.
-- Execute como administrador (root) depois de criar o banco "aulastabela".
-- Troque a senha antes de usar e coloque o mesmo valor em DB_PASSWORD no .env.

CREATE USER IF NOT EXISTS 'horarios_ro'@'localhost' IDENTIFIED BY 'troque_esta_senha';
GRANT SELECT ON aulastabela.* TO 'horarios_ro'@'localhost';
FLUSH PRIVILEGES;
