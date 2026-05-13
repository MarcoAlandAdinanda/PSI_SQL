-- CREATE TABLES

CREATE TABLE VENDOR (
    VENDOR_ID   VARCHAR(10)  PRIMARY KEY,
    V_NAME      VARCHAR(50),
    V_STREET    VARCHAR(50),
    V_CITY      VARCHAR(50),
    V_STATE     CHAR(2),
    V_ZIP       VARCHAR(10)
);

CREATE TABLE PURCHASE_ORDER (
    PO_NUMBER    INTEGER      PRIMARY KEY,
    RELEASE_DATE DATE,
    PO_STATUS    VARCHAR(10),
    PO_AMT       DECIMAL(10,2),
    VENDOR_ID    VARCHAR(10)  REFERENCES VENDOR(VENDOR_ID)
);

CREATE TABLE PO_DETAIL (
    PO_NUMBER        INTEGER,
    PO_LINE_IT       INTEGER,
    MATERIAL_ID      VARCHAR(10),
    UNITS            VARCHAR(5),
    QUANTITY         DECIMAL(10,1),
    BALANCE          DECIMAL(10,1),
    PROMISED_DEL_DATE DATE,
    UNIT_COST        DECIMAL(10,2),
    STATUS           VARCHAR(10),
    PRIMARY KEY (PO_NUMBER, PO_LINE_IT),
    FOREIGN KEY (PO_NUMBER) REFERENCES PURCHASE_ORDER(PO_NUMBER)
);


-- INSERT VENDOR RECORDS

INSERT INTO VENDOR VALUES ('V110', 'Jersey Vegetable Co.', '2 Main St.',     'Patterson',    'NJ', '07055');
INSERT INTO VENDOR VALUES ('V25',  'General Provisions',   '125 Common St.', 'Boise',        'ID', '44830');
INSERT INTO VENDOR VALUES ('V250', 'Spices Unlimited',     '25 Salty Lane',  'East Hampton', 'NY', '10027');
INSERT INTO VENDOR VALUES ('V75',  'Pasta Supply, Inc.',   '34 Henry St.',   'Philadelphia', 'PA', '09098');


-- INSERT PURCHASE_ORDER RECORDS

INSERT INTO PURCHASE_ORDER VALUES (2591, '2006-02-10', 'CLOSED', 4300.00, 'V110');
INSERT INTO PURCHASE_ORDER VALUES (2592, '2006-02-10', 'OPEN',    505.50, 'V25');
INSERT INTO PURCHASE_ORDER VALUES (2593, '2006-02-11', 'OPEN',   4000.00, 'V110');
INSERT INTO PURCHASE_ORDER VALUES (2594, '2006-02-12', 'OPEN',   3280.00, 'V250');
INSERT INTO PURCHASE_ORDER VALUES (2595, '2006-02-15', 'OPEN',    500.00, 'V250');
INSERT INTO PURCHASE_ORDER VALUES (2596, NULL,         'HOLD',   1000.00, 'V75');


-- INSERT PO_DETAIL RECORDS

INSERT INTO PO_DETAIL VALUES (2591, 1, 'RM201', 'LB',  1000.0,    0, '2006-02-20', 2.00, 'CLOSED');
INSERT INTO PO_DETAIL VALUES (2591, 2, 'RM202', 'LB',  1000.0,    0, '2006-02-20', 2.00, 'CLOSED');
INSERT INTO PO_DETAIL VALUES (2591, 3, 'RM205', 'LB',   300.0,    0, '2006-02-20', 1.00, 'CLOSED');
INSERT INTO PO_DETAIL VALUES (2592, 1, 'RM805', 'GAL',  800.5,    0, '2006-02-25', 0.50, 'CLOSED');
INSERT INTO PO_DETAIL VALUES (2592, 2, 'RM810', 'GAL',  210.5,  210, '2006-03-10', 0.50, 'OPEN');
INSERT INTO PO_DETAIL VALUES (2594, 1, 'RM310', 'LB',  4000.0, 4000, '2006-03-12', 0.50, 'OPEN');
INSERT INTO PO_DETAIL VALUES (2594, 2, 'RM311', 'LB',  2000.0, 2000, '2006-03-12', 0.25, 'OPEN');
INSERT INTO PO_DETAIL VALUES (2594, 3, 'RM318', 'LB',  2000.0, 2000, '2006-03-12', 0.25, 'OPEN');
INSERT INTO PO_DETAIL VALUES (2594, 4, 'RM340', 'LB',   560.0,  560, '2006-03-20', 0.50, 'OPEN');
INSERT INTO PO_DETAIL VALUES (2593, 1, 'RM210', 'LB',  1000.0,  500, '2006-02-25', 2.00, 'OPEN');
INSERT INTO PO_DETAIL VALUES (2593, 2, 'RM211', 'LB',  2000.0, 2000, '2006-03-10', 1.00, 'OPEN');
INSERT INTO PO_DETAIL VALUES (2595, 1, 'RM305', 'LB',   400.0,  400, '2006-02-27', 0.50, 'OPEN');
INSERT INTO PO_DETAIL VALUES (2595, 2, 'RM308', 'LB',  1200.0, 1200, '2006-02-27', 0.25, 'OPEN');
INSERT INTO PO_DETAIL VALUES (2596, 1, 'RM502', 'LB',  5000.0, 5000, NULL,         0.20, 'OPEN');

------------------------------

SELECT * FROM PO_DETAIL;
SELECT * FROM PURCHASE_ORDER;
SELECT * FROM VENDOR;

-- Q1. Write a query to display PO_NUMBER, PO_STATUS, and PO_AMT from PURCHASE_ORDER, sorted by PO_AMT from highest to lowest.
SELECT PO_NUMBER, PO_STATUS, PO_AMT 
FROM PURCHASE_ORDER 
ORDER BY PO_AMT DESC;

-- Q2. Write a query to show all unique VENDOR_ID values that appear in the PURCHASE_ORDER table.
SELECT DISTINCT VENDOR_ID
FROM PURCHASE_ORDER;

-- Q3. Write a query to display all columns from PURCHASE_ORDER where the status is 'OPEN' and the amount is greater than $1,000.
SELECT *
FROM PURCHASE_ORDER
WHERE PO_STATUS = 'OPEN'
AND PO_AMT > 1000;

-- Q4. Write a query to find all purchase orders where RELEASE_DATE has no value (is empty/missing).
SELECT *
FROM PURCHASE_ORDER
WHERE RELEASE_DATE IS NULL;

-- Q5. Write a query to display VENDOR_ID, PO_NUMBER, PO_STATUS, and PO_AMT from PURCHASE_ORDER, sorted first by VENDOR_ID ascending, then by PO_AMT descending.
SELECT VENDOR_ID, PO_NUMBER, PO_STATUS, PO_AMT
FROM PURCHASE_ORDER
ORDER BY VENDOR_ID ASC, PO_AMT DESC;

-- Q6. Write a query to find all vendors whose V_NAME starts with the word "General". Use a case-sensitive search.
SELECT *
FROM VENDOR
WHERE V_NAME LIKE 'General%';

-- Q7. Write a query to get the average PO_AMT of all purchase orders with status 'OPEN'.
SELECT AVG(PO_AMT)
FROM PURCHASE_ORDER
WHERE PO_STATUS = 'OPEN';

-- Q8. Write a query to show PO_NUMBER and PO_AMT from PURCHASE_ORDER where PO_AMT is between $500 and $4,000 (inclusive).
SELECT PO_NUMBER, PO_AMT
FROM PURCHASE_ORDER
WHERE PO_AMT BETWEEN 500 AND 4000;

-- Q9. Write a query to display all columns from PURCHASE_ORDER where the status is NOT 'OPEN'.
SELECT *
FROM PURCHASE_ORDER
WHERE NOT PO_STATUS = 'OPEN';

SELECT *
FROM PURCHASE_ORDER
WHERE PO_STATUS != 'OPEN';

-- Q10. Write a query to find the minimum, maximum, and total sum of PO_AMT for all 'OPEN' purchase orders.
SELECT MIN(PO_AMT), MAX(PO_AMT), SUM(PO_AMT)
FROM PURCHASE_ORDER
WHERE PO_STATUS = 'OPEN';

-- Q11. Write a query to show PO_NUMBER, along with the minimum and maximum QUANTITY for each PO, using data from PO_DETAIL. Group the results by PO_NUMBER.
SELECT PO_NUMBER, MIN(QUANTITY), MAX(QUANTITY)
FROM PO_DETAIL
GROUP BY PO_NUMBER;

-- Q12. Write a query to display all columns from PURCHASE_ORDER where PO_STATUS is 'OPEN' AND the VENDOR_ID is greater than 'V150' AND PO_AMT is greater than $500. Sort the results by PO_AMT ascending.
SELECT *
FROM PURCHASE_ORDER
WHERE PO_STATUS = 'OPEN'
	AND VENDOR_ID > 'V150'
	AND PO_AMT > 500
ORDER BY PO_AMT ASC;

-- Q13. Write a query to show PO_NUMBER and PO_AMT from PURCHASE_ORDER where the PO_AMT is above the average PO_AMT of all orders in the table. Use a subquery.
SELECT PO_NUMBER, PO_AMT
FROM PURCHASE_ORDER
WHERE PO_AMT > (SELECT AVG(PO_AMT) FROM PURCHASE_ORDER);

-- Q14. Write a query to get the average PO_AMT labeled as AVG_AMT and the minimum PO_AMT labeled as MIN_AMT from all purchase orders with status 'OPEN'.
SELECT AVG(PO_AMT) AS AVG_AMT, MIN(PO_AMT) AS MIN_AMT
FROM PURCHASE_ORDER
WHERE PO_STATUS = 'OPEN';

-- Q15. Write a query to display all records from PO_DETAIL where the STATUS is 'OPEN' and BALANCE is greater than 1000.
SELECT *
FROM PO_DETAIL
WHERE STATUS = 'OPEN'
	AND BALANCE > 1000;

-- Q16. Write a query to find all vendors where the V_NAME contains the word "Supply" anywhere in the name. Use a case-insensitive search.
SELECT *
FROM VENDOR
WHERE V_NAME ILIKE '%Supply%';

-- Q17. Write a query to update the PROMISED_DEL_DATE of all rows in PO_DETAIL where PO_NUMBER = 2594 to '2006-03-25'.
UPDATE PO_DETAIL
SET PROMISED_DEL_DATE = '2006-03-25'
WHERE PO_NUMBER = 2594;

-- Q18. Write a query to show VENDOR_ID, PO_NUMBER, and PO_AMT from PURCHASE_ORDER where either the VENDOR_ID is 'V110' or the PO_STATUS is 'OPEN'.
SELECT VENDOR_ID, PO_NUMBER, PO_AMT
FROM PURCHASE_ORDER
WHERE VENDOR_ID = 'V110' OR PO_STATUS = 'OPEN';

-- Q19. Write a query to display all records from PURCHASE_ORDER where the RELEASE_DATE is between '2006-02-10' and '2006-02-12' and PO_AMT is greater than $1,000.
SELECT *
FROM PURCHASE_ORDER
WHERE (RELEASE_DATE BETWEEN '2006-02-10' AND '2006-02-12') 
	AND PO_AMT > 1000;

-- Q20. Write a query to count how many line items exist per PO_NUMBER in PO_DETAIL, and display the result with the column labeled TOTAL_LINES. Show only POs that have more than 2 line items.
SELECT PO_NUMBER, COUNT(*) AS TOTAL_LINES
FROM PO_DETAIL
GROUP BY PO_NUMBER
HAVING COUNT(*) > 2;

SELECT * FROM PO_DETAIL;