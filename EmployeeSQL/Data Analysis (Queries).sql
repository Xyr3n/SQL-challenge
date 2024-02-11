-- Data Analysis
-- 1. List the employee number, last name, first name, sex, and salary of each employee.
SELECT employees.emp_no,employees.last_name, employees.first_name,employees.sex, salaries.salary
FROM employees
JOIN salaries ON employees.emp_no = salaries.emp_no
GROUP BY employees.emp_no, salaries.salary

-- 2. List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date >= '1986-01-01' AND hire_date < '1987-01-01';

-- 3. List the manager of each department along with their department number, 
--	  department name, employee number, last name, and first name.
SELECT d.dept_no, d.dept_name,dm.emp_no,e.last_name, e.first_name
FROM dept_managers AS dm
INNER JOIN departments AS d ON dm.dept_no = d.dept_no
INNER JOIN employees AS e ON dm.emp_no = e.emp_no

-- 4. List the department number for each employee along with that 
--	  employee's employee number, last name, first name, and department name.
SELECT de.dept_no, de.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp AS de
INNER JOIN departments AS d ON de.dept_no = d.dept_no
INNER JOIN employees AS e ON de.emp_no = e.emp_no
ORDER BY de.dept_no

-- 5. List first name, last name, and sex of each employee whose 
--	  first name is Hercules and whose last name begins with the letter B.
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%'

-- 6. List each employee in the Sales department, 
--	  including their employee number, last name, and first name.
SELECT emp_no, first_name, last_name
FROM employees
WHERE emp_no IN
(
	SELECT emp_no
	FROM dept_emp
	WHERE dept_no IN 
	(
		SELECT dept_no
		FROM departments
		WHERE dept_name = 'Sales'
	)
)

-- 7. List each employee in the Sales and Development departments, 
--	  including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name,d.dept_name
FROM dept_emp AS de
INNER JOIN employees AS e ON de.emp_no = e.emp_no
INNER JOIN departments AS d ON de.dept_no = d.dept_no
WHERE d.dept_name IN ('Sales', 'Development')

-- 8. List the frequency counts, in descending order, of all the employee last names 
--	  (that is, how many employees share each last name).
SELECT COUNT(last_name) AS "Count",last_name
FROM employees
GROUP BY last_name
ORDER BY "Count" DESC