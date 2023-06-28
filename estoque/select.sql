-- 1) Qual a quantidade de cada produto?
SELECT a.nome AS produto, b.nome AS categoria, sum(c.qtde) AS quantidade
FROM produto a
INNER JOIN categoria b
ON a.idCategoria = b.idCategoria
INNER JOIN estoqueItens c
ON a.idProduto = b.idProduto
GROUP BY a.nome;
  
-- 2) Quantos produtos entraram por mês?
SELECT MONTH(b.dataFim) AS mes, SUM(a.qtde) AS total
FROM transacaoItens a
INNER JOIN transacao b
ON a.idTransacao = b.idTransacao
WHERE tipo = 0
GROUP BY mes;

-- 3) Quantos produtos saíram por mês?
SELECT MONTH(b.dataFim) AS mes, COUNT(*) AS total
FROM transacaoItens a
INNER JOIN transacao b
ON a.idTransacao = b.idTransacao
WHERE tipo = 1
GROUP BY mes;

-- 4) Quanto foi gasto por mês com entrada de produtos?
SELECT MONTH(dataFim) AS mes, sum(preco) + sum(frete) + sum(imposto) AS gastos
FROM transacao
WHERE tipo = 0
GROUP BY mes;

-- 5) Quanto foi ganho por mês com a saída de produtos?
SELECT MONTH(dataFim) AS mes, sum(preco) - sum(frete) - sum(imposto) AS ganhos
FROM transacao
WHERE tipo = 1
GROUP BY mes;

-- 6) Qual foi o lucro mensal (considerando apenas entrada e saída de produtos)?
SELECT MONTH(a.dataFim) AS mes, sum(a.ganhos) - sum(b.gastos)
FROM (SELECT idTransacao, preco - frete - imposto AS ganhos, dataFim
  FROM transacao 
  WHERE tipo = 1) a
INNER JOIN
(SELECT idTransacao, preco + frete + imposto AS gastos
  FROM transacao
  WHERE tipo = 0) b
ON a.idTransacao = b.idTransacao
GROUP BY mes;

  
-- 7) Qual o fornecedor que mais deu produtos?
SELECT a.nome AS fornecedor
FROM fornecedor a
INNER JOIN transacao b
ON a.idFornecedor = b.idFornecedor
INNER JOIN transacaoItens c
ON b.idTransacao = c.idTransacao
GROUP BY a.nome
ORDER BY COUNT(c.*) DESC;

-- 8) Quais produtos estão abaixo da quantidade mínima?
SELECT a.nome AS produto, b.nome AS categoria, c.idEstoque AS "id estoque"
FROM produto a
INNER JOIN categoria b
ON a.idCategoria = b.idCategoria
INNER JOIN estoqueItens c
IN a.idProduto = c.idProduto
WHERE c.qtdeEstoque < c.qtdemin;

-- 9) Quais produtos estão próximos ou abaixo da quantidade mínima?
SELECT a.nome AS produto, b.nome AS categoria, c.idEstoque AS "id estoque"
FROM produto a
INNER JOIN categoria b
ON a.idCategoria = b.idCategoria
INNER JOIN estoqueItens c
ON a.idProduto = c.idProduto
WHERE c.qtdeEstoque < c.qtdemin*2;
