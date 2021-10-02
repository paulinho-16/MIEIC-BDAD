Create Trigger T2
before insert on Segue
when not exists (
  Select *
  From FavoritoMusica natural join Compoe natural join musica
  Where idUtilizador =  new.idutilizador and  idEntidadeMusical = new.idEntidadeMusical
)
Begin
  select raise(abort,"Can't Follow a band if you don't like any of their songs");
End;
