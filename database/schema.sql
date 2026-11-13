
-- GiveTrack: Community Donation Ledger with Allocation Tracking
-- Engine 1: Database Design and Data Integrity

CREATE DATABASE IF NOT EXISTS givetrack_db;
USE givetrack_db;

-- 1. Admin table
CREATE TABLE IF NOT EXISTS admin (
    admin_id INT PRIMARY KEY AUTO_INCREMENT,
    admin_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Application users and roles
CREATE TABLE IF NOT EXISTS app_user (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('ADMIN', 'DONATION_MANAGER', 'ALLOCATION_MANAGER', 'VIEWER') NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. Donor table
CREATE TABLE IF NOT EXISTS donor (
    donor_id INT PRIMARY KEY AUTO_INCREMENT,
    donor_name VARCHAR(100) NOT NULL,
    phone VARCHAR(15),
    email VARCHAR(100),
    address VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 4. Beneficiary table
CREATE TABLE IF NOT EXISTS beneficiary (
    beneficiary_id INT PRIMARY KEY AUTO_INCREMENT,
    beneficiary_name VARCHAR(100) NOT NULL,
    phone VARCHAR(15),
    address VARCHAR(255),
    requirement_details TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 5. Donation table
CREATE TABLE IF NOT EXISTS donation (
    donation_id INT PRIMARY KEY AUTO_INCREMENT,
    donor_id INT NOT NULL,
    admin_id INT NOT NULL,
    amount DECIMAL(12,2) NOT NULL,
    donation_date DATE NOT NULL,
    payment_mode VARCHAR(30),
    purpose VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_donation_donor
        FOREIGN KEY (donor_id) REFERENCES donor(donor_id),
    CONSTRAINT fk_donation_admin
        FOREIGN KEY (admin_id) REFERENCES admin(admin_id),
    CONSTRAINT chk_donation_amount CHECK (amount > 0)
);

-- 6. Allocation table
CREATE TABLE IF NOT EXISTS allocation (
    allocation_id INT PRIMARY KEY AUTO_INCREMENT,
    donation_id INT NOT NULL,
    beneficiary_id INT NOT NULL,
    admin_id INT NOT NULL,
    amount DECIMAL(12,2) NOT NULL,
    allocation_date DATE NOT NULL,
    purpose VARCHAR(255),
    status ENUM('PENDING', 'ALLOCATED', 'FULFILLED', 'CANCELLED')
        DEFAULT 'PENDING',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_allocation_donation
        FOREIGN KEY (donation_id) REFERENCES donation(donation_id),
    CONSTRAINT fk_allocation_beneficiary
        FOREIGN KEY (beneficiary_id) REFERENCES beneficiary(beneficiary_id),
    CONSTRAINT fk_allocation_admin
        FOREIGN KEY (admin_id) REFERENCES admin(admin_id),
    CONSTRAINT chk_allocation_amount CHECK (amount > 0)
);

-- 7. Audit log table
CREATE TABLE IF NOT EXISTS audit_log (
    audit_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    action_type VARCHAR(30) NOT NULL,
    table_name VARCHAR(50) NOT NULL,
    record_id INT NOT NULL,
    old_value JSON,
    new_value JSON,
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_audit_user
        FOREIGN KEY (user_id) REFERENCES app_user(user_id)
);

-- Display all tables
SHOW TABLES;
