====================================================================
-- HR SXEMİ ÜZRƏ SQL TAPŞIRIQLARI VƏ DOĞRU HƏLLƏRİ (06.11.2026)
-- ====================================================================

-- Task 1. Komissiya faizi NULL olanlar üçün 0 yazılması
SELECT 
    FIRST_NAME, 
    LAST_NAME, 
    SALARY, 
    COMMISSION_PCT,
    NVL(COMMISSION_PCT, 0) AS DUZELDILMIS_KOMISSIYA
FROM 
    HR.EMPLOYEES;

-- Task 2. Soyadı böyük-kiçik fərqi olmadan 'KING' olanların tapılması
SELECT 
    FIRST_NAME, 
    LAST_NAME, 
    SALARY
FROM 
    HR.EMPLOYEES
WHERE 
    UPPER(LAST_NAME) = 'KING';

-- Task 3. 1 Yanvar 2006-cı ildən sonra işə qəbul olanlar
SELECT 
    FIRST_NAME, 
    LAST_NAME, 
    HIRE_DATE
FROM 
    HR.EMPLOYEES
WHERE 
    HIRE_DATE > DATE '2006-01-01';

-- Task 4. Şirkətdə işlənilən ay sayının tapılması (Staj)
SELECT 
    FIRST_NAME, 
    LAST_NAME,
    ROUND(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) AS STAZ_AY
FROM 
    HR.EMPLOYEES;

-- Task 5. Telefon nömrəsi '515' ilə başlayan işçilər
SELECT 
    FIRST_NAME, 
    LAST_NAME, 
    PHONE_NUMBER
FROM 
    HR.EMPLOYEES
WHERE 
    PHONE_NUMBER LIKE '515%';

-- Task 6. Minimum maaşı 3000-dən aşağı vəzifələrin azalan sıra ilə düzülməsi
SELECT 
    JOB_TITLE, 
    MIN_SALARY
FROM 
    HR.JOBS
WHERE 
    MIN_SALARY < 3000
ORDER BY 
    MIN_SALARY DESC;

-- Task 7. Poçt kodu (POSTAL_CODE) daxil edilməyən ofislər
SELECT 
    CITY, 
    STREET_ADDRESS
FROM 
    HR.LOCATIONS
WHERE 
    POSTAL_CODE IS NULL;

-- Task 8. Tarix Formatı Xətasının Düzəldilməsi (2008-ci ilin Yanvar ayı)
SELECT 
    FIRST_NAME, 
    HIRE_DATE
FROM 
    HR.EMPLOYEES
WHERE 
    TO_CHAR(HIRE_DATE, 'MM-YYYY') = '01-2008';

-- Task 9. Komissiya faizi 0.15-dən böyük və ya bərabər olanlar
SELECT 
    FIRST_NAME, 
    LAST_NAME, 
    COMMISSION_PCT
FROM 
    HR.EMPLOYEES
WHERE 
    COMMISSION_PCT >= 0.15;

-- Task 10. Ən yüksək maksimum maaşı olan ilk 3 vəzifə
SELECT 
    JOB_TITLE, 
    MAX_SALARY
FROM 
    HR.JOBS
ORDER BY 
    MAX_SALARY DESC
FETCH FIRST 3 ROWS ONLY;

-- Task 11. 80-ci şöbə üçün xüsusi bonus hesablanması
SELECT 
    FIRST_NAME, 
    SALARY, 
    (SALARY * 0.10) + (SALARY * NVL(COMMISSION_PCT, 0)) AS BONUS
FROM 
    HR.EMPLOYEES
WHERE 
    DEPARTMENT_ID = 80;

-- Task 12. 2004-cü ildən sonra və məhz İyun (6-cı ay) ayında işə girənlər
SELECT 
    FIRST_NAME, 
    LAST_NAME, 
    HIRE_DATE
FROM 
    HR.EMPLOYEES
WHERE 
    EXTRACT(YEAR FROM HIRE_DATE) > 2004
    AND EXTRACT(MONTH FROM HIRE_DATE) = 6;

-- Task 13. 50-ci şöbənin maaş göstəriciləri (Tək sətirdə)
SELECT 
    MIN(SALARY) AS EN_ASAGI_MAAS,
    MAX(SALARY) AS EN_YUKSEK_MAAS,
    ROUND(AVG(SALARY)) AS ORTA_MAAS
FROM 
    HR.EMPLOYEES
WHERE 
    DEPARTMENT_ID = 50;

-- Task 14. İllik Bruto, 15% Vergi və Net Maaş hesablanması
SELECT 
    ROUND(SALARY * 12, 2) AS ILLIK_BRUTO,
    ROUND((SALARY * 12) * 0.15, 2) AS ILLIK_VERGI,
    ROUND((SALARY * 12) * 0.85, 2) AS ILLIK_NET
FROM 
    HR.EMPLOYEES;

-- Task 15. Ayın 15-dən sonra işə girən və maaşı 5000-12000 arası olanlar
SELECT 
    FIRST_NAME, 
    LAST_NAME, 
    EXTRACT(DAY FROM HIRE_DATE) AS ISE_GIRME_GUNU
FROM 
    HR.EMPLOYEES 
WHERE
    EXTRACT(DAY FROM HIRE_DATE) > 15
    AND SALARY BETWEEN 5000 AND 12000;

-- Task 16. Həm rəhbəri, həm şöbəsi olan ən yüksək maaşlı ilk 3 işçi
SELECT 
    FIRST_NAME,
    SALARY
FROM 
    HR.EMPLOYEES
WHERE  
    MANAGER_ID IS NOT NULL 
    AND DEPARTMENT_ID IS NOT NULL 
ORDER BY 
    SALARY DESC 
FETCH FIRST 3 ROWS ONLY;

-- Task 17. Komissiya almayanların sayı və yuvarlaq orta maaşı
SELECT 
    COUNT(*) AS ISCILERIN_SAYI,
    ROUND(AVG(SALARY)) AS ORTA_MAAS
FROM 
    HR.EMPLOYEES
WHERE
    COMMISSION_PCT IS NULL;
