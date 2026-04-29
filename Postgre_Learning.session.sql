-- CREATE TABLE psi.mahasiswa (
--     nim VARCHAR(15) PRIMARY KEY,
--     nama VARCHAR(100) NOT NULL,
--     jurusan VARCHAR(50),
--     angkatan INTEGER
-- );
-- CREATE TABLE psi.ipk (
--     id SERIAL PRIMARY KEY,
--     nim VARCHAR(15) REFERENCES psi.mahasiswa(nim) ON DELETE CASCADE,
--     semester INTEGER NOT NULL,
--     nilai_ipk NUMERIC(3, 2) CHECK (
--         nilai_ipk >= 0
--         AND nilai_ipk <= 4.0
--     )
-- );
SELECT *
FROM psi.mahasiswa;