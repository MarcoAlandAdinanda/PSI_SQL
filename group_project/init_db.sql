-- ============================================================
-- PostgreSQL Script: Database Initialization
-- Project: PSI_SQL - Filigree Order Management System
-- Based on: group_project/plan.md & group_project/erd_project.png
-- ============================================================

BEGIN;

-- ============================================================
-- 1. TABLES (DDL)
-- ============================================================

-- 1.1. customer_information
CREATE TABLE IF NOT EXISTS customer_information (
    customer_id   VARCHAR(10) PRIMARY KEY,
    customer_email VARCHAR(100) NOT NULL,
    customer_name VARCHAR(100) NOT NULL,
    street        VARCHAR(100) NOT NULL,
    city          VARCHAR(50)  NOT NULL,
    customer_phone VARCHAR(20) NOT NULL
);

-- 1.2. order_timeline
CREATE TABLE IF NOT EXISTS order_timeline (
    order_id    VARCHAR(10) PRIMARY KEY,
    customer_id VARCHAR(10) NOT NULL,
    order_date  DATE        NOT NULL,
    CONSTRAINT fk_order_timeline_customer
        FOREIGN KEY (customer_id) REFERENCES customer_information(customer_id)
);

-- 1.3. order_detail
CREATE TABLE IF NOT EXISTS order_detail (
    order_detail_id VARCHAR(10) PRIMARY KEY,
    item_name       VARCHAR(100) NOT NULL,
    order_id        VARCHAR(10)  NOT NULL,
    quantity        INT          NOT NULL,
    status          VARCHAR(20)  NOT NULL,
    note_order      TEXT,
    CONSTRAINT fk_order_detail_order
        FOREIGN KEY (order_id) REFERENCES order_timeline(order_id)
);

-- 1.4. sketch_order_name
CREATE TABLE IF NOT EXISTS sketch_order_name (
    sketch_id       VARCHAR(10) PRIMARY KEY,
    order_detail_id VARCHAR(10) NOT NULL,
    CONSTRAINT fk_sketch_order_name_detail
        FOREIGN KEY (order_detail_id) REFERENCES order_detail(order_detail_id)
);

-- 1.5. sketch_detail
CREATE TABLE IF NOT EXISTS sketch_detail (
    sketch_id      VARCHAR(10) NOT NULL,
    sketch_version VARCHAR(5)  NOT NULL,
    sketch_file    VARCHAR(200) NOT NULL,
    sketch_status  VARCHAR(20)  NOT NULL,
    update_date    DATE         NOT NULL,
    note_sketch    TEXT,
    PRIMARY KEY (sketch_id, sketch_version),
    CONSTRAINT fk_sketch_detail_sketch
        FOREIGN KEY (sketch_id) REFERENCES sketch_order_name(sketch_id)
);

-- 1.6. drawing_details
CREATE TABLE IF NOT EXISTS drawing_details (
    drawing_id     VARCHAR(10) PRIMARY KEY,
    sketch_id      VARCHAR(10) NOT NULL,
    drawing_file   VARCHAR(200) NOT NULL,
    tanggal_drawing DATE       NOT NULL,
    note_drawing   TEXT,
    CONSTRAINT fk_drawing_details_sketch
        FOREIGN KEY (sketch_id) REFERENCES sketch_order_name(sketch_id)
);

-- 1.7. material_specification
CREATE TABLE IF NOT EXISTS material_specification (
    material_spec_id VARCHAR(10) PRIMARY KEY,
    material_name    VARCHAR(100) NOT NULL,
    satuan_qp        VARCHAR(10)  NOT NULL,
    description      TEXT
);

-- 1.8. material_needs
CREATE TABLE IF NOT EXISTS material_needs (
    drawing_id       VARCHAR(10) NOT NULL,
    material_spec_id VARCHAR(10) NOT NULL,
    quantity_needed  INT         NOT NULL,
    PRIMARY KEY (drawing_id, material_spec_id),
    CONSTRAINT fk_material_needs_drawing
        FOREIGN KEY (drawing_id) REFERENCES drawing_details(drawing_id),
    CONSTRAINT fk_material_needs_spec
        FOREIGN KEY (material_spec_id) REFERENCES material_specification(material_spec_id)
);

-- 1.9. material_onhand
CREATE TABLE IF NOT EXISTS material_onhand (
    material_id      VARCHAR(10) PRIMARY KEY,
    material_spec_id VARCHAR(10) NOT NULL,
    quantity_onhand  INT         NOT NULL,
    CONSTRAINT fk_material_onhand_spec
        FOREIGN KEY (material_spec_id) REFERENCES material_specification(material_spec_id)
);

-- 1.10. material_supplier
CREATE TABLE IF NOT EXISTS material_supplier (
    supplier_id       VARCHAR(10) PRIMARY KEY,
    supplier_name     VARCHAR(100) NOT NULL,
    supplier_address  VARCHAR(200) NOT NULL,
    supplier_city     VARCHAR(50)  NOT NULL,
    supplier_contact  VARCHAR(20)  NOT NULL
);

-- 1.11. purchase_order
CREATE TABLE IF NOT EXISTS purchase_order (
    purchase_id    VARCHAR(10) PRIMARY KEY,
    supplier_id    VARCHAR(10) NOT NULL,
    purchase_date  DATE        NOT NULL,
    invoice_number VARCHAR(30) NOT NULL,
    CONSTRAINT fk_purchase_order_supplier
        FOREIGN KEY (supplier_id) REFERENCES material_supplier(supplier_id)
);

-- 1.12. purchase_item_detail
CREATE TABLE IF NOT EXISTS purchase_item_detail (
    purchase_id       VARCHAR(10) NOT NULL,
    material_id       VARCHAR(10) NOT NULL,
    quantity_purchased INT        NOT NULL,
    price_per_unit    INT         NOT NULL,
    penjelasan        TEXT,
    PRIMARY KEY (purchase_id, material_id),
    CONSTRAINT fk_purchase_item_detail_order
        FOREIGN KEY (purchase_id) REFERENCES purchase_order(purchase_id),
    CONSTRAINT fk_purchase_item_detail_material
        FOREIGN KEY (material_id) REFERENCES material_onhand(material_id)
);

-- 1.13. product_location
CREATE TABLE IF NOT EXISTS product_location (
    rack_location     VARCHAR(10) PRIMARY KEY,
    warehouse_location VARCHAR(50) NOT NULL
);

-- 1.14. product_catalog
CREATE TABLE IF NOT EXISTS product_catalog (
    product_catalog_id VARCHAR(10) PRIMARY KEY,
    product_name       VARCHAR(100) NOT NULL,
    product_description TEXT
);

-- 1.15. product_inventory
CREATE TABLE IF NOT EXISTS product_inventory (
    product_id        VARCHAR(10) PRIMARY KEY,
    order_id          VARCHAR(10) NOT NULL,
    product_catalog_id VARCHAR(10) NOT NULL,
    rack_location     VARCHAR(10) NOT NULL,
    production_date   DATE        NOT NULL,
    stock_quantity    INT         NOT NULL,
    status            VARCHAR(20) NOT NULL,
    CONSTRAINT fk_product_inventory_order
        FOREIGN KEY (order_id) REFERENCES order_timeline(order_id),
    CONSTRAINT fk_product_inventory_catalog
        FOREIGN KEY (product_catalog_id) REFERENCES product_catalog(product_catalog_id),
    CONSTRAINT fk_product_inventory_location
        FOREIGN KEY (rack_location) REFERENCES product_location(rack_location)
);

-- ============================================================
-- 2. SEED DATA (DML)
-- ============================================================

-- 2.1. customer_information
INSERT INTO customer_information (customer_id, customer_email, customer_name, street, city, customer_phone) VALUES
('CUS001', 'siti.aminah@email.com', 'Ibu Siti Aminah',   'Jl. Melati No. 10',  'Yogyakarta', '81234567890'),
('CUS002', 'joko.w@email.com',      'Bapak Joko Widodo', 'Jl. Merapi No. 5',   'Solo',       '85678123456'),
('CUS003', 'dewi.lestari@email.com','Ibu Dewi Lestari',  'Jl. Anggrek No. 22', 'Jakarta',    '87812345678'),
('CUS004', 'ahmad.fauzi@email.com', 'Tn. Ahmad Fauzi',   'Jl. Kenanga No. 7',  'Bandung',    '82298765432'),
('CUS005', 'rina.wijaya@email.com', 'Ny. Rina Wijaya',   'Jl. Mawar No. 15',   'Surabaya',   '83876543210');

-- 2.2. order_timeline
INSERT INTO order_timeline (order_id, customer_id, order_date) VALUES
('ORD001', 'CUS001', '2026-01-01'),
('ORD002', 'CUS001', '2026-01-02'),
('ORD003', 'CUS003', '2026-01-03'),
('ORD004', 'CUS003', '2026-01-04'),
('ORD005', 'CUS005', '2026-01-05');

-- 2.3. order_detail
INSERT INTO order_detail (order_detail_id, item_name, order_id, quantity, status, note_order) VALUES
('OD001', 'Cincin Filigree Silver',       'ORD001', 2, 'Diterima', 'Ukuran 6 dan 8'),
('OD002', 'Anting Filigree',              'ORD001', 1, 'Diterima', 'Model kecil'),
('OD003', 'Bros Filigree',                'ORD001', 1, 'Diterima', 'Model bunga mawar'),
('OD004', 'Gelang Filigree',              'ORD002', 1, 'Ditolak',  'Stok kosong'),
('OD005', 'Liontin Filigree',             'ORD003', 3, 'Diterima', 'Dengan rantai perak'),
('OD006', 'Gelang Filigree Premium',      'ORD004', 2, 'Diproses', 'Finishing doff'),
('OD007', 'Vas Bunga Filigree Sedang',    'ORD005', 1, 'Diproses', 'Motif custom floral');

-- 2.4. sketch_order_name
INSERT INTO sketch_order_name (sketch_id, order_detail_id) VALUES
('SK001', 'OD001'),
('SK002', 'OD002'),
('SK003', 'OD003'),
('SK004', 'OD005'),
('SK005', 'OD005');

-- 2.5. sketch_detail
INSERT INTO sketch_detail (sketch_id, sketch_version, sketch_file, sketch_status, update_date, note_sketch) VALUES
('SK001', 'v1', 'sketches/ORD001_cincin_v1.jpg', 'Ditolak',  '2025-12-20', 'Desain terlalu simpel'),
('SK001', 'v2', 'sketches/ORD001_cincin_v2.jpg', 'Diterima', '2025-12-25', 'Revisi dengan tambahan ornamen'),
('SK002', 'v1', 'sketches/ORD001_anting_v1.jpg', 'Ditolak',  '2025-12-21', 'Ukuran terlalu besar'),
('SK002', 'v2', 'sketches/ORD001_anting_v2.jpg', 'Diterima', '2025-12-26', 'Ukuran diperkecil'),
('SK003', 'v1', 'sketches/ORD001_bros_v1.jpg',   'Diterima', '2025-12-28', 'Model bunga mawar disetujui'),
('SK004', 'v1', 'sketches/ORD003_liontin_v1.jpg', 'Diterima', '2025-12-27', 'Motif sesuai permintaan'),
('SK005', 'v1', 'sketches/ORD003_liontin_v2.jpg', 'Diterima', '2025-12-29', 'Revisi rantai lebih tebal');

-- 2.6. drawing_details
INSERT INTO drawing_details (drawing_id, sketch_id, drawing_file, tanggal_drawing, note_drawing) VALUES
('DRW001', 'SK001', 'engineering/ORD001_cincin_v2_eng.pdf',  '2026-01-01', 'Cincin ukuran 6'),
('DRW002', 'SK001', 'engineering/ORD001_cincin_v2_eng2.pdf', '2026-01-01', 'Cincin ukuran 8'),
('DRW003', 'SK002', 'engineering/ORD001_anting_v2_eng.pdf',  '2026-01-02', 'Model kecil, sepasang'),
('DRW004', 'SK004', 'engineering/ORD003_liontin_v2_eng.pdf', '2026-01-03', 'Liontin dengan rantai'),
('DRW005', 'SK004', 'engineering/ORD003_liontin_v2_eng2.pdf','2026-01-03', 'Detail sambungan rantai');

-- 2.7. material_specification
INSERT INTO material_specification (material_spec_id, material_name, satuan_qp, description) VALUES
('MS001', 'Silver wire 0.8mm',  'cm',  'Kawat perak diameter 0.8mm untuk filigree'),
('MS002', 'Solder perak',       'gr',  'Bahan solder berbahan perak'),
('MS003', 'Silver band ukuran 6','pcs', 'Ring band perak ukuran 6'),
('MS004', 'Silver wire 0.6mm',  'cm',  'Kawat perak diameter 0.6mm untuk filigree'),
('MS005', 'Kait anting perak',  'pcs', 'Kait anting berbahan perak');

-- 2.8. material_needs
INSERT INTO material_needs (drawing_id, material_spec_id, quantity_needed) VALUES
('DRW001', 'MS001', 30),
('DRW001', 'MS002', 5),
('DRW001', 'MS003', 1),
('DRW003', 'MS001', 20),
('DRW003', 'MS005', 2);

-- 2.9. material_onhand
INSERT INTO material_onhand (material_id, material_spec_id, quantity_onhand) VALUES
('MAT001', 'MS001', 220),
('MAT002', 'MS001', 50),
('MAT003', 'MS002', 1000),
('MAT004', 'MS004', 200),
('MAT005', 'MS005', 500);

-- 2.10. material_supplier
INSERT INTO material_supplier (supplier_id, supplier_name, supplier_address, supplier_city, supplier_contact) VALUES
('SUP001', 'PT Logam Mulia',    'Jl. Industri No. 5',   'Jakarta',    '021-5551234'),
('SUP002', 'CV Perak Jaya',     'Jl. Raya Logam No. 10','Surabaya',   '031-7778899'),
('SUP003', 'UD Logam Sentosa',  'Jl. Diponegoro No. 22','Yogyakarta', '0274-888111'),
('SUP004', 'Toko Emas Subur',   'Jl. Pasar Baru No. 7', 'Bandung',    '022-6664321'),
('SUP006', 'CV Teknik Las',     'Jl. Veteran No. 15',   'Semarang',   '024-7771234');

-- 2.11. purchase_order
INSERT INTO purchase_order (purchase_id, supplier_id, purchase_date, invoice_number) VALUES
('PUR001', 'SUP001', '2026-01-01', 'INV/2026/001'),
('PUR002', 'SUP001', '2026-01-06', 'INV/2026/015'),
('PUR003', 'SUP002', '2026-01-11', 'INV/2026/023'),
('PUR004', 'SUP003', '2026-01-16', 'INV/2026/045'),
('PUR006', 'SUP006', '2026-01-23', 'INV/2026/089');

-- 2.12. purchase_item_detail
INSERT INTO purchase_item_detail (purchase_id, material_id, quantity_purchased, price_per_unit, penjelasan) VALUES
('PUR001', 'MAT001', 150, 18000, 'Pembelian rutin bulanan'),
('PUR001', 'MAT004', 150, 16000, 'Pembelian rutin bulanan'),
('PUR002', 'MAT002', 50,  18000, 'Stok tambahan'),
('PUR003', 'MAT003', 500, 12000, 'Pembelian solder perak'),
('PUR004', 'MAT005', 300, 2500,  '-'),
('PUR006', 'MAT002', 200, 15000, '-');

-- 2.13. product_location
INSERT INTO product_location (rack_location, warehouse_location) VALUES
('Rak A1', 'Gudang Produk Jadi'),
('Rak A2', 'Gudang Produk Jadi'),
('Rak B1', 'Gudang Produk Jadi'),
('Rak C1', 'Gudang Produk Jadi'),
('Rak D1', 'Gudang Transit');

-- 2.14. product_catalog
INSERT INTO product_catalog (product_catalog_id, product_name, product_description) VALUES
('PC001', 'Cincin Filigree Silver Ukuran 6', 'Cincin perak dengan ornamen filigree, ukuran 6'),
('PC002', 'Cincin Filigree Silver Ukuran 8', 'Cincin perak dengan ornamen filigree, ukuran 8'),
('PC003', 'Anting Filigree Model Kecil',     'Anting perak model kecil dengan ornamen filigree, sepasang'),
('PC004', 'Liontin Filigree dengan Rantai',  'Liontin perak dengan ornamen filigree dan rantai 45cm'),
('PC005', 'Vas Bunga Filigree Ukuran Sedang','Vas bunga perak ukuran sedang dengan ornamen filigree');

-- 2.15. product_inventory
INSERT INTO product_inventory (product_id, order_id, product_catalog_id, rack_location, production_date, stock_quantity, status) VALUES
('PRD001', 'ORD001', 'PC001', 'Rak A1', '2026-01-13', 1, 'Dikirim'),
('PRD002', 'ORD001', 'PC002', 'Rak A1', '2026-01-13', 1, 'Dikirim'),
('PRD003', 'ORD001', 'PC003', 'Rak A2', '2026-01-14', 1, 'Dikirim'),
('PRD004', 'ORD003', 'PC004', 'Rak B1', '2026-01-15', 1, 'Tersedia'),
('PRD005', 'ORD003', 'PC004', 'Rak D1', '2026-01-15', 1, 'Tersedia');

COMMIT;
