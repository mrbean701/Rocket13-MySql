use testingsystem;

-- question2
SELECT * FROM Department;

-- question3
SELECT DepartmentID FROM Department WHERE DepartmentName = "Sale";

-- question4
SELECT * FROM `Account` ORDER BY length(FullName) DESC LIMIT 1;

-- question5
SELECT * FROM `Account` WHERE DepartmentID = 3 ORDER BY length(FullName) DESC LIMIT 1;

-- question6
SELECT g.GroupName FROM `Group` g WHERE CreateDate < "2019-12-20";

-- question7
SELECT QuestionID FROM Question WHERE (SELECT count(AnswerID)FROM Answer WHERE Question.QuestionID = Answer.QuestionID) >= 4;

-- question8
SELECT ExamID FROM Exam WHERE Duration >= 60 GROUP BY `Code` HAVING CreateDate < '2019-12-20';

-- question9
SELECT * FROM `Group` ORDER BY CreateDate DESC LIMIT 5 ;

-- question10
SELECT COUNT(a.AccountID) as 'So nhan vien' FROM `Account` a INNER JOIN Department d ON a.DepartmentID = d.DepartmentID WHERE a.DepartmentID = 2;


-- question11
SELECT * FROM `Account` WHERE FullName LIKE "D%" AND "%o";
 
 -- question12
DELETE FROM Exam WHERE CreateDate < "2019-12-20";

-- question13
DELETE FROM Question WHERE Content LIKE "câu hỏi%";

-- question14
UPDATE `Account` SET FullName ='Nguyễn Bá Lộc', Email = 'loc.nguyenba@vti.com.vn' WHERE AccountID = 5;

-- question15
UPDATE GroupAccount SET GroupID = 4 WHERE AccountID = 5;
