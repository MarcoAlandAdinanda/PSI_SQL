SELECT * FROM PO_DETAIL;

SELECT PO_NUMBER, PO_STATUS, PO_AMT FROM PURCHASE_ORDER;
-- Untuk ujian pertanyaan bisa dibalik, bisa "disedaikan table purchase order seperti xx maka querynya bagaimana?"

SELECT PO_NUMBER, PO_STATUS, PO_AMT FROM PURCHASE_ORDER ORDER BY PO_AMT;
-- defaultnya ascending: dari kecil ke besar
-- jika descending bisa dibalik menggugnakan DESC

SELECT PO_NUMBER, PO_STATUS, PO_AMT FROM PURCHASE_ORDER ORDER BY PO_AMT DESC;
-- diujian itu dibalik sudah ada outputnya, maka perlu menuliskan query untuk mencapai hal itu
-- atau bisa juga bersifat narasi, sehingga membuat query sesuai perintah

SELECT VENDOR_ID, PO_NUMBER, PO_STATUS, PO_AMT FROM PURCHASE_ORDER ORDER BY VENDOR_ID, PO_AMT;
-- hierarcy dari kiri ke kanan, jika vendor_id, po_amt; maka akan sorting dulu dari yang paling kiri (vendor id)
-- V110 vs V25, maka jika ascending yang duluan itu V110 karenan melihat 1 dari paling kiri (meskipun V25 lebih kecil).

SELECT VENDOR_ID, PO_NUMBER, PO_STATUS, PO_AMT FROM PURCHASE_ORDER ORDER BY VENDOR_ID, PO_AMT DESC;
-- Jika begini maka vendor_id itu ascending, sedangakn po_amt itu descnding

SELECT VENDOR_ID, PO_NUMBER, PO_STATUS, PO_AMT 
FROM PURCHASE_ORDER 
ORDER BY VENDOR_ID DESC, PO_AMT DESC;
-- Tulis keterangan order by setelah nama atribut ditulis.

SELECT DISTINCT VENDOR_ID FROM PURCHASE_ORDER;
-- DISTINC itu untuk menampilkan unique values dari kolom tersebut.
-- Vendor ID itu foreign key sehingga akan ada duplikasi (mengambil info dari tabel lain)

SELECT VENDOR_ID, PO_AMT
FROM PURCHASE_ORDER
WHERE VENDOR_ID='V110';
-- WHERE digunakan untuk menjadi constraint supaya bisa menentukan hal yang ingin dicari

-- SELECT * FROM PURCHASE_ORDER WHERE VENDOR_ID = 'V110' OR PO_STATUS = 'OPEN';

SELECT VENDOR_ID, PO_NUMBER, PO_AMT
FROM PURCHASE_order
WHERE PO_AMT > 1000 -- AND VENDOR_ID = 'V250'
ORDER BY PO_AMT DESC;
-- karena numeric maka bisa menggunakan statement lebih dan kurang

SELECT *
FROM PURCHASE_ORDER
WHERE PO_STATUS = 'OPEN' AND PO_AMT > 500;
-- Bisa menggunakan logical statement AND, OR, NOT

SELECT *
FROM PURCHASE_ORDER
WHERE PO_STATUS = 'OPEN' AND PO_AMT > 500 AND PO_NUMBER = 2593;
-- bisa juga AND ditumpuk

SELECT *
FROM PURCHASE_ORDER
WHERE NOT PO_STATUS = 'OPEN';
-- Ms access tidak bisa != sehingga harus pakai NOT

SELECT *
FROM PURCHASE_ORDER
WHERE PO_STATUS != 'OPEN';
-- karena ini postgre maka bisa menggunakan !=

SELECT *
FROM PURCHASE_ORDER
WHERE PO_STATUS = 'OPEN'
AND (VENDOR_ID > 'V150' AND PO_AMT > 500)
ORDER BY PO_AMT;
-- bisa juga compound statement.
-- compound itu dikerjakan dulu dari kurung paling kiri

SELECT *
FROM PURCHASE_ORDER
WHERE ((PO_AMT BETWEEN 505 AND 4000) 
AND (RELEASE_DATE BETWEEN '2006-02-11' AND '2006-02-13'));
-- BETWEEN bisa untuk diantara
-- BETWEEN harus dari kecil ke besar, jika dibalik akan error.
-- Pelajari aturan DATE dalam SQL

SELECT * 
FROM VENDOR
WHERE V_NAME LIKE 'Spice%';
-- LIKE itu case sensitive
-- Gunakan % sebagai wildcard
-- Jika mau cari kiri sama berarti % dikanan
-- Jika mau cari kanan sama berarti % dikiri
-- Jika mau tengahnya ada berarti % di kiri kanan

SELECT * 
FROM VENDOR
WHERE V_NAME ILIKE 'spice%';
-- ILIKE itu non case sensitive

SELECT *
FROM PURCHASE_ORDER
WHERE RELEASE_DATE IS NULL;
-- NULL itu dicari menggunakan IS, jika = maka tidak akan muncul karena memang ga ada nilainya.

SELECT * FROM PO_DETAIL WHERE PO_NUMBER = 2594;
-- Sebelumnya 2006-03-12 dan ada 1 yang 2006-03-20

UPDATE PO_DETAIL
SET PROMISED_DEL_DATE = '2006-03-22'
WHERE PO_NUMBER=2594;
-- Update itu untuk mengubah record (row), ALTER untuk mengubah atribut (column)

SELECT AVG(PO_AMT)
FROM PURCHASE_ORDER
WHERE PO_STATUS = 'OPEN';
-- Ini untuk memperoleh yang sudah di agregatkan (mengugnakan average)

SELECT * FROM PURCHASE_ORDER;


SELECT AVG(PO_AMT) , AVG(PO_NUMBER)
FROM PURCHASE_ORDER
WHERE PO_STATUS = 'OPEN';
-- Harus dipisah meskipun tujuan sama

SELECT MIN(PO_AMT) AS MIN_AMT
FROM PURCHASE_ORDER;
-- AS digunakan untuk alias (assign variable)
-- Nama column menjadi berubah

SELECT MIN(PO_AMT), MAX(PO_AMT), SUM(PO_AMT)
FROM PURCHASE_ORDER
WHERE PO_STATUS='OPEN';

SELECT PO_NUMBER, MIN(QUANTITY), MAX(QUANTITY)
FROM PO_DETAIL
GROUP BY PO_NUMBER;
-- Bisa juga diagregatkan berdasarkan suatu group (column)
-- Bisa untuk mengetahui min max quantity per po_numbernya.

-- SELECT AVG(PO_AMT) FROM PURCHASE_ORDER;

SELECT PO_NUMBER, PO_AMT
FROM PURCHASE_ORDER
WHERE PO_AMT > (SELECT AVG(PO_AMT) FROM PURCHASE_ORDER);
-- Sub-query, itu bisa query berjenjang.
-- Query terakhir yang ditampilkan
-- Query ini itu untuk mencari PO_NUMBER dan PO_AMT yang PO_AMT nya lebih besar dari rata rata
-- Rata rata nya gaperlu ditampilin bisa langsung di assign aja ke query utama

