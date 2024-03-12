DROP TABLE IF EXISTS aluno;
CREATE TABLE aluno (
	cd_aluno int identity NOT NULL,	
	nm_aluno varchar(100) NOT NULL,
	email varchar(100) NOT NULL
);

go

DROP TABLE IF EXISTS avaliacao_aluno;
CREATE TABLE avaliacao_aluno (
	cd_avaliacao int NOT NULL,
	cd_aluno int NOT NULL,
	ds_avaliacao_aluno varchar(100),
	dt_inicio datetime NOT NULL,
	dt_fim datetime,
);

go

DROP TABLE IF EXISTS resposta_fechada;
CREATE TABLE resposta_fechada (
	cd_avaliacao int NOT NULL,
	cd_aluno int NOT NULL,
	cd_questao_item int NOT NULL,
	dt_resposta datetime NOT NULL
);

go

DROP TABLE IF EXISTS resposta_aberta;
CREATE TABLE resposta_aberta (
	cd_avaliacao int NOT NULL,
	cd_aluno int NOT NULL,
	cd_questao int NOT NULL,
	ds_resposta_aberta varchar(max) NOT NULL,
	dt_resposta datetime NOT NULL
);

go

DROP TABLE IF EXISTS avaliacao;
CREATE TABLE avaliacao (
	cd_avaliacao int IDENTITY NOT NULL, 
	ds_avaliacao varchar(100) NOT NULL, 
	dt_abertura datetime NOT NULL, 
	dt_fechamento datetime 
);

go

DROP TABLE IF EXISTS questao;
CREATE TABLE questao (
	cd_questao int IDENTITY NOT NULL, 
	cd_avaliacao int NOT NULL, 
	ds_questao varchar(max) NOT NULL, 
	tp_questao char(1) NOT NULL
);

go

DROP TABLE IF EXISTS questao_item;
CREATE TABLE questao_item (
	cd_questao_item int IDENTITY NOT NULL, 
	cd_questao int NOT NULL, 
	ds_questao_item varchar(max) NOT NULL, 
	is_correta bit NOT NULL, 
);

go

ALTER TABLE aluno ADD CONSTRAINT pk_aluno PRIMARY KEY (cd_aluno);
ALTER TABLE avaliacao_aluno ADD CONSTRAINT pk_avaliacao_aluno PRIMARY KEY (cd_avaliacao, cd_aluno);
ALTER TABLE resposta_fechada ADD CONSTRAINT pk_resposta_fechada PRIMARY KEY (cd_avaliacao, cd_aluno, cd_questao_item);
ALTER TABLE resposta_aberta ADD CONSTRAINT pk_resposta_aberta PRIMARY KEY (cd_avaliacao, cd_aluno, cd_questao);
ALTER TABLE avaliacao ADD CONSTRAINT pk_avaliacao PRIMARY KEY (cd_avaliacao);
ALTER TABLE questao ADD CONSTRAINT pk_questao PRIMARY KEY (cd_questao);
ALTER TABLE questao_item ADD CONSTRAINT pk_questao_item PRIMARY KEY (cd_questao_item);

go

ALTER TABLE avaliacao_aluno ADD 
	CONSTRAINT fk_avaliacao_avaliacao_aluno FOREIGN KEY (cd_avaliacao) REFERENCES avaliacao (cd_avaliacao),
	CONSTRAINT fk_aluno_avaliacao_aluno FOREIGN KEY (cd_aluno) REFERENCES aluno (cd_aluno);

ALTER TABLE resposta_fechada ADD 
	CONSTRAINT fk_avaliacao_aluno_resposta_fechada FOREIGN KEY (cd_avaliacao, cd_aluno) REFERENCES avaliacao_aluno (cd_avaliacao, cd_aluno),
	CONSTRAINT fk_questao_item_resposta_fechada FOREIGN KEY (cd_questao_item) REFERENCES questao_item (cd_questao_item);

ALTER TABLE resposta_aberta ADD 
	CONSTRAINT fk_avaliacao__resposta_aberta FOREIGN KEY (cd_avaliacao) REFERENCES avaliacao (cd_avaliacao),
	CONSTRAINT fk_aluno__resposta_aberta FOREIGN KEY (cd_aluno) REFERENCES aluno (cd_aluno),
	CONSTRAINT fk_questao__resposta_aberta FOREIGN KEY (cd_questao) REFERENCES questao (cd_questao);

ALTER TABLE questao ADD
	CONSTRAINT chk_questao CHECK (tp_questao IN ('O', 'M', 'D')),
	CONSTRAINT fk_avaliacao__questao FOREIGN KEY (cd_avaliacao) REFERENCES avaliacao (cd_avaliacao);

ALTER TABLE questao_item ADD 
	CONSTRAINT fk_questao__questao_item FOREIGN KEY (cd_questao) REFERENCES questao (cd_questao);
