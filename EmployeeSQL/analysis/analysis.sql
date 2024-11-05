--step 1) creation of tables to be used for analysis

/*CREATE TABLE departments(
    dept_no VARCHAR(4) PRIMARY KEY,
    dept_name TEXT NOT NULL
);

CREATE TABLE titles(
    title_id VARCHAR(5) PRIMARY KEY,
    title TEXT NOT NULL
);

CREATE TABLE employees(
    emp_no INT PRIMARY KEY,
	emp_title_id VARCHAR(5) NOT NULL,
    birth_date DATE NOT NULL,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    sex VARCHAR(1) NOT NULL,
    hire_date DATE NOT NULL,
    FOREIGN KEY (emp_title_id) REFERENCES titles(title_id)
);


CREATE TABLE dept_emp(
	emp_no INT NOT NULL,
	dept_no VARCHAR(4) NOT NULL,
    PRIMARY KEY (emp_no, dept_no),
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

CREATE TABLE dept_manager(
	dept_no VARCHAR(4) NOT NULL,
	emp_no INT NOT NULL,
    PRIMARY KEY (dept_no, emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

CREATE TABLE salaries(
	emp_no INT NOT NULL,
    salary INT NOT NULL,
    PRIMARY KEY (emp_no, salary),
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);*/




-- step 2 table population using the import method
-- step 3 data analysis of the following:

/* 1) List the employee number, last name, first name, sex, and salary of each employee.*/
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees AS e
JOIN salaries AS s ON e.emp_no = s.emp_no;

/* 2) List the first name, last name, and hire date for the employees who were hired in 1986.*/
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31';

/* 3) List the manager of each department along with their department number, department name, employee number, last name, and first name. */
SELECT dm.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name
FROM dept_manager AS dm
JOIN departments AS d ON dm.dept_no = d.dept_no
JOIN employees AS e ON dm.emp_no = e.emp_no;

/* 4) List the department number for each employee along with that employee’s employee number, last name, first name, and department name. */
SELECT de.dept_no, e.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp AS de
JOIN employees AS e ON de.emp_no = e.emp_no
JOIN departments AS d ON de.dept_no = d.dept_no;

/* 5) List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B. */
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

/* 6) List each employee in the Sales department, including their employee number, last name, and first name. */
SELECT e.emp_no, e.last_name, e.first_name
FROM employees AS e
JOIN dept_emp AS de ON e.emp_no = de.emp_no
JOIN departments AS d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales';

/* 7) List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name. */
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees AS e
JOIN dept_emp AS de ON e.emp_no = de.emp_no
JOIN departments AS d ON de.dept_no = d.dept_no
WHERE d.dept_name IN ('Sales', 'Development');

/* 8) List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name). */
SELECT last_name, COUNT(*) AS frequency
FROM employees
GROUP BY last_name
ORDER BY frequency DESC;

