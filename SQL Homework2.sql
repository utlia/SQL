--- Soal No.1 
SELECT
	DISTINCT billingcity, invoiceid
FROM invoices AS ic 
ORDER BY billingcity desc;

--- Soal No.2 

SELECT 
	COUNT (penipu) as total_cust_penipu
FROM 
	rakamin_customer
WHERE 
	penipu = 'true';

--- Soal No.3 
SELECT
	kota
FROM 
	rakamin_customer_address
GROUP BY 
	kota;
	
--- Soal No.4

SELECT 
	id_pelanggan as customer_id, nama, email, telepon,umur
FROM 
	rakamin_customer
WHERE 
	umur > '22' and penipu != true;
	
--- Soal No.5 
SELECT *
FROM rakamin_order
order by tanggal_pembelian desc
limit 5;

----- Soal No.6 
SELECT 
	bulan_lahir, 
	COUNT (DISTINCT id_pelanggan) AS jumlah_pelanggan
FROM rakamin_customer
GROUP BY bulan_lahir
ORDER BY jumlah_pelanggan desc;

---- Soal No.7 
SELECT 
	rca.kota,
	rca.alamat, 
	(ro.harga * ro.kuantitas) as total_penjualan
FROM rakamin_customer_address AS rca
JOIN rakamin_order AS ro ON rca.id_pelanggan = ro.id_pelanggan 
WHERE rca.kota != 'Depok'
group by kota, alamat, total_penjualan
order by total_penjualan desc;

------ Soal No.8 
SELECT
	rc.id_pelanggan,
	rc.nama,
	rc.telepon,
	rc.email,
	sum (kuantitas * harga) as TPV
FROM rakamin_customer rc
LEFT JOIN rakamin_order ro ON rc.id_pelanggan = ro.id_pelanggan
WHERE rc.email like '%roketmail.com%' and penipu != 'true'
GROUP BY rc.id_pelanggan
ORDER BY TPV;


select id_pelanggan,nama,telepon,email
	from rakamin_customer

---- Soal No.9 

select 
	distinct id_merchant,
	SUM (CASE WHEN metode_bayar = 'ovo' THEN 1 ELSE 0 END) AS ovo,
	SUM (CASE WHEN metode_bayar = 'gopay' THEN 1 ELSE 0 END) AS gopay,
	SUM (CASE WHEN metode_bayar = 'shopeepay' THEN 1 ELSE 0 END) AS shopeepay,
	SUM (CASE WHEN metode_bayar = 'linkaja' THEN 1 ELSE 0 END) AS linkaja,
	SUM (CASE WHEN metode_bayar = 'dana' THEN 1 ELSE 0 END) AS dana,
	
	SUM (CASE WHEN bayar_cash = True THEN 1 ELSE 0 END) AS pelanggan_cash,
	SUM (CASE WHEN bayar_cash = False THEN 1 ELSE 0 END) AS pelanggan_digital

from rakamin_order
group by id_merchant, bayar_cash
order by 1;

-- Data Hasil query ini sangat membantu temen tim dari rakafood, sebab dari data tersebut
dapat terlihat berapa jumlah peminat dari tiap-tiap pembayaran E-Wallet. 
terlihat bahwa restaurant dg jumlah pembeli yg menggunakan pembayaran digital yakni ayam podomoro.
sedangkan yg pembayaran cash terbanyak ada di restaurant Chicken Wing.

---- Soal No.10 
	
SELECT
	DISTINCT rca.kota,
	SUM (CASE WHEN metode_bayar = 'cash' THEN 1 ELSE 0 END) AS cash,
	SUM (CASE WHEN metode_bayar = 'ovo' THEN 1 ELSE 0 END) AS ovo,
	SUM (CASE WHEN metode_bayar = 'gopay' THEN 1 ELSE 0 END) AS gopay,
	SUM (CASE WHEN metode_bayar = 'shopeepay' THEN 1 ELSE 0 END) AS shopeepay,
	SUM (CASE WHEN metode_bayar = 'linkaja' THEN 1 ELSE 0 END) AS linkaja,
	SUM (CASE WHEN metode_bayar = 'dana' THEN 1 ELSE 0 END) AS dana,
	SUM (CASE WHEN bayar_cash = false THEN 1 ELSE 0 END) AS total_pelanggan_cashless,
	COUNT (ro.id_pelanggan) AS jumlah_pelanggan,
	100.0*SUM (CASE WHEN bayar_cash = false THEN 1 ELSE 0 END) / COUNT (ro.id_pelanggan) as cashless_percent
FROM rakamin_customer_address AS rca
JOIN rakamin_order AS ro ON rca.id_pelanggan = ro.id_pelanggan
GROUP BY 1;

