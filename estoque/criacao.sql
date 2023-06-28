DROP TABLE IF EXISTS categoria;
CREATE TABLE categoria(
    idCategoria int identity NOT NULL,
    nome varchar(50) NOT NULL,
    descricao varchar(500) NULL, 
    primary key (idCategoria)
);

DROP TABLE IF EXISTS produto;
CREATE TABLE produto(
    idProduto int identity NOT NULL,
    idCategoria int NULL,
    nome varchar(50) NOT NULL,
    descricao varchar(500) NULL,
    peso decimal(8,3) NULL,
    preco decimal(9,2) NULL,
    primary key (idProduto)
);

DROP TABLE IF EXISTS estoque;
CREATE TABLE estoque(
    idEstoque int identity NOT NULL,
    idLocalizacao int NOT NULL,
    nome varchar(100) NOT NULL,
    primary key (idEstoque)    
);

DROP TABLE IF EXISTS estoqueItens;
CREATE TABLE estoqueItens(
    idEstoqueItens int identity NOT NULL,
    idEstoque int NOT NULL,
    idProduto int NOT NULL, 
    qtde_min smallint NOT NULL,
    qtde_max int NOT NULL,
    total int NOT NULL,
    primary key (idEstoqueItens)    
);

DROP TABLE IF EXISTS localizacao;
CREATE TABLE localizacao(
    idLocalizacao int identity NOT NULL,
    uf char(2) NOT NULL,
    cidade varchar(50) NOT NULL,
    bairro varchar(50) NOT NULL,
    logradouro varchar(100) NOT NULL,
    numero smallint NOT NULL,
    cep char(8) NOT NULL,
    primary key (idLocalizacao)
);

DROP TABLE IF EXISTS transacao;
CREATE TABLE transacao(
    idTransacao int identity NOT NULL,
    idFornecedor int NULL,
    idTransportadora int NOT NULL,
    dataRegistro datetime NOT NULL,
    dataFim datetime NULL,
    preco decimal(9, 2) NOT NULL,
    frete decimal(9, 2) NULL,
    imposto decimal(9, 2) NULL,
    tipo bit NOT NULL,
    primary key (idTransacao)
);

DROP TABLE IF EXISTS transacaoItens; 
CREATE TABLE transacaoItens(
    idTransacaoItens int identity NOT NULL,
    idEstoqueItens int NOT NULL,
    idProduto int NOT NULL,
    idEstoque int NOT NULL,
    idtransacao int NOT NULL,
    qtde int NOT NULL,
    primary key (idTransacaoItens)
);

DROP TABLE IF EXISTS fornecedor;
CREATE TABLE fornecedor(
    idFornecedor int identity NOT NULL,
    idLocalizacao int NOT NULL,
    nome varchar(100),
    cnpj char(14) NOT NULL,
    telefone varchar(20) NOT NULL,
    email varchar(256) NOT NULL,
    primary key (idFornecedor)
);

DROP TABLE IF EXISTS transportadora;
CREATE TABLE transportadora(
    idTransportadora int identity NOT NULL,
    idLocalizacao int NOT NULL,
    nome varchar(100),
    cnpj char(14) NOT NULL,
    telefone varchar(20) NULL,
    email varchar(50) NULL,
    primary key (idTransportadora)
);

ALTER TABLE produto ADD CONSTRAINT fk_produto_categoria foreign key (idCategoria) references categoria (idCategoria);


ALTER TABLE estoque ADD CONSTRAINT fk_estoque_localizacao foreign key (idLocalizacao) references localizacao(idLocalizacao);

ALTER TABLE estoqueItens ADD CONSTRAINT fk_estoqueItens_produto foreign key (idProduto) references produto(idProduto);
ALTER TABLE estoqueItens ADD CONSTRAINT fk_estoqueItens_estoque foreign key (idEstoque) references estoque(idEstoque);

ALTER TABLE transacao ADD CONSTRAINT fk_entrada_fornecedor foreign key (idFornecedor) references fornecedor (idFornecedor);
ALTER TABLE transacao ADD CONSTRAINT fk_entrada_trasportadora foreign key (idTransportadora) references transportadora (idTransportadora);

ALTER TABLE transacaoItens ADD CONSTRAINT fk_transacaoItens_estoqueItens foreign key (idEstoqueItens, idEstoque, idProduto) references estoqueItens (idEstoqueItens, idEstoque, idProduto);
ALTER TABLE transacaoItens ADD CONSTRAINT fk_transacaoItens_transacao foreign key (idTransacao) references transacao (idTransacao); 

ALTER TABLE fornecedor ADD CONSTRAINT fk_fornecedor_localizacao foreign key (idLocalizacao) references localizacao (idLocalizacao);

ALTER TABLE transportadora ADD CONSTRAINT fk_trasportadora_localizacao foreign key (idLocalizacao) references localizacao (idLocalizacao);
