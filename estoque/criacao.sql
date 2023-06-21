CREATE TABLE categoria(
    idCategoria int identity NOT NULL,
    nome varchar(50) NOT NULL,
    descricao text NULL, 
    primary key (idCategoria)
);

CREATE TABLE produto(
    idProduto int identity NOT NULL,
    idCategoria int NOT NULL,
    nome varchar(50) NOT NULL,
    descricao text NULL,
    peso decimal(14,4) NULL,
    preco decimal(12,2) NULL,
    primary key (idProduto)
);

CREATE TABLE estoque(
    idEstoque int identity NOT NULL,
    idProduto int NOT NULL,
    idLocalizacao int NOT NULL,
    nome text NOT NULL,
    qtde_min int NOT NULL,
    qtde_estoque int NOT NULL,
    total int NOT NULL,
    primary key (idEstoque)    
);

CREATE TABLE localizacao(
    idLocalizacao int identity NOT NULL,
    nome varchar(50) NOT NULL,
    cidade varchar(50) NOT NULL,
    bairro varchar(50) NOT NULL,
    logradouro varchar(50) NOT NULL,
    numero int NOT NULL,
    cep int NOT NULL,
    primary key (idLocalizacao)
);

CREATE TABLE transacao(
    idTransacao int identity NOT NULL,
    idFornecedor int NOT NULL,
    idTransportadora int NOT NULL,
    data_compra datetime NOT NULL,
    data_entrada datetime NULL,
    preco decimal(12, 2) NOT NULL,
    frete decimal(12, 2) NULL,
    imposto decimal(12, 2) NULL,
    tipo int NOT NULL CHECK (tipo in (1,2)),
    primary key (idTransacao)
);

CREATE TABLE transacaoItens(
    idTransacaoItens int identity NOT NULL,
    idProduto int NOT NULL,
    idEstoque int NOT NULL,
    idtransacao int NOT NULL,
    qtde int NOT NULL,
    primary key (idTransacaoItens)
);

CREATE TABLE fornecedor(
    idFornecedor int identity NOT NULL,
    idLocalizacao int NOT NULL,
    nome varchar(100),
    cnpj varchar(14) NOT NULL,
    telefone varchar(20) NOT NULL,
    email text NOT NULL,
    primary key (idFornecedor)
);

CREATE TABLE transportadora(
    idTransportadora int identity NOT NULL,
    idLocalizacao int NOT NULL,
    cnpj varchar(14) NOT NULL,
    telefone varchar(20) NULL,
    email varchar(50) NULL,
    primary key (idTransportadora)
);

ALTER TABLE produto ADD CONSTRAINT fk_produto_categoria foreign key (idCategoria) references categoria (idCategoria);

ALTER TABLE estoque ADD CONSTRAINT fk_estoque_produto foreign key (idProduto) references produto(idProduto);
ALTER TABLE estoque ADD CONSTRAINT fk_estoque_localizacao foreign key (idLocalizacao) references localizacao(idLocalizacao);

ALTER TABLE transacao ADD CONSTRAINT fk_entrada_fornecedor foreign key (idFornecedor) references fornecedor (idFornecedor);
ALTER TABLE transacao ADD CONSTRAINT fk_entrada_trasportadora foreign key (idTransportadora) references transportadora (idTransportadora);

ALTER TABLE transacaoItens ADD CONSTRAINT fk_transacaoItens_produto foreign key (idProduto) references produto (idProduto);
ALTER TABLE transacaoItens ADD CONSTRAINT fk_transacaoItens_estoque foreign key (idEstoque) references estoque (idEstoque);
ALTER TABLE transacaoItens ADD CONSTRAINT fk_transacaoItens_transacao foreign key (idTransacao) references transacao (idTransacao); 

ALTER TABLE fornecedor ADD CONSTRAINT fk_fornecedor_localizacao foreign key (idLocalizacao) references localizacao (idLocalizacao);

ALTER TABLE transportadora ADD CONSTRAINT fk_trasportadora_localizacao foreign key (idLocalizacao) references localizacao (idLocalizacao);
