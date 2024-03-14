
#1. Выведите список всех менеджеров, а именно их emp_no, имена/фамилии, номер департамента, который они курируют, 
#и дату найма в компанию. (именно менеджером, то есть подсказка dept_manager)

SELECT a.emp_no, concat(b.first_name, ' ' ,b.last_name) as FIO, a.dept_no, a.from_date 
FROM dept_manager as a
LEFT JOIN employees as b
ON a.emp_no = b.emp_no;

#2. Существует ли сотрудник по фамилии Markovitch, который когда-то был менеджером департамента. 
#Может быть таких сотрудников несколько? (именно менеджером, то есть подсказка dept_manager)

SELECT a.emp_no, b.last_name, CONCAT(YEAR(a.from_date), '-', YEAR(a.to_date)) as Period_of_work
FROM dept_manager as a
JOIN employees as b
ON a.emp_no = b.emp_no
WHERE b.last_name = 'Markovitch';

#3. Вывести список сотрудников, имена/фамилии, дату найма, должность в компании, у которых имя начинается на М, 
#а фамилия заканчивается на H.

SELECT concat(a.first_name, ' ' ,a.last_name) as FIO, a.hire_date, b.title 
FROM employees a
LEFT JOIN titles b
ON a.emp_no =b.emp_no
WHERE a.first_name LIKE 'M%'  AND a.last_name LIKE '%H';

/*4. Создайте временную таблицу на основе salaries, где у вас будет emp_no и его/ее максимальная и 
минимальная зарплата за весь период работы в компании. Далее сделайте JOIN используя эту временную таблицу 
и таблицу employees чтобы получить список сотрудников, их имена/фамилии, и их мин/макс зарплат.*/

SELECT * FROM salaries;
DROP TEMPORARY TABLE IF EXISTS salaries_1;

CREATE temporary table salaries_1
SELECT emp_no, MAX(salary) AS max_salary, MIN(salary) AS min_salary
FROM salaries
GROUP BY emp_no;

SELECT * FROM salaries_1;
SELECT concat(b.first_name, ' ' ,b.last_name) as FIO, a.min_salary, a.max_salary
FROM salaries_1 a
LEFT JOIN employees b
ON a.emp_no = b.emp_no


