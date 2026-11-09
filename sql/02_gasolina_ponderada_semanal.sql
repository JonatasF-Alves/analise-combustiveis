SELECT data_inicial,
       ROUND(SUM(preco_medio * n_postos) / SUM(n_postos), 3) AS preco_ponderado
FROM precos_capitais
WHERE produto = 'GASOLINA COMUM'
GROUP BY data_inicial
ORDER BY data_inicial;
