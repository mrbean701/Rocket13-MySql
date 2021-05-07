  
USE testingsystem;

-- question1: Viết lệnh để lấy ra danh sách nhân viên và thông tin phòng ban của họ
SELECT * FROM `Account` a INNER JOIN
 Department d ON a.DepartmentID = d.DepartmentID;

-- question2: Viết lệnh để lấy ra thông tin các account được tạo sau ngày 20/12/2010
SELECT * FROM `Account` WHERE CreateDate > 20/12/2010;

-- question3: Viết lệnh để lấy ra tất cả các developer
SELECT * FROM `Account` a INNER JOIN Position p 
ON a.PositionID = p.PositionID WHERE p.PositionName = 'Dev';

-- question4: Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên
SELECT d.DepartmentName, count(a.DepartmentID) FROM `account` a 
INNER JOIN department d ON a.DepartmentID = d.DepartmentID
GROUP BY a.DepartmentID
HAVING count(a.DepartmentID)>3;

-- question5: Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhất
SELECT q.*, count(q.Content) AS SL FROM Question q INNER JOIN ExamQuestion eq 
ON q.QuestionID = eq.QuestionID
GROUP BY q.Content 
HAVING count(q.Content) = 
(SELECT max(countquestion) 
FROM (SELECT count(q.QuestionID) AS Countquestion 
FROM ExamQuestion eq INNER JOIN Question q ON eq.QuestionID = q.QuestionID 
GROUP BY q.QuestionID) AS maxContent);

-- question6: Thống kê mỗi category question được sử dụng trong bao nhiêu question
SELECT cq.*, count(q.CategoryID) AS SL FROM CategoryQuestion cq 
LEFT JOIN Question q ON cq.CategoryID = q.CategoryID 
GROUP BY cq.CategoryID ORDER BY cq.CategoryID ASC;

-- question7: Thống kê mỗi question được sử dụng trong bao nhiêu exam
SELECT q.*, count(eq.QuestionID) AS SL FROM Question q 
LEFT JOIN ExamQuestion eq ON q.QuestionID = eq.QuestionID 
GROUP BY QuestionID ORDER BY ExamID ASC;

-- question8: Lấy ra question có nhiều câu trả lời nhất
SELECT q.*, count(a.QuestionID) AS SL FROM Question q INNER JOIN Answer a ON q.QuestionID = a.QuestionID
GROUP BY a.QuestionID
HAVING count(a.QuestionID) = 
(SELECT max(countQuestion) FROM 
(SELECT count(a.QuestionID) AS countQuestion FROM Answer a 
RIGHT JOIN Question q ON a.QuestionID = q.QuestionID) AS maxCountQuestion);

-- question9: Thống kê số lượng account trong mỗi group
SELECT g.*, count(ga.AccountID) AS SL FROM `Group` g LEFT JOIN  GroupAccount ga ON g.GroupID = ga.GroupID 
GROUP BY g.GroupID ORDER BY g.GroupID ASC;

-- question10: Tìm chức vụ có ít người nhất
SELECT d.*, count(a.DepartmentID) AS SL FROM Department d RIGHT JOIN `Account` a ON d.DepartmentID = a.DepartmentID 
GROUP BY d.DepartmentID ORDER BY d.DepartmentID DESC LIMIT 1;

SELECT * FROM Department;
SELECT * FROM `Account`;

-- question11: Thống kê mỗi phòng ban có bao nhiêu dev, test, sale, marketing

-- question12: Lấy thông tin chi tiết của câu hỏi bao gồm: thông tin cơ bản của question, typequestion, creator, answer
SELECT q.*, t.TypeName, a.Content FROM Question q 
INNER JOIN Answer a ON q.QuestionID = a.QuestionID 
INNER JOIN TypeQuestion t ON q.TypeID = t.TypeID;

-- question13: Lấy ra số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm
SELECT t.TypeName ,count(q.TypeID) AS SL FROM Question q INNER JOIN TypeQuestion t
ON q.TypeID = t.TypeID
GROUP BY q.TypeID;

-- question14: Lấy ra group không có account nào
SELECT * FROM `Group` WHERE (SELECT count(ga.AccountID) AS SL FROM GroupAccount ga 
INNER JOIN `Account` a ON ga.AccountID = a.AccountID 
ORDER BY ga.GroupID ASC) = 0;

-- question16: Lấy ra question không có answer nào
SELECT * FROM Question WHERE 
(SELECT count(a.answerID) AS SL FROM Answer a 
INNER JOIN Question q ON a.QuestionID = q.QuestionID 
ORDER BY q.QuestionID ASC) = 0;

-- Exercise 2 : UNION
-- question17: 
-- a) Lấy các account thuộc nhóm thứ 1
SELECT a.* FROM `Account` a INNER JOIN GroupAccount ga ON a.AccountID = ga.AccountID 
WHERE ga.GroupID = 1;

-- b) Lấy các account thuộc nhóm thứ 2
SELECT a.* FROM `Account` a INNER JOIN GroupAccount ga ON a.AccountID = ga.AccountID 
WHERE ga.GroupID = 2;

-- c) Ghép 2 kết quả từ câu a) và câu b) sao cho không có record nào trùng nhau
SELECT a.* FROM `Account` a INNER JOIN GroupAccount ga ON a.AccountID = ga.AccountID 
WHERE ga.GroupID = 1
UNION
SELECT a.* FROM `Account` a INNER JOIN GroupAccount ga ON a.AccountID = ga.AccountID 
WHERE ga.GroupID = 2;

-- question18:
-- a) Lấy các group có lớn hơn 5 thành viên
SELECT g.*, count(1) AS SL FROM `Group` g INNER JOIN GroupAccount ga ON g.GroupID = ga.GroupID
GROUP BY ga.GroupID HAVING SL >= 5;

-- b) Lấy các group có lớn hơn 7 thành viên
SELECT g.*, count(1) AS SL FROM `Group` g INNER JOIN GroupAccount ga ON g.GroupID = ga.GroupID
GROUP BY ga.GroupID HAVING SL >= 7;

-- c) Ghép 2 kết quả từ câu a) và câu b)
SELECT g.*, count(1) AS SL FROM `Group` g INNER JOIN GroupAccount ga ON g.GroupID = ga.GroupID
GROUP BY ga.GroupID HAVING SL >= 5
UNION
SELECT g.*, count(1) AS SL FROM `Group` g INNER JOIN GroupAccount ga ON g.GroupID = ga.GroupID
GROUP BY ga.GroupID HAVING SL >= 7;