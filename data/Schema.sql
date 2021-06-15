-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "employees" (
    "emp_no" INTEGER   NOT NULL,
    "emp_title_id" Varchar   NOT NULL,
    "bith_date" Date   NOT NULL,
    "first_name" Varchar   NOT NULL,
    "last_name" Varchar   NOT NULL,
    "sex" Varchar   NOT NULL,
    "hire_date" Date   NOT NULL,
    PRIMARY KEY ("emp_no")
);

CREATE TABLE "titles" (
    "title_id" Varchar   NOT NULL,
    "title" Varchar   NOT NULL,
    PRIMARY KEY ("title_id")
);

CREATE TABLE "salaries" (
    "emp_no" INTEGER   NOT NULL,
    "salary" INTEGER   NOT NULL,
    PRIMARY KEY ("emp_no")
);

CREATE TABLE "dept_manager" (
    "dept_no" Varchar   NOT NULL,
    "emp_no" INT   NOT NULL,
	Foreign KEY ("emp_no") REFERENCES employees ("emp_no"),
	Foreign KEY ("dept_no") REFERENCES departments ("dept_no"),
    PRIMARY KEY ("dept_no","emp_no")
);

CREATE TABLE "departments" (
    "dept_no" Varchar   NOT NULL,
    "dept_name" Varchar   NOT NULL,
    PRIMARY KEY ("dept_no")
);

CREATE TABLE "dept_emp" (
    "emp_no" INT   NOT NULL,
    "dept_no" Varchar   NOT NULL,
    PRIMARY KEY ("emp_no","dept_no")
);

-- Import csv files from repo into the ERD designed in the Quickdatabasedesigns.com tool
-- Validate the data is showing up in the tables
Select * from departments

Select * from dept_emp

Select * from dept_manager
Limit 10

Select * from employees

Select * from salaries

Select * from titles

-- Data Analysis
-- Once you have a complete database, do the following:
-- 1. List the following details of each employee: employee number, last name, first name, sex, and salary.
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
FROM employees
JOIN salaries
ON employees.emp_no = salaries.emp_no;

-- 2. List first name, last name, and hire date for employees who were hired in 1986.
SELECT last_name, first_name, hire_date
FROM employees
Where hire_date between '1986-01-01' and '1986-12-31';

-- 3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
-- alter table blah alter column col1 int
--select CAST(varchar_col as int) from table
SELECT dept_manager.dept_no, departments.dept_name, CAST(dept_manager.emp_no AS INT), employees.last_name, employees.first_name
FROM dept_manager
JOIN employees
ON dept_manager.emp_no = employees.emp_no
JOIN departments
ON dept_manager.dept_no = departments.dept_no

-- 4. List the department of each employee with the following information: employee number, last name, first name, and department name.
-- Remember to join employees to departments, but also departments with dept_emp on emp_no
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
JOIN dept_emp
ON employees.emp_no = dept_emp.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no;

-- 5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
-- Remember the starts with is after the B and validated in Excel with 20 records
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' and last_name like 'B%';

-- 6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
JOIN dept_emp
ON employees.emp_no = dept_emp.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales'

-- 7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
JOIN dept_emp
ON employees.emp_no = dept_emp.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales' OR departments.dept_name = 'Development';

-- 8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT employees.last_name, COUNT(employees.last_name)
FROM employees
Group by last_name
ORDER by Count(employees.last_name) DESC