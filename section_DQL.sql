select * from school
select * from subjects
select * from staff
select * from STAFF_SALARY
select * from SUBJECTS
select * from CLASSES
select * from STUDENTS
select * from PARENTS
select * from STUDENT_CLASSES
select * from STUDENT_PARENT


/*
Different SQL Operators: = , < , > , >= , <= , <> , != , BETWEEN, ORDER, BY, IN, NOT IN, LIKE, ALIASE, DISTINCT, LIMIT, CASE
Comparison Operators: = ,  <> , != , > , < , >= , <=
Arithmetic Operators: + , - , * , / , %
Logical Operators: AND, OR, NOT, IN, BETWEEN, LIKE etc.
*/
SELECT ID, FIRST_NAME FROM STUDENTS;
SELECT * FROM SUBJECTS WHERE subject_name = 'Mathematics';
SELECT * FROM SUBJECTS WHERE subject_name <> 'Mathematics';
SELECT * FROM STAFF_SALARY WHERE salary <= '10000';
SELECT * FROM STAFF_SALARY WHERE salary <> '10000';
SELECT * FROM STAFF_SALARY ORDER BY salary;
SELECT * FROM STAFF_SALARY ORDER BY salary DESC;
SELECT * FROM STAFF_SALARY WHERE salary BETWEEN 5000 AND 10000 ORDER BY salary;
SELECT * FROM SUBJECTS WHERE subject_name IN ('Mathematics', 'Science', 'Arts');
SELECT * FROM SUBJECTS WHERE subject_name NOT IN ('Mathematics', 'Science', 'Arts');
SELECT * FROM SUBJECTS WHERE subject_name LIKE 'S%';
SELECT * FROM SUBJECTS WHERE subject_name LIKE '%c';
SELECT * FROM SUBJECTS WHERE subject_name LIKE '%si%';
SELECT * FROM STAFF WHERE age > 50 AND gender = 'F'
SELECT * FROM STAFF WHERE age > 50 OR gender = 'F'
SELECT (2+5) AS TOTAL;
SELECT staff_type FROM STAFF;
SELECT DISTINCT staff_type FROM STAFF;
SELECT staff_type FROM STAFF LIMIT 5;


-- Case statement
SELECT STAFF_ID, SALARY,  
	CASE WHEN SALARY >= 10000 THEN 'High Salary'
		WHEN SALARY BETWEEN 5000 AND 10000 THEN 'Average Salary'
		WHEN SALARY < 5000 THEN 'Too Low'
	END 
AS RANGE
FROM STAFF_SALARY ORDER BY 2 DESC;


-- JOIN (two ways to write SQL queries):
SELECT TB1.COL1 AS C1 , TB1.COL2 AS C2, TB2.COL3 AS C3
	FROM TABLE1 AS TB1
	JOIN TABLE2 AS TB2 ON TB1.C1 = TB2.C1 AND TB1.C2 = TB2.C2

SELECT TB1.COL1 AS C1 , TB1.COL2 AS C2, TB2.COL3 AS C3
	FROM TABLE1 AS TB1, TABLE2 AS TB2
	WHERE TB1.C1 = TB2.C1
	AND TB1.C2 = TB2.C2



-- Fetch all the class name where Music is thought as a subject
SELECT CLASS_NAME FROM SUBJECTS SUB
	JOIN CLASSES CLS ON SUB.SUBJECT_ID = CLS.SUBJECT_ID AND SUBJECT_NAME = 'Music'

SELECT CLASS_NAME FROM CLASSES CLS
	JOIN SUBJECTS SUB ON SUB.SUBJECT_ID = CLS.SUBJECT_ID AND SUBJECT_NAME = 'Music'



-- Fetch the full name of all staff who teach Mathematics
SELECT DISTINCT(STF.FIRST_NAME || ' ' ||STF.LAST_NAME) AS FULL_NAME
	FROM SUBJECTS SUB
	JOIN CLASSES CLS ON SUB.SUBJECT_ID = CLS.SUBJECT_ID
	JOIN STAFF STF ON CLS.TEACHER_ID = STF.STAFF_ID
	WHERE SUB.SUBJECT_NAME = 'Mathematics'

SELECT DISTINCT(STF.FIRST_NAME || ' ' ||STF.LAST_NAME) AS FULL_NAME , STF.STAFF_ID , CLS.CLASS_NAME
	FROM SUBJECTS SUB
	JOIN CLASSES CLS ON SUB.SUBJECT_ID = CLS.SUBJECT_ID
	JOIN STAFF STF ON CLS.TEACHER_ID = STF.STAFF_ID
	WHERE SUB.SUBJECT_NAME = 'Mathematics'