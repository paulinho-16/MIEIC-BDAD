.mode	columns
.headers	on
.nullvalue	NULL

SELECT email, username,count(Distinct idEstiloMusical) AS nrEstilosFavoritos
FROM FavoritoMusica NATURAL JOIN Utilizador NATURAL JOIN MusicaEstilo
GROUP BY idUtilizador;
