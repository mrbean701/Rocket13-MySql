DROP DATABASE IF EXISTS TestingSystem;
CREATE DATABASE TestingSystem;
USE TestingSystem;

CREATE TABLE Department (
    DepartmentID					TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    DepartmentName					NVARCHAR(50) NOT NULL UNIQUE KEY
);

CREATE TABLE `Position`(
	PositionID						TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT ,
    PositionName					ENUM('Dev','Test','Scrum','Master','PM') NOT NULL UNIQUE KEY
);


CREATE TABLE `Account`(
	AccountID						INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    Email							VARCHAR(50) NOT NULL UNIQUE KEY,
    UserName						VARCHAR(100) UNIQUE KEY NOT NULL,
    FullName						NVARCHAR(100) NOT NULL,
    DepartmentID					TINYINT UNSIGNED NOT NULL,
    PositionID						TINYINT UNSIGNED NOT NULL,
    CreateDate						DATE,
    
    FOREIGN KEY(DepartmentID) REFERENCES Department(DepartmentID),
    FOREIGN KEY(PositionID)	REFERENCES `Position`(PositionID)
);

CREATE TABLE `Group`(
	GroupID							TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    GroupName						NVARCHAR(50) NOT NULL,
    CreatorID						INT UNSIGNED NOT NULL,
    CreateDate						Date,
    
    FOREIGN KEY(CreatorID) REFERENCES `Account`(AccountID)
);

CREATE TABLE `GroupAccount`(
	GroupID							TINYINT UNSIGNED	NOT NULL,
    AccountID						INT UNSIGNED NOT NULL,
    JoinDate						DATE,
    
    PRIMARY KEY(GroupID, AccountID),
	FOREIGN KEY(GroupID) REFERENCES `Group`(GroupID),
    FOREIGN KEY(AccountID) REFERENCES `Account`(AccountID)
);

CREATE TABLE `TypeQuestion`(
	TypeID							TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    TypeName						ENUM('Essay','Multiple-Choice') NOT NULL
);

CREATE TABLE `CategoryQuestion`(
	CategoryID						TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    CategoryName					NVARCHAR(50) NOT NULL
    
);

CREATE TABLE `Question`(
	QuestionID						TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    Content							NVARCHAR(300),
    CategoryID						TINYINT UNSIGNED NOT NULL,
    TypeID							TINYINT UNSIGNED NOT NULL,
    CreatorID						INT UNSIGNED NOT NULL,
    CreateDate						DATE,
    
    FOREIGN KEY(CategoryID) REFERENCES CategoryQuestion(CategoryID),
    FOREIGN KEY(TypeID) REFERENCES TypeQuestion(TypeID)
);

CREATE TABLE `Answer`(
	AnswerID						TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    Content							NVARCHAR(500) ,
    QuestionID						TINYINT UNSIGNED NOT NULL UNIQUE KEY,
    isCorrect						ENUM('TRUE','FALSE'),
    
    FOREIGN KEY(QuestionID) REFERENCES `Question`(QuestionID)
);

CREATE TABLE `Exam`(
	ExamID							TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `Code`							VARCHAR(50) NOT NULL  UNIQUE KEY,
    Title							NVARCHAR(50) NOT NULL,
    CategoryID						TINYINT UNSIGNED NOT NULL,
    Duration						INT UNSIGNED,
    CreatorID						INT UNSIGNED NOT NULL,
    CreateDate						DATE,
    
    FOREIGN KEY(CategoryID) REFERENCES `CategoryQuestion`(CategoryID),
    FOREIGN KEY(CreatorID) REFERENCES `Account`(AccountID)
);

CREATE TABLE ExamQuestion(
	ExamID							TINYINT UNSIGNED NOT NULL,
    QuestionID						TINYINT UNSIGNED NOT NULL,
    
    PRIMARY KEY(ExamID, QuestionID),
    FOREIGN KEY(ExamID) REFERENCES Exam(ExamID),
    FOREIGN KEY(QuestionID) REFERENCES Question(QuestionID)
);

INSERT INTO `Department`(DepartmentName) VALUES ('Sale'),
												('Marketing'),
                                                ('Dev'),
                                                ('Tester');
                                                
INSERT INTO `Position`(PositionName) VALUES('Dev'),
									   ('Test'),
                                       ('Scrum'),
                                       ('Master'),
                                       ('PM');
                                       
INSERT INTO `Account`(Email, UserName, FullName, DepartmentID, PositionID, CreateDate) VALUES ('7749@gmail.com','chimcuccu','Nguyễn Thanh Huyền','2','1','2020-10-20'),
																							  ('3721@gmail.com','ngay1','Dương Mạnh Hùng','1','3','2019-12-12'),
                                                                                              ('abcxyz@gmail.com','thanglo','Dương Trọng Thắng','1','4','2019-06-01'),
                                                                                              ('duataokhauak@gmail.com','akbatdiet','Trần Việt Hoàng','3','2','2020-11-10'),
                                                                                              ('rumphu@gmail.com','bossssss','Khuất Duy Quyền','3','4','2021-08-08'),
                                                                                              ('umphu@gmail.com','bo','Khuất Duy Quyền','3','4','2021-08-08'),
                                                                                              ('trumphu@gmail.com','boss','Khuất Duy Quyền','4','4','2019-08-08'),
                                                                                              ('cuoi@gmail.com','trumcuoi','Đào Duy Trung','2','2','2020-12-30');
																							
INSERT INTO `Group`(GroupName, CreatorID, CreateDate) VALUES('Nhom1','1','2021-01-01'),
															('Nhom2','1','2021-02-01'),
                                                            ('Nhom3','3','2021-01-30'),
                                                            ('Nhom4','1','2021-02-01'),
                                                            ('Nhom5','4','2021-03-01');
                                                            
INSERT INTO GroupAccount(GroupID,AccountID,JoinDate) VALUES('1','3','2021-01-01'),
														   ('2','1','2021-04-05'),
                                                           ('3','2','2021-06-04'),
                                                           ('4','5','2021-03-04'),
                                                           ('5','4','2021-04-05');
                                                           
INSERT INTO TypeQuestion(TypeName) VALUES('Essay'),
										 ('Multiple-Choice');
                                         
INSERT INTO CategoryQuestion(CategoryName) VALUES('Java'),
												 ('.NET'),
                                                 ('SQL'),
                                                 ('Postman'),
                                                 ('Ruby'),
                                                 ('Python');
                                                 
INSERT INTO Question(CategoryID, TypeID, CreatorID, CreateDate) VALUES('1','1','2','2021-02-03'),
																	  ('2','2','1','2021-04-01'),
																	  ('3','2','1','2021-03-01'),
																	  ('4','1','2','2021-04-20'),
																	  ('5','2','1','2021-02-02'),
																	  ('6','2','2','2021-03-01'),
																	  ('3','1','1','2021-01-02');
                                                                                    
INSERT INTO Answer(QuestionID, isCorrect) VALUES('1','FALSE'),
												('2','FALSE'),
                                                ('3','TRUE'),
                                                ('4','FALSE'),
                                                ('5','TRUE'),
                                                ('6','TRUE');
                                                
INSERT INTO Exam(`Code`, Title, CategoryID, Duration, CreatorID, CreateDate) VALUES('C1','Bai1','1','15','1','2021-01-01'),
																				   ('C2','Bai2','2','60','2','2021-01-02'),
                                                                                   ('C3','Bai3','1','45','3','2021-04-01'),
                                                                                   ('C4','Bai4','2','90','4','2021-02-01'),
                                                                                   ('C5','Bai5','1','120','5','2021-01-04'),
                                                                                   ('C6','Bai6','1','60','1','2021-04-12');
                                                                                   
INSERT INTO ExamQuestion(ExamID, QuestionID) VALUES('1','6'),
												   ('2','5'),
                                                   ('3','4'),
                                                   ('4','3'),
                                                   ('5','2'),
                                                   ('6','1');