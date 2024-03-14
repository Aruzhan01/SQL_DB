
#1. Вывести всю информацию из таблицы employees
SELECT * FROM employees;

#2. Вывести всех мужчин из таблицы employees
SELECT * FROM employees
WHERE gender = 'M';

#3. Вывести всех сотрудников по имени Elvis
SELECT * FROM employees
WHERE first_name = 'Elvis';

#4. Вывести уникальные/различные названия должностей (поищите в базе данных, посмотрите в какой таблице хранится эта информация)
SELECT DISTINCT(title) FROM titles;

#5. Вывести всех сотрудников, кто был трудоустроен в 2000 году (подсказка: столбец hire_date)
SELECT * FROM employees
WHERE hire_date LIKE '2000%';

#6. Вывести всех сотрудников, кому больше 60 лет на данный момент (т.е. используем Curdate)
SELECT * from employees
WHERE birth_date < CURDATE() - INTERVAL 60 YEAR;

#7. Вывести количество строк в таблице salaries
SELECT COUNT(*) from salaries; #967330

#8. Вывести количество строк в таблице salaries, где зарплата > 100.000$
SELECT COUNT(*) from salaries
WHERE salary > 100000;
