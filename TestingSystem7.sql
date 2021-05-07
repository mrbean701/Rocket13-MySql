USE TestingSystem;

DROP TRIGGER IF EXISTS Trg_DeleteAccount;

DELIMITER $$
CREATE TRIGGER Trg_DeleteAccount
BEFORE DELETE ON `Account`
FOR EACH ROW
BEGIN
	DECLARE v_Email VARCHAR(50);
    SELECT a.Email INTO v_Email FROM `Account` a WHERE a.AccountID = OLD.AccountID;
    IF v_Email = 'duataokhauak@gmail.com' THEN
    SIGNAL SQLSTATE '12345'
    SET MESSAGE_TEXT = 'Cant del this Acc';
    END IF;
END $$
DELIMITER ;

SELECT * FROM `Account`;
DELETE FROM `Account` WHERE (AccountID = '4');

CREATE Table `TestingSystem`.`Log_Dep_Name_Acc` (
	ID					INT AUTO_INCREMENT,
    UserName			VARCHAR(45) NOT NULL,
    OldDepName			VARCHAR(50) NOT NULL,
    ChangeDate			DATETIME NOT NULL,
    PRIMARY KEY (ID)
);


DROP TRIGGER IF EXISTS Trg_AfUpdateAcc;
DELIMITER $$
CREATE TRIGGER Trg_AfUpdateAcc
AFTER UPDATE ON `Account`
FOR EACH ROW
BEGIN
	DECLARE DepName VARCHAR(50);
    SELECT d.DepartmentName INTO DepName FROM Department d WHERE d.DepartmentID = OLD.DepartmentID;
END $$
DELIMITER ;

-- question1: Tạo trigger không cho phép người dùng nhập vào Group có ngày tạo trước 1 năm trước

DROP TRIGGER IF EXISTS Trg_InsertGroup;

DELIMITER $$
CREATE TRIGGER Trg_InsertGroup
BEFORE INSERT ON `Group`
FOR EACH ROW
BEGIN
	DECLARE v_CreateDate DATE;
    SELECT g.CreateDate INTO v_CreateDate FROM `Group` g WHERE g.GroupID = NEW.GroupID;
    IF (month(now()) - month(v_CreatDate) > 12 ) THEN
    SIGNAL SQLSTATE '54321'
    SET MESSAGE_TEXT = 'Cant insert this values';
    END IF;
END $$
DELIMITER ;
-- (v_CreateDate > (month(v_CreateDate) = month(now())))

-- question2: Tạo trigger không cho phép người dùng thêm bất kỳ user nào vào department "Sale" nữa,
-- khi thêm thì hiện ra thông báo "Department Sale connot add more user" 

DROP TRIGGER IF EXISTS Trg_InsertIntoSale;

DELIMITER $$
CREATE TRIGGER Trg_InsertIntoSale
