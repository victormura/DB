INSERT INTO DEPT_VMU (DEPARTMENT_ID, DEPARTMENT_NAME)
VALUES (300, 'Programare');

-- 6. Să se insereze un angajat corespunzător departamentului introdus
-- anterior în tabelul EMP_***, precizând valoarea NULL pentru coloanele
-- a căror valoare nu este cunoscută la inserare (metoda implicită de inserare).
-- Determinaţi ca efectele instrucţiunii să devină permanente.

INSERT INTO EMP_VMU
    (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE,
     JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID)
VALUES
       (250, NULL, 'Mura', 'victor.mura@unibuc.ro', null, sysdate,
        'CEVA', null, null, null, 300);


-- 7. Să se mai introducă un angajat corespunzător departamentului 300,
-- precizând după numele tabelului lista coloanelor în care se introduc
-- valori (metoda explicita de inserare). Se presupune că data angajării
-- acestuia este cea curentă (SYSDATE). Salvaţi înregistrarea.
INSERT INTO EMP_VMU (employee_id, last_name, email, HIRE_DATE, JOB_ID, department_id)
VALUES (251, 'Mura', 'victor.mura@unibuc.ro', sysdate, 'CEVA', 300);
delete from EMP_VMU where EMPLOYEE_ID=250;
COMMIT;


-- 8. Este posibilă introducerea de înregistrări prin intermediul subcererilor
-- (specificate în locul tabelului). Ce reprezintă, de fapt, aceste subcereri?
-- Să se analizeze următoarele comenzi INSERT:

INSERT INTO EMP_VMU (employee_id, last_name, email, hire_date, job_id, salary,
commission_pct)
VALUES (252, 'Nume252', 'nume252@emp.com',SYSDATE, 'SA_REP', 5000, NULL);
SELECT employee_id, last_name, email, hire_date, job_id, salary, commission_pct
FROM EMP_VMU
WHERE employee_id=252;
ROLLBACK;

INSERT INTO
(SELECT employee_id, last_name, email, hire_date, job_id, salary,
commission_pct
FROM EMP_VMU)
VALUES (252, 'Nume252', 'nume252@emp.com',SYSDATE, 'SA_REP', 5000, NULL);
SELECT employee_id, last_name, email, hire_date, job_id, salary, commission_pct
FROM EMP_VMU
WHERE employee_id=252;
ROLLBACK;


CREATE TABLE EMP1_VMU AS SELECT * FROM EMPLOYEES;
DELETE FROM EMP1_VMU;

TRUNCATE TABLE EMP1_VMU;

INSERT INTO EMP1_VMU SELECT * FROM EMPLOYEES WHERE COMMISSION_PCT > 0.25;
TRUNCATE TABLE EMP1_VMU;

SELECT MAX(SALARY) FROM EMPLOYEES;

INSERT INTO EMP1_VMU
SELECT * FROM EMPLOYEES
WHERE SALARY IN (SELECT MAX(SALARY) FROM EMPLOYEES);

-- 11. Să permită introducerea de înregistrări în tabelul EMP_*** în mod interactiv.
-- Se vor cere utilizatorului: codul, numele, prenumele si salariul angajatului.
-- Câmpul email se va completa automat prin concatenarea primei litere din prenume
-- şi a primelor 7 litere din nume.

-- INSERT INTO EMP1_VMU
--     (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID)
-- VALUES (&e_id, '&f_name', '&l_name', substr('&f_name', 1, 1) || substr('&l_name', 1, 7), null, sysdate, 'test', &salariul, null, null, 300)

CREATE TABLE EMP2_VMU AS SELECT * FROM EMPLOYEES;
CREATE TABLE EMP3_VMU AS SELECT * FROM EMPLOYEES;



INSERT FIRST
WHEN SALARY < 5000 THEN INTO EMP1_VMU
WHEN SALARY >= 5000 AND SALARY <= 10000 THEN INTO EMP2_VMU
ELSE INTO EMP3_VMU SELECT * FROM EMPLOYEES;

SELECT * FROM EMP1_VMU;
SELECT * FROM EMP2_VMU;
SELECT * FROM EMP3_VMU;

SELECT * FROM DEPT_VMU;
SELECT * FROM EMP_VMU;

CREATE TABLE EMP0_VMU AS SELECT * FROM EMPLOYEES;
TRUNCATE TABLE EMP0_VMU;
TRUNCATE TABLE EMP1_VMU;
TRUNCATE TABLE EMP2_VMU;
TRUNCATE TABLE EMP3_VMU;

INSERT ALL
WHEN DEPARTMENT_ID = 80 THEN INTO EMP0_VMU
WHEN SALARY < 5000 THEN INTO EMP1_VMU
WHEN SALARY >= 5000 AND SALARY <= 10000 THEN INTO EMP2_VMU
WHEN SALARY > 10000 THEN INTO EMP3_VMU SELECT * FROM EMPLOYEES;



