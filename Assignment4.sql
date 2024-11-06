-- Create Borrower1 table
CREATE TABLE Borrower1 (
    Roll INT PRIMARY KEY NOT NULL,
    Name VARCHAR(50),
    DateofIssue DATE,
    NameofBook VARCHAR(50),
    Status CHAR(1) DEFAULT 'I'
);

-- Verify the Borrower1 table structure
DESCRIBE Borrower1;

-- Create Fine1 table with a foreign key reference to Borrower1
CREATE TABLE Fine1 (
    Roll INT NOT NULL,
    Date DATE,
    Amt INT,
    FOREIGN KEY (Roll) REFERENCES Borrower1(Roll)
);

-- Verify the Fine1 table structure
DESCRIBE Fine1;

-- Insert records into Borrower1
INSERT INTO Borrower1 (Roll, Name, DateofIssue, NameofBook) VALUES
    (1, 'Sam', '2024-08-30', 'The Book of Fantasy');

INSERT INTO Borrower1 (Roll, Name, DateofIssue, NameofBook, Status) VALUES
    (2, 'Prabhu', '2024-09-10', 'The Alchemist', 'I'),
    (3, 'Nilesh', '2024-09-02', 'The Hobbit', 'I'),
    (4, 'Mansi', '2024-08-27', 'Lord of the Rings', 'I'),
    (5, 'Arinjay', '2024-09-05', 'Rich Dad Poor Dad', 'I'),
    (6, 'Drishti', '2024-08-28', '48 Laws of Power', 'I');

DROP PROCEDURE IF EXISTS cal_fine;

DELIMITER //
CREATE PROCEDURE cal_fine(IN r INT, IN n VARCHAR(50))
BEGIN
    DECLARE i_date DATE;
    DECLARE fine_amt INT DEFAULT 0;
    DECLARE days_of_count INT DEFAULT 0;
    
    -- Exception handlers for missing records or duplicate entries
    DECLARE EXIT HANDLER FOR SQLEXCEPTION, NOT FOUND 
    BEGIN
        SELECT 'Record not found or error in processing' AS Error;
    END;
    
    DECLARE EXIT HANDLER FOR 1062 
    BEGIN
        SELECT 'Fine already paid' AS Message;
    END;
    
    -- Get Date of Issue for the given Roll number and Name
    SELECT DateofIssue INTO i_date FROM Borrower1 WHERE Roll = r AND Name = n;
    
    -- Calculate the difference in days
    SET days_of_count = DATEDIFF(CURDATE(), i_date);
    
    -- Check and calculate fine based on the days
    IF days_of_count > 15 THEN
       SET fine_amt = 5 * days_of_count;
       INSERT INTO Fine1 (Roll, Date, Amt) VALUES (r, CURDATE(), fine_amt);
    END IF;

    -- Update the status to 'R' (Returned)
    UPDATE Borrower1 SET Status = 'R' WHERE Roll = r AND Name = n;
    
END //
DELIMITER ;

CALL cal_fine(1, 'Sam');

SELECT * FROM Fine1;

SELECT * FROM Borrower1;
