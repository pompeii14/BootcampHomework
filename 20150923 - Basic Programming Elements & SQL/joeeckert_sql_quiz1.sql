--Homework SQL 1 20150923
--Joe Eckert

--Section 1 - Question 1
SELECT id, extra FROM SLEEP;

--Section 1 - Question 2
SELECT extra, id FROM SLEEP;

--Section 1 - Question 3
SELECT DISTINCT category FROM SLEEP;

--Section 1 - Question 4
SELECT id, extra FROM SLEEP WHERE extra > 0;

--Section 1 - Question 5
SELECT category, SUM(extra) AS extraSum, COUNT(extra) AS categoryNUM FROM SLEEP GROUP BY category;

--Section 1 - Question 6
SELECT category, AVG(extra) AS mean_extra FROM SLEEP GROUP BY category;

--Section 2 - Question 1
SELECT * from Department LIMIT 10;

--Section 2 - Question 2
SELECT employeename, hiredate, BaseWage FROM Employee;

--Section 2 - Question 3
SELECT employeename, BaseWage * WageLevel AS totalWage FROM Employee;

--Section 2 - Question 4
SELECT employeename, basewage FROM Employee WHERE basewage <= 3000 AND basewage >= 2000 ORDER BY basewage DESC;

--Section 2 - Question 5
SELECT employeename, hiredate, BaseWage FROM Employee WHERE employeename LIKE '%8' AND hiredate > '2010,06,10';

--Section 2 - Question 6
SELECT employeename, departmentid, BaseWage * WageLevel AS totalWage FROM Employee WHERE (BaseWage * WageLevel) > 7000;

--Section 2 - Question 7
SELECT * FROM (SELECT departmentid, COUNT(departmentid) AS countEmp FROM Employee WHERE basewage > 3000 GROUP BY departmentid) subTable WHERE countEmp > 10;

--Section 2 - Question 8
SELECT departmentid, SUM(BaseWage * WageLevel) AS totalWage FROM Employee GROUP BY departmentid ORDER BY totalWage ASC;

--Section 2 - Question 9
SELECT departmentid, employeesex, AVG(BaseWage * WageLevel) AS avgWage FROM Employee Group By departmentid, employeesex ORDER BY departmentid DESC;

--Section 2 - Question 10
SELECT Employee.employeename, Department.departmentname, Department.principal FROM Employee JOIN Department ON Employee.departmentid = Department.departmentid;

