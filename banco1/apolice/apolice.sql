DROP TABLE IF EXISTS cliente;
CREATE TABLE cliente (
	cod_cliente int identity NOT NULL,
	nome varchar(50),
	cpf char(11),
	sexo char(1),
	endereco varchar(200),
	telefone_fixo varchar(10),
	telefone_celular varchar(11)
);

DROP TABLE IF EXISTS apolice;
CREATE TABLE apolice (
	cod_apolice int identity NOT NULL,
	cod_cliente int NOT NULL,
	data_inicio_vigencia date NOT NULL,
	data_fin_vigencia date NOT NULL,
	valor_cobertura numeric(10,2) NOT NULL,
	valor_franquia numeric(10,2) NOT NULL,
	placa char(10) NOT NULL
);

DROP TABLE IF EXISTS carro;
CREATE TABLE carro (
	placa char(10),
	modelo varchar(50),
	chassi varchar(30),
	marca varchar(30),
	ano tinyint,
	cor varchar(10)
);

DROP TABLE IF EXISTS sinistro;
CREATE TABLE sinistro (
	cod_sinistro int identity NOT NULL,
	placa char(10) NOT NULL,
	data_sinistro date NOT NULL,
	hora_sinistro time NOT NULL,
	local_sinistro varchar(100) NOT NULL,
	condutor varchar(50)
);


DBCC CHECKIDENT('cliente', RESEED, 0);
DBCC CHECKIDENT('apolice', RESEED, 0);
DBCC CHECKIDENT('sinistro', RESEED, 0);

ALTER TABLE cliente 
	ADD CONSTRAINT pk_cliente_cod primary key (cod_cliente);

ALTER TABLE apolice 
	ADD CONSTRAINT pk_apolice_cod primary key (cod_apolice)
	ADD CONSTRAINT fk_cliente_apolice foreign key (cod_cliente) references cliente (cod_cliente)
	ADD CONSTRAINT fk_carro_apolice foreign key (placa) references carro (placa);

ALTER TABLE carro 
	ADD CONSTRAINT pk_carro_placa primary key (placa);

ALTER TABLE sinistro 
	ADD CONSTRAINT pk_sinistro_cod primary key (cod_sinistro)
	ADD CONSTRAINT fk_carro_sinistro foreign key (placa) references carro (placa);