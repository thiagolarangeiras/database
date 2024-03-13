-- 1
WITH count_sinistro AS (
    SELECT placa, count(*) AS qt 
    FROM sinistro
    GROUP BY placa
);
--
SELECT * 
FROM carro 
WHERE carro.placa in (
    SELECT placa
    FROM count_sinistro
    WHERE qt = (SELECT MAX(qt) FROM count_sinistro)
);

-- 2
SELECT * FROM cliente 
WHERE nome LIKE '%a%' and nome NOT LIKE 'a%';

-- 3
SELECT * 
FROM cliente cl
LEFT JOIN apolice ap ON (cl.cod_cliente = ap.cod_cliente)
WHERE ap.cod_cliente IS NULL;
--
SELECT * 
FROM cliente cl
WHERE cl.cod_cliente not in (
	SELECT ap.cod_cliente
	FROM apolice ap
);
--
SELECT * 
FROM cliente cl
WHERE cl.cod_cliente not in (
	SELECT ap.cod_cliente
	FROM apolice ap
	WHERE ap.cod_cliente = cl.cod_cliente
);
--
SELECT * 
FROM cliente cl
WHERE NOT EXISTS(
	SELECT ap.cod_cliente
	FROM apolice ap
	WHERE ap.cod_cliente = cl.cod_cliente
);

-- 4
SELECT * 
FROM carro ca
LEFT JOIN apolice ap ON (ca.placa = ap.placa)
WHERE ap.placa IS NULL;
--
SELECT * 
FROM carro ca
WHERE ca.placa not in (
	SELECT ap.placa
	FROM apolice ap
);
--
SELECT * 
FROM carro ca
WHERE ca.placa not in (
	SELECT ap.placa
	FROM apolice ap
	WHERE ap.placa = ca.placa
);
--
SELECT * 
FROM carro ca
WHERE NOT EXISTS(
	SELECT ap.placa
	FROM apolice ap
	WHERE ap.placa = ca.placa
);

-- 5
SELECT nome FROM cliente; 

-- 6
SELECT * FROM carro
WHERE placa LIKE 'l%' OR placa LIKE 'm%'

-- 7
SELECT * FROM sinistro
WHERE data_sinistro BETWEEN '2022/01/01' AND '2022/12/31'

-- 8
WITH cliente_telefone AS (
	SELECT * FROM cliente
	WHERE (telefone_fixo IS NULL OR telefone_fixo = '') AND
		(telefone_celular IS NULL OR telefone_celular = '')
)

SELECT * FROM cliente_telefone
ORDER BY nome

-- 9
SELECT cl.* FROM cliente cl
INNER JOIN apolice ap ON(cl.cod_cliente = ap.cod_cliente)
WHERE data_fim_vigencia < GETDATE()
GROUP BY cl.cod_cliente, cl.nome, cl.cpf, cl.sexo, cl.endereco, cl.telefone_fixo, cl.telefone_celular
--
SELECT * FROM cliente cl
WHERE cod_cliente in (
	SELECT cod_cliente 
	FROM apolice ap
	WHERE data_fim_vigencia < GETDATE()
)
--
SELECT * FROM cliente cl
WHERE cod_cliente in (
	SELECT cod_cliente 
	FROM apolice ap
	WHERE ap.cod_cliente = cl.cod_cliente AND 
		data_fim_vigencia < GETDATE()
)
--
SELECT * FROM cliente cl
WHERE EXISTS (
	SELECT 1
	FROM apolice ap
	WHERE ap.cod_cliente = cl.cod_cliente AND 
		data_fim_vigencia < GETDATE()
)
--
WITH apolice_vencida AS (
	SELECT * FROM apolice ap
	WHERE data_fim_vigencia < GETDATE()
) 

SELECT * FROM cliente cl
WHERE EXISTS(
	SELECT 1 FROM apolice_vencida av
	WHERE av.cod_cliente = cl.cod_cliente
)

-- 10
SELECT DISTINCT ca.* FROM carro ca
INNER JOIN sinistro si ON (ca.placa = si.placa)
INNER JOIN apolice ap ON (ca.placa = ap.placa)
WHERE si.data_sinistro > ap.data_fim_vigencia
--
SELECT * FROM carro ca
WHERE EXISTS(
	SELECT 1 FROM sinistro si
	WHERE ca.placa = si.placa AND 
	si.data_sinistro > (
		SELECT MAX(ap.data_fim_vigencia) FROM apolice ap
		WHERE ap.placa = ca.placa
	)
)
--
SELECT * FROM carro ca
WHERE EXISTS(
	SELECT 1 FROM sinistro si
	WHERE ca.placa = si.placa AND 
	EXISTS (
		SELECT ap.data_fim_vigencia FROM apolice ap
		WHERE ap.placa = ca.placa AND
		si.data_sinistro > ap.data_fim_vigencia		
	)
)
--
SELECT * FROM carro ca
WHERE ca.placa IN (
	SELECT si.placa FROM sinistro si
	WHERE si.placa IN (
		SELECT ap.placa FROM apolice ap
		WHERE si.data_sinistro > ap.data_fim_vigencia
	)
)

-- 11
SELECT COUNT(*) AS qt FROM regiao

-- 12 
SELECT COUNT(*) AS qt FROM estado

-- 13
SELECT COUNT(*) AS qt FROM municipio

--14
SELECT es.nm_estado, count(*)
FROM estado es
INNER JOIN municipio mu ON(mu.cd_estado = es.cd_estado)
GROUP BY es.cd_estado, es.nm_estado
ORDER BY es.nm_estado

-- 15
SELECT re.nm_regiao, count(*) AS qt
FROM estado es
INNER JOIN municipio mu ON(mu.cd_estado = es.cd_estado)
INNER JOIN regiao re ON (es.cd_regiao = re.cd_regiao)
WHERE re.cd_regiao = 4
GROUP BY re.cd_regiao, re.nm_regiao

-- 16
SELECT re.nm_regiao, count(*) AS qt
FROM estado es
INNER JOIN municipio mu ON(mu.cd_estado = es.cd_estado)
INNER JOIN regiao re ON (es.cd_regiao = re.cd_regiao)
WHERE re.cd_regiao = 4 AND mu.nm_municipio LIKE 'C%'
GROUP BY re.cd_regiao, re.nm_regiao

-- 17
SELECT count(*) AS qt
FROM municipio mu 
WHERE LEN(nm_municipio) > 10 

-- 18
SELECT re.nm_regiao, count(*) AS qt
FROM estado es
INNER JOIN municipio mu ON(mu.cd_estado = es.cd_estado)
INNER JOIN regiao re ON (es.cd_regiao = re.cd_regiao)
WHERE re.cd_regiao = 1
GROUP BY re.cd_regiao, re.nm_regiao

-- 19
SELECT re.nm_regiao, count(*) AS qt
FROM estado es
INNER JOIN municipio mu ON(mu.cd_estado = es.cd_estado)
INNER JOIN regiao re ON (es.cd_regiao = re.cd_regiao)
WHERE re.nm_regiao LIKE 'S%'
GROUP BY re.cd_regiao, re.nm_regiao

-- 20
SELECT count(*) FROM avaliacao;

-- 21
SELECT al.* FROM aluno al
INNER JOIN avaliacao_aluno aa ON (aa.cd_aluno = al.cd_aluno)
WHERE aa.dt_inicio IS NOT NULL AND aa.dt_fim IS NOT NULL

-- 22
SELECT * FROM questao qu
INNER JOIN avaliacao av ON (av.cd_avaliacao = qu.cd_avaliacao)
WHERE tp_questao = 1 AND av.ds_avaliacao LIKE '2a%'

--23
SELECT av.cd_avaliacao, av.ds_avaliacao, qu.cd_questao, qu.ds_questao, count(*) AS qt FROM questao qu
INNER JOIN questao_item qi ON (qi.cd_questao = qu.cd_questao)
INNER JOIN avaliacao av ON (av.cd_avaliacao = qu.cd_avaliacao)
GROUP BY qu.cd_questao, qu.ds_questao, av.cd_avaliacao, av.ds_avaliacao
HAVING count(*) > 4
ORDER BY qt

WITH qt_questao AS (
	SELECT qu.cd_avaliacao, qu.cd_questao, qu.ds_questao, count(*) AS qt FROM questao qu
	INNER JOIN questao_item qi ON (qi.cd_questao = qu.cd_questao)
	GROUP BY qu.cd_questao, qu.ds_questao, qu.cd_avaliacao 
	HAVING count(*) > 4
)

SELECT * 
FROM avaliacao av
INNER JOIN qt_questao qq ON (qq.cd_avaliacao = av.cd_avaliacao)
