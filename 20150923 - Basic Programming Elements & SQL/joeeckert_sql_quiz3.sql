----Homework SQL 3 20150925
--Joe Eckert

--Duplicate Emails
SELECT Email FROM (SELECT Email, COUNT(Email) AS count FROM DE GROUP BY Email) counts WHERE count > 1;

--Employees Earning More Than Their Managers
SELECT emp.Name FROM EEMTTM emp INNER JOIN EEMTTM mgr ON emp.ManagerId = mgr.Id WHERE emp.Salary > mgr.Salary;

--Customers Who Never Order
SELECT Name AS Customers FROM CWNOcustomers LEFT JOIN CWNOorders ON CWNOcustomers.ID = CWNOorders.CustomerId WHERE CustomerId IS NULL;

--Second Highest Salary
SELECT * FROM SHS ORDER BY Salary DESC LIMIT 1 OFFSET 1;

--Delete Duplicate Emails
SELECT min(ID) as EmpID, Email FROM DDE GROUP BY Email;

--Rising Temperature
SELECT tod.ID FROM RT AS tod, RT as yest WHERE tod.Temperature > yest.Temperature AND TO_DAYS(tod.Date) = TO_DAYS(yest.Date) + 1;

--Department Highest Salary
SELECT DHSdepartment.Name AS Department, DHSemployee.Name AS Employee, DHSemployee.Salary AS Salary 

	FROM DHSdepartment JOIN DHSemployee ON DHSemployee.DepartmentId = DHSdepartment.Id 

	WHERE DHSemployee.Salary 

		IN (SELECT MAX(maxsal.Salary) FROM DHSemployee maxsal WHERE maxsal.DepartmentId = DHSemployee.DepartmentId);