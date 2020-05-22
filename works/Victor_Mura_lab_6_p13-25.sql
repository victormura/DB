-- Victor Mura grupa 132 semigrupa I
-- Laboratorul 6 
-- Problemele de la 13 pana la 25




-- 13: Să se afişeze maximul salariilor medii pe departamente.
select max( round(avg(salary)))
from employees e, departments d
where e.department_id=d.department_id
group by d.department_id,d.department_name;

--afisati denumirea departamentului care are media salariilor cea mai mare.

select d.department_name, round(avg(salary))
from employees e, departments d
where e.department_id=d.department_id
group by d.department_name
having round(avg(salary))= (select max( round(avg(salary)))
                          from employees e, departments d
                          where e.department_id=d.department_id
                          group by d.department_id,d.department_name);

--14.	Sa se obtina codul, titlul ?i salariul mediu al job-ului pentru care suma salariilor este minima.

--care este suma salariilor minima per joburi

select min(sum(salary))
from employees
group by job_id;

--corect
select j.job_id, j.JOB_TITLE, sum(salary)
from employees e, jobs j
where e.job_id=j.job_id
group by j.job_id,j.JOB_TITLE
having sum(salary) =(select min(sum(salary))
                      from employees
                      group by job_id);
                    --  AD_ASST	Administration Assistant	4400

--15.	S? se afi?eze salariul mediu din firm? doar dac? acesta este mai mare decāt 2500. (clauza HAVING f?r? GROUP BY)

select avg(salary)
from employees
having avg(salary)>2500;

--16.	S? se afi?eze suma salariilor pe departamente ?i, īn cadrul acestora, pe job-uri.

--suma salariilor per departamente
SELECT department_id, SUM(salary), count(*)
FROM     employees
where department_id is not null
GROUP  BY department_id
order by 1;--11 informatii


SELECT department_id,job_id, SUM(salary), count(*)
FROM     employees
GROUP  BY department_id, job_id
order by 1;--20 informatii

SELECT department_id,job_id, SUM(salary), count(*)
FROM     employees
GROUP  BY  job_id, department_id
order by 1;

--18.	Sa se afiseze codul, numele departamentului si numarul de angajati care lucreaza in acel departament pentru:
--a)	departamentele in care lucreaza mai putin de 4 angajati;
--b)	departamentul care are numarul maxim de angajati.
--a)
SELECT e.department_id, d. department_name, COUNT(*)
    FROM     departments d JOIN employees e
                       ON (d.department_id = e.department_id )
   WHERE e.department_id IN (SELECT  department_id
                             FROM   employees
                             GROUP BY department_id
                             HAVING COUNT(*) < 4)
   GROUP BY  e.department_id, d.department_name;
--Sau
SELECT      e.department_id, d.department_name, COUNT(*)
FROM          employees  e JOIN  departments d
                    ON (d.department_id = e.department_id )
GROUP BY  e.department_id, d.department_name
HAVING       COUNT(*)<4;

--19.	Sa se afiseze salariatii care au fost angajati īn aceea?i zi a lunii īn care cei
--mai multi dintre salariati au fost angajati.
SELECT employee_id, last_name, TO_CHAR(hire_date, 'dd')
FROM     employees
WHERE TO_CHAR(hire_date,'dd') IN
    (SELECT TO_CHAR(hire_date,'dd')
    FROM employees
    GROUP BY TO_CHAR(hire_date,'dd')
    HAVING COUNT(*)=(SELECT MAX(COUNT(*))
                      FROM employees
                      GROUP BY TO_CHAR(hire_date,'dd')));

-- 20: Să se obţină numărul departamentelor care au cel puţin 15 angajaţi.
SELECT COUNT(COUNT(department_id))
FROM employees
GROUP BY department_id
HAVING COUNT(*) > 15;
-- Ce reprezintă rezultatul returnat de cererea:
SELECT COUNT(department_id)
FROM employees
GROUP BY department_id
HAVING COUNT(*) > 15;
-- Raspuns: Aceasta va returna numarul de angajati
-- din departamentele cu un numar de angajati mai mare de 15


-- 21: Să se obţină codul departamentelor şi suma salariilor angajaţilor care lucrează în
-- acestea, în ordine crescătoare. Se consideră departamentele care au mai mult de 10
-- angajaţi şi al căror cod este diferit de 30.
SELECT DEPARTMENT_ID, SUM(SALARY) as salary_sum
FROM employees
GROUP BY department_id
HAVING COUNT(*) > 10 AND DEPARTMENT_ID != 30
ORDER BY salary_sum;


-- 22: Sa se afiseze codul, numele departamentului, numarul de angajati si salariul mediu
-- din departamentul respectiv. Se vor afişa şi departamentele fără angajaţi (outer join).
SELECT d.department_id, d.department_name, COUNT(e.DEPARTMENT_ID) as numarul_de_lucratori,
       avg(SALARY) as salariul_mediu
FROM departments d left outer join employees e
ON (d.department_id = e.department_id )
GROUP BY d.department_id, d.department_name;

-- 23: Scrieti o cerere pentru a afisa, pentru departamentele avand codul > 80, salariul total
-- pentru fiecare job din cadrul departamentului. Se vor afisa orasul, numele
-- departamentului, jobul si suma salariilor. Se vor eticheta coloanele corespunzator.
select l.CITY, d.DEPARTMENT_NAME, j.JOB_TITLE,
       sum(e.SALARY) as suma_salariilor
from EMPLOYEES e
join jobs j on e.JOB_ID = j.JOB_ID
join departments d on e.DEPARTMENT_ID = d.DEPARTMENT_ID
join locations l on l.LOCATION_ID = d.LOCATION_ID
where d.DEPARTMENT_ID > 80
group by l.CITY, d.DEPARTMENT_NAME, j.JOB_TITLE;


-- 24: Care sunt angajatii care au mai avut cel putin doua joburi?
select e.FIRST_NAME, e.LAST_NAME, count(jh.EMPLOYEE_ID) as jobs
from EMPLOYEES e
join JOB_HISTORY jh on jh.EMPLOYEE_ID = e.EMPLOYEE_ID
having count(jh.EMPLOYEE_ID) >= 2
group by e.FIRST_NAME, e.LAST_NAME;

-- 25: Să se calculeze comisionul mediu din firmă, luând în considerare toate liniile din
-- tabel.
SELECT AVG(NVL(commission_pct, 0)) as comisionul_mediu
FROM employees;