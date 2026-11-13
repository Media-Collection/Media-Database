
INSERT INTO midia(tipo) VALUES
('DVD'),
('Blu-ray'),
('VHS'),
('4K UHD'),
('UMD');

INSERT INTO regiao(regiao) VALUES
('EN-US'),
('PT-BR');

INSERT INTO local_compra(local) VALUES
('Sebo'),
('Bazar'),
('Outros');

DESC local_compra;

SELECT * FROM regiao;
SELECT * FROM midia;
SELECT * FROM genero;
SELECT * FROM filme;
SELECT * FROM filme_genero;
select * from usuario;

INSERT INTO filmes VALUES(23, 'Whatever', '1992-10-29');
INSERT INTO filme_genero VALUES(23, 12);
INSERT INTO poster VALUES(23,'path',23);

SELECT titulo, nome_genero FROM filme
JOIN filme_genero ON filme_genero.fk_filme = filme.idFilme
JOIN titulo ON filme.idFilme = titulo.fk_filme
JOIN genero ON genero.idGenero = filme_genero.fk_genero
WHERE fk_regiao = 1;

SELECT titulo.titulo, dt_lancamento, popularidade FROM filme
JOIN titulo ON filme.idFilme = titulo.fk_filme
JOIN regiao ON idRegiao = fk_regiao
WHERE fk_regiao = 1
ORDER BY popularidade DESC;

SELECT titulo.titulo, regiao, dt_lancamento, popularidade FROM filme
JOIN titulo ON filme.idFilme = titulo.fk_filme
JOIN regiao ON idRegiao = fk_regiao
WHERE titulo LIKE '%friday the%'
ORDER BY titulo;

SELECT COUNT(titulo) FROM titulo;

SELECT * FROM titulo;
SELECT MAX(dt_lancamento) FROM filme;
SELECT MAX(idFilme) FROM filme;

DROP DATABASE collect_physical;
SELECT * FROM filmes WHERE titulo LIKE '%the%';
DESC filmes;
DESC poster;



CREATE TABLE IF NOT EXISTS usuario(
	idUsuario INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(45),
    email VARCHAR(45) NOT NULL UNIQUE,
    senha VARCHAR(45) NOT NULL,
    dt_criacao DATETIME DEFAULT CURRENT_TIMESTAMP(),
    fk_colecao INT,
    FOREIGN KEY (fk_colecao) REFERENCES colecao(idColecao)
);

INSERT INTO usuario(username,email,senha,dt_criacao) VALUES
('lucas', 'lucas@gmail', 123123, DEFAULT);

INSERT INTO colecao(descricao) VALUES
('Coleção Principal');

SELECT idUsuario FROM usuario WHERE email = 'lucas@gmail';
SELECT * FROM usuario;

-- Selecionar todos os filmes baseado em uma pesquisa e limite
SELECT DISTINCT idFilme, path, titulo, dt_lancamento, popularidade, regiao.regiao FROM filme
JOIN poster ON filme.idFilme = poster.fk_filme
JOIN titulo ON filme.idFilme = titulo.fk_filme
JOIN regiao ON idRegiao = titulo.fk_regiao AND idRegiao = poster.fk_regiao
WHERE (titulo.fk_regiao = 1) AND titulo LIKE '%glo%'
ORDER BY popularidade DESC
LIMIT 12, 20;

-- Selecionar todos os filmes de uma coleção
SELECT DISTINCT idFilme, path, titulo, filme.dt_lancamento, popularidade, regiao.regiao FROM filme
JOIN poster ON filme.idFilme = poster.fk_filme
JOIN titulo ON filme.idFilme = titulo.fk_filme
JOIN regiao ON idRegiao = titulo.fk_regiao AND idRegiao = poster.fk_regiao
JOIN lancamento ON lancamento.fk_filme = idFilme
JOIN compra ON fk_lancamento = lancamento.idLancamento
JOIN colecao ON fk_colecao = colecao.idColecao
WHERE idColecao = 1 AND titulo.fk_regiao = 1 AND titulo LIKE '%saw%'
ORDER BY popularidade DESC
LIMIT 14;

-- Inserts das compras na coleção
INSERT INTO lancamento(fk_filme, fk_midia) VALUES
('180', 1);

INSERT INTO compra VALUES (1, '2026-11-13', 25.99, 1, 8);
DESC compra;
        
SELECT * FROM colecao;
SELECT * FROM regiao;
        

SELECT idUsuario, username, email, fk_colecao as colecaoId FROM usuario WHERE email = 'teste12@teste12.com' AND senha = '123123';

UPDATE usuario SET fk_colecao = 1 WHERE idUsuario = 1;
DESC usuario;
TRUNCATE usuario;

SELECT * FROM colecao;
DELETE FROM colecao WHERE idColecao = 1;

INSERT IGNORE INTO filme VALUES(11202, '1970-01-25', 11.4978);
INSERT IGNORE INTO poster(path, fk_filme, fk_regiao) VALUES('/wxDAG0bWf7ytbE1tmR5iN8v2Zdf.jpg', 11202, 2),('/rLM7jIEPTjj4CF7F1IrzzNjLUCu.jpg', 11202, 1);
INSERT IGNORE INTO titulo(titulo, fk_filme, fk_regiao) VALUES('Patton', 11202, 1);
INSERT IGNORE INTO titulo(titulo, fk_filme, fk_regiao) VALUES('Patton, Rebelde ou Herói?', 11202, 2);