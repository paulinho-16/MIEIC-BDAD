.mode	columns
.headers	on
.nullvalue	NULL

SELECT  nome as musica, count(*) AS nrFavoritada
FROM FavoritoMusica NATURAL JOIN Musica
GROUP BY idMusica
ORDER BY NrFavoritada
DESC LIMIT 10;
