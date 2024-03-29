CREATE TABLE PAISES (
	ID INT NOT NULL AUTO_INCREMENT,
	DESCRICAO VARCHAR (255) NOT NULL,
	CONSTRAINT PK_PAISES PRIMARY KEY (ID)
);

CREATE TABLE ESTADOS (
	ID INT NOT NULL AUTO_INCREMENT,
	ID_PAIS INT NOT NULL,
	DESCRICAO VARCHAR(255) NOT NULL,
	CONSTRAINT PK_ESTADOS PRIMARY KEY (ID),
	CONSTRAINT FK_ESTADOS_PAISES FOREIGN KEY (ID_PAIS) REFERENCES PAISES(ID)
);

CREATE TABLE CIDADES (
	ID INT NOT NULL AUTO_INCREMENT,
	ID_ESTADO INT NOT NULL,
	DESCRICAO VARCHAR(255) NOT NULL,
	CONSTRAINT PK_CIDADES PRIMARY KEY (ID),
	CONSTRAINT FK_CIDADES_ESTADOS FOREIGN KEY (ID_ESTADO) REFERENCES ESTADOS(ID)
);

CREATE TABLE PESSOAS (
	ID INT NOT NULL AUTO_INCREMENT,
	NOME VARCHAR(255) NOT NULL,
	CPF VARCHAR(14),
	DT_NASC DATE,
	TIPO_PESSOA VARCHAR(20),
	IMAGEM longblob,
	CONSTRAINT PK_PESSOAS PRIMARY KEY (ID)
	);

CREATE TABLE PESSOAS_ENDERECOS (
	ID INT NOT NULL AUTO_INCREMENT,
	ID_PESSOA INT NOT NULL,
	ID_CIDADE INT NOT NULL,
	DESCRICAO VARCHAR(255) NOT NULL,
	NUMERO VARCHAR (5),
	BAIRRO VARCHAR(50),
	CONSTRAINT PK_PESSOAS_ENDERECOS PRIMARY KEY (ID),
	CONSTRAINT FK_PESSOAS_ENDERECOS_PESSOAS FOREIGN KEY (ID_PESSOA) REFERENCES PESSOAS(ID),
	CONSTRAINT FK_PESSOAS_ENDERECOS_CIDADES FOREIGN KEY (ID_CIDADE) REFERENCES CIDADES(ID)
);

CREATE TABLE PESSOAS_TELEFONES (
	ID INT NOT NULL AUTO_INCREMENT,
	ID_PESSOA INT NOT NULL,
	DESCRICAO VARCHAR(255),
	NRO_TELEFONE VARCHAR(15),
	CONSTRAINT PK_PESSOAS_TELEFONES PRIMARY KEY (ID),
	CONSTRAINT FK_PESSOA_TELEFONES FOREIGN KEY (ID_PESSOA) REFERENCES PESSOAS(ID)
);

CREATE TABLE USUARIOS (
	ID INT NOT NULL AUTO_INCREMENT,
	LOGIN VARCHAR(255) NOT NULL,
	SENHA VARCHAR(255) NOT NULL,
	CONSTRAINT PK_USUARIO PRIMARY KEY (ID)
);

CREATE TABLE EMISSAO_CONTA (
	ID INT NOT NULL AUTO_INCREMENT,
	DT_AFERICAO DATE NOT NULL,
	VL_RELOGIO_MES_ATUAL NUMERIC(38) NOT NULL,
	VL_RELOGIO_MES_PASSADO NUMERIC(38) NOT NULL,
	VL_TARIFA_MES NUMERIC(38) NOT NULL,
	VL_TOTAL NUMERIC(38),
	ID_CLIENTE INT NOT NULL,
	ID_FUNCIONARIO INT,
	CONSTRAINT EMISSAO_CONTA_PKEY PRIMARY KEY (ID),
	CONSTRAINT FK_EMISSAO_CONTA_ID_CLIENTE FOREIGN KEY (ID_CLIENTE) REFERENCES PESSOAS(ID),
	CONSTRAINT FK_EMISSAO_CONTA_ID_FUNCIONARIO FOREIGN KEY (ID_FUNCIONARIO) REFERENCES PESSOAS(ID)
);