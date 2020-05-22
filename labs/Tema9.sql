-- 12. a) Să se obţină numele angajaţilor care au lucrat
-- cel puţin pe aceleaşi proiecte ca şi angajatul având codul 200.

SELECT DISTINCT E.EMPLOYEE_ID,
                CONCAT(E.FIRST_NAME, CONCAT(' ', E.LAST_NAME)) AS NAME
FROM WORKS_ON A
JOIN EMPLOYEES E on A.EMPLOYEE_ID = E.EMPLOYEE_ID
WHERE NOT EXISTS(
    (SELECT PROJECT_ID
    FROM WORKS_ON B
    WHERE B.EMPLOYEE_ID=200)

    MINUS

    (SELECT PROJECT_ID
    FROM WORKS_ON C
    WHERE A.EMPLOYEE_ID = C.EMPLOYEE_ID)
);

-- 12. b) Să se obţină numele angajaţilor care au lucrat cel mult pe
-- aceleaşi proiecte ca şi angajatul având codul 200.

SELECT DISTINCT E.EMPLOYEE_ID,
                CONCAT(E.FIRST_NAME, CONCAT(' ', E.LAST_NAME)) AS NAME
FROM WORKS_ON A
JOIN EMPLOYEES E on A.EMPLOYEE_ID = E.EMPLOYEE_ID
WHERE NOT EXISTS(
    (SELECT PROJECT_ID
    FROM WORKS_ON C
    WHERE A.EMPLOYEE_ID = C.EMPLOYEE_ID)
    MINUS
    (SELECT PROJECT_ID
    FROM WORKS_ON B
    WHERE B.EMPLOYEE_ID=200)
);


-- 13. Să se obţină angajaţii care au lucrat pe aceleaşi
-- proiecte ca şi angajatul având codul 200.
-- Obs: Egalitatea între două mulţimi se testează cu ajutorul
-- proprietăţii „A=B => A-B=Ø şi B-A=Ø”.
SELECT DISTINCT E.EMPLOYEE_ID,
                CONCAT(E.FIRST_NAME, CONCAT(' ', E.LAST_NAME)) AS NAME
FROM WORKS_ON A
JOIN EMPLOYEES E on A.EMPLOYEE_ID = E.EMPLOYEE_ID
WHERE NOT EXISTS(
    (SELECT PROJECT_ID
    FROM WORKS_ON C
    WHERE A.EMPLOYEE_ID = C.EMPLOYEE_ID)
    MINUS
    (SELECT PROJECT_ID
    FROM WORKS_ON B
    WHERE B.EMPLOYEE_ID=200)
) AND NOT EXISTS(
    (SELECT PROJECT_ID
    FROM WORKS_ON B
    WHERE B.EMPLOYEE_ID=200)

    MINUS

    (SELECT PROJECT_ID
    FROM WORKS_ON C
    WHERE A.EMPLOYEE_ID = C.EMPLOYEE_ID)
);