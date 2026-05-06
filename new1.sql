-- ============================================================
-- Nama  : Marco Aland Adinanda
-- NIM   : 23/514817/TK/56524
-- Kelas : PSI Kelas A
-- Tanggal: 29 April 2026
-- ============================================================

-- ============================================================
-- CATATAN UMUM
-- Seluruh tabel dibuat di dalam public schema (schema default
-- PostgreSQL), tanpa pembuatan schema tambahan.
-- ============================================================


-- ------------------------------------------------------------
-- BAGIAN 1: PEMBUATAN TABEL PURCHASE_ORDER
-- ------------------------------------------------------------

-- Tabel dibuat terlebih dahulu hanya dengan kolom PO_NUMBER
-- karena nama awal mengandung typo ("ORDED"), lalu di-rename.
CREATE TABLE PURCHASE_ORDED (
	PO_NUMBER SMALLINT
);

-- Memperbaiki typo nama tabel dari PURCHASE_ORDED menjadi PURCHASE_ORDER.
ALTER TABLE PURCHASE_ORDED RENAME TO PURCHASE_ORDER;

-- Menambahkan kolom-kolom yang tersisa ke tabel PURCHASE_ORDER
-- setelah rename berhasil.
ALTER TABLE PURCHASE_ORDER
	ADD COLUMN RELEASE_DATE DATE,
	ADD COLUMN PO_STATUS CHAR(6),
	ADD COLUMN PO_AMT FLOAT,
	ADD COLUMN VENDOR_ID CHAR(5);

-- Menetapkan PO_NUMBER sebagai PRIMARY KEY.
-- Informasi constraint ini akan tercatat di menu Constraints pada pgAdmin.
ALTER TABLE PURCHASE_ORDER ADD PRIMARY KEY (PO_NUMBER);

SELECT * FROM PURCHASE_ORDER;


-- ------------------------------------------------------------
-- BAGIAN 2: PEMBUATAN TABEL VENDOR
-- ------------------------------------------------------------

-- Tabel VENDOR menyimpan data pemasok/vendor.
-- VENDOR_ID ditetapkan sebagai PRIMARY KEY langsung saat definisi tabel.
CREATE TABLE VENDOR (
	VENDOR_ID CHAR(5) PRIMARY KEY,
	V_NAME VARCHAR(20),
	V_STREET VARCHAR(20),
	V_CITY VARCHAR(20),
	V_STATE CHAR(3),
	V_ZIP VARCHAR(5)
);

-- Catatan: ALTER berikut (dinonaktifkan) adalah percobaan mengubah tipe
-- V_ZIP menjadi SMALLINT, namun tidak jadi karena ZIP code bisa diawali 0.
-- ALTER TABLE VENDOR ALTER COLUMN V_ZIP TYPE SMALLINT;

SELECT * FROM VENDOR;


-- ------------------------------------------------------------
-- BAGIAN 3: INSERT DATA KE TABEL PURCHASE_ORDER
-- ------------------------------------------------------------

-- Memasukkan satu baris awal sebagai data percobaan awal.
INSERT INTO PURCHASE_ORDER (PO_NUMBER, RELEASE_DATE, PO_STATUS, PO_AMT, VENDOR_ID)
	VALUES (2591, '02/10/06', 'CLOSED', 4300, 'V110');

SELECT * FROM PURCHASE_ORDER;

-- Catatan: Baris berikut (dinonaktifkan) adalah demo pelanggaran PRIMARY KEY —
-- memasukkan PO_NUMBER 2591 yang sudah ada akan menyebabkan error duplikat.
-- INSERT INTO PURCHASE_ORDER (PO_NUMBER, RELEASE_DATE, PO_STATUS, PO_AMT, VENDOR_ID)
-- 	VALUES (2591, '02/10/06', 'OPEN', 550.5, 'V110');

-- Memasukkan sisa data purchase order secara batch.
-- PO_NUMBER 2596 sengaja memiliki RELEASE_DATE NULL karena tanggal belum ditentukan.
INSERT INTO PURCHASE_ORDER (PO_NUMBER, RELEASE_DATE, PO_STATUS, PO_AMT, VENDOR_ID) VALUES 
	(2592, '02/10/06', 'OPEN',  550.5, 'V25'),
	(2593, '02/11/06', 'OPEN', 4000,   'V110'),
	(2594, '02/12/06', 'OPEN', 3280,   'V250'),
	(2595, '02/15/06', 'OPEN',  500,   'V250'),
	(2596, NULL,       'HOLD', 1000,   'V75');

-- Catatan: Baris berikut (dinonaktifkan) adalah contoh UPDATE PO_NUMBER,
-- yang tidak umum dilakukan karena PO_NUMBER adalah PRIMARY KEY.
-- UPDATE PURCHASE_ORDER SET PO_NUMBER = 2592 WHERE PO_NUMBER = 2591;


-- ------------------------------------------------------------
-- BAGIAN 4: PEMBUATAN TABEL PO_DETAIL
-- ------------------------------------------------------------

-- Tabel PO_DETAIL menyimpan rincian item per purchase order.
-- Kolom UNIT_COST bertipe FLOAT sebagai representasi data bertipe MONEY.
CREATE TABLE PO_DETAIL (
	PO_NUMBER        SMALLINT,
	PO_LINE_IT       SMALLINT,
	MATERIAL_ID      CHAR(10),
	UNITS            CHAR(4),
	QUANTITY         FLOAT,
	BALANCE          FLOAT,
	PROMISED_DEL_DATE DATE,
	UNIT_COST        FLOAT, -- Representasi tipe data MONEY
	STATUS           CHAR(6)
);

-- Memasukkan data detail untuk setiap purchase order.
-- BALANCE menunjukkan sisa kuantitas yang belum diterima.
-- PROMISED_DEL_DATE NULL pada baris terakhir berarti tanggal pengiriman belum dijanjikan.
INSERT INTO PO_DETAIL (
    PO_NUMBER, 
    PO_LINE_IT, 
    MATERIAL_ID, 
    UNITS, 
    QUANTITY, 
    BALANCE, 
    PROMISED_DEL_DATE, 
    UNIT_COST, 
    STATUS
) 
VALUES 
    (2591, 1, 'RM201', 'LB',   1000.0,    0, '2006-02-20', 2.00, 'CLOSED'),
    (2591, 2, 'RM202', 'LB',   1000.0,    0, '2006-02-20', 2.00, 'CLOSED'),
    (2591, 3, 'RM205', 'LB',    300.0,    0, '2006-02-20', 1.00, 'CLOSED'),
    (2592, 1, 'RM805', 'GAL',   800.5,    0, '2006-02-25', 0.50, 'CLOSED'),
    (2592, 2, 'RM810', 'GAL',   210.5,  210, '2006-03-10', 0.50, 'OPEN'),
    (2594, 1, 'RM310', 'LB',   4000.0, 4000, '2006-03-12', 0.50, 'OPEN'),
    (2594, 2, 'RM311', 'LB',   2000.0, 2000, '2006-03-12', 0.25, 'OPEN'),
    (2594, 3, 'RM318', 'LB',   2000.0, 2000, '2006-03-12', 0.25, 'OPEN'),
    (2594, 4, 'RM340', 'LB',    560.0,  560, '2006-03-20', 0.50, 'OPEN'),
    (2593, 1, 'RM210', 'LB',   1000.0,  500, '2006-02-25', 2.00, 'OPEN'),
    (2593, 2, 'RM211', 'LB',   2000.0, 2000, '2006-03-10', 1.00, 'OPEN'),
    (2595, 1, 'RM305', 'LB',    400.0,  400, '2006-02-27', 0.50, 'OPEN'),
    (2595, 2, 'RM308', 'LB',   1200.0, 1200, '2006-02-27', 0.25, 'OPEN'),
    (2596, 1, 'RM502', 'LB',   5000.0, 5000, NULL,         0.20, 'OPEN');

SELECT * FROM PO_DETAIL;


-- ------------------------------------------------------------
-- BAGIAN 5: INSERT DATA KE TABEL VENDOR & PURCHASE_ORDER (FINAL)
-- ------------------------------------------------------------

-- Mengisi data master vendor yang menjadi referensi di tabel PURCHASE_ORDER.
INSERT INTO VENDOR (VENDOR_ID, V_NAME, V_STREET, V_CITY, V_STATE, V_ZIP)
VALUES 
    ('V110', 'Jersey Vegetable Co.', '2 Main St.',     'Patterson',    'NJ', '07055'),
    ('V25',  'General Provisions',   '125 Common St.', 'Boise',        'ID', '44830'),
    ('V250', 'Spices Unlimited',     '25 Salty Lane',  'East Hampton', 'NY', '10027'),
    ('V75',  'Pasta Supply, Inc.',   '34 Henry St.',   'Philadelphia', 'PA', '09098');

-- Mengisi ulang data PURCHASE_ORDER dengan format tanggal yang konsisten (YYYY-MM-DD)
-- dan nilai PO_AMT yang sudah diperbaiki (misal: 2592 dari 550.5 menjadi 505.50).
INSERT INTO PURCHASE_ORDER (PO_NUMBER, RELEASE_DATE, PO_STATUS, PO_AMT, VENDOR_ID)
VALUES 
    (2591, '2006-02-10', 'CLOSED', 4300.00, 'V110'),
    (2592, '2006-02-10', 'OPEN',    505.50, 'V25'),
    (2593, '2006-02-11', 'OPEN',   4000.00, 'V110'),
    (2594, '2006-02-12', 'OPEN',   3280.00, 'V250'),
    (2595, '2006-02-15', 'OPEN',    500.00, 'V250'),
    (2596, NULL,         'HOLD',   1000.00, 'V75');

SELECT * FROM PURCHASE_ORDER;