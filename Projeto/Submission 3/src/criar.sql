-- Desativar foreign_keys para evitar erros na DROP TABLE. Estas são atividades no povoar.sql
-- para garantir a integridade referencial
PRAGMA foreign_keys = off;
.mode columns
.headers on
.nullvalue NULL

DROP TABLE IF EXISTS Pessoa;
CREATE TABLE Pessoa (
  idPessoa                    INTEGER                 PRIMARY KEY,
  nome                        VARCHAR(255)            NOT NULL,
  dataNascimento              VARCHAR(255),
  codPostal                   VARCHAR(255),
  morada                      VARCHAR(255)
);

DROP TABLE IF EXISTS Artista;
CREATE TABLE Artista (
  idArtista                   INTEGER                 PRIMARY KEY REFERENCES Pessoa(idPessoa) ON DELETE SET NULL ON UPDATE CASCADE,
  inicioCarreira              INTEGER
);

DROP TABLE IF EXISTS Utilizador;
CREATE TABLE Utilizador (
  idUtilizador               INTEGER                 PRIMARY KEY REFERENCES Pessoa(idPessoa) ON DELETE SET NULL ON UPDATE CASCADE,
  email                      VARCHAR(255)            NOT NULL UNIQUE,
  username                   VARCHAR(255)            NOT NULL UNIQUE,
  password                   VARCHAR(255)            NOT NULL,
  CONSTRAINT fracaPassword CHECK(length(password) > 8)
);

DROP TABLE IF EXISTS Papel;
CREATE TABLE Papel (
  idPapel                    INTEGER                 PRIMARY KEY,
  atividade                  VARCHAR(255)            NOT NULL UNIQUE
);

DROP TABLE IF EXISTS EntidadeMusical;
CREATE TABLE EntidadeMusical (
  idEntidadeMusical          INTEGER                 PRIMARY KEY,
  nomeArtistico              VARCHAR(255)            NOT NULL,
  imagem                     VARCHAR(255),
  dataFundacao               VARCHAR(255),
  descricao                  VARCHAR(255)
);

DROP TABLE IF EXISTS Album;
CREATE TABLE Album (
  idAlbum                    INTEGER                 PRIMARY KEY,
  nome                       VARCHAR(255)            NOT NULL,
  capa                       VARCHAR(255),
  anoLancamento              INTEGER
);

DROP TABLE IF EXISTS Musica;
CREATE TABLE Musica (
  idMusica                   INTEGER                 PRIMARY KEY,
  idAlbum                    INTEGER                 REFERENCES Album(idAlbum) ON DELETE SET NULL ON UPDATE CASCADE,
  nome                       VARCHAR(255)            NOT NULL,
  duracao                    INTEGER                 NOT NULL,
  CONSTRAINT duracaoMusica CHECK(duracao > 0)
);

DROP TABLE IF EXISTS Playlist;
CREATE TABLE Playlist (
  idPlaylist                 INTEGER                 PRIMARY KEY,
  criador                    INTEGER                 REFERENCES Utilizador(idUtilizador) ON DELETE SET NULL ON UPDATE CASCADE,
  nome                       VARCHAR(255)            NOT NULL,
  imagem                     VARCHAR(255),
  dataCriacao                VARCHAR(255)            NOT NULL,
  descricao                  VARCHAR(255),
  privada                    BOOLEAN                 NOT NULL
);

DROP TABLE IF EXISTS EstiloMusical;
CREATE TABLE EstiloMusical (
  idEstiloMusical            INTEGER                 PRIMARY KEY,
  nome                       VARCHAR(255)            NOT NULL UNIQUE
);

DROP TABLE IF EXISTS Sessao;
CREATE TABLE Sessao (
  idSessao                   INTEGER                 PRIMARY KEY,
  dataInicio                 VARCHAR(255)            NOT NULL
);

DROP TABLE IF EXISTS TempoOuvido;
CREATE TABLE TempoOuvido (
  idSessao                   INTEGER                 REFERENCES Sessao(idSessao) ON DELETE SET NULL ON UPDATE CASCADE,
  idMusica                   INTEGER                 REFERENCES Musica(idMusica) ON DELETE SET NULL ON UPDATE CASCADE,
  duracao                    INTEGER                 NOT NULL,
  CONSTRAINT duracaoTempoOuvido CHECK(duracao > 0)
);

DROP TABLE IF EXISTS Desempenha;
CREATE TABLE Desempenha (
  idArtista                  INTEGER                 REFERENCES Artista(idArtista) ON DELETE SET NULL ON UPDATE CASCADE,
  idPapel                    INTEGER                 REFERENCES Papel(idPapel) ON DELETE SET NULL ON UPDATE CASCADE ,
  PRIMARY KEY(idArtista, idPapel)
);

DROP TABLE IF EXISTS Possui;
CREATE TABLE Possui (
  idEntidadeMusical          INTEGER                 REFERENCES EntidadeMusical(idEntidadeMusical) ON DELETE SET NULL ON UPDATE CASCADE,
  idPapel                    INTEGER                 REFERENCES Papel(idPapel) ON DELETE SET NULL ON UPDATE CASCADE,
  PRIMARY KEY(idEntidadeMusical, idPapel)
);

DROP TABLE IF EXISTS Membro;
CREATE TABLE Membro (
  idArtista                  INTEGER                 REFERENCES Artista(idArtista) ON DELETE SET NULL ON UPDATE CASCADE,
  idEntidadeMusical          INTEGER                 REFERENCES EntidadeMusical(idEntidadeMusical) ON DELETE SET NULL ON UPDATE CASCADE,
  PRIMARY KEY(idArtista, idEntidadeMusical)
);

DROP TABLE IF EXISTS Compoe;
CREATE TABLE Compoe (
  idEntidadeMusical          INTEGER                 REFERENCES EntidadeMusical(idEntidadeMusical) ON DELETE SET NULL ON UPDATE CASCADE,
  idAlbum                    INTEGER                 REFERENCES Album(idAlbum) ON DELETE SET NULL ON UPDATE CASCADE,
  PRIMARY KEY(idEntidadeMusical, idAlbum)
);

DROP TABLE IF EXISTS Segue;
CREATE TABLE Segue (
  idUtilizador               INTEGER                 REFERENCES Utilizador(idUtilizador) ON DELETE SET NULL ON UPDATE CASCADE,
  idEntidadeMusical          INTEGER                 REFERENCES EntidadeMusical(idEntidadeMusical) ON DELETE SET NULL ON UPDATE CASCADE,
  PRIMARY KEY(idUtilizador, idEntidadeMusical)
);

DROP TABLE IF EXISTS FavoritoAlbum;
CREATE TABLE FavoritoAlbum (
  idUtilizador               INTEGER                 REFERENCES Utilizador(idUtilizador) ON DELETE SET NULL ON UPDATE CASCADE,
  idAlbum                    INTEGER                 REFERENCES Album(idAlbum) ON DELETE SET NULL ON UPDATE CASCADE,
  PRIMARY KEY(idUtilizador, idAlbum)
);

DROP TABLE IF EXISTS FavoritoMusica;
CREATE TABLE FavoritoMusica (
  idUtilizador               INTEGER                 REFERENCES Utilizador(idUtilizador) ON DELETE SET NULL ON UPDATE CASCADE,
  idMusica                   INTEGER                 REFERENCES Musica(idMusica) ON DELETE SET NULL ON UPDATE CASCADE,
  data                       VARCHAR(255)            NOT NULL,
  PRIMARY KEY(idUtilizador, idMusica)
);

DROP TABLE IF EXISTS FavoritoPlaylist;
CREATE TABLE FavoritoPlaylist (
  idUtilizador               INTEGER                 REFERENCES Utilizador(idUtilizador) ON DELETE SET NULL ON UPDATE CASCADE,
  idPlaylist                 INTEGER                 REFERENCES Playlist(idPlaylist) ON DELETE SET NULL ON UPDATE CASCADE,
  PRIMARY KEY(idUtilizador, idPlaylist)
);

DROP TABLE IF EXISTS Colabora;
CREATE TABLE Colabora (
  idUtilizador               INTEGER                 REFERENCES Utilizador(idUtilizador) ON DELETE SET NULL ON UPDATE CASCADE,
  idPlaylist                 INTEGER                 REFERENCES Playlist(idPlaylist) ON DELETE SET NULL ON UPDATE CASCADE,
  PRIMARY KEY(idUtilizador, idPlaylist)
);

DROP TABLE IF EXISTS MusicaEstilo;
CREATE TABLE MusicaEstilo (
  idEstiloMusical            INTEGER                 NOT NULL REFERENCES EstiloMusical(idEstiloMusical) ON DELETE SET NULL ON UPDATE CASCADE,
  idMusica                   INTEGER                 NOT NULL REFERENCES Musica(idMusica) ON DELETE SET NULL ON UPDATE CASCADE,
  PRIMARY KEY(idEstiloMusical, idMusica)
);

DROP TABLE IF EXISTS UtilizadorSessao;
CREATE TABLE UtilizadorSessao (
  idUtilizador               INTEGER                 REFERENCES Utilizador(idUtilizador) ON DELETE SET NULL ON UPDATE CASCADE,
  idSessao                   INTEGER                 REFERENCES Sessao(idSessao) ON DELETE SET NULL ON UPDATE CASCADE,
  PRIMARY KEY(idUtilizador, idSessao)
);

DROP TABLE IF EXISTS Pertence;
CREATE TABLE Pertence (
  idPlaylist                 INTEGER                 REFERENCES Playlist(idPlaylist) ON DELETE SET NULL ON UPDATE CASCADE,
  idMusica                   INTEGER                 NOT NULL REFERENCES Musica(idMusica) ON DELETE SET NULL ON UPDATE CASCADE,
  PRIMARY KEY(idMusica, idPlaylist)
);

DROP TABLE IF EXISTS Seguir;
CREATE TABLE Seguir (
  idUtilizador               INTEGER                 REFERENCES Utilizador(idUtilizador) ON DELETE SET NULL ON UPDATE CASCADE,
  idUtilizadorSeguido        INTEGER                 REFERENCES Utilizador(idUtilizador) ON DELETE SET NULL ON UPDATE CASCADE,
  PRIMARY KEY(idUtilizador, idUtilizadorSeguido)
);
