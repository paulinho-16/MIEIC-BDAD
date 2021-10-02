.mode	columns
.headers	on
.nullvalue	NULL


-- Número de Músicas que já começou a a ouvir
Drop View if exists MusicasOuvidas;
Create View MusicasOuvidas As
Select idUtilizador, count(distinct idMusica) as  nrMusicas
From UtilizadorSessao natural join tempoOuvido
Group by idUtilizador;

-- Número de Albuns dos quais já se ouviu uma música
Drop View if exists AlbunsOuvidos;
Create View AlbunsOuvidos As
Select idUtilizador,count(distinct idAlbum) as nrAlbuns
From UtilizadorSessao natural join tempoOuvido  join Musica using(idMusica)
Group by idUtilizador;

-- Número de Entidades Musicais de que já ouviu uma música
Drop View if exists EMOuvidas;
Create View EMOuvidas As
Select idUtilizador,count(distinct idEntidadeMusical) as nrEntidadesMusicais
From UtilizadorSessao natural join tempoOuvido  join Musica using(idMusica) natural join Compoe 
Group by idUtilizador;

-- Tempo total ouvido de música, em segundos
Drop View if exists MusicaTempoOuvido;
Create View MusicaTempoOuvido As
Select idUtilizador, sum(duracao) as tOuvido
From UtilizadorSessao natural join tempoOuvido
Group by idUtilizador;

-- Número de estilos músicais já ouvidos
Drop View if exists EstilosMusicaisOuvidos;
Create View EstilosMusicaisOuvidos As
Select idUtilizador, count(distinct idEstiloMusical) as nrEstilosMusicais
From UtilizadorSessao natural join tempoOuvido  join Musica using(idMusica) natural join musicaEstilo
group by idUtilizador;

-- Número de Músicas favoritadas
Drop View if exists Musicasfavoritadas;
Create View Musicasfavoritadas As
Select idUtilizador, count(distinct idMusica) as  nrMusicasFavoritas
From favoritoMusica
Group by idUtilizador;


-- Número de Albuns seguidos
Drop View if exists Albunsfavoritados;
Create View Albunsfavoritados As
Select idUtilizador, count(distinct idAlbum) as nrAlbunsFavoritos
From favoritoAlbum
Group by idUtilizador;


-- Número de Entidades Musicais Seguidas
Drop View if exists EMfavoritadas;
Create View EMfavoritadas As
Select idUtilizador, count(distinct idEntidadeMusical) as nrEMseguidas
From segue
Group By idUtilizador;


-- Views que mostras as estatísticas
Drop view if exists stats;
Create view stats as
Select *
From Utilizador natural left join
MusicasOuvidas natural left join
AlbunsOuvidos natural left join
EMOuvidas natural left  join
MusicaTempoOuvido natural left join
EstilosMusicaisOuvidos natural left join
Musicasfavoritadas natural left join
Albunsfavoritados natural left join
EMfavoritadas;

-- Query a mostras as estatísticas ( motra usrname em vez de id e os valores a 0 em vez de "null" )
Select username,
       coalesce(nrMusicas,0) as nrMusicas, 
       coalesce(nrAlbuns,0) as nrAlbuns,
       coalesce(nrEntidadesMusicais,0) as nrEntidadesMusicais,
       coalesce(tOuvido,0) as tOuvido,
       coalesce(nrEstilosMusicais,0) as nrEstilosMusicais,
       coalesce(nrMusicasFavoritas,0) as nrMusicasFavoritas,
       coalesce(nrAlbunsFavoritos,0) as nrAlbunsFavoritos,
       coalesce(nrEMseguidas,0) as nrEMseguidas
From stats;













