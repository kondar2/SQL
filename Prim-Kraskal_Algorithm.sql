use [КлимРиски_18-12-13]
go

SELECT [Эк.риск 2014г/365] as R_ec, НазСубъекта as Название_Субъекта
INTO Pemp
FROM [1(2)_Индексы погодно-климатических рисков для экономик субъектов РФ]
ORDER BY R_ec DESC

ALTER TABLE Pemp
ADD Dif float NOT NULL DEFAULT(0)
go



CREATE PROCEDURE DIFFcurs AS 

DECLARE @zna float;
DECLARE @zna1 float;
DECLARE @name nvarchar(255);
DECLARE @name1 nvarchar(255);
DECLARE @dif float;
DECLARE @dif1 float;



DECLARE weather_curs SCROLL CURSOR 
FOR SELECT R_ec, Название_Субъекта, Dif FROM Pemp ORDER BY R_ec DESC
FOR UPDATE OF Dif 

OPEN weather_curs
FETCH NEXT FROM weather_curs INTO @zna, @name, @dif
WHILE @@FETCH_STATUS = 0 
BEGIN 
  
   
   FETCH NEXT FROM weather_curs
   INTO @zna1, @name1, @dif1;

   UPDATE Pemp
   SET Dif = round(@zna - @zna1,2)
   WHERE Название_Субъекта = @name1

   FETCH RELATIVE 0 FROM weather_curs
   INTO @zna, @name, @dif;

END 


CLOSE weather_curs
DEALLOCATE weather_curs
GO


exec DIFFcurs
go


CREATE TABLE Pemp1 (

vich_char nvarchar(255) NULL,
vich_float float NULL,
ost_char nvarchar(255) NULL,
ost_float float NULL,
R_sub float NULL
)
go

CREATE PROCEDURE DIFFcurs1 AS 

DECLARE @dif1 float;
DECLARE @dif2 float;
DECLARE @dif3 float;
DECLARE @name1 nvarchar(255);
DECLARE @name2 nvarchar(255);
DECLARE @name3 nvarchar(255);
DECLARE @zna float;



DECLARE weather_curs1 SCROLL CURSOR 
FOR SELECT R_ec , Название_Субъекта, Dif FROM Pemp ORDER BY R_ec DESC




OPEN weather_curs1

FETCH NEXT FROM weather_curs1 INTO @zna, @name2, @dif2

FETCH NEXT FROM weather_curs1 INTO @zna, @name3, @dif3

   IF (@dif2 > @dif3)
BEGIN
   INSERT INTO Pemp1([vich_char],[vich_float],R_sub) VALUES(@name2, @dif2,(SELECT j.[Эк.риск 2014г/365] FROM [1(2)_Индексы погодно-климатических рисков для экономик субъектов РФ] AS j 
	                                                                       WHERE j.НазСубъекта = @name2))
END
ELSE
BEGIN
   
   INSERT INTO Pemp1([ost_char],[ost_float],R_sub) VALUES(@name2, @dif2,(SELECT j.[Эк.риск 2014г/365] FROM [1(2)_Индексы погодно-климатических рисков для экономик субъектов РФ] AS j 
	                                                                       WHERE j.НазСубъекта = @name2))
END

FETCH RELATIVE 0 FROM weather_curs1 INTO @zna, @name2, @dif2;



WHILE @@FETCH_STATUS = 0
BEGIN 
  
   
   FETCH NEXT FROM weather_curs1
   INTO @zna, @name3, @dif3;

   FETCH RELATIVE -2 FROM weather_curs1
   INTO @zna, @name1, @dif1;

       IF (@name2 = @name3)
   BEGIN
           
	    IF (@dif2 > @dif1)
          BEGIN
             INSERT INTO Pemp1([vich_char],[vich_float],R_sub) VALUES(@name2, @dif2,(SELECT j.[Эк.риск 2014г/365] FROM [1(2)_Индексы погодно-климатических рисков для экономик субъектов РФ] AS j 
	                                                                       WHERE j.НазСубъекта = @name2))
   
          END
		  ELSE
          BEGIN
             INSERT INTO Pemp1([ost_char],[ost_float],R_sub) VALUES(@name2, @dif2,(SELECT j.[Эк.риск 2014г/365] FROM [1(2)_Индексы погодно-климатических рисков для экономик субъектов РФ] AS j 
	                                                                       WHERE j.НазСубъекта = @name2))
          END

    BREAK
  
   END

   
   IF (@dif2 > @dif1) and (@dif2 > @dif3)
BEGIN
   INSERT INTO Pemp1([vich_char],[vich_float],R_sub) VALUES(@name2, @dif2,(SELECT j.[Эк.риск 2014г/365] FROM [1(2)_Индексы погодно-климатических рисков для экономик субъектов РФ] AS j 
	                                                                       WHERE j.НазСубъекта = @name2))
   

   
END
ELSE
BEGIN
   
   INSERT INTO Pemp1([ost_char],[ost_float],R_sub) VALUES(@name2, @dif2,(SELECT j.[Эк.риск 2014г/365] FROM [1(2)_Индексы погодно-климатических рисков для экономик субъектов РФ] AS j 
	                                                                       WHERE j.НазСубъекта = @name2))
END


   FETCH RELATIVE 2 FROM weather_curs1
   INTO @zna, @name2, @dif2;
   

 
END 


CLOSE weather_curs1
DEALLOCATE weather_curs1
GO











----------------------------------
CREATE PROCEDURE Create_Pemp AS 

DECLARE @first float;
DECLARE @first_name nvarchar(255);
DECLARE @Diff float;


DECLARE cheb_pemp_curs CURSOR 
FOR SELECT R_ec, Название_Субъекта, Dif FROM Pemp_main ORDER BY R_ec DESC


OPEN cheb_pemp_curs

FETCH NEXT FROM cheb_pemp_curs INTO @first, @first_name, @Diff


WHILE @@FETCH_STATUS = 0 
BEGIN 
   
   IF @first_name NOT IN (SELECT Название_Субъекта FROM Pemp 
                       RIGHT JOIN Pemp1 ON Название_Субъекта = vich_char
	                 WHERE vich_char IS NOT NULL)
   INSERT INTO Pemp33([ost_char],[ost_float],R_sub) VALUES(@first_name, @Diff, @first)
   ELSE
   INSERT INTO Pemp33([vich_char],[vich_float],R_sub) VALUES(@first_name, @Diff, @first)
   
   FETCH NEXT FROM cheb_pemp_curs INTO @first, @first_name, @Diff

END 


CLOSE cheb_pemp_curs
DEALLOCATE cheb_pemp_curs
go

CREATE PROCEDURE Numeration AS 

DECLARE @vich_char1 nvarchar(255);
DECLARE @R_sub1 float;
DECLARE @Gr1 nvarchar(20);
DECLARE @Gr2 nvarchar(20);


DECLARE numb_curs SCROLL CURSOR 
FOR SELECT vich_char, R_sub, Gr FROM Cheb1
FOR UPDATE OF Gr 


OPEN numb_curs

FETCH NEXT FROM numb_curs INTO @vich_char1, @R_sub1, @Gr1
SET @Gr2 = 1

WHILE @@FETCH_STATUS = 0 
BEGIN 
   

   UPDATE Cheb1
   SET Gr = @Gr2
   WHERE R_sub = @R_sub1

   IF @vich_char1 IS NOT NULL
   BEGIN
   SET @Gr2 = @Gr2 + 1

   UPDATE Cheb1
   SET Gr = @Gr2
   WHERE R_sub = @R_sub1

   END

   FETCH NEXT FROM numb_curs
   INTO @vich_char1, @R_sub1, @Gr1;


END 


CLOSE numb_curs
DEALLOCATE numb_curs
GO

CREATE PROCEDURE Cheb_alg AS 

DECLARE @first float;
DECLARE @vich_first_name nvarchar(255);
DECLARE @ost_first_name nvarchar(255);

DECLARE @second float;
DECLARE @vich_second_name nvarchar(255);
DECLARE @ost_second_name nvarchar(255);

DECLARE @Gr1 nvarchar(20);
DECLARE @Gr2 nvarchar(20);
DECLARE @razn float;
DECLARE @sum float;
DECLARE @last_el nvarchar(255);


DECLARE cheb_curs SCROLL CURSOR 
FOR SELECT vich_char, ost_char, R_sub, Gr FROM Cheb2
FOR UPDATE OF Summ_razn_gr


OPEN cheb_curs

FETCH LAST FROM cheb_curs INTO @vich_first_name, @ost_first_name, @first, @Gr1

SET @last_el = @ost_first_name


FETCH FIRST FROM cheb_curs INTO @vich_first_name, @ost_first_name, @first, @Gr1
SET @razn = 0
SET @sum = 0


WHILE @@FETCH_STATUS = 0 
BEGIN 

   FETCH NEXT FROM cheb_curs
   INTO @vich_second_name, @ost_second_name, @second, @Gr2;
   
     IF @ost_second_name IS NULL
		   BEGIN

		   FETCH PRIOR FROM cheb_curs INTO @vich_second_name, @ost_second_name, @second, @Gr2;

		   UPDATE Cheb2
		   SET Summa = @sum
		   WHERE  ost_char = @ost_second_name

		   SET @sum = 0

		   FETCH NEXT FROM cheb_curs INTO @vich_first_name, @ost_first_name, @first, @Gr1
		   FETCH NEXT FROM cheb_curs INTO @vich_second_name, @ost_second_name, @second, @Gr2;

		   UPDATE Cheb2
		   SET Summ_razn_gr = NULL
		   WHERE  vich_char = @vich_first_name OR ost_char = @ost_first_name
		   
		   END
  
   

   UPDATE Cheb2
   SET Summ_razn_gr = @first - @second
   WHERE  ost_char = @ost_second_name
   
   SET @sum = @sum + (@first - @second)

	 IF @ost_second_name = @last_el
		   Begin
		   UPDATE Cheb2
		   SET Summa = @sum
		   WHERE ost_char = @ost_second_name
		   BREAK
		   End

END 


CLOSE cheb_curs
DEALLOCATE cheb_curs
GO

CREATE PROCEDURE Cheb_alg1 AS 

DECLARE @first float;
DECLARE @vich_first_name nvarchar(255);
DECLARE @ost_first_name nvarchar(255);

DECLARE @second float;
DECLARE @vich_second_name nvarchar(255);
DECLARE @ost_second_name nvarchar(255);

DECLARE @Gr1 nvarchar(20);
DECLARE @Gr2 nvarchar(20);

DECLARE @Summ_razn1 float(20);
DECLARE @Summ_razn2 float(20);

DECLARE @Summa float(20);

DECLARE @razn float;
DECLARE @sum float;

DECLARE @last_el nvarchar(255);


DECLARE cheb_curs2 SCROLL CURSOR 
FOR SELECT vich_char, ost_char, R_sub, Gr, Summ_razn_gr, Summa FROM Cheb2
FOR UPDATE OF Summ_razn_gr


OPEN cheb_curs2

FETCH LAST FROM cheb_curs2 INTO @vich_first_name, @ost_first_name, @first, @Gr1, @Summ_razn1, @Summa
SET @last_el = @ost_first_name


FETCH FIRST FROM cheb_curs2 INTO @vich_first_name, @ost_first_name, @first, @Gr1, @Summ_razn1, @Summa
SET @razn = 0
SET @sum = 0


WHILE @@FETCH_STATUS = 0 
BEGIN 
   label: 
   IF @Gr2 = (SELECT MAX(CAST(Gr AS float)) FROM Cheb2)
				   BEGIN
				   WHILE (SELECT Summ_razn_gr FROM Cheb2 WHERE (vich_char = @vich_second_name) OR (ost_char = @ost_second_name)) IS NOT NULL
					 BEGIN 
					 FETCH PRIOR FROM cheb_curs2 INTO @vich_second_name, @ost_second_name, @second, @Gr2, @Summ_razn2, @Summa
					
					
					 IF (SELECT Summ_razn_gr FROM Cheb2 WHERE (vich_char = @vich_second_name) OR (ost_char = @ost_second_name)) IS NULL
					 BEGIN
					 FETCH NEXT FROM cheb_curs2 INTO @vich_first_name, @ost_first_name, @first, @Gr1, @Summ_razn1, @Summa

					 IF @ost_first_name = @last_el OR @vich_first_name = @last_el
					 BEGIN
					   CLOSE cheb_curs2
                       DEALLOCATE cheb_curs2
                       RETURN
					 END
					 FETCH PRIOR FROM cheb_curs2 INTO @vich_first_name, @ost_first_name, @first, @Gr1, @Summ_razn1, @Summa
					 GOTO label1
					 
					 END
					 
					 END
					 
					 END

   
   WHILE (@Summ_razn1 IS NULL AND @Summa IS NULL)
   BEGIN
   FETCH NEXT FROM cheb_curs2 INTO @vich_first_name, @ost_first_name, @first, @Gr1, @Summ_razn1, @Summa
   END



   
   IF @Summa IS NOT NULL
	   BEGIN
	   label1:
	   FETCH NEXT FROM cheb_curs2 INTO @vich_first_name, @ost_first_name, @first, @Gr1, @Summ_razn1, @Summa
	  
	   END
   ELSE
	   BEGIN
	  
	   
	   UPDATE Cheb2
	   SET Summ_razn_gr = NULL
	   WHERE ost_char = @ost_first_name

		
		FETCH NEXT FROM cheb_curs2 INTO @vich_second_name, @ost_second_name, @second, @Gr2, @Summ_razn2, @Summa

           UPDATE Cheb2
		   SET Summ_razn_gr = @first - @second
		   WHERE (vich_char = @vich_second_name) OR (ost_char = @ost_second_name)
   
		   SET @sum = @sum + (@first - @second)
		
		

	   WHILE @ost_second_name IS NOT NULL
		   BEGIN
		   FETCH NEXT FROM cheb_curs2 INTO @vich_second_name, @ost_second_name, @second, @Gr2, @Summ_razn2, @Summa
		   
		   
              IF @ost_second_name = @last_el
			   BEGIN

			   UPDATE Cheb2
		       SET Summ_razn_gr = @first - @second
		       WHERE (vich_char = @vich_second_name) OR (ost_char = @ost_second_name)
   
		       SET @sum = @sum + (@first - @second)

			   UPDATE Cheb2
			   SET Summa = Summa + @sum
			   WHERE (vich_char = @vich_second_name) OR (ost_char = @ost_second_name)
			   SET @sum = 0
			   
			   GOTO label
			   END
		       
			   
			
			   IF @ost_second_name IS NULL 
			   BEGIN 
			   FETCH RELATIVE -1 FROM cheb_curs2 INTO @vich_second_name, @ost_second_name, @second, @Gr2, @Summ_razn2, @Summa
				 
				 UPDATE Cheb2
				 SET Summa = Summa + @sum
				 WHERE (vich_char = @vich_second_name) OR (ost_char = @ost_second_name)
				 SET @sum = 0
				 
				 
				WHILE (SELECT Summ_razn_gr FROM Cheb2 WHERE (vich_char = @vich_second_name) OR (ost_char = @ost_second_name)) IS NOT NULL
				BEGIN 
				FETCH PRIOR FROM cheb_curs2 INTO @vich_second_name, @ost_second_name, @second, @Gr2, @Summ_razn2, @Summa
					
					
					IF (SELECT Summ_razn_gr FROM Cheb2 WHERE (vich_char = @vich_second_name) OR (ost_char = @ost_second_name)) IS NULL
					BEGIN
					FETCH RELATIVE 1 FROM cheb_curs2 INTO @vich_first_name, @ost_first_name, @first, @Gr1, @Summ_razn1, @Summa
					BREAK
					END
				END

				
				 BREAK
			   END


		   UPDATE Cheb2
		   SET Summ_razn_gr = @first - @second
		   WHERE (vich_char = @vich_second_name) OR (ost_char = @ost_second_name)
   
		   SET @sum = @sum + (@first - @second)
		   
		   END

     END

END
CLOSE cheb_curs2
DEALLOCATE cheb_curs2
go

CREATE PROCEDURE Conut_el_groups AS 

DECLARE @first float;
DECLARE @first_name nvarchar(255);

DECLARE @Gr nvarchar(20);
DECLARE @Gr_set nvarchar(20);
DECLARE @Summa float;
DECLARE @last_el nvarchar(255);


DECLARE count_curs SCROLL CURSOR 
FOR SELECT ost_char, R_sub, Gr, Summa FROM Cheb2
FOR UPDATE OF Count_Num_razn



OPEN count_curs

FETCH LAST FROM count_curs INTO @first_name, @first, @Gr, @Summa
SET @last_el = @first_name


FETCH FIRST FROM count_curs INTO @first_name, @first, @Gr, @Summa

IF @Summa IS NOT NULL
BEGIN
   
	   SET @Gr_set = (SELECT Count(Gr) From Cheb2 Where Gr = @Gr Group by Gr) 

	   UPDATE Cheb2
	   SET Count_Num_razn = @Gr_set
	   WHERE Gr = @Gr AND Summa IS NOT NULL
END


WHILE @@FETCH_STATUS = 0 
BEGIN 
  
  FETCH NEXT FROM count_curs INTO @first_name, @first, @Gr, @Summa

   WHILE @Summa IS NULL
   BEGIN
   FETCH NEXT FROM count_curs INTO @first_name, @first, @Gr, @Summa
   
	   IF @Summa IS NOT NULL
	   BEGIN
   
	   SET @Gr_set = (SELECT Count(Gr) From Cheb2 Where Gr = @Gr Group by Gr) 

	   UPDATE Cheb2
	   SET Count_Num_razn = @Gr_set
	   WHERE Gr = @Gr AND Summa IS NOT NULL
	   END

		   IF @first_name = @last_el
		   BREAK

   END

   IF @first_name = @last_el
   BREAK

END 


CLOSE count_curs
DEALLOCATE count_curs
go

CREATE PROCEDURE Cheb_Delitel AS 

DECLARE @first float;
DECLARE @first_name nvarchar(255);

DECLARE @Gr nvarchar(20);
DECLARE @Count_Num_razn float;
DECLARE @Summa float;
DECLARE @Summa_Num_razn float;
DECLARE @last_el nvarchar(255);



DECLARE delit_curs SCROLL CURSOR 
FOR SELECT ost_char, R_sub, Gr, Summa, Count_Num_razn FROM Cheb2
FOR UPDATE OF Delitel



OPEN delit_curs

FETCH LAST FROM delit_curs INTO @first_name, @first, @Gr, @Summa, @Count_Num_razn
SET @last_el = @first_name

SET @Summa_Num_razn = 0


FETCH FIRST FROM delit_curs INTO @first_name, @first, @Gr, @Summa, @Count_Num_razn

IF @Summa IS NOT NULL
BEGIN
UPDATE Cheb2
SET Delitel = 0
WHERE ost_char = @first_name
END


WHILE @@FETCH_STATUS = 0 
BEGIN 
  IF @Summa IS NOT NULL
	   BEGIN
       
		   WHILE @Count_Num_razn <> 1
		   BEGIN 
		   SET @Count_Num_razn = @Count_Num_razn - 1
	   
		   SET @Summa_Num_razn = @Summa_Num_razn + @Count_Num_razn

			   IF @Count_Num_razn = 1
			   BEGIN
			   UPDATE Cheb2
			   SET Delitel = @Summa_Num_razn
			   WHERE ost_char = @first_name

			   SET @Summa_Num_razn = 0

			   BREAK
			   END

		   END

	   END

  IF @first_name = @last_el
   BREAK

  FETCH NEXT FROM delit_curs INTO @first_name, @first, @Gr, @Summa, @Count_Num_razn



END 


CLOSE delit_curs
DEALLOCATE delit_curs
go

CREATE PROCEDURE Cheb_Summ_Group AS 

DECLARE @first float;
DECLARE @first_name nvarchar(255);

DECLARE @Gr nvarchar(20);
DECLARE @Group_number nvarchar(20);
DECLARE @Summ_Group float;
DECLARE @Summa float;
DECLARE @last_el nvarchar(255);


DECLARE Summ_gr_curs SCROLL CURSOR 
FOR SELECT ost_char, R_sub, Gr, Summa FROM Cheb2
FOR UPDATE OF Delitel


OPEN Summ_gr_curs

FETCH LAST FROM Summ_gr_curs INTO @first_name, @first, @Gr, @Summa
SET @last_el = @first_name

SET @Summ_Group = 0

FETCH FIRST FROM Summ_gr_curs INTO @first_name, @first, @Gr, @Summa

IF @Summa IS NOT NULL
BEGIN
UPDATE Cheb2
SET Summ_Group = @first
WHERE ost_char = @first_name
END


WHILE @@FETCH_STATUS = 0 
BEGIN 

  FETCH NEXT FROM Summ_gr_curs INTO @first_name, @first, @Gr, @Summa

  SET @Group_number = @Gr
  
  

  IF @Group_number = @Gr
  SET @Summ_Group = @Summ_Group + @first

  

  IF @Summa IS NOT NULL
  BEGIN
  UPDATE Cheb2
  SET Summ_Group = @Summ_Group
  WHERE ost_char =  @first_name

  SET @Summ_Group = 0
  END


  IF @first_name = @last_el
   BREAK

END 


CLOSE Summ_gr_curs
DEALLOCATE Summ_gr_curs
go

CREATE PROCEDURE Calc_F1 AS 

DECLARE @first float;
DECLARE @first_name nvarchar(255);
DECLARE @Gr nvarchar(20);
DECLARE @Summa float;
DECLARE @Delitel float;
DECLARE @Result float;
DECLARE @last_el nvarchar(255);



DECLARE F1_curs SCROLL CURSOR 
FOR SELECT ost_char, R_sub, Gr, Summa, Delitel FROM Cheb2
FOR UPDATE OF F1



OPEN F1_curs

FETCH LAST FROM F1_curs INTO @first_name, @first, @Gr, @Summa, @Delitel
SET @last_el = @first_name

SET @Summa = 0
SET @Delitel = 0
SET @Result = 0


FETCH FIRST FROM F1_curs INTO @first_name, @first, @Gr, @Summa, @Delitel

  IF @Summa IS NOT NULL
	  BEGIN

	  SET @Result = 0

	  UPDATE Cheb2
	  SET F1 = @Result
	  WHERE ost_char = @first_name

	  FETCH NEXT FROM F1_curs INTO @first_name, @first, @Gr, @Summa, @Delitel

	  END




WHILE @@FETCH_STATUS = 0 
BEGIN 

  IF @Summa IS NOT NULL
	  BEGIN

	  SET @Result = @Summa / @Delitel

	  UPDATE Cheb2
	  SET F1 = @Result
	  WHERE ost_char = @first_name

	  END

  IF @first_name = @last_el
  BEGIN
  BREAK
  END

  FETCH NEXT FROM F1_curs INTO @first_name, @first, @Gr, @Summa, @Delitel

END 


CLOSE F1_curs
DEALLOCATE F1_curs
go

CREATE PROCEDURE Vich_F2 AS 


DECLARE @Summ_Group float;
DECLARE @Result float;

DECLARE @num_el float;
DECLARE @S1 float;
DECLARE @S2 float;
DECLARE @F2 float;
DECLARE @Pointer_S1 float;
DECLARE @Pointer_S2 float;





DECLARE F2_curs CURSOR 
FOR SELECT Count_Num_razn, Summ_Group, F2 FROM Cheb2
FOR UPDATE OF F2


OPEN F2_curs

SET @S1 = NULL
SET @S2 = NULL
SET @F2 = NULL
SET @num_el = NULL
SET @Pointer_S1 = NULL
SET @Pointer_S2 = NULL


FETCH NEXT FROM F2_curs INTO @num_el, @Summ_Group, @Result



WHILE @@FETCH_STATUS = 0 
BEGIN 
  
  IF @Summ_Group IS NOT NULL
  BEGIN 

		IF @S1 IS NOT NULL AND @S2 IS NOT NULL
			BEGIN
			SET @S1 = @S2
			SET @Pointer_S1 = @Pointer_S2
			SET @S2 = @Summ_Group / @num_el
			SET @Pointer_S2 = @Summ_Group
			
			SET @F2 = @S1 - @S2

			UPDATE Cheb2
			SET F2 = @F2
			WHERE Summ_Group = @Pointer_S1
			END

	  IF @S1 IS NULL
		  BEGIN
		  SET @S1 = @Summ_Group / @num_el
		  SET @Pointer_S1 = @Summ_Group
		  
		  END
	  ELSE
		  BEGIN
			  IF @S1 IS NOT NULL AND @S2 IS NULL
			  BEGIN
			  SET @S2 = @Summ_Group / @num_el
			  SET @Pointer_S2 = @Summ_Group
			  SET @F2 = @S1 - @S2

			  UPDATE Cheb2
			  SET F2 = @F2
			  WHERE Summ_Group = @Pointer_S1
			  END
		  END

  END

  FETCH NEXT FROM F2_curs INTO @num_el, @Summ_Group, @Result
  

END


CLOSE F2_curs
DEALLOCATE F2_curs
go

CREATE PROCEDURE Vich_Result AS 

DECLARE @F1 float;
DECLARE @F2 float;
DECLARE @Result float;



DECLARE Result_curs CURSOR 
FOR SELECT F1, F2 FROM Cheb2
FOR UPDATE OF Result


OPEN Result_curs

FETCH NEXT FROM Result_curs INTO @F1, @F2


WHILE @@FETCH_STATUS = 0 
BEGIN 
  
  IF @F1 IS NOT NULL AND @F2 IS NOT NULL
  BEGIN

  SET @Result = 1 - POWER((@F1 / @F2), 2)

  UPDATE Cheb2
  SET Result = @Result
  WHERE F1 = @F1 AND F2 = @F2

  END




FETCH NEXT FROM Result_curs INTO @F1, @F2
  

END 


CLOSE Result_curs
DEALLOCATE Result_curs
go

CREATE PROCEDURE TestProc
@Tablename varchar(50)
AS
declare @cmd varchar(800)
set @cmd = 'SELECT * INTO ' +@Tablename+ ' FROM Cheb2'
exec (@cmd)
go



DECLARE @MyCounter int;

DECLARE @Tablename varchar(50)
SET @MyCounter = 1


CREATE TABLE Pemp_Result (
Pemp_namber nvarchar(255) NULL,
Result float NULL
)

SELECT * INTO Pemp_main FROM Pemp

exec DIFFcurs1

  While(SELECT Count(vich_char) FROM Pemp1 WHERE vich_char IS NOT NULL)>=2
BEGIN

IF (@MyCounter > 1)
Begin
truncate table Pemp1

exec DIFFcurs1

IF(SELECT Count(vich_char) FROM Pemp1 WHERE vich_char IS NOT NULL)=1
break

end

CREATE TABLE Pemp33 (

vich_char nvarchar(255) NULL,
vich_float float NULL,
ost_char nvarchar(255) NULL,
ost_float float NULL,
R_sub float NULL
)



exec Create_Pemp

  SELECT vich_char, vich_float, ost_char, ost_float, R_sub
  INTO Cheb1
  FROM Pemp33
  ORDER BY R_sub DESC
  ALTER TABLE Cheb1 ADD Gr NVARCHAR(20) NULL;

  
  exec Numeration

  SELECT vich_char, vich_float, ost_char, ost_float, R_sub, Gr
  INTO Cheb2
  FROM Cheb1
  ALTER TABLE Cheb2 ADD Summ_razn_gr float NULL, Summa float NULL;


  exec Cheb_alg
  exec Cheb_alg1

  ALTER TABLE Cheb2 ADD Count_Num_razn float NULL

exec Conut_el_groups

ALTER TABLE Cheb2 ADD Delitel float NULL

exec Cheb_Delitel

ALTER TABLE Cheb2 ADD Summ_Group float NULL

exec Cheb_Summ_Group

ALTER TABLE Cheb2 ADD F1 float NULL

exec Calc_F1

ALTER TABLE Cheb2 ADD F2 float NULL

exec Vich_F2

ALTER TABLE Cheb2 ADD Result float NULL

exec Vich_Result


SET @Tablename = 'Pempm' + CAST(@MyCounter AS VARCHAR(5))
exec TestProc @Tablename

INSERT INTO Pemp_Result(Result, Pemp_namber)
SELECT MIN(Result), 'Pemp' + CAST(@MyCounter AS VARCHAR(5)) FROM Cheb2 WHERE Result IS NOT NULL

SET @MyCounter = @MyCounter + 2




DROP TABLE Cheb1;
DROP TABLE Cheb2;
DROP TABLE Pemp33;


truncate table Pemp

INSERT INTO Pemp(R_ec, Название_Субъекта, Dif)
SELECT R_sub, vich_char, vich_float
FROM Pemp1
WHERE vich_char IS NOT NULL




END
go



CREATE TABLE Cheb_PK (
    Sub nvarchar(255) NOT NULL,
    Gr nvarchar(20)
    PRIMARY KEY (Sub)
);
go


CREATE PROCEDURE TestProc2
@Tablename varchar(50)
AS
declare @cmd varchar(800)
set @cmd = 'DECLARE For_map1 CURSOR FOR SELECT vich_char, ost_char, Gr FROM ' + @Tablename + ' OPEN For_map1'
exec (@cmd)
go



CREATE PROCEDURE For_map AS 

DECLARE @ost nvarchar(255);
DECLARE @vich nvarchar(255);
DECLARE @Gr nvarchar(20);

DECLARE @Tablename varchar(50)
DECLARE @Tablename1 varchar(50)
DECLARE @max_Result float;
SET @max_Result = (SELECT MAX(Result) FROM Pemp_Result)
SET @Tablename1 = (SELECT Pemp_namber FROM Pemp_Result WHERE Result = @max_Result)
SET @Tablename = 'Pempm' + SUBSTRING(@Tablename1, 5, 10)



exec TestProc2 @Tablename

FETCH NEXT FROM For_map1 INTO @vich, @ost, @Gr


WHILE @@FETCH_STATUS = 0 
BEGIN 


  IF @ost IS NOT NULL
	  BEGIN
 
	  INSERT INTO Cheb_PK([Sub],[Gr]) VALUES(@ost, @Gr)
	  END
  ELSE
      BEGIN
      INSERT INTO Cheb_PK([Sub],[Gr]) VALUES(@vich, @Gr)
      END

  FETCH NEXT FROM For_map1 INTO @vich, @ost, @Gr

END 


CLOSE For_map1
DEALLOCATE For_map1
go


exec For_map
go