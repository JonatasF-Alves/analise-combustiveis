WITH ext AS (
  SELECT MIN(data_inicial) AS ini, MAX(data_inicial) AS fim
  FROM precos_capitais
)
SELECT a.municipio,
       a.preco_medio AS preco_inicial,
       b.preco_medio AS preco_final,
       ROUND((b.preco_medio / a.preco_medio - 1) * 100, 2) AS variacao_pct
FROM precos_capitais a
JOIN ext ON a.data_inicial = ext.ini
JOIN precos_capitais b
  ON b.municipio = a.municipio
 AND b.produto = a.produto
 AND b.data_inicial = ext.fim
WHERE a.produto = 'GASOLINA COMUM'
ORDER BY variacao_pct;
