
USE givetrack_db;

-- 1. Start a transaction
START TRANSACTION;

-- 2. Lock the donation record while checking its balance
SELECT
    donation_id,
    amount
FROM donation
WHERE donation_id = 1
FOR UPDATE;

-- 3. Check the amount already allocated
SELECT
    donation_id,
    COALESCE(SUM(amount), 0) AS total_allocated
FROM allocation
WHERE donation_id = 1
  AND status IN ('ALLOCATED', 'FULFILLED')
GROUP BY donation_id;

-- 4. Check the donation's remaining balance
SELECT
    d.donation_id,
    d.amount AS total_donation,
    COALESCE(SUM(
        CASE
            WHEN a.status IN ('ALLOCATED', 'FULFILLED')
            THEN a.amount
            ELSE 0
        END
    ), 0) AS total_allocated,
    d.amount - COALESCE(SUM(
        CASE
            WHEN a.status IN ('ALLOCATED', 'FULFILLED')
            THEN a.amount
            ELSE 0
        END
    ), 0) AS remaining_balance
FROM donation d
LEFT JOIN allocation a
    ON d.donation_id = a.donation_id
WHERE d.donation_id = 1
GROUP BY d.donation_id, d.amount;

-- 5. End the read-only demonstration transaction
COMMIT;
