CREATE DATABASE IF NOT EXISTS RedeSocial;
USE RedeSocial;

CREATE TABLE TipoUsuario ( 
	idTipoUsuario INT PRIMARY KEY,  
	Nome VARCHAR(255)
); 

CREATE TABLE Usuario ( 
	idUsuario INT PRIMARY KEY AUTO_INCREMENT,  
	idTipoUsuario INT,  
	FOREIGN KEY(idTipoUsuario) REFERENCES TipoUsuario (idTipoUsuario),

	Nome VARCHAR(255) NOT NULL,  
	Salt BINARY(32) NOT NULL,  
	Senha_hash BINARY(32) NOT NULL,  
	Email VARCHAR(254) NOT NULL UNIQUE,  
	CPF CHAR(11) NOT NULL UNIQUE,  
	Telefone CHAR(11)
); 

CREATE TABLE TokensUsuario ( 
	idTokensUsuario INT PRIMARY KEY AUTO_INCREMENT,  
	idUsuario INT,  
	IpCliente VARCHAR(20) NOT NULL,  
	DataEmissao DATE NOT NULL,  
	Salt BINARY(32) NOT NULL,
	Token_hash BINARY(32) NOT NULL,
	Validade DATE, 
    
	FOREIGN KEY(idUsuario) REFERENCES Usuario (idUsuario)
); 

CREATE TABLE Endereco ( 
	idEndereco INT PRIMARY KEY AUTO_INCREMENT,  
	idUsuario INT,  
	Logradouro VARCHAR(255) NOT NULL,  
	Numero VARCHAR(255) NOT NULL,  
	Bairro VARCHAR(255),  
	Cidade VARCHAR(255),  
	Estado VARCHAR(255),  
	CEP CHAR(9),  

	FOREIGN KEY(idUsuario) REFERENCES Usuario (idUsuario)
); 

CREATE TABLE Canal ( 
	idCanal INT PRIMARY KEY AUTO_INCREMENT,  
	Nome VARCHAR(255),  
	Bio VARCHAR(2048) DEFAULT "",  
	Caminho_foto VARCHAR(255),  
	Caminho_banner VARCHAR(255),  
	idUsuario INT,  
	FOREIGN KEY(idUsuario) REFERENCES Usuario (idUsuario)
); 

CREATE TABLE Comentario ( 
	idComentario INT PRIMARY KEY AUTO_INCREMENT,  
	Texto VARCHAR(255) NOT NULL,  
	idCanal INT,  
	idAutor INT,  
	FOREIGN KEY(idCanal) REFERENCES Canal (idCanal),
	FOREIGN KEY(idAutor) REFERENCES Usuario (idUsuario)
); 

CREATE TABLE LikeCanal ( 
	idUsuario INT,  
	idCanal INT,  
	Dislike BOOLEAN DEFAULT FALSE,

	FOREIGN KEY(idCanal) REFERENCES Canal (idCanal),
	FOREIGN KEY(idUsuario) REFERENCES Usuario (idUsuario),
	PRIMARY KEY(idUsuario, idCanal)
); 

CREATE TABLE LikeComentario ( 
	idUsuario INT,  
	idComentario INT,
	Dislike BOOLEAN DEFAULT FALSE,
	
	FOREIGN KEY(idComentario) REFERENCES Comentario (idComentario),
	FOREIGN KEY(idUsuario) REFERENCES Usuario (idUsuario),
	PRIMARY KEY(idUsuario, idComentario)
);




INSERT INTO TipoUsuario (idTipoUsuario, Nome) 
VALUES
	(1, "Comum"),
	(2, "Moderador"),
	(3, "Administrador");