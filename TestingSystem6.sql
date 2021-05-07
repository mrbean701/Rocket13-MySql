USE TestingSystem;

-- question1: Tạo store để người dùng nhập vào tên phòng ban và
-- in ra tất cả các account thuộc phòng ban đó

DROP PROCEDURE IF EXISTS sp_GetDepNameFromDepID;
DELIMITER $$
CREATE PROCEDURE sp_GetDepNameFromDepID(IN in_depID TINYINT, OUT in_depName VARCHAR(50))
BEGIN
	SELECT d.DepartmentID INTO in_depName
    FROM Department d WHERE d.DepartmentID = in_depID;
END$$
DELIMITER ;

SET @dep_Name = '';

CALL sp_GetDepNameFromDepID(1, @dep_Name);

SELECT @dep_Name;

-- question2: Tạo store để in ra số lượng account trong mỗi group
DROP PROCEDURE IF EXISTS sp_GetCountAccount;

DELIMITER $$
CREATE PROCEDURE sp_GetCountAccount(IN in_groupName NVARCHAR(50))
BEGIN
	SELECT g.*, count(1) AS SL FROM GroupAccount ga 
    INNER JOIN `Group` g WHERE g.GroupName = in_groupName;
END$$
DELIMITER ;

CALL sp_GetCountAccount('Development');

-- question3: Tạo store để thống kê mỗi type question 
-- có bao nhiêu question được tạo trong tháng hiện tại
DROP PROCEDURE IF EXISTS sp_GetCountTypeInMonth;

DELIMITER $$
CREATE PROCEDURE sp_GetCountTypeInMonth()
BEGIN
	SELECT * FROM Question  WHERE month(CreateDate) = month(now()) 
    AND year(CreateDate) = year(now())
    GROUP BY TypeID;
END $$
DELIMITER ;

-- question4: Tạo store để trả ra id của type question có nhiều câu hỏi nhất
DROP PROCEDURE IF EXISTS sp_GetTypeIDFromTypeQuestion

DELIMITER $$
CREATE PROCEDURE sp_GetTypeIDFromTypeQuestion(OUT v_ID TINYINT)
BEGIN
	WITH CTE_CountTypeID AS (SELECT count(q.TypeID) AS SL FROM Question q GROUP BY q.TypeID)
    SELECT count(TypeID) INTO v_ID FROM Question GROUP BY TypeID HAVING count(TypeID) = (SELECT max(SL) FROM CTE_CountTypeID);
END$$
DELIMITER ;

SET @ID = 0;
CALL sp_GetTypeIDFromTypeQuestion(@ID);

-- question5: Sử dụng store ở question 4 để tìm ra tên của type question
DROP PROCEDURE sp_FindTypeQuestionName

DELIMITER $$
CREATE PROCEDURE sp_FindTypeQuestionName()
BEGIN
	WITH CTE_CountTypeID AS(SELECT count(TypeID) 
    AS SL FROM Question GROUP BY TypeID ORDER BY count(TypeID) DESC LIMIT 1)
    SELECT * FROM Question q INNER JOIN TypeQuestion tq ON q.TypeID = tq.TypeID
    GROUP BY q.TypeID HAVING count(q.TypeID) = (SELECT * FROM CTE_CountTypeID);
END $$
DELIMITER ;

CALL sp_FindTypeQuestionName;

-- question6: Viết 1 store cho phép người dùng nhập vào 1 chuỗi và trả về group có tên
-- chứa chuỗi của người dùng nhập vào hoặc trả về user có username chứa chuỗi
-- của người dùng nhập vào

DROP PROCEDURE IF EXISTS sp_OutPutNameOrUserName

DELIMITER $$
CREATE PROCEDURE sp_OutPutNameOrUserName(IN in_stringInput NVARCHAR(50), IN in_select TINYINT)
BEGIN
	IF in_select = 1 THEN
    SELECT * FROM `Group` WHERE GroupName LIKE in_stringInput;
    ELSE
    SELECT * FROM `Account` WHERE UserName LIKE in_stringInput;
    END IF;
END $$
DELIMITER ;

-- question7: Viết 1 store cho phép người dùng nhập vào thông tin FullName, email
-- và store sẽ tự động gán:
						-- UserName sẽ giống Email nhưng bỏ phần @..mail đi
                        -- PositionID sẽ có Default là developer
                        -- DepartmentID sẽ được cho vào 1 phòng chờ 
			-- Sau đó in ra kết quả tạo thành công
            
DROP PROCEDURE IF EXISTS
DELIMITER $$
CREATE PROCEDURE sp ()
BEGIN

END $$
DELIMITER ;


-- question8: Viết 1 store cho phép người dùng nhập vào Essay hoặc Multiple-Choice
-- để thống kê câu hỏi essay hoặc multiple-choice nào có content dài nhất





-- question9: Viết 1 store cho phép người dùng xóa Exam dựa vào ID
DROP PROCEDURE IF EXISTS sp_DeleteExamByExamID;

DELIMITER $$
CREATE PROCEDURE sp_DeleteExamByExamID(IN in_ExamID TINYINT UNSIGNED)
BEGIN
	DELETE FROM Exam WHERE ExamID = in_ExamID;
END$$
DELIMITER ;

CALL sp_DeleteExamByExamID('4');


-- question10: Tìm ra các Exam được tạo từ 3 năm trước và xóa các Exam đó đi(sử dụng
-- store của câu 9 để xóa)
-- Sau đó in số lượng record đã remove từ các table liên quan trong khi removing
DROP PROCEDURE IF EXISTS sp_DeleteOldExam

DELIMITER $$
CREATE PROCEDURE sp_DeleteOldExam()
BEGIN
	WITH CTE_FindExamID AS(SELECT ExamID FROM Exam WHERE (year(now()) - year(CreateDate)) > 3)
    DELETE FROM Exam WHERE ExamID = (SELECT * FROM CTE_FindExamID);
END $$
DELIMITER ;



-- question11: Viết store cho phép người dùng xóa phòng ban bằng cách người dùng nhập
-- vào tên phòng ban và các account thuộc phòng ban đó sẽ được chuyển về phòng ban
-- default là phòng ban chờ việc




-- question12: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong năm nay





-- question13: Viết store để tin ra mỗi tháng có bao nhiêu câu hỏi được tạo ra trong 6 tháng gần
-- đây nhất
-- (Nếu tháng nào không có thì sẽ in ra là "không có câu hỏi nào trong tháng")