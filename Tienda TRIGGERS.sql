/* TRIGGERS */

--Tipo de proc que se exec cuando se intenta mod un table
--trigger no se puede exec directamente, este se exec automatico
--no recibe ni retorna parametros y puede hacer ref a otras tablas
--se exec despues de una accion o una exec de un update o delete de table
USE Tienda
GO

CREATE TABLE Almacen
(
Id_Producto int IDENTITY NOT NULL,
Cod_Producto int PRIMARY KEY NOT NULL,
Nombre_Producto varchar(50) NOT NULL,
Descripcion_Producto varchar(50),
Cantidad int NOT NULL,
Precio_Compra money NOT NULL
)

INSERT INTO Almacen VALUES (123, 'Aceite', 'Para motor', 1200, 45.32)
INSERT INTO Almacen VALUES (345, 'Aceite', 'Para caja', 1450, 45.35)
INSERT INTO Almacen VALUES (567, 'Aceite', 'Para direccion', 567, 45.9)
INSERT INTO Almacen VALUES (789, 'Refrigerante', 'Amarillo', 1234, 15.3)
INSERT INTO Almacen VALUES (901, 'Refrigerante', 'Azul', 5697, 12.6)
INSERT INTO Almacen VALUES (012, 'Refrigerante', 'Rojo', 5851, 10.22)
INSERT INTO Almacen VALUES (234, 'Refrigerante', 'Rosa', 1466, 14.3)
INSERT INTO Almacen VALUES (456, 'Parabrisas', 'Delantero', 25, 185.3)
INSERT INTO Almacen VALUES (678, 'Parabrisas', 'Trasero', 16, 174.3)
INSERT INTO Almacen VALUES (890, 'Liga de freno', null, 1452, 9.63)
INSERT INTO Almacen VALUES (321, 'Correa unica', 'Para motor', 1588, 10.32)

CREATE TABLE Ventas
(
Id_Venta int PRIMARY KEY IDENTITY NOT NULL,
Cod_Producto int NOT NULL,
Precio_Unidad money NOT NULL,
Cantidad int NOT NULL,
Precio_Venta money NOT NULL,
Fecha datetime NOT NULL
FOREIGN KEY (Cod_Producto) REFERENCES Almacen(Cod_Producto)
)

CREATE TABLE Contabilidad
(
Id_Contabilidad int IDENTITY PRIMARY KEY NOT NULL,
Cod_Producto int NOT NULL,
Ganancia_Total_Venta money NOT NULL,
ID_Venta int NOT NULL,
Estado varchar(50),
FOREIGN KEY (Cod_Producto) REFERENCES Almacen(Cod_Producto)
)
GO

CREATE PROC Insertar_Venta
@cod_prod int,
@p_venta money,
@cant int
WITH ENCRYPTION AS
BEGIN
	DECLARE @fecha datetime = getdate()
	DECLARE @p_total money = @p_venta * @cant
	INSERT INTO Ventas VALUES (@cod_prod, @p_venta, @cant, @p_total, @fecha)
END
GO

CREATE TRIGGER Venta_Almacen
ON Ventas
FOR INSERT
AS
BEGIN
	DECLARE @Cod_prod int = (SELECT Cod_Producto FROM Ventas WHERE Id_Venta = (SELECT COUNT(Id_Venta) FROM Ventas))
	DECLARE @Resta int = ((SELECT Cantidad FROM Almacen WHERE Cod_Producto = @Cod_prod) - (SELECT Cantidad FROM Ventas WHERE Id_Venta = (SELECT COUNT(Id_Venta) FROM Ventas)))
	UPDATE Almacen SET Cantidad = @Resta WHERE Cod_Producto = @Cod_prod
END
GO

CREATE TRIGGER Venta_Contabilidad
ON Ventas
FOR INSERT
AS
BEGIN
	DECLARE @Cod_prod int = (SELECT Cod_Producto FROM Ventas WHERE Id_Venta = (SELECT COUNT(Id_Venta) FROM Ventas))
	DECLARE @Total_Venta money = (SELECT Precio_Venta FROM Ventas WHERE Id_Venta = (SELECT COUNT(Id_Venta) FROM Ventas))
	DECLARE @Total_Compra money = ((SELECT Cantidad FROM Ventas WHERE Id_Venta = (SELECT COUNT(Id_Venta) FROM Ventas)) * (SELECT Precio_Compra FROM Almacen WHERE Cod_Producto = @Cod_prod))
	DECLARE @Ganancia money = @Total_Venta - @Total_Compra
	DECLARE @ID_Venta int = (SELECT COUNT(Id_Venta) FROM Ventas)
	INSERT INTO Contabilidad VALUES (@Cod_prod, @Ganancia, @ID_Venta, NULL)
END
GO

EXEC Insertar_Venta 456, 405.85, 1
EXEC Insertar_Venta 123, 149.32, 2

SELECT * FROM Ventas
SELECT * FROM Almacen
SELECT * FROM Contabilidad

/*CREATE TABLE Prueba
(
Id_Prueba int IDENTITY NOT NULL,
Cantidad int
)

CREATE TRIGGER Insert_Venta
ON Ventas
FOR INSERT
AS
BEGIN
	DECLARE @TOTAL int = (SELECT SUM(Almacen.Cantidad) - SUM(Ventas.Cantidad) FROM Almacen JOIN Ventas ON Almacen.Cod_Producto=Ventas.Cod_Producto)
	INSERT INTO Prueba VALUES (@TOTAL)
END
INSERT INTO Ventas VALUES (123, 150, 2, 300, GETDATE())

SELECT * FROM Ventas
SELECT * FROM Prueba

CREATE TRIGGER Update_Venta
ON Almacen
FOR UPDATE
AS
BEGIN
	DECLARE @TOTAL int = (SELECT SUM(Cantidad) FROM Almacen)
	INSERT INTO Prueba VALUES (@TOTAL)
END
UPDATE Almacen SET Cantidad = 1220 WHERE Cod_Producto=123
SELECT * FROM Almacen
SELECT * FROM Prueba

CREATE TRIGGER Eliminar_Venta
ON Ventas
FOR DELETE
AS
BEGIN
	DECLARE @TOTAL int = (SELECT SUM(Almacen.Cantidad) - SUM(Ventas.Cantidad) FROM Almacen JOIN Ventas ON Almacen.Cod_Producto=Ventas.Cod_Producto)
	UPDATE Prueba
	SET Cantidad = @TOTAL
END
GO
DELETE Ventas WHERE Id_Venta = 1
SELECT * FROM Ventas
SELECT * FROM Prueba

/* HABILITAR / DESHABILITAR TRIGGERS */

ALTER TABLE Almacen
DISABLE
TRIGGER Update_Venta

ALTER TABLE Ventas
DISABLE
TRIGGER Eliminar_Venta
*/