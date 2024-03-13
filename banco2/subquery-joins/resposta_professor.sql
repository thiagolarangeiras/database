--01.	(Aberta) Utilizando a linguagem SQL, execute consultas que possam responder a seguinte questão: Qual(is) Carro(s) possui(em) mais sinistros cadastrados?

--1a opcao
with cte1 as (
	select placa, count(1) as qtde
	from sinistro
	group by placa
)
select * from carro
where placa in (select placa
                from cte1
				where qtde in (select MAX(qtde)
				               from cte1))
go

--2a opcao
with cte1 as (
	select placa, count(1) as qtde from sinistro group by placa
)
select *
from carro A inner join cte1 B
ON A.placa = B.placa
where qtde in (select max(qtde)
				from cte1)
go

--3a opcao
with cte as (
	select c.placa, modelo, chassi, marca, ano, cor, count(1) as qtde
	from carro c inner join sinistro s ON c.placa = s.placa
	group by c.placa, modelo, chassi, marca, ano, cor
)
select *
from cte A
where qtde in (select max(qtde)
               from cte B)
go


--02.	(Aberta) Quais clientes cadastrados possuem letra “a” no meio e não no final? 
--opcao 1
select *
from cliente
where nome like '%a%'
  and nome not like '%a'
go

--opcao 2 - independente se maisculo ou minusculo
select *
from cliente
where UPPER(nome) like '%A%'
  and UPPER(nome) not like '%A'
go


--opcao 3
with cte as (
  select * from cliente where nome like '%a%'
),
cte2 as (
  select * from cte where nome not like '%a'
)
select * from cte2
go

--03.	(Aberta) Quais clientes não possuem apólice? 
--opcao 1
select c.*
from cliente c left join apolice a
on c.cod_cliente = a.cod_cliente
where cod_apolice is null
go

--opcao 2
select *
from cliente
where cod_cliente not in (select cod_cliente
                          from apolice)
go

--opcao 3
select *
from cliente
where not exists (select 1
                  from apolice
				  where cliente.cod_cliente = apolice.cod_cliente)
go


--04.	(Aberta) Quais carros não possuem apólice? 
--opcao 1
select c.*
from carro c left join apolice a on c.placa = a.placa
where cod_apolice is null
go

--opcao 2
select *
from carro
where placa not in (select placa from apolice)
go

--opcao 2 com not exists select *
select *
from carro
where not exists (select *
                  from apolice
				  where carro.placa = apolice.placa)
go

--opcao 2 com not exists select 1
select *
from carro
where not exists (select 1
                  from apolice
				  where carro.placa = apolice.placa)
go


--05.	(Aberta) Quais clientes temos hoje na base de dados? 
select *
from cliente;

--06.	(Aberta) Quais carros possuem a placa iniciando com as letras L ou M
--1a opcao
select *
from carro
where placa like 'l%' or placa like 'm%';

--2a opcao - independente se minusculo ou maiusculo
select *
from carro
where lower(placa) like 'l%' or lower(placa) like 'm%';

--07.	(Aberta) Quais sinistros ocorreram em 2022?
--1a opcao
select *
from sinistro
where data_sinistro BETWEEN '2022-01-01' and '2022-12-31'

--2a opcao
select *
from sinistro
where year(data_sinistro) = 2022


--08.	(Aberta) Quais clientes não possuem telefone fixo E telefone celular cadastrados?
select *
from cliente
where telefone_celular is null
  and telefone_fixo is null
;

--opcao 2
with cte as (
  select *
  from cliente
  where telefone_celular is null
),
cte2 as (
  select *
  from cte
  where telefone_fixo is null
)
select * from cte2
;

--09.	(Aberta) Quantos clientes possuem apólice(s) vencida(s)? Utiliza data e hora atual como base.
--1a opcao 
select distinct c.*
from apolice a inner join cliente c on a.cod_cliente = c.cod_cliente
where data_fim_vigencia < GETDATE();

--2a opcao
select distinct *
from cliente
where cod_cliente in (select cod_cliente
                      from apolice
                      where data_fim_vigencia < GETDATE())
;

--3a opcao
select distinct *
from cliente
where exists (select 1
                      from apolice
                      where 
					    cliente.cod_cliente = apolice.cod_cliente
						and data_fim_vigencia < GETDATE())
;


--10.	(Aberta) Quais carros possuem algum sinistro com data superior a data de fim da vigência da apólice?
--1a opcao
select distinct c.*
from carro c inner join sinistro s on s.placa = c.placa
     inner join apolice a on a.placa = c.placa
where a.data_fim_vigencia < s.data_sinistro;

--2a opcao
select *
from carro
where placa IN (select placa
                from sinistro
				where placa IN (select placa
				                from apolice
								where apolice.data_fim_vigencia < sinistro.data_sinistro))

--3a opcao
select *
from carro
where exists (select 1
                from sinistro
				where carro.placa = sinistro.placa
				  and placa IN (select placa
				                from apolice
								where apolice.data_fim_vigencia < sinistro.data_sinistro))


--11.	(Aberta) Em relação ao modelo abaixo, responda a questão: Quantas regiões existem cadastradas?
SELECT count(*) as qtde
FROM regiao;


--12.	(Aberta) Quantos estados existem cadastrados?
SELECT count(*) as qtde
FROM estado;

--13.	(Aberta) Quantos municípios existem cadastrados?
SELECT count(*) as qtde
FROM municipio;

--14.	(Aberta) Quantos municípios existem por estado? Considere gerar uma lista com o nome do estado e a quantidade de municípios por cada estado.
SELECT nm_estado, count(*) as qtde_municipios
FROM municipio m inner join estado e ON m.cd_estado = e.cd_estado
GROUP BY nm_estado

--15.	(Aberta) Quantos municípios existem na região SUL?
SELECT nm_regiao, COUNT(*) as qtde
FROM municipio m INNER JOIN estado e1 ON m.cd_estado = e1.cd_estado
	 INNER JOIN regiao e2 ON e1.cd_regiao = e2.cd_regiao
WHERE nm_regiao = 'SUL'
GROUP BY nm_regiao

--16.	(Aberta) Quantos municípios existem na região SUL e que começam com a letra C?
--1a opcao
SELECT nm_regiao, count(*) as qtde
FROM municipio m inner join estado e1 on m.cd_estado = e1.cd_estado
	 inner join regiao e2 on e1.cd_regiao = e2.cd_regiao
where nm_regiao = 'SUL'
  and nm_municipio like 'c%'
group by nm_regiao

--2a opcao
SELECT nm_regiao, count(*) as qtde
FROM municipio m inner join estado e1 on m.cd_estado = e1.cd_estado
	 inner join regiao e2 on e1.cd_regiao = e2.cd_regiao
where nm_regiao = 'SUL'
  and substring(nm_municipio, 1, 1) = 'c'
group by nm_regiao

--3a opcao - independente se munisculo ou maiusculo
SELECT nm_regiao, count(*) as qtde
FROM municipio m inner join estado e1 on m.cd_estado = e1.cd_estado
	 inner join regiao e2 on e1.cd_regiao = e2.cd_regiao
where UPPER(nm_regiao) = 'SUL'
  and UPPER(substring(nm_municipio, 1, 1)) = 'C'
group by nm_regiao

--17.	(Aberta) Quantos municípios possuem mais de 10 letras no nome?
SELECT COUNT(*) as qtde
FROM municipio
where LEN(nm_municipio) > 10


--18.	(Aberta) Quantos municípios existem na região NORTE?
--1a opcao
SELECT nm_regiao, count(*) as qtde
FROM municipio m inner join estado e1 on m.cd_estado = e1.cd_estado
	 inner join regiao e2 on e1.cd_regiao = e2.cd_regiao
where nm_regiao = 'NORTE'
group by nm_regiao

--2a opcao - independente se munisculo ou maiusculo
SELECT nm_regiao, count(*) as qtde
FROM municipio m inner join estado e1 on m.cd_estado = e1.cd_estado
	 inner join regiao e2 on e1.cd_regiao = e2.cd_regiao
where UPPER(nm_regiao) = 'NORTE'
group by nm_regiao


--19.	(Aberta) Quais as regiões que começam com a letra S e quantos municípios existem em cada uma delas?
--1a opcao
SELECT nm_regiao, count(*) as qtde
FROM municipio m inner join estado e1 on m.cd_estado = e1.cd_estado
	 inner join regiao e2 on e1.cd_regiao = e2.cd_regiao
where nm_regiao like 'S%'
group by nm_regiao

--2a opcao
SELECT nm_regiao, count(*) as qtde
FROM municipio m inner join estado e1 on m.cd_estado = e1.cd_estado
	 inner join regiao e2 on e1.cd_regiao = e2.cd_regiao
where SUBSTRING(nm_regiao, 1, 1) = 'S'
group by nm_regiao

--20.	(Aberta) Em relação ao modelo abaixo, responda a questão: Quantas avaliações existem cadastradas? Considere as avaliações modelo e não as avaliações respondidas pelos alunos.
SELECT COUNT(*) as qtde
FROM avaliacao;


--21.	(Aberta) Quais alunos iniciaram e finalizaram suas avaliações?
--1a opcao
SELECT aluno.*
FROM aluno inner join avaliacao_aluno on aluno.cd_aluno = avaliacao_aluno.cd_aluno
WHERE dt_fim is null
;

--2a opcao
SELECT *
FROM aluno
WHERE cd_aluno in (select cd_aluno
                   FROM avaliacao_aluno
				   WHERE dt_fim is null)
;

--3a opcao
SELECT *
FROM aluno
WHERE exists (select 1
              FROM avaliacao_aluno
              WHERE avaliacao_aluno.cd_aluno = aluno.cd_aluno
				and dt_fim is null)
;


--22.	(Aberta) Quais questões objetivas possuem as avaliações que começam por “2a” ?
--1a opcao
SELECT questao.cd_questao, questao.ds_questao
FROM questao inner join avaliacao ON avaliacao.cd_avaliacao = questao.cd_avaliacao
WHERE ds_avaliacao LIKE '2a%'
  AND tp_questao = 1

--2a opcao
SELECT cd_questao, ds_questao
FROM questao
WHERE cd_avaliacao IN (SELECT cd_avaliacao
                       FROM avaliacao
                       WHERE ds_avaliacao LIKE '2a%'
                         AND tp_questao = 1)
  
--3a opcao
SELECT cd_questao, ds_questao
FROM questao
WHERE EXISTS (SELECT 1
              FROM avaliacao
              WHERE avaliacao.cd_avaliacao = questao.cd_avaliacao
			    AND ds_avaliacao LIKE '2a%'
                AND tp_questao = 1)
go

--3a opcao
with cte as (
  SELECT questao.cd_questao, questao.ds_questao, questao.tp_questao, avaliacao.ds_avaliacao
  FROM questao inner join avaliacao ON avaliacao.cd_avaliacao = questao.cd_avaliacao
)
select cd_questao, ds_questao
from cte
where ds_avaliacao LIKE '2a%'
  AND tp_questao = 1
go


--23.	(Aberta) Quais são as provas e as questões que possuem mais de 4 alternativas por questão?
--1a opcao
SELECT ds_avaliacao, questao.cd_questao, ds_questao, COUNT(*) as qtde_alternativas
FROM avaliacao INNER JOIN questao ON avaliacao.cd_avaliacao = questao.cd_avaliacao
	 INNER JOIN questao_item ON questao.cd_questao = questao_item.cd_questao
GROUP BY ds_avaliacao, questao.cd_questao, ds_questao
HAVING COUNT(*) > 4
go

--2a opcao
with cte as (
  SELECT ds_avaliacao, questao.cd_questao, ds_questao, COUNT(1) as qtde_alternativas
  FROM avaliacao INNER JOIN questao ON avaliacao.cd_avaliacao = questao.cd_avaliacao
  	   INNER JOIN questao_item ON questao.cd_questao = questao_item.cd_questao
  GROUP BY ds_avaliacao, questao.cd_questao, ds_questao
)
select * from cte where qtde_alternativas > 4
go

--24.	(Aberta) Existe alguma questão cadastrada do tipo aberta? (considere tp_questao = 1 Objetiva, 2 Multipla Escolha e 3 Aberta).
select (CASE WHEN count(1) = 0 THEN 'Não'
        ELSE 'Sim'
	    END) as 'Existe questao aberta?'
from questao
where tp_questao = 3
go

--25.	(Aberta) Gere uma lista com o nome das provas e a quantidade de questões segmentadas por tipo.
--1a opcao
SELECT ds_avaliacao as avaliacao,
       (CASE WHEN tp_questao = 1 THEN 'Objetiva'
	        WHEN tp_questao = 2 THEN 'Multipla Escolha'
			WHEN tp_questao = 3 THEN 'Aberta'
		END) as tipo,
	   COUNT(*) as qtde_questoes
FROM avaliacao INNER JOIN questao ON avaliacao.cd_avaliacao = questao.cd_avaliacao
	 INNER JOIN questao_item ON questao.cd_questao = questao_item.cd_questao
GROUP BY ds_avaliacao, tp_questao
ORDER BY ds_avaliacao ASC






