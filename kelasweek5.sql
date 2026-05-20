-- Kelas week 5

-- QUIZ MARCO
SELECT VENDOR.V_NAME, PURCHASE_ORDER.PO_AMT, PO_DETAIL.PROMISED_DEL_DATE
FROM VENDOR, PURCHASE_ORDER, PO_DETAIL
WHERE VENDOR.VENDOR_ID = PURCHASE_ORDER.VENDOR_ID
	AND PO_DETAIL.PO_NUMBER = PURCHASE_ORDER.PO_NUMBER;

SELECT * FROM PO_DETAIL;
SELECT * FROM PURCHASE_ORDER;
SELECT * FROM VENDOR;

-- Create database baru
CREATE DATABASE SEWA_MOBIL_514817;

CREATE TABLE data_mobil (
    kode_mobil VARCHAR(50) PRIMARY KEY,
    jenis_mobil VARCHAR(50),
    merk_mobil VARCHAR(50),
    tarif_sewa NUMERIC(20,2),
    foto_mobil VARCHAR(50),
    no_kendaraan VARCHAR(50)
);

CREATE TABLE pelanggan (
    kode_pelanggan VARCHAR(50) PRIMARY KEY,
    nama_pelanggan VARCHAR(50),
    kontak VARCHAR(50),
    alamat VARCHAR(50),
    kota VARCHAR(50),
    kode_pos NUMERIC(5,0),
    telepon NUMERIC(10,0)
);

CREATE TABLE sewa_mobil (
    no_faktur VARCHAR(50) PRIMARY KEY,
    kode_pelanggan VARCHAR(50),
    tanggal_pinjam DATE,
    kode_mobil VARCHAR(50),
    lama_pinjam NUMERIC(10,1),
    uang_muka NUMERIC(20,2),
    catatan VARCHAR(50)
);

INSERT INTO pelanggan VALUES
	 ('C-01','PT. ABADI JAYA','Ardi Bone','Jl. Setiabudi 88','BANDUNG',40163,231456),
	 ('C-02','TOKO SEJAHTERA','Bambang','Jl. Cemara Utara 76','BANDUNG',40173,342123),
	 ('C-03','TONI WALUYO','Toni Waluyo','Jl. Surya Sumantri 93','GARUT',41034,574645),
	 ('C-04','CV. TIRTA SANJAYA','Riana','Jl. Merdeka 99','GARUT',40345,344666),
	 ('C-05','PT. FAJAR UTAMA','Handono','Jl. Juanda 34','CIANJUR',40344,565466),
	 ('C-06','TANU WIJAYA','Tanu Wijaya','Jl. Budi Sari Utara 67','CIANJUR',40123,252555),
	 ('C-07','CV. SUMANJAYA','Budi Permana','Jl. Setra Sari 95','SUKABUMI',42046,645762),
	 ('C-08','PT. GERHANA','Jaka Sukma','Jl. Buah Batu 77','GARUT',43025,252455),
	 ('C-09','PT. WIJAYA SUKMA','Kurweni','Jl. Kalimantan 87','SUKABUMI',42873,343244),
	 ('C-10','GRADIYANI','Gradiyan','Jl. Cipedes Tengah 4','BANDUNG',40123,353455),
	 ('C-11','HERI SAPUTRA','Heri Saputra','Jl. Surya Sumantri 93','BANDUNG',40234,342444),
	 ('C-12','RITA CANDRA','Rita Candra','Jl. Sulanjana 97','SUKABUMI',41222,734666),
	 ('C-13','TOKO BINTANG','Yanny','Jl. Hasanudin 32','CIANJUR',43442,767472),
	 ('C-14','WENDY YANUAR','Wendy Yanuar','Jl. Antapani 88','BANDUNG',44324,513555);

INSERT INTO data_mobil VALUES
	 ('M-01','Sedan','BMW 312i',375,NULL,'D 1621 BG'),
	 ('M-02','Ambulan','Mazda 1603',500,NULL,'D 8975 CF'),
	 ('M-03','Sedan','Audi',350,NULL,'D 1003 GH'),
	 ('M-04','Minibus','Toyota',250,NULL,'D 3444 TU'),
	 ('M-05','Sedan Sport','Mercedes Benz',750,NULL,'D 7888 FG'),
	 ('M-06','Pickup','Isuzu',125,NULL,'D 8653 SA'),
	 ('M-07','Truck','Hino',3600,NULL,'D 9845 BT');

INSERT INTO sewa_mobil VALUES
	 ('SM-17001','C-02','2017-06-03','M-03',3,1050,NULL),
	 ('SM-17002','C-07','2017-06-05','M-02',5,350,NULL),
	 ('SM-17003','C-01','2017-06-07','M-01',2,100,NULL),
	 ('SM-17004','guest-1','2017-06-12','M-05',6,500,NULL),
	 ('SM-17005','C-05','2017-06-15','M-02',14,1000,NULL),
	 ('SM-17006','C-01','2017-06-17','M-05',5,600,NULL),
	 ('SM-17007','C-02','2017-06-23','M-05',3,150,NULL),
	 ('SM-17008','C-05','2017-06-23','M-02',13,1200,NULL),
	 ('SM-17009','guest-2','2017-07-01','M-02',6,500,NULL),
	 ('SM-17010','C-01','2017-07-03','M-01',3,200,NULL),
	 ('SM-17011','C-05','2017-07-07','M-03',12,800,NULL);

-- Viz data
SELECT * FROM DATA_MOBIL;
SELECT * FROM PELANGGAN;
SELECT * FROM SEWA_MOBIL;

-- Materi mengenai joining multi-table
-- Inner join itu bisa mengugnakan where kaya biasa (tanpa statement "JOIN")
-- Format query multi table: Parent.Child -> Table.Attribute
-- Kalau bisa digabung maka artinya ada yang sama, PK ada yang jadi FK.
-- Kasus joining bisa jadi belum tentu sebagai PK

-- Umumnya kode pelanggan diambil dari data pelanggan. 
-- Tapi dibisnis ini masih mengakomodasi pelanggan yang mendadak datang (disebut guest) 
-- karena ga sempat memasukan data alat dan sebagainya.
-- Sehingga pada kauss ini kode_pelanggan pada table sewa_mobil bukan FK dari table Pelanggan

-- INNER JOIN
-- LEFT JOIN
-- RIGHT JOIN

-- Yang disebutkan lebih dahulu menjadi table kiri\
-- FROM TABLE_1, TABLE_2 (LEFT, RIGHT)

-- INNER JOIN menampilkan record data yang sama dari kedua table tersebut valuenya.

-- LEFT JOIN menggunakan ON ketimbang WHERE
-- Menampilkan semua yang ditable kiri dan irisannya
-- Sama juga sebaliknya pada RIGHT JOIN

-- Ini terjadi karena ada data record yang belum tentu ada di kedua table karena blm sempat nambah data.


-- Viz data
SELECT * FROM DATA_MOBIL;
SELECT * FROM PELANGGAN;
SELECT * FROM SEWA_MOBIL;

SELECT SEWA_MOBIL.NO_FAKTUR, PELANGGAN.NAMA_PELANGGAN
FROM SEWA_MOBIL, PELANGGAN
WHERE SEWA_MOBIL.KODE_PELANGGAN = PELANGGAN.KODE_PELANGGAN;

SELECT SEWA_MOBIL.NO_FAKTUR, PELANGGAN.NAMA_PELANGGAN
FROM SEWA_MOBIL INNER JOIN PELANGGAN
ON SEWA_MOBIL.KODE_PELANGGAN = PELANGGAN.KODE_PELANGGAN;
-- Ada data missing, data guest tidak masuk, karena guest tidak ada di data pelanggan.

SELECT SEWA_MOBIL.NO_FAKTUR, PELANGGAN.NAMA_PELANGGAN
FROM SEWA_MOBIL LEFT JOIN PELANGGAN
ON SEWA_MOBIL.KODE_PELANGGAN = PELANGGAN.KODE_PELANGGAN;
-- Menampilkan juga data yang dari table kiri (table sewa mobil)
-- Ini menampilkan data yang masih guest dan terbukti null pada table nama_pelanggan

SELECT SEWA_MOBIL.NO_FAKTUR, PELANGGAN.NAMA_PELANGGAN
FROM SEWA_MOBIL RIGHT JOIN PELANGGAN
ON SEWA_MOBIL.KODE_PELANGGAN = PELANGGAN.KODE_PELANGGAN;
-- Menampilkan juga data yang dari table kanan (table pelanggan)
-- Ini menampilkan data pelanggan yang tidak punya no_faktur karena belum pernah sewa

-- Misal table sewa_mobil ingin ditambah satu kolom
-- "query nomor faktur, uang muka, uang muka kali 10"

SELECT NO_FAKTUR, UANG_MUKA, (UANG_MUKA * 100) AS KONVERSI
FROM SEWA_MOBIL;
-- Ini menghashilkan atribut turunan

SELECT NO_FAKTUR, LAMA_PINJAM, -- Ini masih termasuk atribut jadi dikasih comma
	CASE WHEN LAMA_PINJAM > 10 -- bisa ditambah lagi kondisi AND ON
		THEN 'EXTRA'
		ELSE 'NORMAL' -- Ini opsional
	END AS STATUS -- Ini akan mereturn nama atribut turunan yang baru | as juga opsional
FROM SEWA_MOBIL;
-- Jika atributnya adalah kondisi, jika lebih dari maka apa, jika kurang dari maka apa
-- bisa menggunakan ini untuk mencapai itu, serta tidak perlu comma karena itu masih 1 atribut

SELECT NO_FAKTUR, LAMA_PINJAM,
	CASE WHEN LAMA_PINJAM > 10 THEN 'EXTRA'
		WHEN LAMA_PINJAM > 5 THEN 'NORMAL'
		ELSE 'LAINNYA'
	END AS STATUS
FROM SEWA_MOBIL;

-- CASE
--     WHEN kondisi_1 THEN hasil_1
--     WHEN kondisi_2 THEN hasil_2
--     WHEN kondisi_3 THEN hasil_3
--     ELSE hasil_default
-- END

-- SELECT employee_name,
--        CASE 
--            WHEN department = 'Sales' AND performance_score > 90 THEN 'High Performer'
--            WHEN department = 'HR' OR department = 'Admin' THEN 'Support Staff'
--            ELSE 'General'
--        END AS staff_role
-- FROM employees;

