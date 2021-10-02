.mode	columns
.headers	on
.nullvalue	NULL

Select username, AlbumNome
From
(
    Select *, count(idMusica) as nrMusicas
    From
    (
        Select idMusica,idAlbum,album.nome as AlbumNome,duracao,idUtilizador,tOuvido,username
        From Musica natural join
        (
            Select idUtilizador,idMusica,idSessao, max(duracao) as tOuvido
            From UtilizadorSessao natural join tempoOuvido
            Group by idUtilizador,idMusica
        )
        natural join Utilizador join
        album using (idAlbum)
        where tOuvido >= duracao
    )
    group by idUtilizador,idAlbum
)
join
(
    Select nomeArtistico,album.nome as AlbumNome, idAlbum , count(idMusica) as nrMusicas
    From Musica natural join Compoe  natural join entidadeMusical
    join Album using (idAlbum)
    group by nomeArtistico, idAlbum
)
using(idAlbum,nrMusicas,AlbumNome)
Order by username
