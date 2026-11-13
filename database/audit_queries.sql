
USE givetrack_db;

-- 1. View all audit records
SELECT *
FROM audit_log
ORDER BY changed_at DESC;

-- 2. View audit records with user details
SELECT
    a.audit_id,
    u.username,
    a.action_type,
    a.table_name,
    a.record_id,
    a.old_value,
    a.new_value,
    a.changed_at
FROM audit_log a
JOIN app_user u
    ON a.user_id = u.user_id
ORDER BY a.changed_at DESC;

-- 3. Count activities by action type
SELECT
    action_type,
    COUNT(*) AS total_actions
FROM audit_log
GROUP BY action_type;

-- 4. View activities for a particular user
SELECT *
FROM audit_log
WHERE user_id = 1
ORDER BY changed_at DESC;
