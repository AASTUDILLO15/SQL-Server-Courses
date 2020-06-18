Create database Escuela;
GO --Sirve para delimitar una sentencia o cionjunto de sentencias para ejecutarlos y luego ejecutar el siguiente sonjunto de sentencias

USE Escuela

CREATE TABLE CARRERA (
ID_CARRERA INT PRIMARY KEY NOT NULL,
CARRERA VARCHAR(20) NOT NULL
);

INSERT INTO CARRERA VALUES(1,'ING.SISTEMAS');
INSERT INTO CARRERA VALUES(2,'LIC.DERECHO');
INSERT INTO CARRERA VALUES(3,'LIC.ADMINISTRACION');

CREATE TABLE ALUMNO(
ID_ALUMNO INT PRIMARY KEY NOT NULL,
NOMBRE VARCHAR(20)NOT NULL,
APELLIDOS VARCHAR(20)NOT NULL,
ID_CARRERA INT NOT NULL,
FOREIGN KEY (ID_CARRERA) REFERENCES CARRERA(ID_CARRERA)
);

INSERT INTO ALUMNO VALUES(1,'DAVID','HERNANDEZ PEREZ',1);
INSERT INTO ALUMNO VALUES(2,'MARIANA','MARTINEZ LUNA',2);
INSERT INTO ALUMNO VALUES(3,'TATIANA','RAMIREZ RAMIREZ',1);
INSERT INTO ALUMNO VALUES(4,'JUAN','ARCILA CAMPAZ',3);

CREATE table datos (
ID_DATOS INT  PRIMARY KEY NOT NULL,
ID_ALUMNO INT NOT NULL,
EMAIL VARCHAR(20)NOT NULL,
EDAD VARCHAR(50)NOT NULL,
FOREIGN KEY (ID_ALUMNO) REFERENCES ALUMNO(ID_ALUMNO)
);

INSERT INTO DATOS VALUES(1,1,'HACKRO@YAHOO.COM',22);
INSERT INTO DATOS VALUES(2,2,'MARIANA',14);
INSERT INTO DATOS VALUES(3,3,'TATIANA',21);
INSERT INTO DATOS VALUES(4,4,'JUANDAVIDARCILA18@',28);

SELECT * FROM ALUMNO
SELECT * FROM CARRERA
SELECT * FROM datos

/* INNER JOIN */

SELECT ALUMNO.NOMBRE, ALUMNO.APELLIDOS, CARRERA.CARRERA, DATOS.EMAIL FROM ALUMNO
INNER JOIN CARRERA ON CARRERA.ID_CARRERA = ALUMNO.ID_CARRERA
INNER JOIN DATOS ON DATOS.ID_ALUMNO = ALUMNO.ID_ALUMNO--Muestra sólo los match de las dos tablas con la control field

/* LEFT AND RIGHT JOIN solo 2 tablas */

SELECT * FROM ALUMNO LEFT JOIN datos ON datos.ID_ALUMNO = ALUMNO.ID_ALUMNO--Muestratodos sólo los match de la tabla izquierda y todos los datos de la tabla derecha así no haya match con la control field
SELECT * FROM ALUMNO RIGHT JOIN datos ON datos.ID_ALUMNO = ALUMNO.ID_ALUMNO--Muestratodos sólo los match de la tabla derecha y todos los datos de la tabla izquierda así no haya match con la control field

/*JOIN AND GROUP BY */

SELECT	COUNT(ALUMNO.ID_CARRERA) AS CANTIDAD_ALUMNO_CARRERA, CARRERA.CARRERA FROM ALUMNO
INNER JOIN CARRERA ON CARRERA.ID_CARRERA=ALUMNO.ID_CARRERA
GROUP BY CARRERA.CARRERA

/*JOIN UPDATE AND DELETE */

UPDATE ALUMNO SET NOMBRE='ALEJANDRA'
FROM ALUMNO INNER JOIN CARRERA ON CARRERA.ID_CARRERA=ALUMNO.ID_CARRERA
WHERE CARRERA.ID_CARRERA=2

/* ALTER TABLE */

ALTER TABLE CARRERA ADD Cupo_Limitado int
ALTER TABLE CARRERA ADD Cupo_Minimo int
GO

UPDATE CARRERA SET Cupo_Minimo=10 WHERE ID_CARRERA=1
UPDATE CARRERA SET Cupo_Minimo=15 WHERE ID_CARRERA=2
UPDATE CARRERA SET Cupo_Minimo=15 WHERE ID_CARRERA=3
UPDATE CARRERA SET Cupo_Limitado=50 WHERE ID_CARRERA=1
UPDATE CARRERA SET Cupo_Limitado=60 WHERE ID_CARRERA=2
UPDATE CARRERA SET Cupo_Limitado=65 WHERE ID_CARRERA=3

ALTER TABLE CARRERA ALTER COLUMN Cupo_Minimo int NOT NULL
ALTER TABLE CARRERA ALTER COLUMN Cupo_Limitado int NOT NULL

ALTER TABLE CARRERA ADD Resta AS (Cupo_Minimo + 100)--Añade columna con la operacion indicada
ALTER TABLE CARRERA DROP COLUMN Resta

/* SUBCONSULTAS */

SELECT * FROM CARRERA WHERE CARRERA.ID_CARRERA = (SELECT ID_CARRERA FROM CARRERA WHERE ID_CARRERA=1)

USE Tutorial
ALTER TABLE Libros ADD Num_Pags int

SELECT * FROM Libros

UPDATE Libros SET Num_Pags = 25 WHERE ID_Libro=1
UPDATE Libros SET Num_Pags = 52 WHERE ID_Libro=2
UPDATE Libros SET Num_Pags = 56 WHERE ID_Libro=3
UPDATE Libros SET Num_Pags = 785 WHERE ID_Libro=4
UPDATE Libros SET Num_Pags = 14 WHERE ID_Libro=5
UPDATE Libros SET Num_Pags = 250 WHERE ID_Libro=6
UPDATE Libros SET Num_Pags = 205 WHERE ID_Libro=7
UPDATE Libros SET Num_Pags = 265 WHERE ID_Libro=8
UPDATE Libros SET Num_Pags = 68 WHERE ID_Libro=9
UPDATE Libros SET Num_Pags = 70 WHERE ID_Libro=10
UPDATE Libros SET Num_Pags = 21 WHERE ID_Libro=11
UPDATE Libros SET Num_Pags = 25 WHERE ID_Libro=12
UPDATE Libros SET Num_Pags = 30 WHERE ID_Libro=13
UPDATE Libros SET Num_Pags = 78 WHERE ID_Libro=14
UPDATE Libros SET Num_Pags = 916 WHERE ID_Libro=15
UPDATE Libros SET Num_Pags = 64 WHERE ID_Libro=16

SELECT * FROM Libros WHERE ID_Libro in (2,4,6)
SELECT * FROM Libros WHERE ID_Libro not in (2,4,6)

SELECT ID_Libro FROM Libros WHERE ID_Libro IN (SELECT ID_Libro FROM Libros WHERE Num_Pags>100)

SELECT * FROM Libros WHERE Ganancia = 40 AND Precio_Venta = any (SELECT Precio_Venta FROM Libros WHERE Precio_Compra>100)
ORDER BY Titulo

SELECT * FROM Libros WHERE Ganancia = 40 AND Precio_Venta <> all (SELECT Precio_Venta FROM Libros WHERE Precio_Compra>100)
ORDER BY Titulo

UPDATE Libros SET Titulo = 'Cronicas de una muerte anunciada' WHERE Autor = 'Elena'
AND Precio_Compra > (SELECT Precio_Venta FROM Libros WHERE Titulo = 'El codigo Da Vinci')

DELETE Libros WHERE Num_Pags = any (SELECT Precio_Venta FROM Libros WHERE Autor='Luis')

SELECT * FROM Names
INSERT INTO Names (Name)
SELECT (Name)
FROM Usuarios--Se insertaron los nombres de Usuarios a Names

/* VISTAS */

CREATE VIEW Libros_view--Error porque debe ser la unica sentencia en el query
AS SELECT Titulo, Descripcion, Autor FROM Libros--Vistas creadas, son dinamicas
SELECT * FROM Libros_view--Sirven para mostrar solo ciertas columnas de las tablas
sp_helptext Libros_view-- Ver la sentencia de la vista

CREATE VIEW Libros_2view WITH ENCRYPTION AS--Se cifra la vista
SELECT Titulo, Descripcion, Autor, Num_Pags FROM Libros
SELECT * FROM Libros_2view
sp_helptext Libros_2view-- No se puede ver la sentencia de la vista porque esta cifrada

DROP VIEW Libros_view--Eliminar las vistas. Cuando se eliminan las vistas no se eliminan las tablas

USE empleados
GO

CREATE VIEW Mujeres WITH ENCRYPTION AS
SELECT * FROM usuarios WHERE sexo='F'

SELECT * FROM Mujeres ORDER BY edad
UPDATE Mujeres SET tipo_usuario = 'root' WHERE edad>25--A traves de la vista se puede act la tabla
DELETE FROM Mujeres WHERE id_usuario=20

CREATE VIEW Hombres WITH ENCRYPTION AS
SELECT * FROM usuarios WHERE sexo='M'
WITH CHECK OPTION--Condiciono la vista para que no elimine más allá de los datos de la tabla. Solo los de la vista.
SELECT * FROM Hombres ORDER BY edad
DELETE FROM Hombres--Elimino solo los de la vista sexo='M'

ALTER VIEW Hombres as
SELECT * FROM usuarios WHERE sexo='M' AND edad>18