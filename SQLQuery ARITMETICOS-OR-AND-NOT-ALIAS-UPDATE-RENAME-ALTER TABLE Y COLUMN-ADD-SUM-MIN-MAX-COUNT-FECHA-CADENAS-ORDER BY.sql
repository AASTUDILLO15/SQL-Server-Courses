USE Tutorial

/* OPERADORES ARITMETICOS */

CREATE TABLE Libros
(ID_Libro int identity PRIMARY KEY,
Nombre varchar(50) NOT NULL,
Precio_Venta int NOT NULL,
Precio_Compra float NOT NULL)

INSERT INTO Libros VALUES ('El Lobo', 115, 95.23)
INSERT INTO Libros VALUES ('Caperusa Roja', 236, 189.25)
INSERT INTO Libros VALUES ('Programacion en Java', 123, 101.56)
INSERT INTO Libros VALUES ('Programacion desde cero con C', 78, 50.36)
INSERT INTO Libros VALUES ('SQL Server 2000', 456, 368.56)
INSERT INTO Libros VALUES ('El Codigo Da Vinci', 232, 199.98)
INSERT INTO Libros VALUES ('Aura', 147, 112.31)
INSERT INTO Libros VALUES ('Cien Años de Soledad', 166, 124.23)
INSERT INTO Libros VALUES ('La Fisica es Divertida', 168, 123.32)
INSERT INTO Libros VALUES ('Calculo Integral', 456, 289.56)
INSERT INTO Libros VALUES ('Las 20 Lenguas del Dragon', 365, 236.42)
INSERT INTO Libros VALUES ('Narnia', 100, 89.36)
INSERT INTO Libros VALUES ('El Señor de los Anillos', 157, 123.56)
INSERT INTO Libros VALUES ('Ruperth', 145, 123.21)
INSERT INTO Libros VALUES ('Tutoriales Hackro', 457, 369.54)
INSERT INTO Libros VALUES ('La Magia de las Matematicas', 456, 345.45)

SELECT * FROM Libros

/* Sacar las ganancias de cada libro */

SELECT Nombre, Precio_Venta - Precio_Compra FROM Libros
SELECT Nombre, Precio_Venta - Precio_Compra FROM Libros WHERE ID_Libro = 5

/* Presupuesto */

SELECT Nombre, Precio_Venta * 10 FROM Libros WHERE ID_Libro = 14

/* Actualizar datos, Ganancias de precio_venta del 40%*/

UPDATE Libros SET Precio_Venta=Precio_Compra*1.40

/* Calcular la el pocentaje de ganancia del libro */

SELECT Nombre, (Precio_Venta - Precio_Compra) / Precio_Compra * 100 FROM Libros
ALTER TABLE Libros ADD Ganancia float
UPDATE Libros SET Ganancia=(Precio_Venta - Precio_Compra) / Precio_Compra * 100
ALTER TABLE Libros ALTER COLUMN Ganancia decimal NOT NULL

/* CONCATENACION Y ALIAS */

SELECT 'Libro: ' + Nombre FROM Libros
SELECT 'Libro: ' + Nombre + ' NOT AVIABLE' FROM Libros WHERE ID_Libro=1

SELECT Precio_Venta as Este_es_el_precio_de_Venta, Precio_Compra as Este_es_el_precio_de_Compra FROM Libros

/* AÑADIR NUEVAS COLUMNAS Y DATOS A ESAS COLUMNAS, RENOMBRAR UNA COLUMNA */

EXECUTE sp_rename 'Libros.Nombre', 'Titulo', 'COLUMN';
ALTER TABLE Libros ADD Descripcion varchar(100), Autor varchar(50)
UPDATE Libros SET Descripcion = 'Libro de Aventura' WHERE ID_Libro=1
UPDATE Libros SET Descripcion = 'Libro de Niños' WHERE ID_Libro=2
UPDATE Libros SET Descripcion = 'Libro de Programacion' WHERE ID_Libro=3
UPDATE Libros SET Descripcion = 'Libro de Programacion' WHERE ID_Libro=4
UPDATE Libros SET Descripcion = 'Libro de Programacion' WHERE ID_Libro=5
UPDATE Libros SET Descripcion = 'Libro de Ficcion' WHERE ID_Libro=6
UPDATE Libros SET Descripcion = 'Libro de Aventura' WHERE ID_Libro=7
UPDATE Libros SET Descripcion = 'Libro de Novela' WHERE ID_Libro=8
UPDATE Libros SET Descripcion = 'Libro de Fisica' WHERE ID_Libro=9
UPDATE Libros SET Descripcion = 'Libro de Matematica' WHERE ID_Libro=10
UPDATE Libros SET Descripcion = 'Libro de Niños' WHERE ID_Libro=11
UPDATE Libros SET Descripcion = 'Libro de Niños' WHERE ID_Libro=12
UPDATE Libros SET Descripcion = 'Libro de Aventura' WHERE ID_Libro=13
UPDATE Libros SET Descripcion = 'Libro de Aventura' WHERE ID_Libro=14
UPDATE Libros SET Descripcion = 'Libro de Programacion' WHERE ID_Libro=15
UPDATE Libros SET Descripcion = 'Libro de Matematica' WHERE ID_Libro=16
UPDATE Libros SET Autor = 'Maria' WHERE ID_Libro=1
UPDATE Libros SET Autor = 'Alejandra' WHERE ID_Libro=2
UPDATE Libros SET Autor = 'Yordy' WHERE ID_Libro=3
UPDATE Libros SET Autor = 'Luis' WHERE ID_Libro=4
UPDATE Libros SET Autor = 'Beatriz' WHERE ID_Libro=5
UPDATE Libros SET Autor = 'Elena' WHERE ID_Libro=6
UPDATE Libros SET Autor = 'Guillermo' WHERE ID_Libro=7
UPDATE Libros SET Autor = 'Javier' WHERE ID_Libro=8
UPDATE Libros SET Autor = 'Maria' WHERE ID_Libro=9
UPDATE Libros SET Autor = 'Dayanare' WHERE ID_Libro=10
UPDATE Libros SET Autor = 'Beatriz' WHERE ID_Libro=11
UPDATE Libros SET Autor = 'Maria' WHERE ID_Libro=12
UPDATE Libros SET Autor = 'Alejandra' WHERE ID_Libro=13
UPDATE Libros SET Autor = 'Yordy' WHERE ID_Libro=14
UPDATE Libros SET Autor = 'Elena' WHERE ID_Libro=15
UPDATE Libros SET Autor = 'Maria' WHERE ID_Libro=16

/* FUNCIONES DE AGREGADO "count, sum, min, max" */

SELECT COUNT (Titulo) FROM Libros
WHERE Precio_Venta>200

SELECT SUM (Precio_Venta) FROM Libros
WHERE Autor='Maria'

SELECT MAX (Precio_Compra) FROM Libros
SELECT MIN (Precio_Compra) FROM Libros

/* MANEJAR CADENAS */

SELECT SUBSTRING ('Hola a todos', 8, 5)--Mostrar una parte de la cadena
SELECT STR (456) --Pasar un Numero int a cadena
SELECT STUFF ('Tutoriales Hackro', 12, 6, 'Venezuela')--Cambiar una frase de la cadena
SELECT LEN('Hola Mundo')--Longitud de cadena
SELECT CHAR(99);--Mostrar una letra segun el numero de caracter
SELECT LOWER ('Yordy Luis Level Sanchez')--Pasar todo a minusculas
SELECT UPPER ('Yordy Luis Level Sanchez')--Pasar todo a mayusculas
SELECT LTRIM ('                      Yordy Luis Level Sanchez                        ')--Quitar los espacios izquierda
SELECT RTRIM ('                      Yordy Luis Level Sanchez                        ')--Quitar los espacios derecha
SELECT REPLACE ('Hola a todos mi nombre es Yordy Level', 'Yordy Level', 'Alejandra Astudillo')--Cambiar una parte de la cadena
SELECT REVERSE ('Yordy lava la tina')--Pone la cadena alrevez
SELECT PATINDEX ('%Yordy%', 'Hola a todos mi nombre es Yordy Level')--Buscar coincidencias
SELECT REPLICATE ('Hola ', 10)--Devuelve la palabra tantas veces se le indique
SELECT 'Tutoriales' + SPACE(1) + 'Hackro' + SPACE(5) + 'para ti'--Poner espacios entre las cadenas

/* FUNCIONES DE FECHA Y HORA */

SELECT GETDATE()--Devuelve la fecha y hora del sistema
SELECT DATEPART(YEAR,GETDATE())--Solos una parte de la fecha u hora= YEAR, MONTH, MINUTE, HOUR, DAY, SECOND
SELECT DATENAME (MONTH, GETDATE())--Devuelve el nombre de una parte de la fecha
SELECT DATEDIFF(DAY, '2020/04/20', '2020/05/13')--Calcula intervalos de tiempo= Dias, meses, años, horas, minutos
SELECT DAY(GETDATE())--Devuelve una parte de la fecha reducido YEAR, DAY, MONTH, HOUR, MINUTE

/* ORDER BY */

SELECT * FROM Libros ORDER BY Precio_Venta ASC
SELECT * FROM Libros ORDER BY Titulo
SELECT * FROM Libros ORDER BY Precio_Compra DESC
SELECT * FROM Libros ORDER BY Autor ASC, Titulo DESC

/* OPERADORES LOGICOS AND=&& OR=|| NOT=!* */

SELECT * FROM Libros WHERE NOT Autor='Beatriz'
SELECT * FROM Libros WHERE Autor='Maria' AND Precio_Venta>200
SELECT * FROM Libros WHERE Autor='Alejandra' OR Autor='Yordy'
SELECT * FROM Libros WHERE ID_Libro>1 AND ID_Libro<6
SELECT * FROM Libros WHERE NOT ID_Libro=1 AND Autor='Maria' AND Precio_Compra<100