
# GiveTrack – Community Donation Ledger with Allocation Tracking

## 1. Project Overview

GiveTrack is a database-driven system designed to manage community donations and their allocation to beneficiaries.

The system stores donor details, beneficiary details, donation records and allocation records. It helps maintain accurate financial information and track the remaining donation balance.

## 2. Database Information

- Database Name: givetrack_db
- Database: MySQL
- Storage Engine: InnoDB
- Project Module: Engine 1 – Database and Data Integrity

## 3. Database Tables

The database contains seven tables.

### 3.1 admin
Stores administrator information.

- admin_id – Primary Key
- admin_name
- email
- password_hash
- created_at

### 3.2 app_user
Stores application user accounts and roles.

- user_id – Primary Key
- username
- email
- password_hash
- role
- is_active
- created_at

### 3.3 donor
Stores information about people who donate.

- donor_id – Primary Key
- donor_name
- phone
- email
- address
- created_at

### 3.4 beneficiary
Stores information about people receiving assistance.

- beneficiary_id – Primary Key
- beneficiary_name
- phone
- address
- requirement_details
- created_at

### 3.5 donation
Stores donation transactions.

- donation_id – Primary Key
- donor_id – Foreign Key
- admin_id – Foreign Key
- amount
- donation_date
- payment_mode
- purpose
- created_at

### 3.6 allocation
Stores donation allocation details.

- allocation_id – Primary Key
- donation_id – Foreign Key
- beneficiary_id – Foreign Key
- admin_id – Foreign Key
- amount
- allocation_date
- purpose
- status
- created_at

### 3.7 audit_log
Stores records of application activities.

- audit_id – Primary Key
- user_id – Foreign Key
- action_type
- table_name
- record_id
- old_value
- new_value
- changed_at

## 4. Primary Keys

Every table has a primary key to uniquely identify each record.

## 5. Foreign Keys

The database uses foreign keys to maintain relationships:

- donation.donor_id references donor.donor_id
- donation.admin_id references admin.admin_id
- allocation.donation_id references donation.donation_id
- allocation.beneficiary_id references beneficiary.beneficiary_id
- allocation.admin_id references admin.admin_id
- audit_log.user_id references app_user.user_id

## 6. Data Integrity Constraints

The database uses:

- NOT NULL constraints for mandatory fields.
- UNIQUE constraints for email addresses.
- PRIMARY KEY constraints for unique identification.
- FOREIGN KEY constraints for relationships.
- CHECK constraints to ensure donation and allocation amounts are greater than zero.
- ENUM constraints for user roles and allocation statuses.

## 7. Allocation Status

The allocation table supports four statuses:

- PENDING
- ALLOCATED
- FULFILLED
- CANCELLED

## 8. Remaining Balance Calculation

Remaining balance is calculated using:

Remaining Balance = Total Donation - Total Allocated Amount

The balance is calculated from donation and allocation records rather than stored as an independently editable value.

The current reporting queries count ALLOCATED and FULFILLED records as allocated amounts.

## 9. SQL Operations Implemented

The database module includes:

- CREATE operations for database tables.
- INSERT operations for sample records.
- SELECT operations to retrieve information.
- JOIN operations to combine related records.
- UPDATE operations to modify permitted details.
- Transaction queries to demonstrate transaction handling.
- Audit queries to retrieve activity history.

## 10. Conclusion

The GiveTrack database provides structured storage for donors, beneficiaries, donations and allocations. Primary keys, foreign keys and constraints help maintain data consistency.

The database module supports the other project engines by providing a common and reliable data foundation.
