DROP DATABASE IF EXISTS TestingSystem;
CREATE DATABASE TestingSystem;
USE TestingSystem;

DROP DATABASE IF EXISTS Department;
CREATE TABLE Department (
   DepartmentID INT,
   DepartmentName VARCHAR(50)
   );

DROP DATABASE IF EXISTS Position;
CREATE TABLE Position (
   PositionID INT,
   PositionName VARCHAR(50)
   );
   
DROP DATABASE IF EXISTS `Account`;
CREATE TABLE `Account` (
   AccountID INT,
   Email VARCHAR(50),
   Username VARCHAR(50),
   FullName VARCHAR(50),
   DepartmentID INT,
   PositionID INT,
   CreateDate DATE
   );
   
DROP DATABASE IF EXISTS `Group`;
CREATE TABLE `Group` (
   GroupID INT,
   GroupName VARCHAR(50),
   CreatorID INT,
   CreatDate DATE
   );
   
DROP DATABASE IF EXISTS GroupAccount;
CREATE TABLE GroupAccount (
   GroupID INT,
   AccountID INT,
   JoinDate DATE
   );
   
DROP DATABASE IF EXISTS TypeQuestion;
CREATE TABLE TypeQuestion (
   TypeID INT,
   TypeName VARCHAR(50)
   );
   
DROP DATABASE IF EXISTS CategoryQuestion;
CREATE TABLE CategoryQuestion (
   CategoryID INT,
   CategoryName VARCHAR(50)
   );
   
DROP DATABASE IF EXISTS Question;
CREATE TABLE Question (
   QuestionID INT,
   Content VARCHAR(50),
   CategoryID INT,
   TypeID INT,
   CreatorID INT,
   CreateDate DATE
   );

DROP DATABASE IF EXISTS Answer;
CREATE TABLE Answer (
   AnswerID INT,
   Content VARCHAR(50),
   QuestionID INT,
   isCorrect VARCHAR(50)
   );
   
DROP DATABASE IF EXISTS Exam;
CREATE TABLE Exam (
   ExamID INT,
   Code INT,
   Title VARCHAR(50),
   CategoryID INT,
   Duration INT,
   CreatorID INT,
   CreateDate DATE
   );

DROP DATABASE IF EXISTS ExamQuestion;
CREATE TABLE ExamQuestion (
   ExamID INT,
   QuestionID INT
   );   