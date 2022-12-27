-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema school
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema schooldb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `schooldb` ;

-- -----------------------------------------------------
-- Schema schooldb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `schooldb` ;
USE `schooldb` ;

-- -----------------------------------------------------
-- Table `schooldb`.`school`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `schooldb`.`school` ;

CREATE TABLE IF NOT EXISTS `schooldb`.`school` (
  `SchoolName` VARCHAR(10) NOT NULL,
  `SchoolAddress` VARCHAR(90) NULL,
  `SchoolPhone` VARCHAR(30) NULL,
  `SchoolEmail` VARCHAR(25) NULL,
  PRIMARY KEY (`SchoolName`))
ENGINE = InnoDB;

-- ------------------------------------------------------------
-- SQL statement to populate data into school table
-- ------------------------------------------------------------
INSERT INTO school (SchoolName, SchoolAddress, SchoolPhone, SchoolEmail)
VALUES ('TafeSa_Ade', '120 Currie Street ADELAIDE SA 5000, AUSTRALIA', '+61 8 8207 8200', 'study@tafesa.edu.au');

-- ---------------------------------------------------
-- SQL statement to sellect all from school table
-- ---------------------------------------------------
SELECT * FROM school;


-- -----------------------------------------------------
-- Table `schooldb`.`teacher`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `schooldb`.`teacher` ;

CREATE TABLE IF NOT EXISTS `schooldb`.`teacher` (
  `TeacherID` INT NOT NULL,
  `TeacherFirstName` VARCHAR(20) NULL,
  `TeacherMiddleName` VARCHAR(5) NULL,
  `TeacherLastName` VARCHAR(20) NULL,
  `TeacherEmail` VARCHAR(30) NULL,
  `TeacherPhoneNumber` VARCHAR(15) NULL,
  `school_SchoolName` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`TeacherID`),
  INDEX `fk_teacher_school_idx` (`school_SchoolName` ASC) VISIBLE,
  CONSTRAINT `fk_teacher_school`
    FOREIGN KEY (`school_SchoolName`)
    REFERENCES `schooldb`.`school` (`SchoolName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- ------------------------------------------------------------
-- SQL statement to populate data into teacher table
-- ------------------------------------------------------------
INSERT INTO teacher (TeacherID, TeacherFirstName, TeacherMiddleName, TeacherLastName,TeacherEmail,TeacherPhoneNumber,school_SchoolName)
VALUES (44556677, 'John', 'D', 'Smitt', 'j.smitt@tafesa.edu.au', '0458223345' ,'TafeSa_Ade'),
(44556678, 'Adams', 'E', 'Willson', 'a.willson@tafesa.edu.au', '0458223583' ,'TafeSa_Ade'),
(44556700, 'Paul', 'D', 'Robert', 'p.robert@tafesa.edu.au', '0458223360' ,'TafeSa_Ade'),
(44556701, 'Corey', 'A', 'Holgan', 'c.holgan@tafesa.edu.au', '0468225689' ,'TafeSa_Ade'),
(445566704, 'David', 'E', 'Graham', 'd.graham@tafesa.edu.au', '0458215445' ,'TafeSa_Ade');

-- ------------------------------------------------------
-- SQL statement to return all data from teacher table
-- ------------------------------------------------------
SELECT * FROM teacher;


-- -----------------------------------------------------
-- Table `schooldb`.`student`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `schooldb`.`student` ;

CREATE TABLE IF NOT EXISTS `schooldb`.`student` (
  `StudentID` INT NOT NULL,
  `StudentFirstName` VARCHAR(20) NULL,
  `StudentMiddleName` VARCHAR(5) NULL,
  `StudentLastName` VARCHAR(20) NULL,
  `StudentPhoneNumber` VARCHAR(15) NULL,
  `StudentAddress` VARCHAR(90) NULL,
  `StudentEmail` VARCHAR(50) NULL,
  `StudentNationality` VARCHAR(60) NULL,
  `DateOfBirth` DATE NULL,
  `Gender` VARCHAR(6) NULL,
  `school_SchoolName` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`StudentID`),
  INDEX `fk_student_school1_idx` (`school_SchoolName` ASC) VISIBLE,
  CONSTRAINT `fk_student_school1`
    FOREIGN KEY (`school_SchoolName`)
    REFERENCES `schooldb`.`school` (`SchoolName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
-- ------------------------------------------------------------
-- SQL statement to populate data into student table
-- ------------------------------------------------------------
INSERT INTO student (StudentID, StudentFirstName, StudentMiddleName, StudentLastName, StudentPhoneNumber,
StudentAddress, StudentEmail, StudentNationality, DateOfBirth, Gender, school_SchoolName)
VALUES (11398156, 'Denny', 'J', 'okwu', '0458239846', '7 Drive,Blakeview SA 5114', 'os@student.tafesa.edu.au', 'Australian' ,'1983-04-03','Male','TafeSa_Ade'),
(11002233, 'Matthew', 'A', 'Ude', '0458238834', '7 Wolsten Drive,Blakeview SA 5114', 'matthew.ude@student.tafesa.edu.au', 'Australian' ,'1990-12-15','Male','TafeSa_Ade'),
(11002234, 'Jess', 'A', 'Johnson', '0423994562', '6 Britton Street,Richmond SA 5009','jess.jonson@student.tafesa.edu.au', 'Indian' ,'1980-02-10','Female','TafeSa_Ade'),
(11002235, 'Daniel', 'I', 'Harrison', '0468020001','28 Hotchkiss Crescent,Cyodon SA 5008', 'daniel.harrison@student.tafesa.edu.au', 'American' ,'1995-12-25','Male','TafeSa_Ade'),
(11002236, 'Jode', 'W', 'Halide', '0458629945', '39 Peterson Road, Adelaide 5000', 'jode.halide@student.tafesa.edu.au', 'Scotish' ,'1976-03-28','Female','TafeSa_Ade');

-- ------------------------------------------------------
-- SQL statement to return all data from student table
-- ------------------------------------------------------
SELECT * FROM student;


-- -----------------------------------------------------
-- Table `schooldb`.`subject`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `schooldb`.`subject` ;

CREATE TABLE IF NOT EXISTS `schooldb`.`subject` (
  `SubjectName` VARCHAR(10) NOT NULL,
  `SubjectDecription` VARCHAR(200) NULL,
  `SubjectCost` DECIMAL(8,4) NULL,
  `SubjectDuration` DECIMAL(6,2) NULL,
  `NumberOfAssessement` VARCHAR(45) NULL,
  `teacher_TeacherID` INT NOT NULL,
  PRIMARY KEY (`SubjectName`),
  INDEX `fk_subject_teacher1_idx` (`teacher_TeacherID` ASC) VISIBLE,
  CONSTRAINT `fk_subject_teacher1`
    FOREIGN KEY (`teacher_TeacherID`)
    REFERENCES `schooldb`.`teacher` (`TeacherID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
-- ------------------------------------------------------------
-- SQL statement to populate data into subject table
-- ------------------------------------------------------------
INSERT INTO subject (SubjectName, SubjectDecription, SubjectCost, SubjectDuration, NumberOfAssessement,teacher_TeacherID)
VALUES ('WEB451SQL', 'This unit describes the skills and knowledge required to produce SQL statements to work with server-side scripts, enabling web developers to interact with web server databases', 350.0, 100, 4, 44556677),
('WEB4C3HL5' , 'This unit describes the skills and knowledge required to design and create basic markup language documents and cascading style sheets (CSS) in order to define the structure and style of a website', 275.5, 150, 5, 44556701),
('IT_PracTL', 'IT Studies Online Connect (IT Prac)', 10.89, 50, 10, 44556677),
('ICTPRG302', 'This unit describes the skills and knowledge required to create simple applications in Python through introductory programming techniques', 200.50, 120, 3, 445566704),
('ICTPRG437', 'This unit describes the skills and knowledge required to design, build and test a user interface (UI) to specification using Visual Studio with the Universal Windows Platform (UWP) and XAML', 300.75, 130, 4, 445566704);

-- ------------------------------------------------------
-- SQL statement to return all data from subject table
-- ------------------------------------------------------
SELECT * FROM subject;


-- -----------------------------------------------------
-- Table `schooldb`.`studentsubjectenrollement`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `schooldb`.`studentsubjectenrollement` ;

CREATE TABLE IF NOT EXISTS `schooldb`.`studentsubjectenrollement` (
  `EnrollementDate` DATE NULL,
  `Grade` VARCHAR(4) NULL,
  `Result` INT NULL,
  `GradeDate` DATE NULL,
  `subject_SubjectName` VARCHAR(10) NOT NULL,
  `student_StudentID` INT NOT NULL,
  PRIMARY KEY (`subject_SubjectName`, `student_StudentID`),
  INDEX `fk_studentsubjectenrollement_student1_idx` (`student_StudentID` ASC) VISIBLE,
  CONSTRAINT `fk_studentsubjectenrollement_subject1`
    FOREIGN KEY (`subject_SubjectName`)
    REFERENCES `schooldb`.`subject` (`SubjectName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_studentsubjectenrollement_student1`
    FOREIGN KEY (`student_StudentID`)
    REFERENCES `schooldb`.`student` (`StudentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- ------------------------------------------------------------
-- SQL statement to populate data into studentsbjectenrollement table
-- ------------------------------------------------------------
INSERT INTO studentsubjectenrollement (EnrollementDate, Grade, Result, GradeDate, subject_SubjectName,student_StudentID)
VALUES ('2022-08-03', 'Dist', 92, '2022-09-09', 'WEB4C3HL5', 11398140),
('2022-08-02', 'Dist', 95, '2022-09-08', 'WEB451SQL', 11398140),
('2022-08-03', 'Dist', 90, '2022-09-10', 'ICTPRG302', 11398140),
('2022-08-05', 'Dist', 98, '2022-09-09', 'ICTPRG437', 11398140),
('2022-08-04', 'Dist', 95, '2022-09-03', 'ICTPRG302', 11002233),
('2022-08-02', 'Cred', 78, '2022-09-07', 'IT_PracTL', 11398140),
('2022-08-02', 'Cred', 78, '2022-09-07', 'IT_PracTL', 11002233),
('2022-08-10', 'Pass', 64, '2022-09-07', 'WEB4C3HL5', 11002233),
('2022-08-02', 'Dist', 81, '2022-09-08', 'WEB451SQL', 11002233),
('2022-08-04', 'Dist', 97, '2022-09-03', 'ICTPRG437', 11002233),
('2022-08-04', 'Dist', 95, '2022-09-03', 'ICTPRG437', 11002234),
('2022-08-02', 'Cred', 78, '2022-09-07', 'IT_PracTL', 11002234),
('2022-08-02', 'Dist', 91, '2022-09-07', 'WEB451SQL', 11002234),
('2022-08-10', 'Pass', 64, '2022-09-07', 'WEB4C3HL5', 11002234),
('2022-08-10', 'Pass', 64, '2022-09-07', 'WEB4C3HL5', 11002235),
('2022-08-02', 'Dist', 88, '2022-09-08', 'WEB451SQL', 11002235),
('2022-08-04', 'Dist', 94, '2022-09-03', 'ICTPRG437', 11002235),
('2022-08-02', 'Cred', 75, '2022-09-07', 'IT_PracTL', 11002235);
('2022-08-02', 'Cred', 90, '2022-09-07', 'WEB451SQL', 11002236),
('2022-08-02', 'Cred', 73, '2022-09-07', 'ICTPRG437', 11002236),
('2022-08-02', 'Cred', 80, '2022-09-07', 'IT_PracTL', 11002236),
('2022-08-02', 'Cred', 60, '2022-09-07', 'WEB4C3HL5', 11002236);
-- ------------------------------------------------------------
-- SQL statement to return all data from studentsubjecterollement table
-- ------------------------------------------------------------
SELECT * FROM studentsubjectenrollement;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- ----------------------------------
-- Query to outputs the students first and last name concatenated together as “Full Name” as well as their Phone number  
-- List all students in the Database  
-- -----------------------------------

SELECT CONCAT (StudentFirstName,' ',StudentLastName) AS 'Full Name', StudentPhoneNumber AS 'Phone number'
FROM student;

-- ----------------------------------------------
-- Aggregate Functions
-- -----------------------------------------------

-- Count of Students in the Database
SELECT COUNT(*) AS 'Total Number of Students' FROM student;

-- counts students enrolled in each subject and provides a single value to represent total subject enrolments for each subject
SELECT subject_SubjectName AS 'Subject Name',COUNT(student_StudentID) AS 'Number of Student Enrolled'
FROM studentsubjectenrollement
GROUP BY subject_SubjectName
ORDER BY COUNT(student_StudentID) DESC;

-- Provide a query that shows the Highest (Max) Result for all students in a Subject
SELECT subject_SubjectName AS 'Subject Name',MAX(Result) AS 'Highest Result'
FROM studentsubjectenrollement
GROUP BY subject_SubjectName
ORDER BY MAX(Result) DESC;

-- Provide a query that shows the Lowest (Min) Result for all students in a Subject
SELECT subject_SubjectName AS 'Subject Name',MIN(Result) AS 'Lowest Mark'
FROM studentsubjectenrollement
GROUP BY subject_SubjectName
ORDER BY MIN(Result);

-- ---------------------------------------------
-- JOINING TABLES
-- Query which shows all results of a specific student By Joining Student, Subject and Enrolement Tables. 
-- ----------------------------------------------
-- My Result record in the database
-- To change this query to display record of another student, a WHERE St.StudentFirstName = 'student name' is used.

SELECT * FROM student;
SELECT * FROM subject;
SELECT * FROM studentsubjectenrollement;
SELECT CONCAT (StudentFirstName,' ',StudentLastName) AS 'Full Name',
Su.SubjectName AS 'Subject',
Su.SubjectDecription AS 'Subject Decription',
E.Result,
E.Grade
FROM student AS St
INNER JOIN studentsubjectenrollement AS E 
ON St.StudentID = E.student_StudentID
INNER JOIN `schooldb`.subject AS Su
ON E.subject_SubjectName = Su.SubjectName
WHERE St.StudentFirstName = 'Dennis';


-- Result record of a student with StudentFirstName Matthew in the database
SELECT CONCAT (StudentFirstName,' ',StudentLastName) AS 'Full Name',
Su.SubjectName AS 'Subject',
Su.SubjectDecription AS 'Subject Decription',
E.Result,
E.Grade
FROM student AS St
INNER JOIN studentsubjectenrollement AS E 
ON St.StudentID = E.student_StudentID
INNER JOIN `schooldb`.subject AS Su
ON E.subject_SubjectName = Su.SubjectName
WHERE St.StudentFirstName = 'Matthew';

-- ------------------------------------------------------------------------------------
-- Grades in a Subject 
-- SQL query showing the results of all students in a IT_PracTL subject.
-- To display another results for another subject, I used "WHERE Su.SubjectName = '[subject name]'
-- --------------------------------------------------------------------------------------   
SELECT St.StudentID,CONCAT (StudentFirstName,' ',StudentLastName) AS 'Full Name',
Su.SubjectName AS 'Subject',
Su.SubjectDecription AS 'Subject Decription',
E.Result,
E.Grade
FROM student AS St
INNER JOIN studentsubjectenrollement AS E 
ON St.StudentID = E.student_StudentID
INNER JOIN subject AS Su
ON E.subject_SubjectName = Su.SubjectName
WHERE Su.SubjectName = 'IT_PracTL';

-- ---------------------------------------------------------------------------------
-- SQL query showing the results of all students in a 'WEB451SQL' subject.
-- ----------------------------------------------------------------------------------
SELECT St.StudentID,CONCAT (StudentFirstName,' ',StudentLastName) AS 'Full Name',
Su.SubjectName AS 'Subject',
Su.SubjectDecription AS 'Subject Decription',
E.Result,
E.Grade
FROM student AS St
INNER JOIN studentsubjectenrollement AS E 
ON St.StudentID = E.student_StudentID
INNER JOIN subject AS Su
ON E.subject_SubjectName = Su.SubjectName
WHERE Su.SubjectName = 'WEB451SQL';

-- ---------------------------------------------
-- Alter Tables and Update
-- ------------------------------------------------
-- Alter student table to add a new column called Language Spoken At Home

SELECT * FROM student;

ALTER TABLE student
DROP LanguageSpokenAtHome;

ALTER TABLE student
ADD LanguageSpokenAtHome varchar(60);

UPDATE student SET LanguageSpokenAtHome='Igbo' WHERE StudentID=11398140;
UPDATE student SET LanguageSpokenAtHome='French' WHERE StudentID=11002233;
UPDATE student SET LanguageSpokenAtHome='Spainsh' WHERE StudentID=11002234;
UPDATE student SET LanguageSpokenAtHome='English' WHERE StudentID=11002235;
UPDATE student SET LanguageSpokenAtHome='French' WHERE StudentID=11002236;

SELECT * FROM student;

-- --------------------------------------------------------------------
-- Change A Subject Coordinator
-- --------------------------------------------------------------------
-- Selecting all record from subject table. From the result, subject table has only Teacher's ID, 
-- To get the teacher's name for each subject, I did INNER JOIN between subject table and Teacher table on TeacherID since both table has TeacherID 
-- I also concatinated Teacher's firstname,middlename and lastname as Teacher FullName.
-- From the result below the subject ICTPRG302 has it's coordinator as David E Graham with ID 445566704.
-- ---------------------------------------------------------------------------------------------------------
SELECT * FROM subject;
SELECT  S.teacher_TeacherID AS 'Teacher_ID', S.SubjectName AS 'Subject Name', S.SubjectDecription AS 'Subject Description', 
CONCAT (TeacherFirstName,' ',TeacherMiddleName,' ',TeacherLastName) AS 'Teacher Full Name' 
FROM subject AS S
INNER JOIN teacher AS T ON S.teacher_TeacherID = T.TeacherID;

-- Change the Subject Teacher for Subject 'ICTPRG302' from David E Graham with ID 445566704 to Paul D Robert and ID 44556700
ALTER TABLE subject;
UPDATE subject SET teacher_TeacherID= 44556700 WHERE SubjectName= 'ICTPRG302';

-- From the result below, the subject teacher for ICTPRG302 has been changed from David E Graham with ID 445566704 to Paul D Robert and ID 44556700
SELECT * FROM subject;
SELECT  S.teacher_TeacherID AS 'Teacher_ID', S.SubjectName AS 'Subject Name', S.SubjectDecription AS 'Subject Description', 
CONCAT (TeacherFirstName,' ',TeacherMiddleName,' ',TeacherLastName) AS 'Teacher Full Name' 
FROM subject AS S
INNER JOIN teacher AS T ON S.teacher_TeacherID = T.TeacherID;

-- ---------------------------------------------------------
-- Delete a teacher
-- ---------------------------------------------------------
-- To Identify a teacher who is not coordinating any subjects, I will do a RIGHT OUTER JOIN between subject and teacher table.
-- From the result below, Adams E Willson with ID 44556678 is a teacher/coordinator to any subject.
-- So Adams E Willson will be delected in the teacher table.
-- ------------------------------------------------------------------------------------------------
SELECT * FROM subject AS S
RIGHT JOIN teacher AS T ON S.teacher_TeacherID = T.TeacherID;


-- ---------------------------------------------------------------------
-- Deleting Adams E Willson with ID 44556678 row from teacher table.
-- -------------------------------------------------------------------
DELETE FROM teacher
WHERE TeacherID = 44556678;

-- ------------------------------------------------------------------------------------------
-- To confirm that Adams E Willson with ID 44556678 row has been deleted from teacher table.
-- -------------------------------------------------------------------------------------------
SELECT * FROM teacher;
