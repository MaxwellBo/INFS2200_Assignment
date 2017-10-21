-- INFS2200 Assignment, Semester 2 - 2017

-- Student Number: 43926871
-- Student Name: Maxwell Bo
-- DOG_ID: 3376

--#############################################################################

-- Task 1: Constraints

-- a)
	SELECT OWNER, CONSTRAINT_NAME, TABLE_NAME, SEARCH_CONDITION, INDEX_NAME FROM USER_CONSTRAINTS;

-- b)
	# C_ID is the primary key of CUSTOMERS
	ALTER TABLE CUSTOMERS ADD CONSTRAINT PK_CUSTOMERS PRIMARY KEY (C_ID);

	# DOGS.C_ID refers to CUSTOMERS.C_ID
	ALTER TABLE DOGS ADD CONSTRAINT FK_C_ID FOREIGN KEY (C_ID) REFERENCES CUSTOMERS (C_ID);

	# CUSTOMERS.DOB is not null
	ALTER TABLE CUSTOMERS ADD CONSTRAINT NN_DOB CHECK (DOB IS NOT NULL);

	# Check: SERVICE_HISTORY.FINISHED must be equal to ‘T’ or ‘F’.
	ALTER TABLE SERVICE_HISTORY ADD CONSTRAINT CK_FINISHED CHECK (FINISHED IN ('T', 'F'));

	# Check: Customers were born in the year 1998 or earlier.
	ALTER TABLE CUSTOMERS ADD CONSTRAINT CK_DOB CHECK (DOB < "1999-01-01");

	# Check: START_TIME is not greater than or equal to END_TIME
	ALTER TABLE SERVICE_HISTORY_DETAIL ADD CONSTRAINT CK_START_TIME_END_TIME CHECK (START_TIME < END_TIME);

	# Check: SERVICE_HISTORY_DETAIL.END_TIME is not greater than or equal than dates in the year 2018
	ALTER TABLE SERVICE_HISTORY_DETAIL ADD CONSTRAINT CK_SERVICE_DATE CHECK (END_TIME < "2018-01-01")

--#############################################################################

-- Task 2: Triggers

-- a)

-- b)

-- c)

-- d)

--#############################################################################

-- Task 3: Views

-- a)

-- b)

-- c) Note this question also has an explanation component. 

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
