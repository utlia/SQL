select
	kota
from rakamin_customer_address
group by kota;
------------------------------
select *
from rakamin_order
order by tanggal_pembelian desc
limit 10;
------------------------------
select 
	nama, telepon, umur, penipu
from rakamin_customer
where penipu = 'true';


select 
	count (penipu) as total_cust_penipu
from rakamin_customer
where penipu = 'true';

--------------------------------------------------------

select 
	nama,umur,tanggal_registrasi, email,
case 
	when email like '%gmail.com%' then 'gmail'
	when email like '%yahoo.com%' then 'yahoo'
	when email like '%outlook.com%' then 'outlook'
	else 'others'
end as platform_email
from rakamin_customer
	where umur = 17 and extract (year from tanggal_registrasi) = '2013'
	and extract (month from tanggal_registrasi) between '01' and '06'
order by platform_email;
--------------------------------------------------------

select metode_bayar, 
	count (tanggal_pembelian) as jumlah_transaksi,
	min (harga) as harga_terendah, ROUND(avg (harga))as harga_ratarata,
	max (harga) as harga_tertinggi, 
	sum (harga) as total_spending, id_merchant
from rakamin_order
where metode_bayar in ('ovo','gopay') and id_merchant in ('3','5','6')
group by metode_bayar(desc),id_merchant
order by metode_bayar desc;
---------------------------------------------------------------------
select 
	metode_bayar,
case 
	when harga < 30000 then 'Low Spending'
	when harga between 30000 and 50000 then 'Medium Spending'
	when harga > 50000 then 'High Spending'
end as spending_group,
count (distinct id_pelanggan) as jml_cust_unik
from 
	rakamin_order
where 
	metode_bayar != 'cash'
group by metode_bayar, spending_group;



