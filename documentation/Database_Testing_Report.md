# GiveTrack – Database Integration Guide

## 1. Database Details
- Database Name: givetrack_db
- DBMS: MySQL
- Storage Engine: InnoDB

## 2. Main Tables
- admin
- donor
- beneficiary
- donation
- allocation
- app_user
- audit_log

## 3. Important Relationships
- A donor can make multiple donations.
- An admin can record donations.
- A donation can have multiple allocations.
- A beneficiary can receive multiple allocations.
- An admin can manage allocations.

## 4. Important Database Rules
1. Donation amount must be greater than zero.
2. Allocation amount must be greater than zero.
3. Foreign keys must reference existing records.
4. Total allocations must not exceed the available donation balance.
5. Allocation status must be valid.

## 5. Integration Requirements
- Connect Java using JDBC.
- Use prepared statements.
- Use transactions for allocation operations.
- Validate the available balance before allocation.
- Record relevant application activities in audit_log.

## 6. Database Connection
URL: jdbc:mysql://localhost:3306/givetrack_db

Username: Your MySQL username

Password: Your MySQL password

## 7. Conclusion
The database is prepared for integration with the GiveTrack business logic and web interface.