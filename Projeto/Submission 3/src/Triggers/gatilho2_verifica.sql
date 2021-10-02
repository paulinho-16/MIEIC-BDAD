Select * from Segue;

.print "\nTentativa do Utilizador 1 de Seguir a Billie Eilish sem ter nos favoritos uma música dela"
Insert into Segue Values (1,4);
 
.print "\nUtilizador 1 vai adicionar aos favoritos uma Música da Billie Eilish\n"
Insert into FavoritoMusica Values (1,41,"2020-05-17");

Insert into Segue Values (1,4);

Select * from Segue;
.print "\nSucesso do Utilizador 1 ao seguir a Billie Eilish"