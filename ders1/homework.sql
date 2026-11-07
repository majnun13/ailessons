-- Task 1. Maaş artımı
SELECT FIRST_NAME, LAST_NAME, SALARY, SALARY * 1.1 AS YENI_MAAS FROM HR.EMPLOYEES;

-- Task 2. Ofis olan ölkələr
SELECT DISTINCT COUNTRY_ID FROM HR.LOCATIONS;

-- Task 3. İki şöbə, iki fərqli şərt
SELECT FIRST_NAME, DEPARTMENT_ID, SALARY FROM HR.EMPLOYEES WHERE (DEPARTMENT_ID = 50 AND SALARY < 3000) OR (DEPARTMENT_ID = 80 AND SALARY > 10000);

-- Task 4. Başlanğıc maaş aralığı
SELECT JOB_TITLE, MIN_SALARY FROM HR.JOBS WHERE MIN_SALARY BETWEEN 4000 AND 6000;

-- Task 5. Seçilmiş ölkələrdəki ofislər
SELECT CITY, COUNTRY_ID FROM HR.LOCATIONS WHERE COUNTRY_ID IN('US', 'GB', 'CA'); 

-- Task 6. Ad axtarışı
SELECT FIRST_NAME, LAST_NAME FROM HR.EMPLOYEES WHERE FIRST_NAME LIKE 'S____' AND LAST_NAME LIKE '%a%';

-- Task 7. Rəhbəri olmayan şöbələr
SELECT DEPARTMENT_NAME FROM HR.DEPARTMENTS WHERE MANAGER_ID IS NULL;

-- Task 8. Maaş fərqi ən böyük olan vəzifələr
SELECT JOB_TITLE, (MAX_SALARY - MIN_SALARY) AS MAAS_FERQI FROM HR.JOBS ORDER BY MAAS_FERQI DESC FETCH FIRST 3 ROW ONLY;

-- Task 9. 80-ci şöbənin hesabatı
SELECT COUNT(EMPLOYEE_ID) AS iscilerin_sayi , COUNT(COMMISSION_PCT) AS komissiya_alanlar, ROUND(AVG(SALARY), 2) AS orta_maas, (MAX(SALARY) - MIN(SALARY)) AS ferq FROM HR.EMPLOYEES WHERE DEPARTMENT_ID = 80;

-- Task 10. Səhvləri tapın
SELECT FIRST_NAME AS AD, SALARY
FROM HR.EMPLOYEES
WHERE FIRST_NAME LIKE 'A%'
  AND COMMISSION_PCT IS NULL;

-- 10. task'da olan sehvler: 
-- 1. Where'den sonra AD gelebilmez çünkü o alias'dır ancaq first_name olmalıdır.
-- 2. Olarak LIKE'dan sonra gelen A% ifadesi tek dırnaqlar arasında olmalıdır çünki tek dırnaq arasında olanda string olaraq başa düşülür.
-- 3. olaraq ise COMMISSION_PCT = NULL ifadesi yanlışdır düzgün ifade COMMISSION_PCT IS NULL olmalıdır. 

-- QEYD : TASK 5'de UK yerine GB istifade olunmuşdur çünki oracle'da uk deyil gb olaraq yazılır böyük britaniya.
