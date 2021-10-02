.mode	columns
.headers	on
.nullvalue	NULL

Select username,eMusical
From
(
  Select idEntidadeMusical,nomeArtistico as eMusical, count(idAlbum) as nrOuvidos
  From Compoe natural join EntidadeMusical natural join album
  group by idEntidadeMusical
)
natural join
(
  Select idUtilizador,idEntidadeMusical,username,count(idAlbum) as nrOuvidos
  From FavoritoAlbum natural join album natural join utilizador natural join Compoe
  group by idUtilizador,idEntidadeMusical
)
Order By idUtilizador
