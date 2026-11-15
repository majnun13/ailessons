-- TASK 1
SELECT
    JOB_TITLE,
    MAX_SALARY
FROM
    HR.JOBS
WHERE
    MAX_SALARY > (
        SELECT
            AVG(MAX_SALARY)
        FROM
            HR.JOBS
    )
ORDER BY
    MAX_SALARY DESC;

-- TASK 2
SELECT
    FIRST_NAME,
    LAST_NAME
FROM
    HR.EMPLOYEES
WHERE
        DEPARTMENT_ID = (
            SELECT
                DEPARTMENT_ID
            FROM
                HR.EMPLOYEES
            WHERE
                    FIRST_NAME = 'Steven'
                AND LAST_NAME = 'King'
        )
    AND NOT ( FIRST_NAME = 'Steven'
              AND LAST_NAME = 'King' );

-- TASK 3
SELECT
    FIRST_NAME,
    LAST_NAME,
    JOB_ID
FROM
    HR.EMPLOYEES
WHERE
    JOB_ID IN (
        SELECT
            JOB_ID
        FROM
            HR.EMPLOYEES
        GROUP BY
            JOB_ID
        HAVING
            COUNT(JOB_ID) = 1
    )
ORDER BY
    JOB_ID ASC;

-- TASK 4
SELECT
    DEPARTMENT_ID,
    COUNT(*) AS ISCI_SAYI
FROM
    HR.EMPLOYEES
GROUP BY
    DEPARTMENT_ID
HAVING
    ISCI_SAYI > (
        SELECT
            COUNT(*)
        FROM
            HR.EMPLOYEES
        WHERE
            DEPARTMENT_ID = (
                SELECT
                    DEPARTMENT_ID
                FROM
                    HR.DEPARTMENTS
                WHERE
                    DEPARTMENT_NAME = 'IT'
            )
    )
ORDER BY
    ISCI_SAYI DESC;

-- TASK 5
SELECT
    FIRST_NAME,
    LAST_NAME,
    DEPARTMENT_ID
FROM
    HR.EMPLOYEES
WHERE
    DEPARTMENT_ID IN (
        SELECT
            DEPARTMENT_ID
        FROM
            HR.DEPARTMENTS
        WHERE
            LOCATION_ID IN (
                SELECT
                    LOCATION_ID
                FROM
                    HR.LOCATIONS
                WHERE
                    COUNTRY_ID IN (
                        SELECT
                            COUNTRY_ID
                        FROM
                            HR.COUNTRIES
                        WHERE
                            COUNTRY_NAME LIKE '%Great Britain%'
                    )
            )
    );
-- 35 İŞÇİ ÇIXDI
-- 34'ü 80 1'i 40'cı şöbede işleyir.

-- TASK 6
SELECT
    JOB_TITLE,
    MIN_SALARY,
    MAX_SALARY
FROM
    HR.JOBS
WHERE
    JOB_ID IN (
        SELECT
            JOB_ID
        FROM
            HR.EMPLOYEES
        GROUP BY
            JOB_ID
        HAVING
            COUNT(*) = (
                SELECT
                    MAX(COUNT(*))
                FROM
                    HR.EMPLOYEES
                GROUP BY
                    JOB_ID
            )
    );

-- TASK 7
-- A)
SELECT
    FIRST_NAME,
    LAST_NAME,
    DEPARTMENT_ID,
    SALARY
FROM
    HR.EMPLOYEES
WHERE
    DEPARTMENT_ID IN (
        SELECT
            DEPARTMENT_ID
        FROM
            HR.DEPARTMENTS
        WHERE
            DEPARTMENT_NAME IN ( 'Finance', 'Accounting' )
    )
    AND SALARY = (
        SELECT
            MAX(SALARY)
        FROM
            HR.EMPLOYEES
        WHERE
            DEPARTMENT_ID IN (
                SELECT
                    DEPARTMENT_ID
                FROM
                    HR.DEPARTMENTS
                WHERE
                    DEPARTMENT_NAME IN ( 'Finance', 'Accounting' )
            )
    );
--B)
SELECT
    FIRST_NAME,
    LAST_NAME,
    DEPARTMENT_ID,
    SALARY
FROM
    HR.EMPLOYEES
WHERE
    DEPARTMENT_ID IN (
        SELECT
            DEPARTMENT_ID
        FROM
            HR.DEPARTMENTS
        WHERE
            DEPARTMENT_NAME IN ( 'Finance', 'Accounting' )
    )
ORDER BY
    SALARY DESC
FETCH FIRST 1 ROW ONLY;
-- a 2 setir b ise 1 setir qaytarır ve düzgün olan a'dır çünkü 2 eded 12008 maaşlı employee var ve bu demekdirki her ikisi en çox qazanandır ve her ikisi görsenmelidir.

-- TASK 8
SELECT
    DEPARTMENT_ID,
    ROUND(AVG(SALARY)) AS ORTA_MAAS
FROM
    HR.EMPLOYEES
GROUP BY
    DEPARTMENT_ID
HAVING
    AVG(SALARY) > (
        SELECT
            AVG(SALARY)
        FROM
            HR.EMPLOYEES
        WHERE
            DEPARTMENT_ID = (
                SELECT
                    DEPARTMENT_ID
                FROM
                    HR.DEPARTMENTS
                WHERE
                    DEPARTMENT_NAME = 'IT'
            )
    )
ORDER BY
    ORTA_MAAS DESC;

-- 1. sehv it yox IT olmalıdır.
-- 2. where yerine having olmalıdır çünkü bu bir aggregate functiondur.
-- 3. order by department_ıd lazım deyil çünkü artıqdır. 

-- TASK 9
SELECT
    CITY,
    COUNTRY_ID
FROM
    HR.LOCATIONS
WHERE
    LOCATION_ID IN (
        SELECT
            LOCATION_ID
        FROM
            HR.DEPARTMENTS
        WHERE
            DEPARTMENT_ID IN (
                SELECT
                    DEPARTMENT_ID
                FROM
                    HR.EMPLOYEES
                GROUP BY
                    DEPARTMENT_ID
                HAVING
                    COUNT(*) IN (
                        SELECT
                            MAX(COUNT(*))
                        FROM
                            HR.EMPLOYEES
                        GROUP BY
                            DEPARTMENT_ID
                    )
            )
    );

-- TASK 10 
SELECT
    J.JOB_TITLE,
    COUNT(*) AS ISCI_SAYI
FROM
         HR.EMPLOYEES E
    JOIN HR.JOBS J ON E.JOB_ID = J.JOB_ID
GROUP BY
    J.JOB_ID,
    J.JOB_TITLE
HAVING
    COUNT(*) > (
        SELECT
            AVG(COUNT(*))
        FROM
            HR.EMPLOYEES
        GROUP BY
            JOB_ID
    )
ORDER BY
    ISCI_SAYI DESC;

-- vezifelerin orta işçisi 5.6'dır
