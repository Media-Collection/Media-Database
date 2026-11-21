
INSERT INTO midia(tipo) VALUES
('DVD'), -- 1
('Blu-ray'), -- 2
('VHS'), -- 3
('4K UHD'), -- 4
('UMD'); -- 5

INSERT INTO regiao(regiao) VALUES
('EN-US'),
('PT-BR');

INSERT INTO local_compra(local) VALUES
('Sebo'), -- 1
('Bazar'), -- 2
('Outros'), -- 3
('Internet'), -- 4
('Presente'); -- 5

DESC local_compra;

SELECT * FROM regiao;
SELECT * FROM midia;
SELECT * FROM genero;
SELECT * FROM filme;
SELECT * FROM filme_genero;
SELECT * FROM usuario;
SELECT * FROM colecao;

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

SELECT DISTINCT idFilme, path, titulo, filme.dt_lancamento, popularidade, regiao.regiao FROM filme
JOIN poster ON filme.idFilme = poster.fk_filme
JOIN titulo ON filme.idFilme = titulo.fk_filme
JOIN regiao ON idRegiao = titulo.fk_regiao AND idRegiao = poster.fk_regiao
JOIN compra ON compra.fk_filme = filme.idFilme
JOIN colecao ON fk_colecao = idColecao
WHERE idColecao = 1 AND titulo.fk_regiao = 1 AND titulo LIKE '%saw%'
ORDER BY popularidade DESC
LIMIT 14;


SELECT idFilme, path, titulo, filme.dt_lancamento, popularidade, regiao.regiao, midia.tipo, preco FROM filme
JOIN poster ON filme.idFilme = poster.fk_filme
JOIN titulo ON filme.idFilme = titulo.fk_filme
JOIN regiao ON idRegiao = titulo.fk_regiao AND idRegiao = poster.fk_regiao
JOIN compra ON compra.fk_filme = filme.idFilme
JOIN colecao ON fk_colecao = colecao.idColecao
JOIN midia ON fk_midia = midia.idMidia
WHERE idColecao = 1 -- AND titulo.fk_regiao = 1 AND titulo like '%${search}%'
ORDER BY popularidade DESC
LIMIT 300;

SELECT * FROM compra WHERE fk_colecao = 1;

SELECT idFilme, path, titulo, dt_lancamento, popularidade, regiao.regiao FROM filme
JOIN poster ON filme.idFilme = poster.fk_filme
JOIN titulo ON filme.idFilme = titulo.fk_filme
JOIN regiao ON idRegiao = titulo.fk_regiao AND idRegiao = poster.fk_regiao
WHERE (titulo.fk_regiao = 1) -- AND titulo LIKE '%${search}%'
ORDER BY popularidade DESC
LIMIT 300;
        
-- Inserts das compras na coleção
-- INSERT INTO lancamento(fk_filme, fk_midia) VALUES ('176', 1);
INSERT INTO compra(fk_colecao, dt_compra, valor_compra, fk_local_compra, fk_midia, fk_filme) VALUES (1, '2026-11-13', 25.99, 1, 1, 176);
DESC compra;
     
-- Select de Gêneros para a dashboard
SELECT genero.nome_genero AS 'genero', COUNT(genero.idGenero) AS 'total' FROM genero
JOIN filme_genero ON filme_genero.fk_genero = genero.idGenero
JOIN filme ON filme_genero.fk_filme = filme.idFilme
JOIN compra ON compra.fk_filme = filme.idFilme
JOIN colecao ON fk_colecao = colecao.idColecao
-- WHERE colecao.idColecao = 3
GROUP BY genero.idGenero
ORDER BY total DESC;

-- Select para valor total da coleção
SELECT SUM(valor_compra) AS 'valor total' FROM compra 
JOIN colecao ON fk_colecao = colecao.idColecao;
-- WHERE colecao.idColecao = 1;

-- Select do total de filmes na coleção
SELECT COUNT(filme.idFilme) AS 'quantidade total' FROM filme
JOIN compra ON compra.fk_filme = filme.idFilme
JOIN colecao ON compra.fk_colecao = colecao.idColecao;
-- WHERE colecao.idColecao = 1;

-- Select da média de preço por DVD na coleção
SELECT AVG(valor_compra) AS 'valor medio' FROM compra 
JOIN colecao ON fk_colecao = colecao.idColecao;
-- WHERE colecao.idColecao = 1;

SELECT SUM(valor_compra) AS 'valor total', COUNT(filme.idFilme) AS 'quantidade total', AVG(valor_compra) AS 'valor medio' FROM filme
JOIN compra ON compra.fk_filme = filme.idFilme
JOIN colecao ON compra.fk_colecao = colecao.idColecao
WHERE colecao.idColecao = 3;

-- Select da quantidade de filmes por ano
SELECT YEAR(dt_lancamento) AS 'ano', COUNT(YEAR(dt_lancamento)) AS 'quantidade ano' FROM filme
JOIN compra ON compra.fk_filme = filme.idFilme
JOIN colecao ON fk_colecao = colecao.idColecao
-- WHERE colecao.idColecao = 1
GROUP BY YEAR(dt_lancamento)
ORDER BY YEAR(dt_lancamento);

SELECT YEAR(dt_lancamento) AS 'ano', COUNT(YEAR(dt_lancamento)) AS 'quantidade_ano' FROM filme
JOIN compra ON compra.fk_filme = filme.idFilme
JOIN colecao ON fk_colecao = colecao.idColecao
-- WHERE colecao.idColecao = 1
GROUP BY YEAR(dt_lancamento)
ORDER BY YEAR(dt_lancamento);

SELECT decada AS 'ano', COUNT(*) AS 'quantidade_ano' FROM
(SELECT floor(YEAR(dt_lancamento) / 10) * 10 AS 'decada'
FROM filme
JOIN compra ON compra.fk_filme = filme.idFilme
JOIN colecao ON fk_colecao = colecao.idColecao
WHERE colecao.idColecao = 1) d
GROUP BY decada
ORDER BY quantidade_ano DESC;

-- Select da quantidade de filmes por origem de compra
SELECT local_compra.local AS 'local', COUNT(local_compra.id_local_compra) AS 'quantidade_local' FROM local_compra
JOIN compra ON compra.fk_local_compra = local_compra.id_local_compra
JOIN filme ON compra.fk_filme = filme.idFilme
JOIN colecao ON compra.fk_colecao = colecao.idColecao
-- WHERE colecao.idColecao = 1
GROUP BY local_compra.local
ORDER BY quantidade_local DESC;

SELECT COUNT(DISTINCT filme.idFilme) FROM filme;
SELECT COUNT(genero.idGenero) FROM genero
JOIN filme_genero ON filme_genero.fk_genero = genero.idGenero
JOIN filme ON filme_genero.fk_filme = filme.idFilme;

SELECT titulo.titulo, genero.nome_genero FROM genero 
JOIN filme_genero ON fk_genero = genero.idGenero
JOIN filme ON fk_filme = filme.idFilme
JOIN titulo ON titulo.fk_filme = filme.idFilme
JOIN compra ON compra.fk_filme = filme.idFilme
JOIN colecao ON idColecao = fk_colecao;

SELECT idFilme FROM filme
JOIN titulo ON titulo.fk_filme = filme.idFilme
JOIN compra ON compra.fk_filme = filme.idFilme
JOIN colecao ON idColecao = fk_colecao;

SELECT genero.nome_genero, COUNT(genero.idGenero) FROM genero 
JOIN filme_genero ON fk_genero = genero.idGenero
JOIN filme ON fk_filme = filme.idFilme
JOIN titulo ON titulo.fk_filme = filme.idFilme
JOIN compra ON compra.fk_filme = filme.idFilme
JOIN colecao ON idColecao = fk_colecao
WHERE idFilme IN(SELECT idFilme FROM filme
JOIN titulo ON titulo.fk_filme = filme.idFilme
JOIN compra ON compra.fk_filme = filme.idFilme
JOIN colecao ON idColecao = fk_colecao) 
AND fk_colecao = 3
GROUP BY genero.nome_genero
HAVING COUNT(DISTINCT genero.idGenero) = 1;

SELECT COUNT(fk_filme) FROM compra
JOIN colecao ON fk_colecao = colecao.idColecao
WHERE idColecao = 3;

SELECT titulo.titulo FROM titulo
JOIN filme ON titulo.fk_filme = filme.idFilme
JOIN compra ON compra.fk_filme =  filme.idFilme
JOIN colecao ON fk_colecao = colecao.idColecao
WHERE fk_colecao = 3;


SELECT id_genero AS 'genero' FROM (SELECT idFilme, genero.idGenero FROM filme
JOIN compra ON compra.fk_filme = filme.idFilme
JOIN colecao ON idColecao = fk_colecao);
     
SELECT * FROM colecao;
SELECT * FROM regiao;
SELECT * FROM lancamento;
        

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

UPDATE usuario SET fk_colecao = (SELECT idUsuario FROM user_test) WHERE email = 'lucas1@gmail.com' AND senha = 'lucas123';  
CREATE VIEW user_test AS
SELECT idUsuario FROM usuario WHERE email = 'lucas1@gmail.com' AND senha = 'lucas123';
SELECT * FROM usuario;
SHOW TABLES;

DROP DATABASE collect_physical;
TRUNCATE compra;

SELECT idFilme, path, titulo, dt_lancamento, popularidade, regiao.regiao, GROUP_CONCAT(genero.nome_genero) as genero FROM filme
JOIN filme_genero ON filme.idFilme = filme_genero.fk_filme
JOIN genero ON genero.idGenero = filme_genero.fk_genero
JOIN poster ON filme.idFilme = poster.fk_filme
JOIN titulo ON filme.idFilme = titulo.fk_filme
JOIN regiao ON idRegiao = titulo.fk_regiao AND idRegiao = poster.fk_regiao
WHERE (titulo.fk_regiao = 1)
GROUP BY idFilme, titulo, path, dt_lancamento, popularidade, regiao.regiao
ORDER BY popularidade DESC
LIMIT 300;

SELECT idFilme, path, titulo, dt_lancamento, popularidade, regiao.regiao, GROUP_CONCAT(genero.nome_genero SEPARATOR ';') AS genero FROM filme
JOIN filme_genero ON filme.idFilme = filme_genero.fk_filme
JOIN genero ON genero.idGenero = filme_genero.fk_genero
JOIN poster ON filme.idFilme = poster.fk_filme
JOIN titulo ON filme.idFilme = titulo.fk_filme
JOIN regiao ON idRegiao = titulo.fk_regiao AND idRegiao = poster.fk_regiao
WHERE (titulo.fk_regiao = 1)
GROUP BY idFilme, titulo, path, dt_lancamento, popularidade, regiao.regiao
ORDER BY popularidade DESC
LIMIT 300;
