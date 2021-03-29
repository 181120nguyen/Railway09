DROP DATABASE IF EXISTS testingsystem;
CREATE DATABASE testingsystem;
USE testingsystem;
DROP DATABASE IF EXISTS Department;
CREATE TABLE Department (
   DepartmentID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
   DepartmentName NVARCHAR(30) NOT NULL UNIQUE KEY
   );

DROP DATABASE IF EXISTS `Position`;
CREATE TABLE `Position` (
   PositionID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
   PositionName ENUM ('Dev', 'Test','Scrum Master','PM') NOT NULL 
  );

DROP TABLE IF EXISTS `Account`;
CREATE TABLE `Account` (
   AccountID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
   Email VARCHAR(50) NOT NULL UNIQUE KEY,
   UserName NVARCHAR(50) NOT NULL UNIQUE KEY,
   FullName NVARCHAR(50) NOT NULL,
   DepartmentID TINYINT UNSIGNED NOT NULL,
   PositionID TINYINT UNSIGNED NOT NULL,
   CreateDate DATETIME DEFAULT NOW(),
   FOREIGN KEY(DepartmentID) REFERENCES Department(DepartmentID),
   FOREIGN KEY(PositionID) REFERENCES `Position`(PositionID)
);

DROP TABLE IF EXISTS `Group`;
CREATE TABLE `Group`(
   GroupID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
   GroupName VARCHAR(50) NOT NULL UNIQUE KEY,
   CreatorID TINYINT UNSIGNED,
   CreateDate DATETIME DEFAULT NOW(),
   FOREIGN KEY(CreatorID) REFERENCES `Account`(AccountID)
);

DROP TABLE IF EXISTS GroupAccount;
CREATE TABLE GroupAccount (
   GroupID TINYINT UNSIGNED NOT NULL,
   AccountID TINYINT UNSIGNED NOT NULL,
   JoinDate DATETIME DEFAULT NOW(),
   PRIMARY KEY (GroupID,AccountID),
   FOREIGN KEY(GroupID) REFERENCES `Group`(GroupID),
   FOREIGN KEY(AccountID) REFERENCES `Account`(AccountID)
);
   
DROP TABLE IF EXISTS TypeQuestion;
CREATE TABLE TypeQuestion (
   TypeID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
   TypeName ENUM('Essay','Multilpe-choice') NOT NULL UNIQUE KEY
);   
 
DROP TABLE IF EXISTS CategoryQuestion;
CREATE TABLE CategoryQuestion(
    CategoryID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    CategoryName NVARCHAR(50) NOT NULL UNIQUE KEY
);

DROP TABLE IF EXISTS Question;
CREATE TABLE Question(
    QuestionID	TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Content	NVARCHAR(100) NOT NULL,
    CategoryID	TINYINT UNSIGNED NOT NULL,
    TypeID	TINYINT UNSIGNED NOT NULL,
    CreatorID	TINYINT UNSIGNED NOT NULL UNIQUE KEY,
    CreateDate	DATETIME DEFAULT NOW(),
    FOREIGN KEY(CategoryID) REFERENCES CategoryQuestion(CategoryID),
    FOREIGN KEY(TypeID) REFERENCES TypeQuestion(TypeID),
    FOREIGN KEY(CreatorID) REFERENCES `Account`(AccountId)
);

DROP TABLE IF EXISTS Answer;
CREATE TABLE Answer(
    Answers	TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Content	NVARCHAR(100) NOT NULL,
    QuestionID	TINYINT UNSIGNED NOT NULL,
    isCorrect	BIT DEFAULT 1,
    FOREIGN KEY(QuestionID) REFERENCES Question(QuestionID)
);

DROP TABLE IF EXISTS Exam;
CREATE TABLE Exam(
    ExamID	TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `Code`	CHAR(10) NOT NULL,
    Title	NVARCHAR(50) NOT NULL,
    CategoryID	TINYINT UNSIGNED NOT NULL,
    Duration TINYINT UNSIGNED NOT NULL,
    CreatorID	TINYINT UNSIGNED NOT NULL,
    CreateDate	DATETIME DEFAULT NOW(),
    FOREIGN KEY(CategoryID) REFERENCES CategoryQuestion(CategoryID),
    FOREIGN KEY(CreatorID) 	REFERENCES `Account`(AccountId)
);

DROP TABLE IF EXISTS ExamQuestion;
CREATE TABLE ExamQuestion (
   ExamID TINYINT UNSIGNED NOT NULL,
   QuestionID TINYINT UNSIGNED NOT NULL,
   PRIMARY KEY (ExamID, QuestionID),
   FOREIGN KEY(QuestionID) REFERENCES Question(QuestionID),
   FOREIGN KEY(ExamID) REFERENCES Exam(ExamID)
   );
   
SELECT * FROM testingsystem.department;
INSERT INTO Department (DepartmentName)
VALUES ('Marketting'),
       ('Sale'),
       ('Bao ve1'),
       ('Nhan su'),
       ('Ky thuat1');
   
SELECT * FROM testingsystem.position;
INSERT INTO `Position`(PositionName)
VALUES ('Dev'),
	   ('Test'),
       ('Scrum Master'),
       ('PM');
   
SELECT * FROM testingsystem.account;
INSERT INTO `Account`(Email								, Username			, FullName				, DepartmentID	, PositionID, CreateDate)
VALUES 				('Email1@gmail.com'				, 'Username1'		,'Fullname1'				,   '2'			,   '1'		,'2020-03-05'),
					('Email2@gmail.com'				, 'Username2'		,'Fullname2'				,   '3'			,   '2'		,'2020-03-05'),
                    ('Email3@gmail.com'				, 'Username3'		,'Fullname3'				,   '5'			,   '4'		,'2020-03-05'),
                    ('Email4@gmail.com'				, 'Username4'		,'Fullname4'				,   '4'			,   '3'		,'2020-03-05'),
					('Email5@gmail.com'				, 'Username5'		,'Fullname5'				,   '1'			,   '1'		,'2020-03-05');   
                    
SELECT * FROM testingsystem.group;
INSERT INTO `group`(GroupName   ,CreatorID    ,CreateDate )
VALUES 			('Testingsystem', 5           ,'2019-04-05')
				('Development'	, 1			  ,'2020-11-07'),
				('Salegr1'	    , 2			  ,'2019-02-09'),
				('PMgr'			, 3			  ,'2020-12-16'),
				('KythuatGr'	, 4			  ,'2018-09-28');         

SELECT * FROM testingsystem.groupaccount;
INSERT INTO GroupAccount(GroupID   ,AccountID, JoinDate )
VALUES                  (1		, 1		,'2019-12-12'),
						(2		, 2		,'2020-06-23'),
						(4		, 3		,'2020-08-21'),
						(5		, 4		,'2020-11-10'),
						(3		, 5		,'2020-01-28');        
                        
SELECT * FROM testingsystem.typequestion;
INSERT INTO TypeQuestion(TypeName)
VALUES ('Essay'),
       ('Multiple-choice');
       
SELECT * FROM testingsystem.categoryquestion;
INSERT INTO CategoryQuestion(CategoryName) 
VALUES                      ('Name1' ),
	                        ('Name2' ),
	                        ('Name3' ),
							('Name4' ),
							('Name5' );
                            
SELECT * FROM testingsystem.question;
INSERT INTO Question(Content   , CategoryID, TypeID   , CreatorID, CreateDate) 
VALUES              ('Cauhoi1' , 2         ,  2       , 1        , '2020-01-21'),
                    ('Cauhoi2' , 5         ,  1       , 2        , '2020-01-21'),
                    ('Cauhoi3' , 1         ,  3       , 3        , '2020-01-21'),
                    ('Cauhoi4' , 3         ,  4       , 4        , '2020-01-21'),
                    ('Cauhoi5' , 4         ,  5       , 5        , '2020-01-21');
                    
SELECT * FROM testingsystem.answer;
INSERT INTO Answer(Content  , QuestionID , isCorrect)
VALUES            ('Traloi1', 1          ,  0),
				  ('Traloi2', 2          ,  1),
                  ('Traloi3', 1          ,  1),
                  ('Traloi4', 2          ,  0),
                  ('Traloi5', 1          ,  1);
                  
SELECT * FROM testingsystem.exam;
INSERT INTO Exam(`Code` , Title  , CategoryID, Duration, CreatorID, CreateDate)
VALUES          ('code1', 'De1'  , 1         , 60      , 2        , '2020-11-18'),
                ('code2', 'De2'  , 2         , 60      , 3        , '2020-11-18'),
                ('code3', 'De3'  , 3         , 60      , 4        , '2020-11-18'),
                ('code4', 'De4'  , 4         , 60      , 1        , '2020-11-18'),
                ('code5', 'De5'  , 5         , 60      , 5        , '2020-11-18');
                
SELECT * FROM testingsystem.examquestion;
INSERT INTO ExamQuestion(ExamID  , QuestionID )
VALUES                  (1       , 1          ),
                        (2       , 2          ),
                        (3       , 3          ),
                        (1       , 1          ),
                        (4       , 4          );
          
