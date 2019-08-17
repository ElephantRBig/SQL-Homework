CREATE TABLE "Departments" (
    "dept_no" VARCHAR   NOT NULL,
    "dept_name" VARCHAR   NOT NULL,
    CONSTRAINT "pk_Departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "Dept_emp" (
    "emp_no" int   NOT NULL,
    "dept_no" VARCHAR   NOT NULL,
    "from_date" VARCHAR   NOT NULL,
    "to_date" VARCHAR   NOT NULL
);

CREATE TABLE "Dept_manager" (
    "dept_no" VARCHAR   NOT NULL,
    "emp_no" int   NOT NULL,
    "from_date" VARCHAR   NOT NULL,
    "to_date" VARCHAR   NOT NULL
);

CREATE TABLE "Employees" (
    "emp_no" int   NOT NULL,
    "birth_date" VARCHAR   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "gender" VARCHAR   NOT NULL,
    "hire_date" VARCHAR   NOT NULL,
    CONSTRAINT "pk_Employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "Salaries" (
    "emp_no" int   NOT NULL,
    "salary" int   NOT NULL,
    "from_date" VARCHAR   NOT NULL,
    "to_date" VARCHAR   NOT NULL
);

CREATE TABLE "Titles" (
    "emp_no" int   NOT NULL,
    "title" VARCHAR   NOT NULL,
    "from_date" VARCHAR   NOT NULL,
    "to_date" VARCHAR   NOT NULL
);

ALTER TABLE "Dept_emp" ADD CONSTRAINT "fk_Dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Dept_emp" ADD CONSTRAINT "fk_Dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "Dept_manager" ADD CONSTRAINT "fk_Dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "Salaries" ADD CONSTRAINT "fk_Salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Titles" ADD CONSTRAINT "fk_Titles_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

SELECT *
FROM "Departments";

SELECT *
FROM "Dept_emp";

SELECT *
FROM "Dept_manager";

SELECT *
FROM "Employees";

SELECT *
FROM "Salaries";

SELECT *
FROM "Titles";

-- Question 1
-- List the following details of each employee:
-- Employee Number, Last name, First Name, Gender, and Salary

SELECT E.emp_no, E.first_name, E.last_name, E.gender, S.salary
FROM "Employees" E
JOIN "Salaries" S ON
(s.emp_no = e.emp_no)

-- Question 2
-- List employees who were hired in 1986

SELECT emp_no, hire_date, first_name, last_name
FROM "Employees"
WHERE hire_date LIKE '1986%'
ORDER BY hire_date ASC;

-- Question 3
-- List the manager of each department with the following information:
-- Department number, Department name, Manager's employee number,
-- last name, first name, start and end employment dates.

SELECT M.dept_no, D.dept_name ,M.emp_no, E.last_name, E.first_name, H.from_date, H.to_date
FROM "Dept_manager" M
	JOIN "Departments" D ON (D.dept_no = M.dept_no)
	JOIN "Employees" E ON (E.emp_no = M.emp_no)
	JOIN "Dept_emp" H ON (H.emp_no = E.emp_no)

-- Question 4
-- List the department of each employee with the following information:
-- Employee number, last name, first name, and department name

SELECT E.emp_no, E.first_name, E.last_name, D.dept_name
FROM "Employees" E
	JOIN "Dept_emp" H ON (E.emp_no = H.emp_no)
	JOIN "Departments" D ON (D.dept_no = H.dept_no)

-- Question 5
-- List all employees whose first name is "Hercules" 
-- and last names begin with "B"

SELECT emp_no, last_name, first_name
FROM "Employees"
WHERE first_name = 'Hercules'
	AND last_name LIKE ('B%');
	
-- Question 6 
-- List all employees in the Sales department including:
-- Employee number, Last name, First name, and Department name

SELECT E.emp_no, E.last_name, E.first_name, D.dept_name
FROM "Employees" E
	JOIN "Dept_emp" H ON (H.emp_no = E.emp_no)
	JOIN "Departments" D ON (D.dept_no = H.dept_no)
WHERE D.dept_name = 'Sales'

-- Question 7
-- List all employees in the Sale and Development departments, including:
-- Employee number, Last name, First name, and Department name

SELECT E.emp_no, E.last_name, E.first_name, D.dept_name
FROM "Employees" E
	JOIN "Dept_emp" H ON (H.emp_no = E.emp_no)
	JOIN "Departments" D ON (D.dept_no = H.dept_no)
WHERE D.dept_name = 'Sales'
	OR D.dept_name = 'Development'
	
-- Question 8
-- In Descending order, list the frequency count of employee last names
-- i.e how many employees share each last name

SELECT last_name, COUNT(last_name) AS "Employees_with_Last_name"
FROM "Employees"
GROUP BY last_name
ORDER BY COUNT(last_name) DESC