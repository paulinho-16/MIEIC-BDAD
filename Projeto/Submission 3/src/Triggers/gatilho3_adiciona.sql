Create Trigger T3
after insert on Compoe
when exists (
  Select *
  From Compoe natural join Album natural join entidadeMusical
  where anoLancamento < DataFundacao)
Begin
  Select raise(abort,"Can't be the creator of  an album if the band was not formed on that date");
End;