.mode	columns
.headers	on
.nullvalue	NULL

SELECT nomeArtistico As entidadeMusical, nome AS estiloMusical, max(occurences) as nrMusicas
FROM EntidadeMusical NATURAL JOIN
(
  SELECT idEntidadeMusical, nome, count(nome) as occurences
  FROM Compoe
  NATURAL JOIN
  (
    SELECT idEstiloMusical, idMusica, nome, idAlbum
    FROM MusicaEstilo
    NATURAL JOIN
    (
      SELECT *
      FROM EstiloMusical JOIN Musica
    )
  )
  GROUP BY idEntidadeMusical, idEstiloMusical
)
GROUP BY idEntidadeMusical;
