CREATE DATABASE [ставки3]
go
USE [ставки3]
go
CREATE TABLE [Пользователи]
( 
	[id_Пользователя]    nvarchar(10)  NOT NULL ,
	[пароль]             nvarchar(20)  NULL ,
	[баланс]             decimal(20,2)  NULL ,
	[фамилия]            nvarchar(20)  NULL ,
	[логин]              nvarchar(20)  NULL 

	PRIMARY KEY  CLUSTERED ([id_Пользователя] ASC),
	CHECK (id_Пользователя LIKE 'П%')
	
)
go

CREATE TABLE [Команды]
( 
	[id_команды]         nvarchar(3)  NOT NULL ,
	[название]           char(25)  NULL ,
	[очки]               smallint NULL

	PRIMARY KEY  CLUSTERED ([id_команды] ASC),
	CHECK (id_команды LIKE 'К%')
)
go

CREATE TABLE [Работник_компании]
( 
	[фамилия]            nvarchar(20)  NULL ,
	[id_Работника]       nvarchar(4)  NOT NULL ,
	[пороль]             nvarchar(20)  NULL ,
	[баланс]             decimal(20,2)  NULL ,
	[логин]              nvarchar(20)  NULL 

	PRIMARY KEY  CLUSTERED ([id_Работника] ASC),
	CHECK (id_Работника LIKE 'Р%')
)
go



CREATE TABLE [Турнир]
( 
	[id_Турнира]         nvarchar(5)  NOT NULL ,
	[Дата_начала]        datetime  NULL ,
	[название]           nvarchar(20)  NULL ,
	[Дата_окончания]     datetime  NULL 

	PRIMARY KEY  CLUSTERED ([id_Турнира] ASC),
	CHECK (id_Турнира LIKE 'Т%'),
)
go


CREATE TABLE [Событие]
( 
	[id_События]         nvarchar(15)  NOT NULL ,
	[описание]           char(50)  NULL ,
	[id_Работника]       nvarchar(4)  NOT NULL ,
	[время_истечения_приема_ставок] datetime  NULL ,
	[id_Победителя]      char(18)  NULL ,
	[id_Турнира]         nvarchar(5)  NOT NULL,
	[id_завершенного_события] nvarchar(15)  NULL 

	PRIMARY KEY  CLUSTERED ([id_События] ASC)
	FOREIGN KEY ([id_Работника]) REFERENCES [Работник_компании]([id_Работника]),
	FOREIGN KEY ([id_Турнира]) REFERENCES [Турнир]([id_Турнира]),
	CHECK (id_События LIKE 'Е%'),
	CHECK (id_Работника LIKE 'Р%'),
	CHECK (id_Победителя LIKE 'К%'),
	CHECK (id_Турнира LIKE 'Т%'),
	CHECK (id_завершенного_события LIKE ' Е%'),


)
go





CREATE TABLE [команда_в_игре]
( 
	[очки]               smallint  NULL ,
	[id_События]         nvarchar(15)  NOT NULL ,
	[id_команды]         nvarchar(3)  NOT NULL 

	PRIMARY KEY  CLUSTERED ([id_События] ASC,[id_команды] ASC)
	FOREIGN KEY ([id_События]) REFERENCES [Событие]([id_События]),
	FOREIGN KEY ([id_команды]) REFERENCES [Команды]([id_команды]),
	CHECK (id_команды LIKE 'К%'),
	CHECK (id_События LIKE 'Е%')
)
go


CREATE TABLE [ставка]
( 
	[id_Пользователя]    nvarchar(10)  NOT NULL ,
	[id_команды]         nvarchar(3)  NOT NULL ,
	[id_События]         nvarchar(15)  NOT NULL ,
	[количество_денег]   decimal(20,2)  NULL ,
	[коэффициент]        decimal(20,2)     NULL

	PRIMARY KEY  ([id_Пользователя] ASC,[id_команды] ASC,[id_События] ASC),
	FOREIGN KEY ([id_Пользователя]) REFERENCES [Пользователи]([id_Пользователя]),
	FOREIGN KEY ([id_События],[id_команды]) REFERENCES [команда_в_игре]([id_События],[id_команды]),
	CHECK (id_команды LIKE 'К%'),
	CHECK (id_События LIKE 'Е%'),
	CHECK (id_Пользователя LIKE 'П%'),
	CHECK (количество_денег > 0.00 )
)
go

CREATE TABLE [Выплаты]
( 
	[id_Пользователя]    nvarchar(10)  NOT NULL ,
	[id_команды]         nvarchar(3)  NOT NULL ,
	[id_События]         nvarchar(15)  NOT NULL ,
	[сумма_выплаты]      decimal(20,2)  NULL ,
	[дата_выплаты]       datetime  NULL 

	PRIMARY KEY   ([id_Пользователя] ASC,[id_команды] ASC,[id_События] ASC)
	

)
go

ALTER TABLE [Выплаты]
	ADD CONSTRAINT [R_72] FOREIGN KEY ([id_Пользователя],[id_команды],[id_События]) REFERENCES [ставка]([id_Пользователя],[id_команды],[id_События])
go


INSERT INTO [Команды](id_команды, название, очки) 
VALUES ('К01', 'VirtusPro', 1),
       ('К02', 'NaVi', 0),
	   ('К03', 'Team Liquid', 1),
	   ('К04', 'PSG.LGD', 0),
	   ('К05', 'Team Secret', 0),
	   ('К06', 'Mineski', 0),
	   ('К07', 'Vici Gaming', 0),
	   ('К08', 'Newbee', 0),
	   ('К09', 'VGJ.Thunder', 0),
	   ('К10', 'Team Serenity', 0),
	   ('К11', 'Invictus Gaming', 0),
	   ('К12', 'Winstrike', 0),
	   ('К13', 'VGJ.Storm', 0),
	   ('К14', 'Pain Gaming', 0),
	   ('К15', 'Fnatic', 0),
	   ('К16', 'Evil Geniuses', 0);

INSERT INTO Работник_компании(фамилия, id_Работника, пороль, баланс, логин) 
VALUES ('Иванов', 'Р01', 'qwer123', 10000, 'RABOT1'),
       ('Сноу', 'Р02','qwer321', 20000, 'RABOT2'),
	   ('Ланистер', 'Р03','asd123', 30000, 'RABOT3');


INSERT INTO Турнир(id_Турнира, Дата_начала, Дата_окончания, название) 
VALUES ('Т01', '2019-05-30T14:08:09', '2019-06-30T14:08:09', 'Major'),
       ('Т02', '2019-04-30T14:08:09', '2019-05-30T14:08:09', 'DreamHack'),
       ('Т03', '2019-07-30T14:08:09', '2019-08-30T14:08:09', 'MJL');
	   

INSERT INTO Пользователи(id_Пользователя, пароль, логин, баланс, фамилия) 
VALUES ('П01', 'zxc1423', 'john', 10000, 'Петров'),
      -- ('П01', 'zxc1423', 'john', 10000, 'Е02', 'Петров'),
       ('П02', 'gdf5443', 'sugrob', 12644, 'Сергеев'),
	   ('П03', 'jhg7743', 'sabrix', 146544, 'Борисов'),
	   ('П04', 'jgh5643', 'lisa', 16644, 'Захаров'),
	   ('П05', 'rwe3443', 'fain', 13423, 'Медведев'),
       ('П06', 'zyr2343', 'patrix', 175677, 'Поляков'),
	   ('П07', 'yrr4563', 'noone', 15435, 'Крылов'),
       ('П08', 'oiu6783', 'gordon', 12344, 'Максимов'),
	   ('П09', 'khj9783', 'rassul', 16456, 'Егоров'),
	   ('П10', 'hfg3453', 'aquaman', 12344, 'Анисимов'),
	   ('П11', 'gnv2343', 'flash', 17565, 'Марков'),
       ('П12', 'hjk0983', 'ozera', 16456, 'Маслов'),
	   ('П13', 'bnm3453', 'smith', 188888, 'Третьяков');
	   
INSERT INTO Событие(id_События, описание, id_Работника, время_истечения_приема_ставок, id_Победителя, id_Турнира) 
VALUES ('Е01', 'VirtusPro vs NaVi', 'Р01','2019-05-30T19:00:00' ,'К01','Т01'),
       ('Е02', 'Team Liquid vs PSG.LGD', 'Р02','2019-05-30T21:00:00' ,'К03','Т01'),
	   ('Е03', 'Team Secret vs Mineski', 'Р03','2019-05-30T23:00:00' ,NULL,'Т01');
	   
INSERT INTO команда_в_игре(очки, id_События, id_команды) 
VALUES (1, 'Е01', 'К01'),
       (0, 'Е01', 'К02'),
	   (1, 'Е02', 'К03'),
       (0, 'Е02', 'К04'),
	   (0, 'Е03', 'К05'),
       (0, 'Е03', 'К06');

INSERT INTO ставка(количество_денег, id_Пользователя, id_команды, id_События) 
VALUES (1000, 'П01', 'К01','Е01'),
       (1000, 'П01', 'К02','Е01'),
	   (500, 'П02', 'К01','Е01'),
       (500, 'П02', 'К02','Е01'),
	   (1600, 'П03', 'К01','Е01'),
	   (1600, 'П03', 'К02','Е01'),
	   (1500, 'П04', 'К01','Е01'),
	   (600, 'П11', 'К03','Е02'),
	   (10000, 'П12', 'К04','Е02');

INSERT INTO Выплаты(сумма_выплаты, дата_выплаты, id_Пользователя, id_команды, id_События) 
VALUES (1300, '2019-05-30T22:00:00', 'П01','К01','Е01'),
       (800, '2019-05-30T22:00:00', 'П02','К01','Е01'),
       (2000, '2019-05-30T22:00:00', 'П03','К01','Е01'),
	   (1800, '2019-05-30T22:00:00', 'П04','К01','Е01'),
	   (800, '2019-05-30T23:00:00', 'П11','К03','Е02');
GO


CREATE VIEW asd (id_События, id_команды, количество_ставок) AS 
SELECT id_События, id_команды, COUNT(id_Пользователя)
FROM ставка 

GROUP BY id_События 
,id_команды
GO



CREATE PROCEDURE Обнов1

@id_События1 nvarchar(15), 
@id_команды1 nvarchar(15)


AS 

SELECT количество_ставок FROM asd 
    WHERE id_События = @id_События1 and id_команды = @id_команды1

SELECT SUM(количество_ставок) FROM asd 
    WHERE id_События = @id_События1



UPDATE ставка 

SET коэффициент = 

(1.00/
 (
  (CONVERT(decimal(20,2),(SELECT количество_ставок 
           FROM asd 
           WHERE id_События = @id_События1 and id_команды = @id_команды1)))
		/
		(CONVERT(decimal(20,2),(SELECT SUM(количество_ставок) 
             FROM asd 
             WHERE id_События = @id_События1)))))
 WHERE (id_События = @id_События1 and id_команды = @id_команды1) 
	



UPDATE ставка 

SET коэффициент = 

(1.00/



  (
  
  
 
  (CONVERT(decimal(20,2),(SELECT количество_ставок 
           FROM asd 
           WHERE id_События = @id_События1 and id_команды <> @id_команды1)))

 
			 /
			 
  (CONVERT(decimal(20,2),(SELECT SUM(количество_ставок) 
             FROM asd 
             WHERE id_События = @id_События1)))
		   ))

 WHERE (id_События = @id_События1 and id_команды <> @id_команды1)
	


GO

CREATE TRIGGER new_coff ON ставка
AFTER INSERT 
 AS
    declare
    @id_События1 nvarchar(15), 
    @id_команды1 nvarchar(15)


BEGIN

    
    Select @id_События1=id_События,
	       @id_команды1=id_команды
    From Inserted
  
    EXEC Обнов1 @id_События1, @id_команды1
END

GO


CREATE TRIGGER вхож_ком ON команда_в_игре 
AFTER INSERT 
AS 

IF EXISTS (SELECT COUNT(id_команды), id_События 
FROM команда_в_игре 
WHERE id_События = (SELECT id_События FROM inserted)
GROUP BY id_События 
HAVING COUNT(id_команды) >= 3)

BEGIN 
RAISERROR ('всего могут учавствовать 2 команды', 16, 1); 
ROLLBACK TRANSACTION; 
RETURN 
END; 

GO

CREATE PROCEDURE spisanie_cash 

	@id_Пользователя1 nvarchar(10),
    @input_cash1 decimal(20,2)


AS 



UPDATE Пользователи

SET баланс = баланс - @input_cash1
WHERE id_Пользователя = @id_Пользователя1


GO

CREATE PROCEDURE zachis_rab
   @id_Работника1 nvarchar(4),
   @input_cash1 decimal(20,2)
 AS

   UPDATE Работник_компании
   SET баланс = баланс + @input_cash1
   WHERE id_Работника = @id_Работника1

   GO

CREATE TRIGGER spisanie ON ставка
AFTER INSERT 
 AS
    declare
	@id_Пользователя1 nvarchar(10),
    @input_cash decimal(20,2),
    @id_Работника nvarchar(4)


BEGIN

    
    Select @id_Пользователя1=id_Пользователя,
	       @input_cash=количество_денег
    From Inserted
  
    EXEC spisanie_cash @id_Пользователя1, @input_cash
	
	SET @id_Работника = (SELECT id_Работника FROM Событие WHERE id_События = 
	                                 (SELECT id_События FROM inserted));

	EXEC zachis_rab @id_Работника1 = @id_Работника , @input_cash1 = @input_cash
END
GO



CREATE PROCEDURE Выплата111

    @id_Пользователя1 nvarchar(10),
	@input_cash1 decimal(20,2),
    @id_События1 nvarchar(15),
	@коэффициент1 decimal(20,2),
	@id_команды1 nvarchar(3)

AS 

BEGIN TRANSACTION

UPDATE Пользователи
SET баланс = CONVERT(decimal(20,2),(баланс + (@input_cash1 * @коэффициент1)))
WHERE id_Пользователя = @id_Пользователя1 

UPDATE Работник_компании
SET баланс = баланс - (@input_cash1 * @коэффициент1)
WHERE id_Работника = (SELECT id_Работника FROM Событие WHERE id_События = @id_События1)



INSERT INTO [Выплаты](id_Пользователя, id_команды, id_События,сумма_выплаты, дата_выплаты)
              VALUES (@id_Пользователя1, @id_команды1, @id_События1,(@input_cash1 * @коэффициент1),  GETDATE())  
COMMIT
			  
GO


CREATE TRIGGER new_viplata111111 ON Событие
AFTER UPDATE
 AS
    declare
    @id_Пользователя2 nvarchar(10),
	@input_cash2 decimal(20,2),
	@id_События2 nvarchar(15),
	@коэффициент2 decimal(20,2),
	@id_команды2 nvarchar(3)
    
	
  
  SELECT id_Пользователя, с.количество_денег,с.коэффициент, с.id_События, с.id_команды
    	 	          
  INTO #Temp
  FROM ставка  AS  с JOIN inserted AS i   ON с.id_команды = i.id_Победителя

  
  WHILE EXISTS (SElECT TOP 1 id_Пользователя, количество_денег, коэффициент , id_События  From #Temp)
  
  
  
    BEGIN   
  
    SELECT TOP 1 @id_Пользователя2 = id_Пользователя, 
                 @input_cash2 = количество_денег,
                 @коэффициент2 = коэффициент,
				 @id_События2 = id_События,
				 @id_команды2 = id_команды

    FROM #Temp;
    
  
	EXEC Выплата111 @id_Пользователя1 = @id_Пользователя2, @input_cash1 = @input_cash2, 
	                @коэффициент1 = @коэффициент2, @id_События1 = @id_События2,
				    @id_команды1 = @id_команды2
    
   
  
    DELETE #Temp WHERE (@id_Пользователя2 = id_Пользователя)   and (@input_cash2 = количество_денег) and
                       (@коэффициент2 = коэффициент) and (@id_События2 = id_События)

    END;
GO

CREATE TRIGGER проверка_балан ON ставка
AFTER INSERT 
AS 


IF EXISTS (SELECT с.id_Пользователя, id_События, количество_денег, id_команды, баланс --i.id_Пользователя , i.количество_денег 

FROM inserted  AS  i JOIN Пользователи AS с   ON i.id_Пользователя = с.id_Пользователя
where i.количество_денег > с.баланс)


BEGIN 
RAISERROR ('Недостаточно денег для ставки', 16, 1); 
ROLLBACK TRANSACTION; 
RETURN 
END; 

GO



CREATE TRIGGER очки_в_матче ON Событие
AFTER UPDATE 
AS 


IF EXISTS (SELECT i.id_События, i.id_Победителя 
FROM inserted AS i)




UPDATE команда_в_игре
SET очки = 1 
WHERE id_команды = (SELECT i.id_Победителя FROM inserted AS i)
  and id_События = (SELECT i.id_События FROM inserted AS i)

UPDATE команда_в_игре
SET очки = 0 
WHERE id_команды <> (SELECT i.id_Победителя FROM inserted AS i)
  and id_События = (SELECT i.id_События FROM inserted AS i)

UPDATE Команды
SET очки =очки + 1 
WHERE id_команды = (SELECT i.id_Победителя FROM inserted AS i)
GO



CREATE TRIGGER запрет_на_update_победителя ON Событие
INSTEAD OF UPDATE 
AS 
declare
@id_События nvarchar(15),
@id_Победителя char(18),
@id_завершенного_события nvarchar(15)




IF (SELECT id_Победителя FROM deleted
WHERE id_События = id_завершенного_события) IS NOT NULL


BEGIN 
RAISERROR ('Победитель уже существует', 16, 1); 
ROLLBACK TRANSACTION; 
RETURN 
END; 

    Select @id_События=id_События,
	       @id_Победителя=id_Победителя,
		   @id_завершенного_события=id_завершенного_события
    From Inserted

UPDATE Событие
SET id_Победителя = @id_Победителя ,id_завершенного_события = @id_завершенного_события
WHERE id_События = @id_События

GO



CREATE TRIGGER запрет_на_set_stavka ON ставка
AFTER INSERT 
AS 

if exists (SELECT i.id_Пользователя, i.id_команды, i.id_События, с.время_истечения_приема_ставок FROM ставка AS i
                              JOIN Событие AS с ON i.id_События = с.id_События
							   WHERE время_истечения_приема_ставок < GETDATE() )



BEGIN 
RAISERROR ('время приема ставок истекло', 16, 1); 
ROLLBACK TRANSACTION; 
RETURN 
END; 

GO