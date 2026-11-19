-- TASK 1
SELECT CONCAT(FIRST_NAME, ' ', UPPER(LAST_NAME)) AS TAM_AD, CONCAT(SUBSTR(FIRST_NAME, 1, 1), '. ', LAST_NAME) AS QISA_AD, CONCAT(LOWER(EMAIL), '@company.com') AS EMAIL
FROM HR.EMPLOYEES
ORDER BY LAST_NAME ASC;

-- TASK 2
SELECT FIRST_NAME, CONCAT(TO_CHAR(SALARY, 'FM99,999'), ' AZN') AS MAAS, TO_CHAR(SALARY * 12, 'FM999,999.00') AS ILLIK_MAAS
FROM HR.EMPLOYEES
ORDER BY SALARY DESC;
-- ORDER BY MAAS DESC sehv olacaq çünkü biz burada string olaraq yazmışıq ve burada 24000 azn tamamile stringdir yeni düzgün sıralama olmayacaq.

-- TASK 3
SELECT FIRST_NAME, TO_CHAR(HIRE_DATE, 'DD-MM-YYYY') AS ISE_GIRIS, EXTRACT(YEAR FROM HIRE_DATE) AS IL, TO_CHAR(HIRE_DATE, 'FMMonth') AS AY_ADI, TO_CHAR(HIRE_DATE, 'FMDay') AS HEFTE_GUNU
FROM HR.EMPLOYEES
ORDER BY HIRE_DATE ASC;

-- TASK 4
SELECT CONCAT(FIRST_NAME, ' ' ,LAST_NAME) AS ISCI, TO_CHAR(HIRE_DATE, 'FMDD FMMonth YYYY') AS ISE_GIRIS, TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12) || ' il ' || MOD(TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)), 12) || ' ay '  AS STAJ
FROM HR.EMPLOYEES
ORDER BY SYSDATE - HIRE_DATE DESC;

-- TASK 5
SELECT FIRST_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE, 3) AS SINAQ_BITIR, LAST_DAY(HIRE_DATE) AS ILK_MAAS_GUNU, LAST_DAY(HIRE_DATE) - HIRE_DATE AS MAASA_QALAN_GUN
FROM HR.EMPLOYEES;

SELECT TO_CHAR(ADD_MONTHS(TO_DATE('28.02.2025', 'DD.MM.YYYY'), 3),'DD.MM.YYYY')
FROM DUAL;
-- 28.02 fevral ayının son günüdü deye 3 ay elave edende may ayının son gününe denk gelir

-- TASK 6
SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME) || ', komissiya: ' || CASE 
                                                                WHEN NVL(COMMISSION_PCT, 0) = 0 THEN 'yoxdur'
                                                                ELSE TO_CHAR(COMMISSION_PCT, 'FM0.00')
                                                                END AS MELUMAT
FROM HR.EMPLOYEES
WHERE TO_CHAR(HIRE_DATE, 'MM') = '03';

-- 1. sehv nvl'de commission_pct string vermediyi üçün yanına string yazabilmerik
-- 2. WHERE'DE mm = 03 olmalı idi
-- 3. 

-- TASK 7
SELECT TO_CHAR(HIRE_DATE, 'MM') AS AY_NO, TO_CHAR(HIRE_DATE, 'FMMonth') AS AY, COUNT(*) AS ISCI_SAYI
FROM HR.EMPLOYEES
GROUP BY AY_NO, AY
ORDER BY AY_NO ASC;
-- order by'ı ay ile yazsaq ingilis dilindeki herflere göre 'september've s olarak sıralanacaqdı

-- TASK 8
SELECT EMPLOYEE_ID, LOWER(SUBSTR(FIRST_NAME, 1, 1)) || LOWER(LAST_NAME) || LPAD(TO_CHAR(EMPLOYEE_ID), 4, '0') AS LOGIN, REPLACE(PHONE_NUMBER, '.', '-') AS TELEFON
FROM HR.EMPLOYEES
WHERE LENGTH(LAST_NAME) >= 7
ORDER BY LOGIN;

-- TASK 9
SELECT EXTRACT(YEAR FROM HIRE_DATE) AS IL, COUNT(*) AS ISCI_SAYI, TO_CHAR(MIN(HIRE_DATE), 'DD.MM.YYYY') AS ILK_TARIX, TO_CHAR(MAX(HIRE_DATE), 'DD.MM.YYYY') AS SON_TARIX, TO_CHAR(AVG(SALARY), 'FM999,990.00') AS ORTA_MAAS
FROM HR.EMPLOYEES
GROUP BY IL
ORDER BY IL ASC;
-- minimumu stringe göre alar ve sehv sıralayar

-- TASK 10 A
SELECT FIRST_NAME, TO_CHAR(HIRE_DATE, 'FMDy, DD.MM.YYYY') AS ISE_GIRIS, CASE
                                                                            WHEN TO_CHAR(HIRE_DATE, 'FMDAY') IN ('SATURDAY', 'SUNDAY') THEN 'Hefte sonu'
                                                                            ELSE 'Is gunu'
                                                                        END AS GUN_NOVU
FROM HR.EMPLOYEES;
-- TO_CHAR(HIRE_DATE, 'DAY') = 'SATURDAY' yazsaq day olaraq aldığımız üçün oracle avtomatik maximum boşluqu alacaq ve saturday'in yanınd boşluq olacak
-- buna göre de eger day istifade edirikse trim istifade etmeliyik ya da fmday yazabilerik

-- TASK 10 B
SELECT TO_CHAR(HIRE_DATE, 'FMDay') AS GUN, COUNT(*) AS ISCI_SAYI
FROM HR.EMPLOYEES
GROUP BY GUN
ORDER BY ISCI_SAYI DESC;
