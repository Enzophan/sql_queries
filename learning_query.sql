select * from STAFF;

insert into staff (staff_id, staff_type, school_id, first_name, last_name, age, dob, gender, join_date, address_id)
values ('STF2099', 'Non-Teaching', 'SCHL1001', 'Shamala', 'Devi', '56', TO_DATE('03/09/1964', 'DD/MM/YYYY'), 'F', TO_DATE('05/12/2021', 'DD/MM/YYYY'), 'ADR1009');

CREATE Table STAFF
(
STAFF_ID VARCHAR(20),
STAFF_TYPE VARCHAR(30),
SCHOOL_ID VARCHAR(20),
FIRST_NAME VARCHAR(100) NOT NULL,
LAST_NAME VARCHAR(100) NOT NULL,
AGE INT,
DOB DATE,
GENDER VARCHAR(10) CHECK (GENDER IN ('M', 'F')),
JOIN_DATE DATE,
ADDRESS_ID VARCHAR(20),
CONSTRAINT PR_STF PRIMARY KEY (STAFF_ID),
CONSTRAINT FR_STAFF_SCHL FOREIGN KEY (SCHOOL_ID) REFERENCES SCHOOL(SCHOOL_ID),
CONSTRAINT FR_STAFF_ADDR FOREIGN KEY (ADDRESS_ID) REFERENCES ADDRESS(ADDRESS_ID)
);

ALTER TABLE STAFF DROP COLUMN JOIN_DATE;
ALTER TABLE STAFF ALTER COLUMN AGE TYPE VARCHAR(5);
ALTER TABLE STAFF RENAME TO STAFF_NEW;

select * from STAFF_NEW;
ALTER TABLE STAFF_NEW RENAME COLUMN FIRST_NAME TO FULL_NAME;
ALTER TABLE STAFF_NEW ADD CONSTRAINT UNQ_STF UNIQUE (STAFF_TYPE);
DROP TABLE STAFF_NEW;

-- DML Commands
SELECT * FROM address;

INSERT INTO address (address_id, street, city, state, country)
VALUES ('ADR9001', '12342 St20', 'Richmond', 'Virginia', 'United States');

INSERT INTO address(address_id, street, city, country)
VALUES ('ADR9002', '199/11 Nguyen Phuoc Nguyen', 'Da Nang', 'Viet Nam');

INSERT INTO address
VALUES ('ADR9999', '47 Ham Nghi', 'Richmond', 'Virginia', 'United States');

SELECT * FROM address WHERE address_id = 'ADR9999';

UPDATE address
SET country = 'Viet Nam'
WHERE address_id = 'ADR9999';

UPDATE address
SET country = 'Viet Nam', state = null
WHERE address_id = 'ADR9999';

DELETE FROM address WHERE address_id = 'ADR9999';