/* CASE */

SELECT *,--Campos a mostrar
CASE--Si case no se va a evaluar con boolean colocar el campo, si si tiene boolean no se coloca
WHEN edad<18 THEN 'Menor'--condiciones
WHEN edad>=18 THEN 'Mayor'
END Tipo_edad--terminar la condicion. se coloca el nombre de la new column aqui
FROM usuarios--la tabla de donde los saco
ORDER BY edad

/* IF*/

IF EXISTS (SELECT * FROM usuarios WHERE edad>27)
	SELECT nombre, tipo_usuario, edad FROM usuarios WHERE edad > 27
ELSE
	SELECT 'No hay mayores de edad'

IF EXISTS (SELECT * FROM usuarios WHERE edad>17)
	SELECT nombre, tipo_usuario, edad FROM usuarios WHERE edad > 17
ELSE
	SELECT 'No hay mayores de edad'

/* VARIABLES */

DECLARE @Variable1 varchar(50)
SET @Variable1 = 'El promedio de edad es: ' + (CONVERT (VARCHAR (50), (SELECT AVG(edad) FROM usuarios))) + 'años'
SELECT @Variable1

DECLARE @Variable2 int SET @Variable2 = (SELECT SUM(edad) FROM usuarios WHERE sexo='M')
DECLARE @Variable3 int SET @Variable3 = (SELECT SUM(edad) FROM usuarios WHERE sexo='F')
IF (@Variable2>@Variable3)
	BEGIN
		SELECT 'La sumatoria de edad M es: ' + (CONVERT (VARCHAR (50), @Variable2))
	END
ELSE
	BEGIN
		SELECT 'La sumatoria de edad F es: ' + (CONVERT (VARCHAR (50), @Variable3))
	END

/* STORED PROCEDURES */
--Estructura: 1 create procedure, 2nombre_procedure, 3 AS y 4 lo que va a almacenar (sentencias)

CREATE PROCEDURE Mujeres1 WITH ENCRYPTION AS--crear proc
SELECT nombre, edad, tipo_usuario FROM Usuarios WHERE sexo='F'--sentencias del proc
DROP PROCEDURE Mujeres1--eliminar proc
EXEC Mujeres1
sp_helptext Mujeres1

CREATE PROCEDURE Insertar_Usuario1 WITH ENCRYPTION AS
INSERT INTO usuarios VALUES ('alejandra', 'ale1507', 'yorisa09', 'admin', 23, 'F')
GO
EXEC Insertar_Usuario1

IF OBJECT_ID ('Mujeres1') IS NOT NULL
	DROP PROCEDURE Mujeres1
ELSE
	SELECT 'No existe'-- sentencia para verificar si existe el proc y si se hará alguna acción de existir

/*--------------------------------------------------------------------------------------*/

CREATE PROCEDURE Insert_Usuario
@nombre varchar(30), @usuario varchar(30), @contraseña varchar(30), @tipo_usuario varchar(10), @edad int, @sexo varchar(20)
WITH ENCRYPTION AS
INSERT INTO usuarios VALUES (@nombre, @usuario, @contraseña, @tipo_usuario, @edad, @sexo)
GO--Creo proc con parametros de entrada.
EXEC Insert_Usuario 'yordy', 'yor0606', 'aleisa09', 'root', 24, 'M'

/*--------------------------------------------------------------------------------------*/

CREATE PROC View_Female
@edad int WITH ENCRYPTION
AS
SELECT * FROM usuarios WHERE edad = @edad AND sexo='F'
ORDER BY edad 
GO
EXEC View_Female 18

/*--------------------------------------------------------------------------------------*/

CREATE PROC Give_Age--Indican el nombre y se devuelve la edad y el tipo de usuario
@edad int OUTPUT,--Parametro de salida
@tipo_usuario varchar (20) OUTPUT,
@nombre varchar(30)
WITH ENCRYPTION AS
SET @edad = (SELECT edad FROM usuarios WHERE nombre=@nombre)
SET @tipo_usuario = (SELECT tipo_usuario FROM usuarios WHERE nombre=@nombre)
GO
DECLARE @Edad int--Se declaran variables para asignar el parametro de salida almacenado en el proc
DECLARE @Usuario varchar (20)
EXEC Give_Age @Edad OUTPUT, @Usuario OUTPUT, 'yordy'--Ejecuta el proc y guara edad en Edad y tipo_usuario en Usuario
SELECT 'La edad es: ' +		CONVERT (VARCHAR (10), @Edad) + ' y el tipo de usuario es: ' + @Usuario--Lo indica en forma de texto

/*--------------------------------------------------------------------------------------*/

CREATE PROC Total_Num_Of_Age--Indican la edad y devuelve el total de usuarios con dicha edad
@edad int,
@total_count int OUTPUT
WITH ENCRYPTION AS
SET @total_count = (SELECT COUNT(edad) FROM usuarios WHERE edad = @edad)
GO
DECLARE @COUNT int
EXEC Total_Num_Of_Age 23, @COUNT OUTPUT
SELECT 'El numero total de usuarios con la edad indicada es de: ' + CONVERT (VARCHAR(50), @COUNT)

/*--------------------------------------------------------------------------------------*/

CREATE PROC Selection--El proc en si va a almacenar el valor de retorno y no una var como parametro de salida.
@edad int,--Solo variables de parametros de entrada
@sexo varchar(10)
WITH ENCRYPTION AS
IF (@edad IS NULL) OR (@sexo IS NULL)
	RETURN 0--Almacenara 0 en el proc
ELSE
	RETURN 1--Almacenara 1 en el proc
GO
DECLARE @Return int--Declaro var que pasa a tener el valor de lo almacenado en el proc.
EXEC @Return = Selection null, 'M'--Ejecutar procedimiento donde asigno el valor de retorno a la var Return
IF (@Return = 0)
	SELECT @Return as 'Valor falso'
ELSE
	SELECT @Return as 'Valor verdadero'

sp_help--Arroja todos los objetos de la base de datos y el tipo.
sp_helptext Libros_2view--Arroja la definicion de un objeto. Las sentencias que se ultilizaron para una view o proc.
sp_stored_procedures--Muestra solo TODOS los proc almacenados
sp_depends Mujeres--Muestra todos los datos relacionados al proc, view o table
select * from sysobjects--Muestra todos los objetos de la DB

/*--------------------------------------------------------------------------------*/

CREATE PROC Procedure1
@edad int
WITH ENCRYPTION AS--Todo lo que tenga encryptin no va a aparecer en help_text
SELECT * FROM usuarios WHERE edad=@edad
GO
EXEC Procedure1 26

/*--------------------------------------------------------------------------------*/

CREATE PROC Anidado
@result int out
WITH ENCRYPTION AS
SELECT SUM(edad) FROM usuarios
GO
CREATE PROC Anidado1
@result2 int out
WITH ENCRYPTION AS
BEGIN
	DECLARE @Num int
	EXEC Anidado @Num OUTPUT
	SET @result2 = @Num
END
GO
DECLARE @THIS_NUM int
EXEC Anidado1 @THIS_NUM output