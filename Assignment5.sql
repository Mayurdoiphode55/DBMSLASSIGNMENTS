-- Creating Stud_Marks table
CREATE TABLE Stud_Marks (
    Name VARCHAR(50),
    Total_Marks INT
);

-- Creating Result table
CREATE TABLE Result (
    Roll INT PRIMARY KEY,
    Name VARCHAR(50),
    Class VARCHAR(30)
);
DELIMITER //

CREATE PROCEDURE proc_Grade (
    IN p_roll INT,
    IN p_name VARCHAR(50),
    IN p_total_marks INT
)
BEGIN
    DECLARE v_class VARCHAR(30);

    -- Determine the class based on Total_Marks
    IF p_total_marks BETWEEN 990 AND 1500 THEN
        SET v_class := 'Distinction';
    ELSEIF p_total_marks BETWEEN 900 AND 989 THEN
        SET v_class := 'First Class';
    ELSEIF p_total_marks BETWEEN 825 AND 899 THEN
        SET v_class := 'Higher Second Class';
    ELSE
        SET v_class := 'No Grade';
    END IF;

    -- Insert the result into the Result table
    INSERT INTO Result (Roll, Name, Class)
    VALUES (p_roll, p_name, v_class);
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE categorize_students()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_roll INT DEFAULT 0;
    DECLARE v_name VARCHAR(50);
    DECLARE v_total_marks INT;

    -- Cursor to select each student from Stud_Marks
    DECLARE stud_cursor CURSOR FOR
        SELECT row_number() OVER () AS Roll, Name, Total_Marks FROM Stud_Marks;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Open cursor and process each record
    OPEN stud_cursor;

    stud_loop: LOOP
        FETCH stud_cursor INTO v_roll, v_name, v_total_marks;
        IF done THEN
            LEAVE stud_loop;
        END IF;

        -- Call the proc_Grade procedure
        CALL proc_Grade(v_roll, v_name, v_total_marks);
    END LOOP;

    CLOSE stud_cursor;

    -- Commit changes
    COMMIT;
END //

DELIMITER ;

-- Insert sample data into Stud_Marks table
INSERT INTO Stud_Marks (Name, Total_Marks) VALUES ('John Doe', 1000);
INSERT INTO Stud_Marks (Name, Total_Marks) VALUES ('Jane Smith', 950);
INSERT INTO Stud_Marks (Name, Total_Marks) VALUES ('Alice Johnson', 875);
INSERT INTO Stud_Marks (Name, Total_Marks) VALUES ('Bob Brown', 800);
INSERT INTO Stud_Marks (Name, Total_Marks) VALUES ('Charlie Davis', 1200);

CALL proc_Grade(1, 'John Doe', 1000);
SELECT * FROM Result;
