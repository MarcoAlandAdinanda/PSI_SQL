-- Belajar mengenai menggabungkan tabel (Joining)

SELECT * FROM PO_DETAIL;
SELECT * FROM PURCHASE_ORDER;
SELECT * FROM VENDOR;

-- Ada 2 syntax untuk join 2 table

-- Bisa dengan memberikan dot dalam select (OOP), FROM menggunakan seluruh table
-- Where itu harus nulis primary key dan foreign key

SELECT PURCHASE_ORDER.VENDOR_ID, PURCHASE_ORDER.RELEASE_DATE, 
		PURCHASE_ORDER.PO_NUMBER, PO_DETAIL.*
FROM PURCHASE_ORDER, PO_DETAIL
WHERE PURCHASE_ORDER.PO_NUMBER = PO_DETAIL.PO_NUMBER -- Primary Key = Foreign Key
	AND PURCHASE_ORDER.VENDOR_ID = 'V250'; -- Untuk filtering
-- Atribut wajib sama tapi table boleh berbeda
-- Bisa juga referencekan ke atribut yang nilainya sama

SELECT --PURCHASE_ORDER.VENDOR_ID, 
		--PURCHASE_ORDER.PO_NUMBER, 
		SUM(PO_DETAIL.QUANTITY)
FROM PURCHASE_ORDER, PO_DETAIL
WHERE PURCHASE_ORDER.PO_NUMBER = PO_DETAIL.PO_NUMBER -- Primary Key = Foreign Key
	AND PURCHASE_ORDER.VENDOR_ID = 'V110';

SELECT * FROM PO_DETAIL;
-- VENDOR V110 pernah mengorder seberapa banyak


-- Joining 3 table
SELECT VENDOR.V_NAME, VENDOR.VENDOR_ID, PURCHASE_ORDER.RELEASE_DATE, PO_DETAIL.QUANTITY
FROM VENDOR, PURCHASE_ORDER, PO_DETAIL
WHERE VENDOR.VENDOR_ID = PURCHASE_ORDER.VENDOR_ID -- VENDOR_ID sebagai penghubung
	AND PURCHASE_ORDER.PO_NUMBER = PO_DETAIL.PO_NUMBER -- PO_NUMBER sebagai penghubung
	AND VENDOR.VENDOR_ID = 'V250';

-- EXERCISE 1
SELECT * 
FROM PO_DETAIL 
WHERE PO_NUMBER = 2594;

-- EXERCISE 2
SELECT DISTINCT PO_NUMBER 
FROM PURCHASE_ORDER 
WHERE PO_STATUS = 'OPEN';

SELECT * FROM PO_DETAIL;

-- EXERCISE 3
SELECT PO_DETAIL.PO_NUMBER, PO_DETAIL.PO_LINE_IT, 
	PO_DETAIL.MATERIAL_ID, PO_DETAIL.QUANTITY, PO_DETAIL.UNIT_COST,
	(PO_DETAIL.QUANTITY * PO_DETAIL.UNIT_COST) AS TOTAL_COST
FROM PO_DETAIL, PURCHASE_ORDER
WHERE PO_DETAIL.PO_NUMBER = PURCHASE_ORDER.PO_NUMBER 
	AND PURCHASE_ORDER.VENDOR_ID = 'V250';

-- Misal ingin mengubah data type saat query
SELECT PO_DETAIL.PO_NUMBER, PO_DETAIL.PO_LINE_IT, 
	PO_DETAIL.MATERIAL_ID, PO_DETAIL.QUANTITY, PO_DETAIL.UNIT_COST,
	(PO_DETAIL.QUANTITY * PO_DETAIL.UNIT_COST)::numeric(20,2) AS TOTAL_COST -- max 20 digit, decimal 2
FROM PO_DETAIL, PURCHASE_ORDER
WHERE PO_DETAIL.PO_NUMBER = PURCHASE_ORDER.PO_NUMBER 
	AND PURCHASE_ORDER.VENDOR_ID = 'V250';

-- Cara 2 untuk joining
-- Yang pertama disebutkan itu menjadi left, berikutnya right
-- INNER join, jika punya data left dan right yang nilainya sama atau beririsan
-- LEFT join, semua yang ada di table left dan irisannya dimunculkan.
-- Right join, semua yang di table right dan irisannya dimunculkan.

-- Intinya itu mengacu ke atribut penghubung joiningnya
-- INNER itu berarti hanya menampilkan record yang nilai atribut penghubungnya sama
-- LEFT/RIGHT itiu berarti menampilkan record yang atribut penghubugnanya sama dan seluruh record LEFT/RIGHT

SELECT *
FROM PURCHASE_ORDER
RIGHT JOIN PO_DETAIL ON PURCHASE_ORDER.PO_NUMBER = PO_DETAIL.PO_NUMBER;