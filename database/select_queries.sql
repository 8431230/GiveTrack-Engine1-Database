
-- GiveTrack: Data Retrieval Queries
-- Engine 1: Database and Data Integrity

USE givetrack_db;

-- 1. View all donors
SELECT * FROM donor;

-- 2. View all beneficiaries
SELECT * FROM beneficiary;

-- 3. View donations with donor names
SELECT
    d.donation_id,
    dr.donor_name,
    d.amount,
    d.donation_date,
    d.payment_mode,
    d.purpose
FROM donation d
JOIN donor dr ON d.donor_id = dr.donor_id;

-- 4. View allocations with donor and beneficiary names
SELECT
    a.allocation_id,
    dr.donor_name,
    b.beneficiary_name,
    a.amount,
    a.allocation_date,
    a.status
FROM allocation a
JOIN donation d ON a.donation_id = d.donation_id
JOIN donor dr ON d.donor_id = dr.donor_id
JOIN beneficiary b ON a.beneficiary_id = b.beneficiary_id;

-- 5. Calculate total donations
SELECT SUM(amount) AS total_donations
FROM donation;

-- 6. Calculate total allocated amount
SELECT COALESCE(SUM(amount), 0) AS total_allocated
FROM allocation
WHERE status IN ('ALLOCATED', 'FULFILLED');

-- 7. Calculate remaining amount for each donation
SELECT
    d.donation_id,
    d.amount AS donated_amount,
    COALESCE(SUM(
        CASE
            WHEN a.status IN ('ALLOCATED', 'FULFILLED')
            THEN a.amount
            ELSE 0
        END
    ), 0) AS allocated_amount,
    d.amount - COALESCE(SUM(
        CASE
            WHEN a.status IN ('ALLOCATED', 'FULFILLED')
            THEN a.amount
            ELSE 0
        END
    ), 0) AS remaining_amount
FROM donation d
LEFT JOIN allocation a ON d.donation_id = a.donation_id
GROUP BY d.donation_id, d.amount;
