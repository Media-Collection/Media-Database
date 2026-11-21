-- SELECT para criação de uma linha do tempo do crescimento da coleção
SELECT dt_compra AS 'data', SUM(COUNT(fk_filme)) OVER (ORDER BY dt_compra) AS 'total' FROM compra 
JOIN colecao ON fk_colecao = colecao.idColecao
WHERE colecao.idColecao = 1
GROUP BY dt_compra
ORDER BY dt_compra;

DESC compra;

SELECT dt_compra, COUNT(fk_filme) FROM compra 
JOIN colecao ON fk_colecao = colecao.idColecao
WHERE colecao.idColecao = 1
GROUP BY dt_compra
ORDER BY dt_compra;

