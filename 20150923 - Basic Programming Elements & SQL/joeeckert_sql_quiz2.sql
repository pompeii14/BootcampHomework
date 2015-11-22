--Homework SQL 2 20150924
--Joe Eckert

--Section 1 - Question 1
scp adult.data joeeckert26@216.230.228.88:~/
CREATE TABLE adult (
	age float,
	workclass char(30),
	fnlwgt float,
	education char(30),
	educationNum float,
	maritalStatus char(30),
	occupation char(30),
	relationship char(30),
	race char(30),
	sex char(30),
	capitalGain float,
	capitalLoss float,
	hoursPerWeek float,
	nativeCountry char(30),
	class char(30)
);

--Section 1 - Question 2
LOAD DATA LOCAL INFILE 'adult.data'
	INTO TABLE adult
	FIELDS TERMINATED BY ','
	OPTIONALLY ENCLOSED BY '"'
	LINES TERMINATED BY '\n';

--Section 1 - Question 3
SELECT * FROM adult 
	WHERE age + 
		workclass + 
		fnlwgt + 
		education + 
		educationNum + 
		maritalStatus + 
		occupation + 
		relationship + 
		race + 
		sex + 
		capitalGain + 
		capitalLoss + 
		hoursPerWeek + 
		nativeCountry + 
		class IS NULL;
	--One row of NULL values

--Section 1 - Question 4
DELETE FROM adult 
	WHERE age + 
		workclass + 
		fnlwgt + 
		education + 
		educationNum + 
		maritalStatus + 
		occupation + 
		relationship + 
		race + 
		sex + 
		capitalGain + 
		capitalLoss + 
		hoursPerWeek + 
		nativeCountry + 
		class IS NULL;

--Section 1 - Question 5
SELECT *, (lowC / highC) AS ratio FROM (SELECT COUNT(class) AS lowC, (SELECT COUNT(class) AS highC FROM adult WHERE class = ' >50K') as highC FROM adult WHERE class = ' <=50K') lowHigh;

--Section 1 - Question 6
SELECT class, AVG(age) AS avgAge FROM adult GROUP BY class;

--Section 1 - Question 7
SELECT class, COUNT(class) AS countClass FROM adult WHERE class = ' >50K' AND age < 36.78 GROUP BY class;

--Section 1 - Question 8
SELECT class, AVG(hoursPerWeek) AS avgHrsWeek FROM adult GROUP BY class;

--Section 1 - Question 9
SELECT *, "Female" AS gender, (lowC / highC) AS ratio FROM (SELECT COUNT(class) AS lowC, (SELECT COUNT(class) AS highC FROM adult WHERE class = ' >50K' AND sex = " Female") as highC FROM adult WHERE class = ' <=50K' AND sex = " Female") lowHigh UNION SELECT *, "Male" AS gender, (lowC / highC) AS ratio FROM (SELECT COUNT(class) AS lowC, (SELECT COUNT(class) AS highC FROM adult WHERE class = ' >50K' AND sex = " Male") as highC FROM adult WHERE class = ' <=50K' AND sex = " Male") lowHigh;

--Section 2 - Question 1
DELETE FROM Employee WHERE Employeeid = 5;

--Section 2 - Question 2
DELETE FROM Employee WHERE DepartmentID = 1;

--Section 2 - Question 3
ALTER TABLE Department ADD AvgWage float;

--Section 2 - Question 4
UPDATE Department SET Department.AvgWage=(SELECT AVG(Employee.BaseWage) FROM Employee WHERE Employee.DepartmentID = Department.DepartmentID);

--Section 2 - Question 5
UPDATE Employee SET BaseWage=BaseWage*1.1 WHERE DepartmentID = 2;
