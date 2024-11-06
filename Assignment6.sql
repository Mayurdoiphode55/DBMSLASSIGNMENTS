-- Create tables
CREATE TABLE N_EmpId (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    Department VARCHAR(50)
);

CREATE TABLE O_EmpId (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    Department VARCHAR(50)
);

-- Insert sample data into N_EmpId
INSERT INTO N_EmpId (EmpID, EmpName, Department) VALUES
(1, 'Alice', 'HR'),
(2, 'Bob', 'IT'),
(3, 'Charlie', 'Finance');

-- Insert sample data into O_EmpId
INSERT INTO O_EmpId (EmpID, EmpName, Department) VALUES
(2, 'Bob', 'IT'),
(4, 'David', 'Marketing');

-- Create stored procedure to merge data
DELIMITER //

CREATE PROCEDURE MergeEmployees()
BEGIN
    DECLARE v_EmpID INT;
    DECLARE v_EmpName VARCHAR(50);
    DECLARE v_Department VARCHAR(50);
    DECLARE done INT DEFAULT 0;

    -- Declare a cursor to iterate over the N_EmpId table
    DECLARE cur CURSOR FOR 
        SELECT EmpID, EmpName, Department FROM N_EmpId;

    -- Declare a handler for the end of the cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur;

    -- Loop through all records in the cursor
    read_loop: LOOP
        FETCH cur INTO v_EmpID, v_EmpName, v_Department;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Check if the employee exists in O_EmpId; if not, insert
        IF NOT EXISTS (SELECT 1 FROM O_EmpId WHERE EmpID = v_EmpID) THEN
            INSERT INTO O_EmpId (EmpID, EmpName, Department)
            VALUES (v_EmpID, v_EmpName, v_Department);
        END IF;
    END LOOP;

    CLOSE cur;

    -- Completion message
    SIGNAL SQLSTATE '01000' SET MESSAGE_TEXT = 'Merge completed successfully';
END //

DELIMITER ;
CALL MergeEmployees();
SELECT * FROM O_EmpId;
