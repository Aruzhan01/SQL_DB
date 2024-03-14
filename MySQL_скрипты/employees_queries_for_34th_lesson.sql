#1. Найти всех женщин, у которых emp_no заканчивается на 7
SELECT * FROM employees
WHERE gender = 'F' AND emp_no LIKE '%7';

#2. Вывести все emp_no сотрудников, кто не работал в департаменте d005 (таблица dept_emp)
SELECT emp_no FROM dept_emp
WHERE dept_no != 'd005';

#3. Вывести все названия департаментов, где есть буквы ‘u’ и ‘o’
SELECT dept_name FROM departments
WHERE dept_name LIKE '%u%' AND dept_name LIKE '%o%';

#4. Вывести имена всех сотрудников, где есть либо ‘z’ либо ‘t’
SELECT first_name FROM employees
WHERE first_name LIKE '%z%' OR first_name LIKE '%t%';

#5 Вывести все фамилии сотрудников, которые были наняты на работу между ‘1993-01-15’ и ‘1993-12-31’
SELECT last_name FROM employees
WHERE hire_date BETWEEN '1993-01-15' AND '1993-12-31';

#6. Получить список со всеми сотрудницами, чье имя Kellie
SELECT * FROM employees
WHERE first_name ='Kellie' AND gender = 'F';

#7. Получить список со всеми сотрудницами, чье имя Kellie или Aruna
SELECT * FROM employees
WHERE (first_name ='Kellie' AND gender = 'F') OR (first_name ='Aruna' AND gender = 'F');
#либо:
SELECT * FROM employees
WHERE first_name ='Kellie' OR first_name ='Aruna' 
AND gender = 'F';

#8. Выбрать всю информацию из таблицы salaries где зарплаты между 66 000 и 70 000 долларов
SELECT * FROM salaries
WHERE salary BETWEEN 60000 AND 70000;
