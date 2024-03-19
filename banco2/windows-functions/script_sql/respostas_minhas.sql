-- 1
SELECT ap.cod_apolice,
	(
		select nome from cliente where cod_cliente = ap.cod_cliente
	) as 'nome do cliente',
	ap.data_inicio_vigencia,
	ap.data_fim_vigencia,
	ap.valor_cobertura,
	ap.valor_franquia,
	ap.placa
 FROM apolice ap
ORDER BY data_fim_vigencia ASC
GO

-- 2 
SELECT ap.cod_apolice,
	cl.nome,
	ap.data_inicio_vigencia,
	ap.data_fim_vigencia,
	ap.valor_cobertura,
	ap.valor_franquia,
	ap.placa
FROM apolice ap
inner join cliente cl on (cl.cod_cliente = ap.cod_cliente)
ORDER BY data_fim_vigencia ASC
GO

-- 3
SELECT sinistro.*, row_number() over( order by local_sinistro) as ordem
FROM sinistro
GO

-- 4
SELECT sinistro.*, rank() over(order by local_sinistro) as ordem
FROM sinistro
GO

-- 5 
SELECT sinistro.*, dense_rank() over(order by local_sinistro) as ordem
FROM sinistro
GO

-- 6
with carro_sinistros as (
	SELECT carro.*,
	(
		SELECT count(*) 
		FROM sinistro si
		WHERE si.placa = carro.placa
	) AS qt_sinistros
	FROM carro 
)

select * 
from carro_sinistros
where qt_sinistros > 0
ORDER BY qt_sinistros DESC

-- 7 
WITH carro_s AS (
	SELECT ca.*,
	(
		SELECT count(*)  
		FROM sinistro si
		WHERE si.placa = ca.placa
	) AS qt_sinistros,
	(
		SELECT min(si.data_sinistro)
		FROM sinistro si
		WHERE si.placa = ca.placa
	) AS data
	FROM carro ca
)

select * from carro_s WHERE qt_sinistros > 0

-- 8
WITH carro_s AS (
	SELECT ca.*,
	(
		SELECT count(*)  
		FROM sinistro si
		WHERE si.placa = ca.placa
	) AS qt_sinistros,
	(
		SELECT min(si.data_sinistro)
		FROM sinistro si
		WHERE si.placa = ca.placa
	) AS menor_data,
	(
		SELECT max(si.data_sinistro)
		FROM sinistro si
		WHERE si.placa = ca.placa
	) AS maior_data
	FROM carro ca
)

select * from carro_s WHERE qt_sinistros > 0
--
WITH carro_sinistro AS (
SELECT ca.*,
	COUNT(si.placa) OVER(PARTITION BY si.placa) AS qt_sinistros,
	MAX(si.data_sinistro) OVER(PARTITION BY si.placa) AS maior_data,
	MIN(si.data_sinistro) OVER(PARTITION BY si.placa) AS menor_data
FROM carro ca
INNER JOIN sinistro si ON (si.placa = ca.placa)
)

SELECT * FROM carro_sinistro cs 
GROUP BY cs.placa, cs.modelo, cs.chassi, cs.marca, cs.ano, cs.cor, cs.qt_sinistros, cs.maior_data, cs.menor_data


-- 9
SELECT re.nm_regiao, es.nm_estado 
FROM regiao re
INNER JOIN estado es ON (es.cd_regiao = re.cd_regiao)
ORDER BY re.nm_regiao, es.nm_estado 
--
SELECT 
	(
		SELECT re.nm_regiao 
		FROM regiao re
		WHERE re.cd_regiao = es.cd_regiao
	) AS nome_regiao, 
	es.nm_estado AS nome_estado
FROM estado es
WHERE es.cd_regiao IS NOT NULL
ORDER BY nome_regiao, nome_estado

-- 10
WITH cte AS (
SELECT re.nm_regiao, es.nm_estado, 
	DENSE_RANK() OVER(ORDER BY re.nm_regiao, es.nm_estado) as rank
FROM regiao re
INNER JOIN estado es ON (es.cd_regiao = re.cd_regiao)
) 

SELECT * FROM cte WHERE rank = 5
--
WITH cte AS (
	SELECT 
		(
			SELECT re.nm_regiao 
			FROM regiao re
			WHERE re.cd_regiao = es.cd_regiao
		) AS nome_regiao, 
		es.nm_estado AS nome_estado
	FROM estado es
	WHERE es.cd_regiao IS NOT NULL
), cte2 AS (
	SELECT cte.*, 
		DENSE_RANK() OVER(ORDER BY nome_regiao, nome_estado) as rank
	FROM cte
)

SELECT * FROM cte2 WHERE rank = 5

-- 11
WITH cte AS (
	SELECT ap.cod_apolice,
		(	
			SELECT nome 
			FROM cliente 
			WHERE ap.cod_cliente = cod_cliente
		) AS nome_cliente,
		ap.data_fim_vigencia,
		ap.data_inicio_vigencia,
		ap.placa,
		ap.valor_cobertura,
		ap.valor_franquia
	FROM apolice ap
)

SELECT cte.*, 
	SUM(valor_franquia) OVER(
		PARTITION BY nome_cliente 
		ORDER BY nome_cliente, cod_apolice 
		ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS total_franquia
FROM cte
ORDER BY nome_cliente, cod_apolice 
