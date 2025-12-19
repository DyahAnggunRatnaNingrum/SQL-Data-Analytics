-- Menampilkan seluruh data dari tabel staging (raw data)
-- Digunakan untuk pengecekan awal struktur dan isi data
select * from sales.bank;

-- Membuat DIMENSION TABLE: dim_customer
-- Tabel ini menyimpan atribut karakteristik nasabah
-- GENERATE_UUID() digunakan untuk membuat surrogate key
-- DISTINCT memastikan tidak ada duplikasi kombinasi data nasabah
CREATE OR REPLACE TABLE `portofolio1-480907.sales.dim_customer` AS
SELECT DISTINCT
  GENERATE_UUID() AS customer_key,
  age_group,
  job,
  marital,
  education,
  balance_bucket
FROM `portofolio1-480907.sales.bank`;


-- Membuat DIMENSION TABLE: dim_channel
-- Menyimpan jenis channel komunikasi yang digunakan dalam campaign
-- Digunakan untuk analisis performa campaign berdasarkan channel
CREATE OR REPLACE TABLE `portofolio1-480907.sales.dim_channel` AS
SELECT DISTINCT
  GENERATE_UUID() AS channel_key,
  contact AS contact_type
FROM `portofolio1-480907.sales.bank`;


-- Membuat DIMENSION TABLE: dim_time
-- Menyimpan informasi waktu untuk analisis tren temporal
-- Dalam kasus ini menggunakan bulan campaign
CREATE OR REPLACE TABLE `portofolio1-480907.sales.dim_time` AS
SELECT DISTINCT
  GENERATE_UUID() AS time_key,
  month
FROM `portofolio1-480907.sales.bank`;


-- Mengecek hasil tabel dim_customer
-- LIMIT digunakan agar query lebih cepat dan hemat resource
SELECT * FROM `portofolio1-480907.sales.dim_customer` LIMIT 5;



-- Mengambil kolom-kolom yang relevan untuk analisis bisnis dan visualisasi
CREATE OR REPLACE VIEW `portofolio1-480907.sales.bi_campaign_view` AS
SELECT
  age_group,
  job,
  marital,
  education,
  balance_bucket,
  contact,
  month,
  IF(y, 1, 0) AS success_flag
FROM `portofolio1-480907.sales.bank`;


SELECT table_name, table_type
FROM `portofolio1-480907.sales.INFORMATION_SCHEMA.TABLES`
WHERE table_name = 'bi_campaign_view';

SELECT *
FROM `portofolio1-480907.sales.bi_campaign_view`
LIMIT 10;

