CREATE TABLE Usuarios2
(ID_Usuario int Identity,
Name nchar(10) NOT NULL,
Age int NOT NULL)

UPDATE Usuarios SET Name='carla' WHERE Name='crala'

INSERT INTO Usuarios2 VALUES ('angel', 32)
INSERT INTO Usuarios2 VALUES ('ALEJANDRA ', 61)
INSERT INTO Usuarios2 VALUES ('crala', 19)
INSERT INTO Usuarios2 VALUES ('valeria', 25)
INSERT INTO Usuarios2 VALUES ('yordy', 46)

SELECT * FROM Usuarios

CREATE TABLE Usuarios3
(ID_Usuario int Identity(2,2),
Name nchar(10) NOT NULL,
Age int NOT NULL)

INSERT INTO Usuarios3 VALUES ('angel', 32)
INSERT INTO Usuarios3 VALUES ('ALEJANDRA ', 61)
INSERT INTO Usuarios3 VALUES ('crala', 19)
INSERT INTO Usuarios3 VALUES ('valeria', 25)
INSERT INTO Usuarios3 VALUES ('yordy', 46)

SELECT IDENT_SEED ('Usuarios3')
SELECT IDENT_INCR ('Usuarios3')
SELECT * FROM Usuarios3

ALTER TABLE Usuarios3 DROP COLUMN Age
TRUNCATE TABLE Usuarios2
DELETE FROM Usuarios3 where ID_Usuario=2

SELECT * FROM Usuarios2
SELECT * FROM Usuarios3

SET IDENTITY_INSERT Usuarios3 on
INSERT INTO Usuarios3(ID_Usuario, Name) VALUES (10,'yordy')