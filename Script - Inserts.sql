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
SELECT * FROM generos;
SELECT * FROM filme;
SELECT * FROM filme_genero;

INSERT INTO filmes VALUES(23, 'Whatever', '1992-10-29');
INSERT INTO filme_genero VALUES(23, 12);
INSERT INTO poster VALUES(23,'path',23);

SELECT titulo, nome_genero FROM filmes 
JOIN filme_genero ON filme_genero.fk_filme = filmes.idFilmes
JOIN generos ON generos.idGenero = filme_genero.fk_genero;

SELECT titulo.titulo, regiao FROM filme
JOIN titulo ON filme.idFilme = titulo.fk_filme
JOIN regiao ON idRegiao = fk_regiao
ORDER BY titulo;

SELECT * FROM titulo;

DROP DATABASE collect_physical;
SELECT * FROM filmes WHERE titulo LIKE '%the%';
DESC filmes;
DESC poster;