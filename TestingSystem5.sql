USE TestingSystem;

-- question1: Tạo view có chứa danh sách nhân viên thuộc phòng ban sale
CREATE OR REPLACE VIEW VW_DSNV_Sale AS
SELECT a.AccountID, a.Email, a.UserName, a.FullName, a.PositionID, a.CreateDate, a.DepartmentID, d.DepartmentName FROM `Account` a INNER JOIN Department d
ON a.DepartmentID = d.DepartmentID WHERE d.DepartmentName = 'Sale';

SELECT * FROM VW_DSNV_Sale;

-- question2: Tạo view có chứa thông tin các account tham gia vào nhiều group nhất

CREATE OR REPLACE VIEW VW_MostAccountGroup AS 
WITH CTE_GetListCountAccount AS(
SELECT count(ga.AccountID) AS SL 
FROM GroupAccount ga GROUP BY ga.AccountID
)
SELECT ga.AccountID, ga.GroupID FROM GroupAccount ga INNER JOIN `Account` a ON ga.AccountID = a.AccountID
GROUP BY ga.AccountID 
HAVING count(ga.AccountID) = (SELECT MAX(SL) FROM CTE_GetListCountAccount);

SELECT * FROM VW_MostAccountGroup;


-- question3 : Tạo view có chứa câu hỏi có những content dài quá 18 kí tự

CREATE OR REPLACE VIEW VW_ContentMore18Chars AS
SELECT * FROM Question WHERE LENGTH(Content) > 18;

DELETE FROM VW_ContentMore18Chars;

-- question4: Tạo view có chứa danh sách các phòng ban có nhiều nhân viên nhất

CREATE OR REPLACE VIEW VW_MaxAccountDepartment AS

SELECT d.DepartmentID, d.DepartmentName FROM Department d INNER JOIN `Account` a 
ON a.DepartmentID = d.DepartmentID;

-- question5: Tạo view có chứa tất cả các câu hỏi do user họ Nguyễn tạo

CREATE OR REPLACE VIEW VW_Que5 AS
SELECT Q.CategoryID, q.Content, a.FullName AS Creator 
FROM Question q INNER JOIN `Account` a ON
q.CreatorID = a.AccountID
WHERE SUBSTRING_INDEX(a.FullName,'',1) = 'Nguyễn';

SELECT * FROM VW_Que5;