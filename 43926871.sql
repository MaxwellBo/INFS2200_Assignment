-- INFS2200 Assignment, Semester 2 - 2017

-- Student Number: 43926871
-- Student Name: Maxwell Bo
-- DOG_ID: 3376

--#############################################################################

-- Task 1: Constraints

-- a)
	SELECT OWNER, CONSTRAINT_NAME, TABLE_NAME, SEARCH_CONDITION, INDEX_NAME FROM USER_CONSTRAINTS;

-- b)
	-- C_ID is the primary key of CUSTOMERS
	ALTER TABLE CUSTOMERS ADD CONSTRAINT PK_CUSTOMERS PRIMARY KEY (C_ID);

	-- DOGS.C_ID refers to CUSTOMERS.C_ID
	ALTER TABLE DOGS ADD CONSTRAINT FK_C_ID FOREIGN KEY (C_ID) REFERENCES CUSTOMERS (C_ID);

	-- CUSTOMERS.DOB is not null
	ALTER TABLE CUSTOMERS ADD CONSTRAINT NN_DOB CHECK (DOB IS NOT NULL);

	-- Check: SERVICE_HISTORY.FINISHED must be equal to ‘T’ or ‘F’.
	ALTER TABLE SERVICE_HISTORY ADD CONSTRAINT CK_FINISHED CHECK (FINISHED IN ('T', 'F'));

	-- Check: Customers were born in the year 1998 or earlier.
	ALTER TABLE CUSTOMERS ADD CONSTRAINT CK_DOB CHECK (DOB < '01-JAN-1999');

	-- Check: START_TIME is not greater than or equal to END_TIME
	ALTER TABLE SERVICE_HISTORY_DETAIL ADD CONSTRAINT CK_START_TIME_END_TIME CHECK (START_TIME < END_TIME);

	-- Check: SERVICE_HISTORY_DETAIL.END_TIME is not greater than or equal than dates in the year 2018
	ALTER TABLE SERVICE_HISTORY_DETAIL ADD CONSTRAINT CK_SERVICE_DATE CHECK (END_TIME < '01-JAN-2018')

--#############################################################################

-- Task 2: Triggers

-- a)
	CREATE SEQUENCE 'SEQ_CUSTOMER' MINVALUE 10000
	INCREMENT BY 1 START WITH 10000;

	CREATE OR REPLACE TRIGGER 'TR_CUSTOMER_ID'
		BEFORE INSERT ON 'CUSTOMERS'
		FOR EACH ROW
	BEGIN
		SELECT "SEQ_CUSTOMER".NEXTVAL INTO :NEW.C_ID FROM DUAL;
	END;
	/

-- b)
	CREATE SEQUENCE 'SEQ_SERVICE_HISTORY' MINVALUE 125000
	INCREMENT BY 1 START WITH 125000;

	CREATE OR REPLACE TRIGGER 'TR_SERVICE_ID'
		BEFORE INSERT ON 'SERVICE_HISTORY'
		FOR EACH ROW
	BEGIN
		SELECT 'SEQ_SERVICE_HISTORY'.NEXTVAL INTO :NEW.SERVICE_ID FROM DUAL;
	END;
	/

-- c)
	CREATE OR REPLACE TRIGGER 'TR_SERVICE_HISTORY_MESSAGE'
		AFTER INSERT OR UPDATE ON 'SERVICE_HISTORY'
		FOR EACH ROW
	BEGIN
	END;
	/

-- d)
	INSERT INTO CUSTOMERS (F_NAME, L_NAME, DOB)
	VALUES ('Luke', 'Cheung', '08-OCT-1996');

	INSERT INTO SERVICE_HISTORY (DOG_ID, STORE_ID, FINISHED) 
	VALUES (1234, 30, 'F')

--#############################################################################

-- Task 3: Views

-- a)
	CREATE VIEW 'V_DOG_BREED_STATISTICS' AS
	SELECT D.DOG_BREED, SUM(S.PRICE), AVG(S.PRICE), STDEVP(S.PRICE)
	FROM DOGS D, SERVICE_HISTORY SH, SERVICE_HISTORY_DETAIL SHD, SERVICES S
	WHERE D.DOG_ID = SH.DOG_ID 
		AND SH.SERVICE_ID = SHD.SERVICE_ID 
		AND SHD.SERVICE_NAME = S.SERVICE_NAME
	GROUP BY D.DOG_BREED;

-- b)
	CREATE MATERIALIZED VIEW 'MV_DOG_BREED_STATISTICS' 
	BUILD IMMEDIATE 
	AS
	SELECT D.DOG_BREED, SUM(S.PRICE), AVG(S.PRICE), STDEVP(S.PRICE)
	FROM DOGS D, SERVICE_HISTORY SH, SERVICE_HISTORY_DETAIL SHD, SERVICES S
	WHERE D.DOG_ID = SH.DOG_ID 
		AND SH.SERVICE_ID = SHD.SERVICE_ID 
		AND SHD.SERVICE_NAME = S.SERVICE_NAME
	GROUP BY D.DOG_BREED;

-- c) Note this question also has an explanation component. 
	SET TIMING ON;

	SELECT * FROM V_DOG_BREED_STATISTICS;

	SELECT * FROM MV_DOG_BREED_STATISTICS;

--#############################################################################

-- Task 4: Function Based Indexes

-- a)

-- b)

-- c) Note this question also has an explanation component. 

--#############################################################################

-- Task 5: Bitmap Indexing

-- a)

-- b)

-- c) Note this question also has an explanation component. 

-- d) Note this question also has an explanation component. 

--#############################################################################

-- Task 6: Execution Plan & Analysis

-- b)

-- c) Note this question also has an explanation component. 

-- d) Note this question also has an explanation component. 

-- e)

--#############################################################################
