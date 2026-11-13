
-- GiveTrack: Update Queries
-- Engine 1: Database and Data Integrity

USE givetrack_db;

-- 1. Update donor contact details
UPDATE donor
SET phone = '9876500001',
    address = 'Hubballi'
WHERE donor_id = 1;

-- 2. Update beneficiary requirement details
UPDATE beneficiary
SET requirement_details = 'Educational support - books and fees'
WHERE beneficiary_id = 1;

-- 3. Update allocation status
UPDATE allocation
SET status = 'FULFILLED'
WHERE allocation_id = 1
AND status = 'ALLOCATED';

-- 4. Verify donor update
SELECT * FROM donor WHERE donor_id = 1;

-- 5. Verify beneficiary update
SELECT * FROM beneficiary WHERE beneficiary_id = 1;

-- 6. Verify allocation update
SELECT * FROM allocation WHERE allocation_id = 1;
