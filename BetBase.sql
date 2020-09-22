CREATE DATABASE [������3]
go
USE [������3]
go
CREATE TABLE [������������]
( 
	[id_������������]    nvarchar(10)  NOT NULL ,
	[������]             nvarchar(20)  NULL ,
	[������]             decimal(20,2)  NULL ,
	[�������]            nvarchar(20)  NULL ,
	[�����]              nvarchar(20)  NULL 

	PRIMARY KEY  CLUSTERED ([id_������������] ASC),
	CHECK (id_������������ LIKE '�%')
	
)
go

CREATE TABLE [�������]
( 
	[id_�������]         nvarchar(3)  NOT NULL ,
	[��������]           char(25)  NULL ,
	[����]               smallint NULL

	PRIMARY KEY  CLUSTERED ([id_�������] ASC),
	CHECK (id_������� LIKE '�%')
)
go

CREATE TABLE [��������_��������]
( 
	[�������]            nvarchar(20)  NULL ,
	[id_���������]       nvarchar(4)  NOT NULL ,
	[������]             nvarchar(20)  NULL ,
	[������]             decimal(20,2)  NULL ,
	[�����]              nvarchar(20)  NULL 

	PRIMARY KEY  CLUSTERED ([id_���������] ASC),
	CHECK (id_��������� LIKE '�%')
)
go



CREATE TABLE [������]
( 
	[id_�������]         nvarchar(5)  NOT NULL ,
	[����_������]        datetime  NULL ,
	[��������]           nvarchar(20)  NULL ,
	[����_���������]     datetime  NULL 

	PRIMARY KEY  CLUSTERED ([id_�������] ASC),
	CHECK (id_������� LIKE '�%'),
)
go


CREATE TABLE [�������]
( 
	[id_�������]         nvarchar(15)  NOT NULL ,
	[��������]           char(50)  NULL ,
	[id_���������]       nvarchar(4)  NOT NULL ,
	[�����_���������_������_������] datetime  NULL ,
	[id_����������]      char(18)  NULL ,
	[id_�������]         nvarchar(5)  NOT NULL,
	[id_������������_�������] nvarchar(15)  NULL 

	PRIMARY KEY  CLUSTERED ([id_�������] ASC)
	FOREIGN KEY ([id_���������]) REFERENCES [��������_��������]([id_���������]),
	FOREIGN KEY ([id_�������]) REFERENCES [������]([id_�������]),
	CHECK (id_������� LIKE '�%'),
	CHECK (id_��������� LIKE '�%'),
	CHECK (id_���������� LIKE '�%'),
	CHECK (id_������� LIKE '�%'),
	CHECK (id_������������_������� LIKE ' �%'),


)
go





CREATE TABLE [�������_�_����]
( 
	[����]               smallint  NULL ,
	[id_�������]         nvarchar(15)  NOT NULL ,
	[id_�������]         nvarchar(3)  NOT NULL 

	PRIMARY KEY  CLUSTERED ([id_�������] ASC,[id_�������] ASC)
	FOREIGN KEY ([id_�������]) REFERENCES [�������]([id_�������]),
	FOREIGN KEY ([id_�������]) REFERENCES [�������]([id_�������]),
	CHECK (id_������� LIKE '�%'),
	CHECK (id_������� LIKE '�%')
)
go


CREATE TABLE [������]
( 
	[id_������������]    nvarchar(10)  NOT NULL ,
	[id_�������]         nvarchar(3)  NOT NULL ,
	[id_�������]         nvarchar(15)  NOT NULL ,
	[����������_�����]   decimal(20,2)  NULL ,
	[�����������]        decimal(20,2)     NULL

	PRIMARY KEY  ([id_������������] ASC,[id_�������] ASC,[id_�������] ASC),
	FOREIGN KEY ([id_������������]) REFERENCES [������������]([id_������������]),
	FOREIGN KEY ([id_�������],[id_�������]) REFERENCES [�������_�_����]([id_�������],[id_�������]),
	CHECK (id_������� LIKE '�%'),
	CHECK (id_������� LIKE '�%'),
	CHECK (id_������������ LIKE '�%'),
	CHECK (����������_����� > 0.00 )
)
go

CREATE TABLE [�������]
( 
	[id_������������]    nvarchar(10)  NOT NULL ,
	[id_�������]         nvarchar(3)  NOT NULL ,
	[id_�������]         nvarchar(15)  NOT NULL ,
	[�����_�������]      decimal(20,2)  NULL ,
	[����_�������]       datetime  NULL 

	PRIMARY KEY   ([id_������������] ASC,[id_�������] ASC,[id_�������] ASC)
	

)
go

ALTER TABLE [�������]
	ADD CONSTRAINT [R_72] FOREIGN KEY ([id_������������],[id_�������],[id_�������]) REFERENCES [������]([id_������������],[id_�������],[id_�������])
go


INSERT INTO [�������](id_�������, ��������, ����) 
VALUES ('�01', 'VirtusPro', 1),
       ('�02', 'NaVi', 0),
	   ('�03', 'Team Liquid', 1),
	   ('�04', 'PSG.LGD', 0),
	   ('�05', 'Team Secret', 0),
	   ('�06', 'Mineski', 0),
	   ('�07', 'Vici Gaming', 0),
	   ('�08', 'Newbee', 0),
	   ('�09', 'VGJ.Thunder', 0),
	   ('�10', 'Team Serenity', 0),
	   ('�11', 'Invictus Gaming', 0),
	   ('�12', 'Winstrike', 0),
	   ('�13', 'VGJ.Storm', 0),
	   ('�14', 'Pain Gaming', 0),
	   ('�15', 'Fnatic', 0),
	   ('�16', 'Evil Geniuses', 0);

INSERT INTO ��������_��������(�������, id_���������, ������, ������, �����) 
VALUES ('������', '�01', 'qwer123', 10000, 'RABOT1'),
       ('����', '�02','qwer321', 20000, 'RABOT2'),
	   ('��������', '�03','asd123', 30000, 'RABOT3');


INSERT INTO ������(id_�������, ����_������, ����_���������, ��������) 
VALUES ('�01', '2019-05-30T14:08:09', '2019-06-30T14:08:09', 'Major'),
       ('�02', '2019-04-30T14:08:09', '2019-05-30T14:08:09', 'DreamHack'),
       ('�03', '2019-07-30T14:08:09', '2019-08-30T14:08:09', 'MJL');
	   

INSERT INTO ������������(id_������������, ������, �����, ������, �������) 
VALUES ('�01', 'zxc1423', 'john', 10000, '������'),
      -- ('�01', 'zxc1423', 'john', 10000, '�02', '������'),
       ('�02', 'gdf5443', 'sugrob', 12644, '�������'),
	   ('�03', 'jhg7743', 'sabrix', 146544, '�������'),
	   ('�04', 'jgh5643', 'lisa', 16644, '�������'),
	   ('�05', 'rwe3443', 'fain', 13423, '��������'),
       ('�06', 'zyr2343', 'patrix', 175677, '�������'),
	   ('�07', 'yrr4563', 'noone', 15435, '������'),
       ('�08', 'oiu6783', 'gordon', 12344, '��������'),
	   ('�09', 'khj9783', 'rassul', 16456, '������'),
	   ('�10', 'hfg3453', 'aquaman', 12344, '��������'),
	   ('�11', 'gnv2343', 'flash', 17565, '������'),
       ('�12', 'hjk0983', 'ozera', 16456, '������'),
	   ('�13', 'bnm3453', 'smith', 188888, '���������');
	   
INSERT INTO �������(id_�������, ��������, id_���������, �����_���������_������_������, id_����������, id_�������) 
VALUES ('�01', 'VirtusPro vs NaVi', '�01','2019-05-30T19:00:00' ,'�01','�01'),
       ('�02', 'Team Liquid vs PSG.LGD', '�02','2019-05-30T21:00:00' ,'�03','�01'),
	   ('�03', 'Team Secret vs Mineski', '�03','2019-05-30T23:00:00' ,NULL,'�01');
	   
INSERT INTO �������_�_����(����, id_�������, id_�������) 
VALUES (1, '�01', '�01'),
       (0, '�01', '�02'),
	   (1, '�02', '�03'),
       (0, '�02', '�04'),
	   (0, '�03', '�05'),
       (0, '�03', '�06');

INSERT INTO ������(����������_�����, id_������������, id_�������, id_�������) 
VALUES (1000, '�01', '�01','�01'),
       (1000, '�01', '�02','�01'),
	   (500, '�02', '�01','�01'),
       (500, '�02', '�02','�01'),
	   (1600, '�03', '�01','�01'),
	   (1600, '�03', '�02','�01'),
	   (1500, '�04', '�01','�01'),
	   (600, '�11', '�03','�02'),
	   (10000, '�12', '�04','�02');

INSERT INTO �������(�����_�������, ����_�������, id_������������, id_�������, id_�������) 
VALUES (1300, '2019-05-30T22:00:00', '�01','�01','�01'),
       (800, '2019-05-30T22:00:00', '�02','�01','�01'),
       (2000, '2019-05-30T22:00:00', '�03','�01','�01'),
	   (1800, '2019-05-30T22:00:00', '�04','�01','�01'),
	   (800, '2019-05-30T23:00:00', '�11','�03','�02');
GO


CREATE VIEW asd (id_�������, id_�������, ����������_������) AS 
SELECT id_�������, id_�������, COUNT(id_������������)
FROM ������ 

GROUP BY id_������� 
,id_�������
GO



CREATE PROCEDURE �����1

@id_�������1 nvarchar(15), 
@id_�������1 nvarchar(15)


AS 

SELECT ����������_������ FROM asd 
    WHERE id_������� = @id_�������1 and id_������� = @id_�������1

SELECT SUM(����������_������) FROM asd 
    WHERE id_������� = @id_�������1



UPDATE ������ 

SET ����������� = 

(1.00/
 (
  (CONVERT(decimal(20,2),(SELECT ����������_������ 
           FROM asd 
           WHERE id_������� = @id_�������1 and id_������� = @id_�������1)))
		/
		(CONVERT(decimal(20,2),(SELECT SUM(����������_������) 
             FROM asd 
             WHERE id_������� = @id_�������1)))))
 WHERE (id_������� = @id_�������1 and id_������� = @id_�������1) 
	



UPDATE ������ 

SET ����������� = 

(1.00/



  (
  
  
 
  (CONVERT(decimal(20,2),(SELECT ����������_������ 
           FROM asd 
           WHERE id_������� = @id_�������1 and id_������� <> @id_�������1)))

 
			 /
			 
  (CONVERT(decimal(20,2),(SELECT SUM(����������_������) 
             FROM asd 
             WHERE id_������� = @id_�������1)))
		   ))

 WHERE (id_������� = @id_�������1 and id_������� <> @id_�������1)
	


GO

CREATE TRIGGER new_coff ON ������
AFTER INSERT 
 AS
    declare
    @id_�������1 nvarchar(15), 
    @id_�������1 nvarchar(15)


BEGIN

    
    Select @id_�������1=id_�������,
	       @id_�������1=id_�������
    From Inserted
  
    EXEC �����1 @id_�������1, @id_�������1
END

GO


CREATE TRIGGER ����_��� ON �������_�_���� 
AFTER INSERT 
AS 

IF EXISTS (SELECT COUNT(id_�������), id_������� 
FROM �������_�_���� 
WHERE id_������� = (SELECT id_������� FROM inserted)
GROUP BY id_������� 
HAVING COUNT(id_�������) >= 3)

BEGIN 
RAISERROR ('����� ����� ������������ 2 �������', 16, 1); 
ROLLBACK TRANSACTION; 
RETURN 
END; 

GO

CREATE PROCEDURE spisanie_cash 

	@id_������������1 nvarchar(10),
    @input_cash1 decimal(20,2)


AS 



UPDATE ������������

SET ������ = ������ - @input_cash1
WHERE id_������������ = @id_������������1


GO

CREATE PROCEDURE zachis_rab
   @id_���������1 nvarchar(4),
   @input_cash1 decimal(20,2)
 AS

   UPDATE ��������_��������
   SET ������ = ������ + @input_cash1
   WHERE id_��������� = @id_���������1

   GO

CREATE TRIGGER spisanie ON ������
AFTER INSERT 
 AS
    declare
	@id_������������1 nvarchar(10),
    @input_cash decimal(20,2),
    @id_��������� nvarchar(4)


BEGIN

    
    Select @id_������������1=id_������������,
	       @input_cash=����������_�����
    From Inserted
  
    EXEC spisanie_cash @id_������������1, @input_cash
	
	SET @id_��������� = (SELECT id_��������� FROM ������� WHERE id_������� = 
	                                 (SELECT id_������� FROM inserted));

	EXEC zachis_rab @id_���������1 = @id_��������� , @input_cash1 = @input_cash
END
GO



CREATE PROCEDURE �������111

    @id_������������1 nvarchar(10),
	@input_cash1 decimal(20,2),
    @id_�������1 nvarchar(15),
	@�����������1 decimal(20,2),
	@id_�������1 nvarchar(3)

AS 

BEGIN TRANSACTION

UPDATE ������������
SET ������ = CONVERT(decimal(20,2),(������ + (@input_cash1 * @�����������1)))
WHERE id_������������ = @id_������������1 

UPDATE ��������_��������
SET ������ = ������ - (@input_cash1 * @�����������1)
WHERE id_��������� = (SELECT id_��������� FROM ������� WHERE id_������� = @id_�������1)



INSERT INTO [�������](id_������������, id_�������, id_�������,�����_�������, ����_�������)
              VALUES (@id_������������1, @id_�������1, @id_�������1,(@input_cash1 * @�����������1),  GETDATE())  
COMMIT
			  
GO


CREATE TRIGGER new_viplata111111 ON �������
AFTER UPDATE
 AS
    declare
    @id_������������2 nvarchar(10),
	@input_cash2 decimal(20,2),
	@id_�������2 nvarchar(15),
	@�����������2 decimal(20,2),
	@id_�������2 nvarchar(3)
    
	
  
  SELECT id_������������, �.����������_�����,�.�����������, �.id_�������, �.id_�������
    	 	          
  INTO #Temp
  FROM ������  AS  � JOIN inserted AS i   ON �.id_������� = i.id_����������

  
  WHILE EXISTS (SElECT TOP 1 id_������������, ����������_�����, ����������� , id_�������  From #Temp)
  
  
  
    BEGIN   
  
    SELECT TOP 1 @id_������������2 = id_������������, 
                 @input_cash2 = ����������_�����,
                 @�����������2 = �����������,
				 @id_�������2 = id_�������,
				 @id_�������2 = id_�������

    FROM #Temp;
    
  
	EXEC �������111 @id_������������1 = @id_������������2, @input_cash1 = @input_cash2, 
	                @�����������1 = @�����������2, @id_�������1 = @id_�������2,
				    @id_�������1 = @id_�������2
    
   
  
    DELETE #Temp WHERE (@id_������������2 = id_������������)   and (@input_cash2 = ����������_�����) and
                       (@�����������2 = �����������) and (@id_�������2 = id_�������)

    END;
GO

CREATE TRIGGER ��������_����� ON ������
AFTER INSERT 
AS 


IF EXISTS (SELECT �.id_������������, id_�������, ����������_�����, id_�������, ������ --i.id_������������ , i.����������_����� 

FROM inserted  AS  i JOIN ������������ AS �   ON i.id_������������ = �.id_������������
where i.����������_����� > �.������)


BEGIN 
RAISERROR ('������������ ����� ��� ������', 16, 1); 
ROLLBACK TRANSACTION; 
RETURN 
END; 

GO



CREATE TRIGGER ����_�_����� ON �������
AFTER UPDATE 
AS 


IF EXISTS (SELECT i.id_�������, i.id_���������� 
FROM inserted AS i)




UPDATE �������_�_����
SET ���� = 1 
WHERE id_������� = (SELECT i.id_���������� FROM inserted AS i)
  and id_������� = (SELECT i.id_������� FROM inserted AS i)

UPDATE �������_�_����
SET ���� = 0 
WHERE id_������� <> (SELECT i.id_���������� FROM inserted AS i)
  and id_������� = (SELECT i.id_������� FROM inserted AS i)

UPDATE �������
SET ���� =���� + 1 
WHERE id_������� = (SELECT i.id_���������� FROM inserted AS i)
GO



CREATE TRIGGER ������_��_update_���������� ON �������
INSTEAD OF UPDATE 
AS 
declare
@id_������� nvarchar(15),
@id_���������� char(18),
@id_������������_������� nvarchar(15)




IF (SELECT id_���������� FROM deleted
WHERE id_������� = id_������������_�������) IS NOT NULL


BEGIN 
RAISERROR ('���������� ��� ����������', 16, 1); 
ROLLBACK TRANSACTION; 
RETURN 
END; 

    Select @id_�������=id_�������,
	       @id_����������=id_����������,
		   @id_������������_�������=id_������������_�������
    From Inserted

UPDATE �������
SET id_���������� = @id_���������� ,id_������������_������� = @id_������������_�������
WHERE id_������� = @id_�������

GO



CREATE TRIGGER ������_��_set_stavka ON ������
AFTER INSERT 
AS 

if exists (SELECT i.id_������������, i.id_�������, i.id_�������, �.�����_���������_������_������ FROM ������ AS i
                              JOIN ������� AS � ON i.id_������� = �.id_�������
							   WHERE �����_���������_������_������ < GETDATE() )



BEGIN 
RAISERROR ('����� ������ ������ �������', 16, 1); 
ROLLBACK TRANSACTION; 
RETURN 
END; 

GO