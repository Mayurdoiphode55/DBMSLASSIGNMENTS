create table Library(
id int primary key auto_increment,#remember syntax of auto increment
name varchar(20),
price int);
show tables;
create table Library_Audit(audit_id int auto_increment primary key, id int, name varchar(20),price int, operation_type varchar(20)); #opeartion type whether update or delete
insert into Library(name,price)
values('SPOS' , 100),
('CN' , 200),
('DELD' , 300),
('DBMS' , 100),
('BXE' , 900),
('DS' , 1200);

DELIMITER //
create trigger before_delete_on
before delete on Library
FOR each row
BEGIN
 INSERT into Library_Audit(id,name,price,operation_type) values(old.id,old.name,old.price,'Before Delete');
END//

DELIMITER //
create trigger after_delete_on
after delete on Library
FOR each row
BEGIN
 INSERT into Library_Audit(id,name,price,operation_type) values(old.id,old.name,old.price,'After Delete');
END//


DELIMITER //
create trigger before_update
before update on Library
FOR each row
BEGIN
 INSERT into Library_Audit(id,name,price,operation_type) values(old.id,old.name,old.price,'Before Update');
END//



DELIMITER //
create trigger after_update
after update on Library
FOR each row
BEGIN
 INSERT into Library_Audit(id,name,price,operation_type) values(new.id,new.name,new.price,'After Update');
END//

DELIMITER //
create trigger after_insert
after insert on Library
for each row
BEGIN
    INSERT into Library_Audit(id,name,price,operation_type) values(new.id,new.name,new.price,'After Insert');
END //



select * from Library_Audit;

