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
ORDER BY qt_sinistros DESC

-- 8
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
) AS data,
row_number() over( order by local_sinistro) as ordem
FROM carro ca
ORDER BY qt_sinistros DESC




with carro_sinistros as (
	SELECT carro.*,
	(
		SELECT count(*) 
		FROM sinistro si
		WHERE si.placa = carro.placa
	) AS qt_sinistros
	(
		SELECT min(si.data_sinistro)
		from sinistro si
		WHERE si.placa = carro.placa
	) as data_ultimo_sinistro,
	(
		SELECT min(si.data_sinistro)
		from sinistro si
		WHERE si.placa = carro.placa
	) as data_ultimo_sinistro,

	FROM carro 
)

select * 
from carro_sinistros
where qt_sinistros > 0
ORDER BY qt_sinistros DESC