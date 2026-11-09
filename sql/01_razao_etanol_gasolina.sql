SELECT municipio, estado,
       ROUND(
         MAX(CASE WHEN produto = 'ETANOL HIDRATADO' THEN preco_medio END) /
         MAX(CASE WHEN produto = 'GASOLINA COMUM'   THEN preco_medio END)
       , 3) AS razao
FROM precos_capitais
WHERE data_inicial = (SELECT MAX(data_inicial) FROM precos_capitais)
GROUP BY municipio, estado
HAVING razao IS NOT NULL
ORDER BY razao;
