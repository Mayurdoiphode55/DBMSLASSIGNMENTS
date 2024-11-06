create table Borrower1(Roll int PRIMARY KEY not null,Name varchar(50),DateofIssue DATE, NameofBook varchar(50), Status Char(1) default 'I');
DESCRIBE Borrower1;
select * from Borrower1;

insert into Borrower1(Roll,Name,DateofIssue,NameofBook) values(1,'Sam','2024-08-30',"The Book of Fantasy");
insert into Borrower1(Roll,Name,DateofIssue,NameofBook,Status) values(2,'Prabhu','2024-09-10',"The Alchemist", 'I'),
(3,'Nilesh','2024-09-02',"The Hobbit", 'I'),
(4,'Mansi','2024-08-27',"Lord of the Rings", 'I'),
(5,'Arinjay','2024-09-05',"Rich Dad Poor Dad", 'I'),
(6,'Drishti','2024-08-28',"48 Laws of Power", 'I');
drop table Fine1;
create table Fine1(Roll int not null, Date DATE, Amt int, foreign key(roll) references Borrower1(roll));
describe Fine1;

DELIMITER //
Create PROCEDURE cal_fine(IN r INT,IN n varchar(50))
BEGIN 
    DECLARE i_date DATE;
	DECLARE fine_amt int default 0;
    DECLARE days_of_count int default 0;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION,NOT FOUND
    BEGIN
      select 'Record not found';
	END;
    DECLARE EXIT HANDLER FOR 1062 
    BEGIN
    SELECT 'Fine already paid';
    END;
    select 	Dateofissue into i_date from Borrower1 where Roll=r and Name=n;
    select DATEDIFF(CURDATE(),i_date) into days_of_count;
    IF(days_of_count>15 and days_of_count<30) then
       set fine_amt=5*days_of_count;
       insert into Fine1(Roll,Date,Amt) values(r, CURDATE(),fine_amt);
    ELSEIF(days_of_count>30) then
       set fine_amt=5*days_of_count;
       insert into Fine1(Roll,Date,Amt) values(r, CURDATE(),fine_amt);
     END IF;
     UPDATE Borrower1 set status='R' where Roll = r and Name = n;
     END;
     //
     DELIMITER ;
     
	call cal_fine(1,'Sam');
    select * from Fine1;
    select * from Borrower1;
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
        