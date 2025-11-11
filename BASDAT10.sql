
-- DATABASE PENJUALAN TOKO (By Kak Widya)

CREATE DATABASE BASDAT10;
USE BASDAT10;
-- 1️⃣ Buat tabel MASTER dan TRANSAKSI
CREATE TABLE pelanggan (
    id_pelanggan INT PRIMARY KEY AUTO_INCREMENT,
    nama_pelanggan VARCHAR(50),
    total_hutang DECIMAL(10,2) DEFAULT 0
);

CREATE TABLE kasir (
    id_kasir INT PRIMARY KEY AUTO_INCREMENT,
    nama_kasir VARCHAR(50)
);

CREATE TABLE barang (
    id_barang INT PRIMARY KEY AUTO_INCREMENT,
    nama_barang VARCHAR(50),
    harga DECIMAL(10,2),
    stok INT
);

CREATE TABLE penjualan (
    id_penjualan INT PRIMARY KEY AUTO_INCREMENT,
    id_pelanggan INT,
    id_kasir INT,
    tanggal DATE,
    total_bayar DECIMAL(10,2),
    FOREIGN KEY (id_pelanggan) REFERENCES pelanggan(id_pelanggan),
    FOREIGN KEY (id_kasir) REFERENCES kasir(id_kasir)
);

CREATE TABLE detail_penjualan (
    id_detail INT PRIMARY KEY AUTO_INCREMENT,
    id_penjualan INT,
    id_barang INT,
    jumlah INT,
    FOREIGN KEY (id_penjualan) REFERENCES penjualan(id_penjualan),
    FOREIGN KEY (id_barang) REFERENCES barang(id_barang)
);

-- 2️ Isi data awal untuk semua tabel

-- Pelanggan
INSERT INTO pelanggan (nama_pelanggan, total_hutang)
VALUES
('Andi', 0),
('Budi', 50000),
('Citra', 0),
('Dewi', 100000),
('Eka', 0);

-- Kasir
INSERT INTO kasir (nama_kasir)
VALUES 
('Rina'), 
('Fajar'), 
('Tomi');

-- Barang
INSERT INTO barang (nama_barang, harga, stok)
VALUES
('Sabun', 5000, 10),
('Sampo', 12000, 5),
('Pasta Gigi', 8000, 2),
('Minyak Goreng', 20000, 1),
('Beras 5kg', 65000, 3);

-- Penjualan
INSERT INTO penjualan (id_pelanggan, id_kasir, tanggal, total_bayar)
VALUES
(1, 1, '2025-11-05', 20000),
(2, 2, '2025-11-06', 40000),
(3, 1, '2025-11-07', 80000),
(4, 3, '2025-11-08', 65000),
(5, 2, '2025-11-09', 15000);

-- Detail Penjualan
INSERT INTO detail_penjualan (id_penjualan, id_barang, jumlah)
VALUES
(1, 1, 2),
(1, 3, 1),
(2, 2, 2),
(2, 1, 1),
(3, 5, 1),
(3, 4, 2),
(4, 5, 1),
(5, 2, 1);

-- 3️ QUERY TUGAS DARI DOSEN

-- 1. Tampilkan 3 pelanggan dengan total penjualan tertinggi
SELECT p.nama_pelanggan, SUM(pe.total_bayar) AS total_belanja
FROM pelanggan p
JOIN penjualan pe ON p.id_pelanggan = pe.id_pelanggan
GROUP BY p.id_pelanggan, p.nama_pelanggan
ORDER BY total_belanja DESC
LIMIT 3;

-- 2. Siapa pelanggan yang masih punya hutang
SELECT nama_pelanggan, total_hutang
FROM pelanggan
WHERE total_hutang > 0;

-- 3. Barang apa yang paling banyak terjual bulan ini (November 2025)
SELECT b.nama_barang, SUM(dp.jumlah) AS total_terjual
FROM detail_penjualan dp
JOIN penjualan p ON dp.id_penjualan = p.id_penjualan
JOIN barang b ON dp.id_barang = b.id_barang
WHERE MONTH(p.tanggal) = 11 AND YEAR(p.tanggal) = 2025
GROUP BY b.id_barang, b.nama_barang
ORDER BY total_terjual DESC
LIMIT 1;

-- 4. Siapa saja pelanggan yang harus ditagih (masih punya hutang)
SELECT nama_pelanggan, total_hutang
FROM pelanggan
WHERE total_hutang > 0;

-- 5. Siapa kasir yang melayani pelanggan paling banyak
SELECT k.nama_kasir, COUNT(p.id_penjualan) AS jumlah_transaksi
FROM kasir k
JOIN penjualan p ON k.id_kasir = p.id_kasir
GROUP BY k.id_kasir, k.nama_kasir
ORDER BY jumlah_transaksi DESC
LIMIT 1;

-- 6. Mana barang yang stok-nya hampir habis (stok <= 2)
SELECT nama_barang, stok
FROM barang
WHERE stok <= 2
ORDER BY stok ASC;
