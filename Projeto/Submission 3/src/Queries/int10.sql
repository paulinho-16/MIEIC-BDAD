.mode	columns
.headers	on
.nullvalue	NULL



Select username,nomeArtistico
From
(
  Select *, count(idMusica) as number
  From
  (
      Select idEntidadeMusical,idUtilizador,idMusica,username,nomeArtistico
      From Musica natural join
      (
          Select idUtilizador,idMusica,idSessao, max(duracao) as tOuvido
          From UtilizadorSessao natural join tempoOuvido
          Group by idUtilizador,idMusica
      )
      natural join Utilizador join
      album using (idAlbum)
      natural join compoe natural join entidadeMusical natural join segue
      where tOuvido >= duracao
  )
  group by idUtilizador,idEntidadeMusical
)
natural join
(
  Select nomeArtistico, count(nome) as number
  From Musica join (Compoe  natural join entidadeMusical) using (idAlbum)
  group by nomeArtistico
)
order by username
