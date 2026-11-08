INSERT INTO midia(tipo) VALUES
('DVD'),
('Blu-ray'),
('VHS'),
('4K UHD'),
('UMD');

INSERT INTO regiao(regiao) VALUES
('EN-US'),
('PT-BR');

SELECT * FROM regiao;
SELECT * FROM midia;
SELECT * FROM genero;
SELECT * FROM filme;
SELECT * FROM filme_genero;

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

DROP DATABASE collect_physical;
SELECT * FROM filmes WHERE titulo LIKE '%the%';
DESC filmes;
DESC poster;