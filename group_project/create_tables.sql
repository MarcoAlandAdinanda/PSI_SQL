--DROP SCHEMA public CASCADE;
--CREATE SCHEMA public;

-- customer_information
CREATE TABLE customer_information (
    customer_id    VARCHAR(10)  PRIMARY KEY,
    customer_email VARCHAR(100),
    customer_name  VARCHAR(100),
    street         VARCHAR(150),
    city           VARCHAR(50),
    customer_phone VARCHAR(20)
);

-- order_timeline
CREATE TABLE order_timeline (
    order_id    VARCHAR(10) PRIMARY KEY,
    customer_id VARCHAR(10) REFERENCES customer_information(customer_id),
    order_date  DATE
);

-- order_detail
CREATE TABLE order_detail (
    order_detail_id VARCHAR(10)  PRIMARY KEY,
    item_name       VARCHAR(150),
    order_id        VARCHAR(10)  REFERENCES order_timeline(order_id),
    quantity        INT,
    status          VARCHAR(20),
    note_order      TEXT
);

-- sketch_detail
CREATE TABLE sketch_detail (
    sketch_id      VARCHAR(10),
    sketch_version VARCHAR(10),
    sketch_file    VARCHAR(255),
    sketch_status  VARCHAR(20),
    update_date    DATE,
    note_sketch    TEXT,
    PRIMARY KEY (sketch_id, sketch_version)
);

-- sketch_order_name
CREATE TABLE sketch_order_name (
    sketch_id       VARCHAR(10) REFERENCES sketch_detail(sketch_id),
    order_detail_id VARCHAR(10) REFERENCES order_detail(order_detail_id),
    PRIMARY KEY (sketch_id, order_detail_id)
);

-- drawing_details
CREATE TABLE drawing_details (
    drawing_id      VARCHAR(10)  PRIMARY KEY,
    sketch_id       VARCHAR(10)  REFERENCES sketch_detail(sketch_id),
    drawing_file    VARCHAR(255),
    tanggal_drawing DATE,
    note_drawing    TEXT
);

-- material_specification
CREATE TABLE material_specification (
    material_spec_id VARCHAR(10)  PRIMARY KEY,
    material_name    VARCHAR(100),
    satuan_qp        VARCHAR(20),
    description      TEXT
);

-- material_needs
CREATE TABLE material_needs (
    drawing_id       VARCHAR(10) REFERENCES drawing_details(drawing_id),
    material_spec_id VARCHAR(10) REFERENCES material_specification(material_spec_id),
    quantity_needed  NUMERIC(10,2),
    PRIMARY KEY (drawing_id, material_spec_id)
);

-- material_onhand
CREATE TABLE material_onhand (
    material_id      VARCHAR(10) PRIMARY KEY,
    material_spec_id VARCHAR(10) REFERENCES material_specification(material_spec_id),
    quantity_onhand  NUMERIC(10,2)
);

-- material_supplier
CREATE TABLE material_supplier (
    supplier_id      VARCHAR(10)  PRIMARY KEY,
    supplier_name    VARCHAR(100),
    supplier_address VARCHAR(200),
    supplier_city    VARCHAR(50),
    supplier_contact VARCHAR(50)
);

-- purchase_order
CREATE TABLE purchase_order (
    purchase_id    VARCHAR(10) PRIMARY KEY,
    supplier_id    VARCHAR(10) REFERENCES material_supplier(supplier_id),
    purchase_date  DATE,
    invoice_number VARCHAR(50)
);

-- purchase_item_detail
CREATE TABLE purchase_item_detail (
    purchase_id        VARCHAR(10) REFERENCES purchase_order(purchase_id),
    material_id        VARCHAR(10) REFERENCES material_onhand(material_id),
    quantity_purchased NUMERIC(10,2),
    price_per_unit     NUMERIC(12,2),
    penjelasan         TEXT,
    PRIMARY KEY (purchase_id, material_id)
);

-- product_catalog
CREATE TABLE product_catalog (
    product_catalog_id VARCHAR(10)  PRIMARY KEY,
    product_name       VARCHAR(150),
    product_description TEXT
);

-- product_location
CREATE TABLE product_location (
    rack_location      VARCHAR(20) PRIMARY KEY,
    warehouse_location VARCHAR(100)
);

-- product_inventory
CREATE TABLE product_inventory (
    product_id         VARCHAR(10) PRIMARY KEY,
    order_id           VARCHAR(10) REFERENCES order_timeline(order_id),
    product_catalog_id VARCHAR(10) REFERENCES product_catalog(product_catalog_id),
    rack_location      VARCHAR(20) REFERENCES product_location(rack_location),
    production_date    DATE,
    stock_quantity     INT,
    status             VARCHAR(20)
);