-- Quantos produtos entraram por mês?
SELECT MONTH(b.dataFim) AS mes, COUNT(*) AS total
from TransacaoItens a
inner join transacao b
in a.idTransacao = b.idTransacao
where tipo = 0
group by mes

-- Quantos produtos saíram por mês?
SELECT MONTH(b.dataFim) AS mes, COUNT(*) AS total
from TransacaoItens a
inner join transacao b
in a.idTransacao = b.idTransacao
where tipo = 1
group by mes

-- Qual o fornecedor que mais deu produtos?
select a.nome
from Fornecedor a
inner join Transacao b
in a.idFornecedor = b.idFornecedor
inner join TransacaoItens c
in b.idTransacao = c.idTransacao
group by a.nome
order by count(c.*) desc

-- Quais produtos estão abaixo da quantidade mínima?
select distinct a.nome, b.nome
from Produto a
inner join Categoria b
in a.idCategoria = b.idCategoria
inner join Estoque c
in a.idProduto = c.idProduto
where c.qtdeEstoque < c.qtdemin

-- Quais produtos estão próximos da quantidade mínima
select distinct a.nome, b.nome
from Produto a
inner join Categoria b
in a.idCategoria = b.idCategoria
inner join Estoque c
in a.idProduto = c.idProduto
where c.qtdeEstoque < c.qtdemin*2

