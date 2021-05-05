USE testingsystem;

-- question1
SELECT * FROM `Account` a INNER JOIN Department d ON a.DepartmentID = d.DepartmentID;

-- question3
SELECT * FROM `Account` a INNER JOIN Position p ON a.PositionID = p.PositionID WHERE p.PositionName = 'Dev';

-- question4
SELECT d.DepartmentName, count(a.DepartmentID) FROM `account` a 
INNER JOIN department d ON a.DepartmentID = d.DepartmentID
GROUP BY a.DepartmentID
HAVING count(a.DepartmentID)>3;

-- question5
