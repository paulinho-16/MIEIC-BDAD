.mode	columns
.headers	on
.nullvalue	NULL

Select username1, username2
From (
    Select s1.idUtilizador, s1.idUtilizadorSeguido
    From seguir s1, seguir s2
    Where s1.idUtilizador = s2.idUtilizadorSeguido and s1.idUtilizadorSeguido = s2.idUtilizador
) natural join (
    Select u1.idUtilizador as name1, u2.idUtilizador as name2, u1.username as username1,u2.username as username2
    From utilizador u1 join utilizador u2
)
Where name1 = idutilizador and name2 = idUtilizadorSeguido and name1 < name2;
