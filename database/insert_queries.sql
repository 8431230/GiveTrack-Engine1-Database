
-- GiveTrack: Sample Data
-- Engine 1: Database and Data Integrity

USE givetrack_db;

-- 1. Insert Admin
INSERT INTO admin (admin_name, email, password_hash)
VALUES ('System Admin', 'admin@givetrack.com', 'sample_hash_admin');

-- 2. Insert Application Users
INSERT INTO app_user (username, email, password_hash, role)
VALUES
('admin', 'appadmin@givetrack.com', 'sample_hash_1', 'ADMIN'),
('donation_manager', 'donation@givetrack.com', 'sample_hash_2', 'DONATION_MANAGER'),
('allocation_manager', 'allocation@givetrack.com', 'sample_hash_3', 'ALLOCATION_MANAGER'),
('viewer', 'viewer@givetrack.com', 'sample_hash_4', 'VIEWER');

-- 3. Insert Donors
INSERT INTO donor (donor_name, phone, email, address)
VALUES
('Rahul Sharma', '9876543210', 'rahul@example.com', 'Hubballi'),
('Priya Patil', '9876501234', 'priya@example.com', 'Dharwad'),
('Arun Kumar', '9876512345', 'arun@example.com', 'Belagavi');

-- 4. Insert Beneficiaries
INSERT INTO beneficiary
(beneficiary_name, phone, address, requirement_details)
VALUES
('Ananya', '9876523456', 'Hubballi', 'Educational support'),
('Ramesh', '9876534567', 'Dharwad', 'Medical assistance'),
('Meena', '9876545678', 'Belagavi', 'Food and basic needs');

-- 5. Insert Donations
INSERT INTO donation
(donor_id, admin_id, amount, donation_date, payment_mode, purpose)
VALUES
(1, 1, 10000.00, '2026-11-01', 'UPI', 'Education support'),
(2, 1, 8000.00, '2026-11-02', 'Bank Transfer', 'Medical assistance'),
(3, 1, 5000.00, '2026-11-03', 'Cash', 'General support');

-- 6. Insert Allocations
INSERT INTO allocation
(donation_id, beneficiary_id, admin_id, amount, allocation_date, purpose, status)
VALUES
(1, 1, 1, 4000.00, '2026-11-04', 'Books and fees', 'ALLOCATED'),
(2, 2, 1, 3000.00, '2026-11-05', 'Medical expenses', 'ALLOCATED'),
(3, 3, 1, 2000.00, '2026-11-06', 'Food supplies', 'PENDING');

-- 7. Verify inserted records
SELECT * FROM admin;
SELECT * FROM app_user;
SELECT * FROM donor;
SELECT * FROM beneficiary;
SELECT * FROM donation;
SELECT * FROM allocation;
