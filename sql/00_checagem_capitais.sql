SELECT municipio, COUNT(DISTINCT data_inicial) AS semanas
FROM precos_capitais
GROUP BY municipio
ORDER BY semanas, municipio;
