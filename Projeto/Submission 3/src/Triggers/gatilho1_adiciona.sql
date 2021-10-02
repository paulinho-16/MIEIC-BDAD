Create Trigger T1
before insert on TempoOuvido
when exists (select * from TempoOuvido where (idSessao = new.idSessao and idMusica = new.idMusica))
Begin
  Update TempoOuvido
  set duracao = duracao + new.duracao
  where new.idSessao = idSessao and new.idMusica = idMusica;
  select raise(ignore);
End;
