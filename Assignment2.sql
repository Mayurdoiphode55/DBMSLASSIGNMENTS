-- Step 1: Create Dept2 Table
CREATE TABLE Dept2 (
    Dept_id INT PRIMARY KEY AUTO_INCREMENT,
    Dept_name VARCHAR(50),
    Location VARCHAR(50)
);

-- Step 2: Insert Data into Dept2
INSERT INTO Dept2 (Dept_name, Location) VALUES 
    ('Computer', 'New York'),
    ('IT', 'San Francisco'),
    ('Finance', 'Chicago'),
    ('Marketing', 'Los Angeles'),
    ('Sales', 'Seattle'),
    ('Legal', 'Boston'),
    ('R&D', 'Austin'),
    ('Operations', 'Denver'),
    ('Support', 'Atlanta'),
    ('Logistics', 'Houston');

-- Step 3: Create Employee2 Table
CREATE TABLE Employee2 (
    Emp_id INT PRIMARY KEY AUTO_INCREMENT,
    Dept_id INT,
    Emp_fname VARCHAR(50) NOT NULL,
    Emp_lname VARCHAR(50),
    Emp_position VARCHAR(50) NOT NULL DEFAULT '0',
    Emp_salary INT NOT NULL,
    Emp_joindate DATE,
    FOREIGN KEY (Dept_id) REFERENCES Dept2(Dept_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Step 4: Create Project2 Table
CREATE TABLE Project2 (
    Proj_id INT PRIMARY KEY AUTO_INCREMENT,
    Dept_id INT,
    Proj_name VARCHAR(50) NOT NULL DEFAULT ' ',
    Proj_location VARCHAR(50) NOT NULL DEFAULT ' ',
    Proj_cost INT NOT NULL DEFAULT 0,
    Proj_year DATE,
    FOREIGN KEY (Dept_id) REFERENCES Dept2(Dept_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Step 5: Insert Data into Employee2
INSERT INTO Employee2 (Dept_id, Emp_fname, Emp_lname, Emp_position, Emp_salary, Emp_joindate) VALUES 
    (1, 'John', 'Doe', 'HR Manager', 70000, '2020-05-10'),
    (2, 'Jane', 'Smith', 'Software Engineer', 85000, '2019-04-15'),
    (3, 'Bob', 'Johnson', 'Financial Analyst', 65000, '2021-01-20'),
    (4, 'Alice', 'Brown', 'Marketing Specialist', 60000, '2018-11-05'),
    (5, 'Tom', 'White', 'Sales Representative', 55000, '2020-03-12'),
    (6, 'Sam', 'Green', 'Legal Advisor', 80000, '2017-09-23'),
    (7, 'Chris', 'Black', 'Research Scientist', 95000, '2022-06-30'),
    (8, 'Jessica', 'Davis', 'Operations Manager', 90000, '2019-08-19'),
    (9, 'David', 'Martinez', 'Support Engineer', 60000, '2021-10-25'),
    (10, 'Laura', 'Garcia', 'Logistics Coordinator', 58000, '2020-02-14');

-- Step 6: Insert Data into Project2
INSERT INTO Project2 (Dept_id, Proj_name, Proj_Location, Proj_Cost, Proj_year) VALUES
    (1, 'Employee Engagement', 'New York', 200000, '2022-01-01'),
    (2, 'App Development', 'San Francisco', 500000, '2021-05-15'),
    (3, 'Annual Financial Report', 'Chicago', 150000, '2021-12-01'),
    (4, 'Ad Campaign', 'Los Angeles', 300000, '2022-06-10'),
    (5, 'Sales Strategy', 'Seattle', 250000, '2021-09-30'),
    (6, 'Compliance Audit', 'Boston', 100000, '2022-03-20'),
    (7, 'Product Research', 'Austin', 750000, '2023-02-01'),
    (8, 'Warehouse Operations', 'Denver', 400000, '2021-07-15'),
    (9, 'Customer Support Optimization', 'Atlanta', 350000, '2022-11-05'),
    (10, 'Supply Chain Overhaul', 'Houston', 600000, '2023-04-18');

-- Step 7: Queries
-- 1. Select employees in Computer or IT departments with names starting with 'J' or 'H'
SELECT * FROM Employee2 
WHERE Dept_id IN (SELECT Dept_id FROM Dept2 WHERE Dept_name IN ('Computer', 'IT'))
AND (Emp_fname LIKE 'J%' OR Emp_fname LIKE 'H%');

-- 2. Count distinct positions in Employee2
SELECT COUNT(DISTINCT Emp_position) AS NoOfPositions FROM Employee2;

-- 3. Update salaries for employees who joined before 2020
UPDATE Employee2 SET Emp_salary = Emp_salary * 1.1 WHERE Emp_joindate < '2020-01-01';

-- 4. Find projects located in Chicago
SELECT Proj_name FROM Project2 WHERE Proj_location = 'Chicago';

-- 5. Find projects with costs between 150,000 and 300,000
SELECT * FROM Project2 WHERE Proj_cost BETWEEN 150000 AND 300000;

-- 6. Calculate the average project cost
SELECT AVG(Proj_cost) AS AverageCost FROM Project2;

-- 7. Select the most expensive project
SELECT * FROM Project2 ORDER BY Proj_cost DESC LIMIT 1;
