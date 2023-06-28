-- Quantos produtos entraram por mês?
SELECT MONTH(b.dataFim) AS mes, COUNT(*) AS total
from TransacaoItens a
inner join transacao b
on a.idTransacao = b.idTransacao
where tipo = 0
group by mes;

-- Quantos produtos saíram por mês?
SELECT MONTH(b.dataFim) AS mes, COUNT(*) AS total
from TransacaoItens a
inner join transacao b
on a.idTransacao = b.idTransacao
where tipo = 1
group by mes;

-- Quanto foi gasto por mês com entrada de produtos?
SELECT MONTH(dataFim) AS mes, sum(preco) + sum(frete) + sum(imposto) AS gastos
from transacao
where tipo = 0
group by mes;

-- Quanto foi ganho por mês com a saída de produtos?
SELECT MONTH(dataFim) AS mes, sum(preco) - sum(frete) - sum(imposto) AS ganhos
from transacao
where tipo = 1
group by mes;

-- Qual foi o lucro mensal (considerando apenas entrada e saída de produtos)?
SELECT MONTH(a.dataFim) AS mes, sum(a.ganhos) - sum(b.gastos)
from (select idTransacao, preco - frete - imposto AS ganhos, dataFim
  from transacao 
  where tipo = 1) as a
inner join
(select idTransacao, preco + frete + imposto AS gastos
  from transacao
  where tipo = 0) as b
on a.idTransacao = b.idTransacao
group by mes;

  
-- Qual o fornecedor que mais deu produtos?
select a.nome
from Fornecedor a
inner join Transacao b
on a.idFornecedor = b.idFornecedor
inner join TransacaoItens c
on b.idTransacao = c.idTransacao
group by a.nome
order by count(c.*) desc;

-- Quais produtos estão abaixo da quantidade mínima?
select distinct a.nome, b.nome
from Produto a
inner join Categoria b
on a.idCategoria = b.idCategoria
inner join Estoque c
in a.idProduto = c.idProduto
where c.qtdeEstoque < c.qtdemin;

-- Quais produtos estão próximos da quantidade mínima
select distinct a.nome, b.nome
from Produto a
inner join Categoria b
on a.idCategoria = b.idCategoria
inner join Estoque c
on a.idProduto = c.idProduto
where c.qtdeEstoque < c.qtdemin*2;

