-- PRAKTIKUM 1 s.d. 7 
CREATE DATABASE IF NOT EXISTS mhs_db;
USE mhs_db;

-- ============================= PRAKTIKUM 1 =============================
-- Tugas: Pembuatan tabel, INSERT, UPDATE, DELETE, JOIN dasar

CREATE TABLE jurusan (
  kode_jurusan VARCHAR(10) PRIMARY KEY,
  nama_jurusan VARCHAR(100),
  ketua_jurusan VARCHAR(200)
);

CREATE TABLE biodata (
  no_mahasiswa VARCHAR(20) PRIMARY KEY,
  kode_jurusan VARCHAR(10),
  nama_mahasiswa VARCHAR(200),
  alamat VARCHAR(200),
  ipk DECIMAL(3,2),
  FOREIGN KEY (kode_jurusan) REFERENCES jurusan(kode_jurusan)
);

-- Tugas 1: Isi tabel jurusan sesuai modul
-- (KD01, KD02, KD03 dengan nama jurusan dan ketua)
INSERT INTO jurusan (kode_jurusan, nama_jurusan, ketua_jurusan) VALUES
('KD01','Sistem Informasi','Harnaningrum,S.Si'),
('KD02','Teknik Informatika','EnnySela,S.Kom.,M.Kom'),
('KD03','Tekhnik Komputer','Berta Bednar,S.Si,M.T.');

-- Tugas 1: Isi tabel biodata sesuai modul
INSERT INTO biodata (no_mahasiswa, kode_jurusan, nama_mahasiswa, alamat, ipk) VALUES
('210089','KD01','Rina Gunawan','Denpasar',3.00),
('210090','KD03','Gani Suprapto','Singaraja',3.50),
('210012','KD02','Alexandra','Nusa dua',3.00),
('210099','KD02','Nadine','Gianyar',3.20),
('210002','KD01','Rizal Samurai','Denpasar',3.70);

-- Tugas 2: Masukkan data baru pada biodata dengan kode jurusan KD04
-- (contoh penambahan satu mahasiswa baru dengan KD04)
INSERT INTO jurusan (kode_jurusan, nama_jurusan, ketua_jurusan)
VALUES ('KD04','Teknologi Informasi','Ketua KD04');

INSERT INTO biodata (no_mahasiswa, kode_jurusan, nama_mahasiswa, alamat, ipk)
VALUES ('210101','KD04','Mahasiswa Baru','Tabanan',3.10);

-- Tugas 3: Operasi UPDATE sesuai instruksi modul
-- a) Ganti nama "Rina Gunawan" -> "Rina Gunawan Astuti"
UPDATE biodata
SET nama_mahasiswa = 'Rina Gunawan Astuti'
WHERE nama_mahasiswa = 'Rina Gunawan' AND no_mahasiswa = '210089';


-- b) Ganti kode jurusan KD01 menjadi KM01 (aman: tambahkan dulu KM01, update, lalu opsional hapus KD01)
INSERT INTO jurusan (kode_jurusan, nama_jurusan, ketua_jurusan)
SELECT 'KM01', nama_jurusan, ketua_jurusan FROM jurusan WHERE kode_jurusan='KD01';

UPDATE biodata SET kode_jurusan = 'KM01' WHERE kode_jurusan = 'KD01';
-- (opsional) DELETE FROM jurusan WHERE kode_jurusan='KD01';

-- c) Ganti no_mahasiswa 210089 -> 210098 (gunakan kondisi nama agar unik)
UPDATE biodata
SET no_mahasiswa = '210098'
WHERE no_mahasiswa = '210089';

-- d) Ganti nilai IPK = 3.00 menjadi 3.30
UPDATE biodata SET ipk = 3.30 WHERE ipk = 3.00 AND no_mahasiswa = '210012';

-- e) Ganti kode jurusan KD03 -> KD05 (proses aman: tambahkan KD05, update biodata, opsional hapus KD03)
INSERT INTO jurusan (kode_jurusan, nama_jurusan, ketua_jurusan)
SELECT 'KD05', nama_jurusan, ketua_jurusan FROM jurusan WHERE kode_jurusan='KD03';

UPDATE biodata SET kode_jurusan = 'KD05' WHERE kode_jurusan = 'KD03';
-- (opsional) DELETE FROM jurusan WHERE kode_jurusan='KD03';

-- ============================= PRAKTIKUM 2 =============================
-- Tugas: Cartesian product, JOIN (praktik memakai tabel Mahasiswa)

-- Contoh Cartesian product (CROSS JOIN) antara biodata dan jurusan (untuk latihan)
SELECT b.no_mahasiswa, j.kode_jurusan, b.nama_mahasiswa, j.nama_jurusan
FROM biodata b
CROSS JOIN jurusan j;

-- INNER JOIN (sama seperti contoh di modul)
SELECT b.no_mahasiswa, b.nama_mahasiswa, j.nama_jurusan
FROM biodata b
INNER JOIN jurusan j ON b.kode_jurusan = j.kode_jurusan;

-- LEFT JOIN
SELECT b.no_mahasiswa, b.nama_mahasiswa, b.kode_jurusan, j.nama_jurusan
FROM biodata b
LEFT JOIN jurusan j ON b.kode_jurusan = j.kode_jurusan;

-- RIGHT JOIN
SELECT b.no_mahasiswa, b.nama_mahasiswa, j.kode_jurusan, j.nama_jurusan
FROM biodata b
RIGHT JOIN jurusan j ON b.kode_jurusan = j.kode_jurusan;

-- Tugas 1: Cobalah masing-masing perintah join dengan database Mahasiswa (jalankan query di atas)
-- Tugas 2: Kesimpulan perbedaan LEFT JOIN dan RIGHT JOIN:
-- LEFT JOIN menampilkan semua baris dari tabel kiri (biodata) dan cocokkan dari tabel kanan (jurusan) jika ada.
-- RIGHT JOIN menampilkan semua baris dari tabel kanan (jurusan) dan cocokkan dari tabel kiri (biodata) jika ada.


-- ============================= PRAKTIKUM 3 =============================
-- Tugas: Single Row Function (berikan 1 contoh tiap fungsi)

-- LOWER
SELECT LOWER(nama_mahasiswa) AS huruf_kecil FROM biodata;

-- UPPER
SELECT UPPER(nama_mahasiswa) AS huruf_besar FROM biodata;

-- SUBSTRING
SELECT SUBSTRING(nama_mahasiswa, 1, 4) AS potongan_nama FROM biodata;

-- LTRIM / RTRIM contoh (literal)
SELECT LTRIM('  Contoh') AS tanpa_spasi_kiri, RTRIM('Contoh  ') AS tanpa_spasi_kanan;

-- LEFT / RIGHT
SELECT LEFT(nama_mahasiswa,3) AS tiga_kiri, RIGHT(nama_mahasiswa,3) AS tiga_kanan FROM biodata;

-- LENGTH
SELECT nama_mahasiswa, LENGTH(nama_mahasiswa) AS panjang_nama FROM biodata;

-- REVERSE
SELECT nama_mahasiswa, REVERSE(nama_mahasiswa) AS nama_terbalik FROM biodata;

-- SPACE
SELECT SPACE(10) AS sepuluh_spasi;

-- CONCAT
SELECT CONCAT(nama_mahasiswa, ' - ', alamat) AS gabungan FROM biodata;

-- IFNULL
SELECT nama_mahasiswa, IFNULL(alamat,'Alamat belum diisi') AS alamat_cek FROM biodata;



-- ============================= PRAKTIKUM 4 =============================
-- Tugas: ORDER BY, fungsi agregat (COUNT, SUM, AVG, MAX, MIN), GROUP BY, HAVING

-- ORDER BY asc / desc (contoh)
SELECT * FROM biodata ORDER BY nama_mahasiswa ASC;
SELECT * FROM biodata ORDER BY nama_mahasiswa DESC;

-- COUNT, AVG, SUM, MAX, MIN
SELECT COUNT(*) AS jumlah_mahasiswa FROM biodata;
SELECT AVG(ipk) AS rata_rata_ipk FROM biodata;
SELECT SUM(ipk) AS total_ipk FROM biodata; -- contoh penggunaan SUM
SELECT MAX(ipk) AS ipk_tertinggi, MIN(ipk) AS ipk_terendah FROM biodata;

-- GROUP BY contoh
SELECT kode_jurusan, COUNT(*) AS jumlah_mahasiswa
FROM biodata
GROUP BY kode_jurusan;

-- GROUP BY + JOIN ke jurusan
SELECT j.nama_jurusan, COUNT(b.no_mahasiswa) AS jumlah_mahasiswa, AVG(b.ipk) AS rata_ipk
FROM biodata b
JOIN jurusan j ON b.kode_jurusan = j.kode_jurusan
GROUP BY j.nama_jurusan;

-- HAVING: tampilkan jurusan dengan rata-rata IPK > 3.20
SELECT j.nama_jurusan, AVG(b.ipk) AS rata_ipk
FROM biodata b
JOIN jurusan j ON b.kode_jurusan = j.kode_jurusan
GROUP BY j.nama_jurusan
HAVING AVG(b.ipk) > 3.20;


-- ============================= PRAKTIKUM 5 =============================
-- Tugas: Subquery & Set Operation (UNION; simulasi INTERSECT / EXCEPT)

-- Subquery: Mahasiswa dengan IPK > rata-rata
SELECT * FROM biodata
WHERE ipk > (SELECT AVG(ipk) FROM biodata);

-- Subquery: Mahasiswa dengan IPK tertinggi
SELECT * FROM biodata
WHERE ipk = (SELECT MAX(ipk) FROM biodata);

-- Subquery korelasi: mahasiswa yang IPK di bawah rata-rata jurusannya
SELECT * FROM biodata b
WHERE ipk < (
  SELECT AVG(ipk) FROM biodata WHERE kode_jurusan = b.kode_jurusan
);

-- Set operation: UNION (gabungkan dua SELECT)
SELECT no_mahasiswa, nama_mahasiswa, kode_jurusan FROM biodata WHERE kode_jurusan = 'KM01'
UNION
SELECT no_mahasiswa, nama_mahasiswa, kode_jurusan FROM biodata WHERE kode_jurusan = 'KD02';

-- UNION ALL (menyertakan duplikasi jika ada)
SELECT no_mahasiswa, nama_mahasiswa, kode_jurusan FROM biodata WHERE kode_jurusan = 'KM01'
UNION ALL
SELECT no_mahasiswa, nama_mahasiswa, kode_jurusan FROM biodata WHERE kode_jurusan = 'KD02';

-- Simulasi INTERSECT: ambil mahasiswa yang juga memiliki alamat yang sama dengan mahasiswa KD02
SELECT nama_mahasiswa, alamat FROM biodata
WHERE alamat IN (SELECT alamat FROM biodata WHERE kode_jurusan = 'KD02');

-- Simulasi EXCEPT: ambil mahasiswa yang tidak berasal dari KD02
SELECT nama_mahasiswa, kode_jurusan FROM biodata
WHERE kode_jurusan NOT IN (SELECT kode_jurusan FROM biodata WHERE kode_jurusan = 'KD02');


-- ============================= PRAKTIKUM 6 =============================
-- VIEW, CONTROL FLOW, TEMPORARY TABLE, USER-DEFINED VARIABLES

-- VIEW
DROP VIEW IF EXISTS view_mahasiswa;

CREATE VIEW view_mahasiswa AS
SELECT b.no_mahasiswa, b.nama_mahasiswa, b.alamat, b.ipk,
       j.nama_jurusan, j.ketua_jurusan
FROM biodata b
JOIN jurusan j ON b.kode_jurusan = j.kode_jurusan;

SELECT * FROM view_mahasiswa;

-- USER DEFINED VARIABLES
SET @t1 = 1, @t2 = 2, @t3 = 4;
SELECT @t1, @t2, @t3, (@t1 + @t2 + @t3) AS total;

-- CONTROL FLOW FUNCTION
SELECT nama_mahasiswa, ipk,
  IF(ipk >= 3.50, 'Lulus dengan Pujian',
     IF(ipk >= 3.00, 'Lulus', 'Tidak Lulus')) AS keterangan
FROM biodata;

SELECT nama_mahasiswa, ipk,
  CASE
    WHEN ipk >= 3.50 THEN 'Sangat Memuaskan'
    WHEN ipk >= 3.00 THEN 'Memuaskan'
    ELSE 'Cukup'
  END AS predikat
FROM biodata;

SELECT nama_mahasiswa, IFNULL(alamat,'Alamat belum diisi') AS alamat_cek
FROM biodata;

-- TEMPORARY TABLE
CREATE TEMPORARY TABLE templatihan (
  id INT PRIMARY KEY,
  nama VARCHAR(80),
  alamat VARCHAR(50),
  hobby VARCHAR(70)
);

INSERT INTO templatihan VALUES
(1,'Ani','Denpasar','Membaca'),
(2,'Budi','Singaraja','Futsal');

SELECT * FROM templatihan;

-- ============================= PRAKTIKUM 7 =============================

-- FUNCTION
DROP FUNCTION IF EXISTS tambah;

DELIMITER //
CREATE FUNCTION tambah(a INT, b INT)
RETURNS INT
DETERMINISTIC
BEGIN
  RETURN a + b;
END //
DELIMITER ;

-- STORED PROCEDURE: Menampilkan mahasiswa berdasarkan ketua jurusan
DROP PROCEDURE IF EXISTS tampil_mahasiswa_ketua;

DELIMITER //
CREATE PROCEDURE tampil_mahasiswa_ketua(IN nama_ketua VARCHAR(200))
BEGIN
  SELECT b.no_mahasiswa, b.nama_mahasiswa, b.alamat, b.ipk,
         j.nama_jurusan, j.ketua_jurusan
  FROM biodata b
  JOIN jurusan j ON b.kode_jurusan = j.kode_jurusan
  WHERE j.ketua_jurusan = nama_ketua;
END //
DELIMITER ;

-- STORED PROCEDURE: Mencari ketua jurusan berdasarkan nama
DROP PROCEDURE IF EXISTS cari_ketua;

DELIMITER //
CREATE PROCEDURE cari_ketua(IN potongan VARCHAR(100))
BEGIN
  SELECT * FROM jurusan
  WHERE ketua_jurusan LIKE CONCAT('%', potongan, '%');
END //
DELIMITER ;

-- TRIGGER: Mencatat mahasiswa yang baru ditambahkan
CREATE TABLE IF NOT EXISTS log_mahasiswa (
  id_log INT AUTO_INCREMENT PRIMARY KEY,
  no_mahasiswa VARCHAR(20),
  nama_mahasiswa VARCHAR(200),
  waktu_input DATETIME
);

DROP TRIGGER IF EXISTS after_insert_biodata;

DELIMITER //
CREATE TRIGGER after_insert_biodata
AFTER INSERT ON biodata
FOR EACH ROW
BEGIN
  INSERT INTO log_mahasiswa (no_mahasiswa, nama_mahasiswa, waktu_input)
  VALUES (NEW.no_mahasiswa, NEW.nama_mahasiswa, NOW());
END //
DELIMITER ;
