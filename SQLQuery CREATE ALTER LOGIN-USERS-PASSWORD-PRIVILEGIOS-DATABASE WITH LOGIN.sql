ALTER LOGIN sa ENABLE--Habilita a un Login. Login sa viene por defecto en la DB. DISABLE deshabilita login.
--El usuario por defecto es dbo.
/*PARA HABILITAR EL INICIO DE SESION MIXTO:
Desde SQL Server Management Studio:
	1. Click derecho en el servidor/instancia
	2. Properties
	3. Select a page: Security
	4. Seleccionar modo de autenticación mixto (SQL y Windows)
	5. Hacer click en SCRIPT y generará el script(segunda forma)
	6. Click en OK*/
ALTER LOGIN sa WITH PASSWORD = 'Astudillo1507';--Cambio la contraseña de un login.
--Debe cerrar las pestañas del login que se va a deshabilitar ya que sino aun esta ejecutando ese login.

/*CREAR LOGIN Y USUARIO*/
--SQL SERVER AUTENTICATION
CREATE LOGIN [Alejandra] WITH PASSWORD = '123456' MUST_CHANGE,
DEFAULT_DATABASE = Tienda, DEFAULT_LANGUAGE = [English],--Siempre debe ser default la base de datos master
CHECK_EXPIRATION = ON

--WINDOWS AUTENTICATION
CREATE LOGIN [CCS01\DesktopSolution] FROM WINDOWS WITH DEFAULT_DATABASE = master--Tiene que ser con usuarios registrados
--Como no tengo usuarios en la PC solo puedo hacerlo con DesktopSolution

DROP LOGIN Alejandra
--Si el login no se puede eliminar dar click derecho a SERVER\INSTANCE,
--Seleccionar Activity Monitor
--Processes
--En el proceso del usuario que se quiere eliminar click derecho y luego KILL PROCESS

CREATE USER Tienda FOR LOGIN Alejandra WITH DEFAULT_SCHEMA = dbo--	Usuario de un login
DROP USER Tienda--Elimina USUARIO de un login
ALTER DATABASE Tienda SET MULTI_USER --Permite que varios usuarios se conecten a una DB

GRANT CREATE ANY DATABASE TO Alejandra--Solo se le puede otorgar permisos de crear base de datos a un LOGIN
GRANT CREATE TABLE TO Tienda--Permitir que el USUARIO cree tablas
ALTER ROLE db_owner ADD MEMBER Tienda--Le doy permisos al usuario de ser un dueño de DB y crear tablas.

/* CREAR DB CON ESPECIFICACIÓN DE UBICACION, TAMAÑO, NOMBRE, LOGIN*/

USE master
GO
CREATE DATABASE Sales
ON
(NAME = Sales_dat,
FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Salesdat.mdf',
SIZE = 10,--TAMAÑO INICIAL PARA RESERVAR ESTE ESPACIO EN EL DISCO DURO
MAXSIZE = 50,
FILEGROWTH = 5)--que tanto va a crecer la DB cada vez que vaya ocupando el espacio hasta el max de MAXSIZE.
LOG ON
(NAME = Sales_log,
FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Sales_log.ldf',
SIZE = 5MB,
MAXSIZE = 25MB,
FILEGROWTH = 5MB)
GO

--Buscar si una DB existe
SELECT DB_ID (N'Tienda')
SELECT DB_ID (N'Sales')

IF db_id (N'Sales') IS NOT NULL
DROP DATABASE Sales
ELSE
BEGIN
CREATE DATABASE Sales
ON
(NAME = Sales_dat,
FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Salesdat.mdf',
SIZE = 10,--TAMAÑO INICIAL PARA RESERVAR ESTE ESPACIO EN EL DISCO DURO
MAXSIZE = 50,
FILEGROWTH = 5)--que tanto va a crecer la DB cada vez que vaya ocupando el espacio hasta el max de MAXSIZE.
LOG ON
(NAME = Sales_log,
FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Sales_log.ldf',
SIZE = 5MB,
MAXSIZE = 25MB,
FILEGROWTH = 5MB)
END