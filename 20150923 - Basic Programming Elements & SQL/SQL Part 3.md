# Background
The SQL questions are collected from [Leetcode](https://leetcode.com/problemset/database/).
Leetcode is an online platform to test your programming skills.  
We encourage you to do more practices on that platform.  We provide tables with different names in our database to help you to test them locally.

These questions are **not** easy.  Sometimes you need to learn more about SQL syntax.  In that case, you should think about the keyword you could search.  This process is a training, not only for you, also for [your google account](http://en.wikipedia.org/wiki/Google_Personalized_Search).  Do *not* search for solution directly.  Some hints will be available on Friday night.

If you find the questions are too hard, you can find some introductory exercises [here](http://en.wikibooks.org/wiki/SQL_Exercises).  Try to solve at least one question below.

# SQL setup

For exercise, you need login our server and `use` the database `sqlexercise` first:

	mysql> USE sqlexercise;
	
And then you can start with exercise with the corresponding `table` for each question. 
	
Even in the case that information is selected correctly, it won't guarantee your code is correct for every case.  You will gain more experience as you keep writing scripts.

Alternatively you could also practice on [leetcode](https://leetcode.com/problemset/database/) directly with provided links.  However be careful about your submissions.  There will be a record for each submission. 

## Homework Submission

Please submit your solution to our git repo [bootcamp003_student/sql](https://github.com/casunlight/bootcamp003_student/tree/master/sql/student_solution).
Save your SQL scripts in `yourname.sql` file, put it in [student_solution](./student_solution) folder.

+ Mark each exercise starts with its title as `/* Title is here */`
+ Paste your solution below the title.
+ You are welcome to provide multiple solutions.

## Questions

### Duplicate Emails  - no need for JOIN.
[leetcode link](https://leetcode.com/problems/duplicate-emails/)
 
Write a SQL query to find all duplicate emails in a table named `DE`.


| Id | Email   |
|----|---------|
| 1  | a@b.com |
| 2  | c@d.com |
| 3  | a@b.com |


For example, your query should return the following for the above table:

| Email   |
|---------|
| a@b.com |

**Note**: All emails are in lowercase.

### Employees Earning More Than Their Managers

[leetcode link](https://leetcode.com/problems/employees-earning-more-than-their-managers/)

The `EEMTTM` table holds all employees including their managers. Every employee has an Id, and there is also a column for the manager Id.


| Id | Name  | Salary | ManagerId |
|----|-------|--------|-----------|
| 1  | Joe   | 70000  | 3         |
| 2  | Henry | 80000  | 4         |
| 3  | Sam   | 60000  | NULL      |
| 4  | Max   | 90000  | NULL      |


Given the `EEMTTM` table, write a SQL query that finds out employees who earn more than their managers. For the above table, Joe is the only employee who earns more than his manager.


| Employee |
|----------|
| Joe      |


### Customers Who Never Order - No need for JOIN
[leetcode link](https://leetcode.com/problems/customers-who-never-order/)

Suppose that a website contains two tables, the `CWNOcustomers` table and the `CWNOorders` table. Write a SQL query to find all customers who never order anything.


Table: CWNOcustomers

| Id | Name  |
|----|-------|
| 1  | Joe   |
| 2  | Henry |
| 3  | Sam   |
| 4  | Max   |



Table: CWNOorders

| Id | CustomerId |
|----|------------|
| 1  | 3          |
| 2  | 1          |



Using the above tables as example, return the following:



| Customers |
|-----------|
| Henry     |
| Max       |

### Second Highest Salary

Write a SQL query to get the second highest salary from the `SHS` table.


| Id | Salary |
|----|--------|
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |


For example, given the above `SHS` table, the second highest salary is `200`.  If there is no second highest salary, then the query should return `null`.

### Delete Duplicate Emails - No need of JOIN
[leetcode link](https://leetcode.com/problems/delete-duplicate-emails/)

Write a SQL query to select email entries in a table named `DDE`, keeping only unique emails based on its smallest Id.

| Id | Email            |
|----|------------------|
| 1  | john@example.com |
| 2  | bob@example.com  |
| 3  | john@example.com |

Id is the primary key column for this table.

For example, after running your query, the above `DDE` table should have the following rows:

| Id | Email            |
|----|------------------|
| 1  | john@example.com |
| 2  | bob@example.com  |


### Rising Temperature

[leetcode link](https://leetcode.com/problems/rising-temperature/)

Given a `RT` table, write a SQL query to find all dates' Ids with higher temperature compared to its previous (yesterday's) dates.


| Id(INT) | Date(DATE) | Temperature(INT) |
|---------|------------|------------------|
|       1 | 2015-01-01 |               10 |
|       2 | 2015-01-02 |               25 |
|       3 | 2015-01-03 |               20 |
|       4 | 2015-01-04 |               30 |



For example, return the following Ids for the above `RT` table:


| Id |
|----|
|  2 |
|  4 |


## Exercise (Advanced but not crazy)

### Department Highest Salary
[leetcode link](https://leetcode.com/problems/department-highest-salary/)

The `DHSemployee` table holds all employees. Every employee has an Id, a salary, and there is also a column for the department Id.

| Id | Name  | Salary | DepartmentId |
|----|-------|--------|--------------|
| 1  | Joe   | 70000  | 1            |
| 2  | Henry | 80000  | 2            |
| 3  | Sam   | 60000  | 2            |
| 4  | Max   | 90000  | 1            |

The `DHSdepartment` table holds all departments of the company.

| Id | Name     |
|----|----------|
| 1  | IT       |
| 2  | Sales    |

Write a SQL query to find employees who have the highest salary in each of the departments. For the above tables, Max has the highest salary in the IT department and Henry has the highest salary in the Sales department.


| Department | Employee | Salary |
|------------|----------|--------|
| IT         | Max      | 90000  |
| Sales      | Henry    | 80000  |
