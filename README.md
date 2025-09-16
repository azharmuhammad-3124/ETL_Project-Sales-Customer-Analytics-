# ETL Project: Sales & Customer Analytics

## Repository Outline
1. zoomcamp_dag.py                - Script utama ETL (extract, transform, load)  
2. query_sales.sql                - Query SQL untuk data penjualan  
3. query_customer.sql             - Query SQL untuk data pelanggan  
4. query_customer_report.sql      - Query SQL untuk laporan gabungan  
5. airflow_lite.yaml              - File konfigurasi Docker Compose untuk Airflow  
6. images/                        - Dokumentasi hasil analisis visualisasi di Kibana  
   - business recommendation.png  
   - distribusi segmen dan usia pelanggan.png  
   - total sales berdasarkan segmen dan usia pelanggan.png 

## Problem Background
Perusahaan ritel perlu memahami pola perilaku pelanggan dan performa penjualan untuk tetap kompetitif.  
Tantangan utama ada pada volume data yang besar dan tersebar, sehingga dibutuhkan **proses ETL** untuk mengekstrak data dari database, melakukan transformasi, dan memuat hasil akhir ke sistem analitik seperti **Elasticsearch & Kibana**.  

## Project Output
- Pipeline **ETL otomatis** dengan Python & Airflow.  
- Penyimpanan hasil data di **Elasticsearch**.  
- **Dashboard Kibana** untuk eksplorasi customer segmentation, distribusi usia, dan total penjualan.  
- Insight & rekomendasi bisnis untuk meningkatkan retensi pelanggan.  

## Data
- Sumber: PostgreSQL (hasil ekstraksi penjualan & pelanggan).  
- Query utama:  
  - `query_sales.sql` → data transaksi penjualan  
  - `query_customer.sql` → data pelanggan  
  - `query_customer_report.sql` → laporan agregasi penjualan & pelanggan  

## Method
- **Extract** data dari PostgreSQL menggunakan Pandas  
- **Transform** data sesuai kebutuhan analisis (segmentasi & agregasi penjualan)  
- **Load** data ke Elasticsearch  
- **Visualisasi** menggunakan Kibana  
- **Orkestrasi & scheduling** pipeline dengan Apache Airflow  

## Stacks
- **ETL**: Apache Airflow – untuk otomatisasi pipeline  
- **Database**: PostgreSQL – sebagai sistem database relasional utama  
- **Search & Analytics**: Elasticsearch – untuk menyimpan dan querying data hasil ETL  
- **Visualisasi**: Kibana – untuk membuat dashboard analisis  
- **Bahasa Pemrograman**: Python  
- **Library Python**: pandas, sqlalchemy, elasticsearch  

