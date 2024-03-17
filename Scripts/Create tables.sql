

-- DROP TABLE statements
DROP TABLE IF EXISTS Cart1;
DROP TABLE IF EXISTS Cart2;

-- CREATE TABLE statements
CREATE TABLE Cart1 (
    Item VARCHAR(100) PRIMARY KEY
);

CREATE TABLE Cart2 (
    Item VARCHAR(100) PRIMARY KEY
);

-- INSERT INTO statements
INSERT INTO Cart1 (Item) VALUES
('Sugar'),('Bread'),('Juice'),('Soda'),('Flour');

INSERT INTO Cart2 (Item) VALUES
('Sugar'),('Bread'),('Butter'),('Cheese'),('Fruit');


Answer to Puzzle #2
Managers and Employees
*/----------------------------------------------------

DROP TABLE IF EXISTS Employees;


CREATE TABLE Employees
(
EmployeeID  INTEGER PRIMARY KEY,
ManagerID   INTEGER NULL,
JobTitle    VARCHAR(100) NOT NULL
);


INSERT INTO Employees (EmployeeID, ManagerID, JobTitle) VALUES
(1001,NULL,'President'),(2002,1001,'Director'),
(3003,1001,'Office Manager'),(4004,2002,'Engineer'),
(5005,2002,'Engineer'),(6006,2002,'Engineer');