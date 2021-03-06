select * from school
select * from subjects
select * from staff
select * from STAFF_SALARY
select * from SUBJECTS
select * from CLASSES
select * from STUDENTS
select * from PARENTS
SELECT * FROM ADDRESS;
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


-- Fetch all staff who teach grade 8,9,10 and also fetch all the non-teach staff
-- case 1
SELECT STF.STAFF_TYPE,
	(STF.FIRST_NAME || ' ' ||STF.LAST_NAME) AS FULL_NAME , 
	STF.AGE , 
	(CASE 
		WHEN STF.GENDER = 'M' THEN 'Male' 
		WHEN STF.GENDER = 'F' THEN 'Female'
	END) AS GENDER,
	STF.JOIN_DATE
	FROM STAFF STF
	JOIN CLASSES CLS ON CLS.TEACHER_ID = STF.STAFF_ID
	WHERE STF.STAFF_TYPE = 'Teaching' AND CLS.CLASS_NAME in ('Grade 8', 'Grade 9', 'Grade 10')
UNION
SELECT STF.STAFF_TYPE,
	(STF.FIRST_NAME || ' ' ||STF.LAST_NAME) AS FULL_NAME , 
	STF.AGE , 
	(CASE 
		WHEN STF.GENDER = 'M' THEN 'Male' 
		WHEN STF.GENDER = 'F' THEN 'Female'
	END) AS GENDER,
	STF.JOIN_DATE
	FROM STAFF STF
	WHERE STF.STAFF_TYPE = 'Non-Teaching'

-- case 2
SELECT STF.STAFF_TYPE,
	(STF.FIRST_NAME || ' ' ||STF.LAST_NAME) AS FULL_NAME , 
	STF.AGE , 
	(CASE 
		WHEN STF.GENDER = 'M' THEN 'Male' 
		WHEN STF.GENDER = 'F' THEN 'Female'
	END) AS GENDER,
	STF.JOIN_DATE
	FROM STAFF STF
	JOIN CLASSES CLS ON CLS.TEACHER_ID = STF.STAFF_ID
	WHERE STF.STAFF_TYPE = 'Teaching' AND CLS.CLASS_NAME in ('Grade 8', 'Grade 9', 'Grade 10')
UNION ALL -- Not remove duplicate
SELECT STF.STAFF_TYPE,
	(STF.FIRST_NAME || ' ' ||STF.LAST_NAME) AS FULL_NAME , 
	STF.AGE , 
	(CASE 
		WHEN STF.GENDER = 'M' THEN 'Male' 
		WHEN STF.GENDER = 'F' THEN 'Female'
	END) AS GENDER,
	STF.JOIN_DATE
	FROM STAFF STF
	WHERE STF.STAFF_TYPE = 'Non-Teaching'


-- Group by statement 
-- Count no of students in each class
SELECT SC.CLASS_ID , COUNT(1) AS "no_of_students"
	FROM STUDENT_CLASSES SC
	GROUP BY SC.CLASS_ID
	ORDER BY SC.CLASS_ID
	
-- More than 100 students in each class
SELECT SC.CLASS_ID , COUNT(1) AS "no_of_students"
	FROM STUDENT_CLASSES SC
	GROUP BY SC.CLASS_ID
	HAVING COUNT(1) > 100
	ORDER BY SC.CLASS_ID

-- Parents with more than 1 kid in school
SELECT SP.PARENT_ID, COUNT(1) AS "no_of_kids"
	FROM STUDENT_PARENT SP
	GROUP BY SP.PARENT_ID
	HAVING COUNT(1) > 1
	ORDER BY SP.PARENT_ID


-- SUBQUERY: query written inside a query
-- Fetch details of parents having more than 1 kids going to this school

SELECT (P.FIRST_NAME || ' ' || P.LAST_NAME) AS PARENT_NAME,
	(S.FIRST_NAME || ' ' || S.LAST_NAME) AS STUDENT_NAME,
	S.AGE AS STUDENT_AGE,
	S.GENDER AS STUDENT_GENDER,
	(ADR.STREET || ' ' || ADR.CITY || ' ' || ADR.STATE || ' ' || ADR.COUNTRY) AS ADDRESS
	FROM PARENTS P
	JOIN STUDENT_PARENT SP ON P.ID = SP.PARENT_ID
	JOIN STUDENTS S ON S.ID = SP.STUDENT_ID
	JOIN ADDRESS ADR ON ADR.ADDRESS_ID = P.ADDRESS_ID
	WHERE P.ID IN (
		SELECT SP.PARENT_ID
			FROM STUDENT_PARENT SP
			GROUP BY SP.PARENT_ID
			HAVING COUNT(1) > 1 
		)
	ORDER BY 1;

-- Aggregate functions (AVG, MIN, MAX, SUM, COUNT) : Aggregate functions are used to perform calculations on a set of values
-- AVG
SELECT AVG(SS.SALARY) AS AVG_SALARY
	FROM STAFF_SALARY SS
	JOIN STAFF STF ON STF.STAFF_ID = SS.STAFF_ID
	WHERE STF.STAFF_TYPE = 'Non-Teaching'

SELECT STF.STAFF_TYPE , AVG(SS.SALARY) AS AVG_SALARY
	FROM STAFF_SALARY SS
	JOIN STAFF STF ON STF.STAFF_ID = SS.STAFF_ID
	GROUP BY STF.STAFF_TYPE

-- SUM
SELECT STF.STAFF_TYPE , SUM(SS.SALARY) AS SUM_SALARY
	FROM STAFF_SALARY SS
	JOIN STAFF STF ON STF.STAFF_ID = SS.STAFF_ID
	GROUP BY STF.STAFF_TYPE

-- MIN
SELECT STF.STAFF_TYPE , MIN(SS.SALARY) AS MIN_SALARY
	FROM STAFF_SALARY SS
	JOIN STAFF STF ON STF.STAFF_ID = SS.STAFF_ID
	GROUP BY STF.STAFF_TYPE

-- MAX
SELECT STF.STAFF_TYPE , MAX(SS.SALARY) AS MAX_SALARY
	FROM STAFF_SALARY SS
	JOIN STAFF STF ON STF.STAFF_ID = SS.STAFF_ID
	GROUP BY STF.STAFF_TYPE

-- COUNT
SELECT COUNT(1)
	FROM STAFF_SALARY SS
	JOIN STAFF STF ON STF.STAFF_ID = SS.STAFF_ID
	ORDER BY 1


-- Fetch all staff name and salary info
SELECT DISTINCT (STF.FIRST_NAME || ' ' || STF.LAST_NAME) AS FULL_NAME, SS.SALARY
	FROM STAFF STF
	JOIN STAFF_SALARY SS ON STF.STAFF_ID = SS.STAFF_ID
	ORDER BY 2


-- INNER
SELECT DISTINCT (STF.FIRST_NAME || ' ' || STF.LAST_NAME) AS FULL_NAME, SS.SALARY
	FROM STAFF STF
	INNER JOIN STAFF_SALARY SS ON STF.STAFF_ID = SS.STAFF_ID -- inner join fetches records when there are matching 
	ORDER BY 2


-- LEFT
SELECT COUNT(1)
	FROM STAFF_SALARY SS
	LEFT JOIN STAFF STF ON STF.STAFF_ID = SS.STAFF_ID
	ORDER BY 1

SELECT DISTINCT (STF.FIRST_NAME || ' ' || STF.LAST_NAME) AS FULL_NAME, SS.SALARY
	FROM STAFF STF
	LEFT JOIN STAFF_SALARY SS ON STF.STAFF_ID = SS.STAFF_ID
	ORDER BY 2


-- RIGHT
SELECT COUNT(1)
	FROM STAFF STF
	RIGHT JOIN STAFF_SALARY SS ON STF.STAFF_ID = SS.STAFF_ID
	ORDER BY 1


SELECT DISTINCT (STF.FIRST_NAME || ' ' || STF.LAST_NAME) AS FULL_NAME, SS.SALARY
	FROM STAFF STF
	RIGHT JOIN STAFF_SALARY SS ON STF.STAFF_ID = SS.STAFF_ID 
	ORDER BY 2

-- FULL OUTER - Fetch all records from bold tables
 SELECT COUNT(1)
	FROM STAFF STF
	FULL OUTER JOIN STAFF_SALARY SS ON STF.STAFF_ID = SS.STAFF_ID
	ORDER BY 1

SELECT DISTINCT (STF.FIRST_NAME || ' ' || STF.LAST_NAME) AS FULL_NAME, SS.SALARY
	FROM STAFF STF
	FULL OUTER JOIN STAFF_SALARY SS ON STF.STAFF_ID = SS.STAFF_ID 
	ORDER BY 1,2

