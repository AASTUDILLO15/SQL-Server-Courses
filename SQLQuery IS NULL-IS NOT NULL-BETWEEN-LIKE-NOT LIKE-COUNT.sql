/* CAMBIAR ALLOW NULLS TO NOT NULL*/

ALTER TABLE Libros ALTER COLUMN Autor varchar(50) NOT NULL

/* IS NULL BETWEEN */

UPDATE Libros SET Descripcion=NULL WHERE ID_Libro=3 OR ID_Libro=6
SELECT * FROM Libros WHERE Descripcion is null --Busca los registros que son nulos.
SELECT * FROM Libros WHERE Descripcion is not null --Busca los registros que no son nulos. NO ES RECOMENDABLE
SELECT * FROM Libros WHERE Precio_Compra between 100 and 200 --Busca registros entre os valores ingresados

/* LIKE NOT LIKE */

SELECT * FROM Libros WHERE Titulo like '%de%'--Buscar los registros que tengan esa cadena
SELECT * FROM Libros WHERE Titulo not like '%de%'--Buscar los registros que no tengan esa cadena
SELECT * FROM Libros WHERE Titulo like 'la%'--Buscar los registros que comiencen con esa cadena
SELECT * FROM Libros WHERE Titulo like '%as'--Buscar los registros que terminen con esa cadena
SELECT * FROM Libros WHERE Autor like '%Yord_%'--Buscar los registros que tengan esa cadena y el _ es un comodin

/* COUNT */

SELECT COUNT (*) FROM Libros
SELECT COUNT (Descripcion) FROM Libros--No cuentan los nulos