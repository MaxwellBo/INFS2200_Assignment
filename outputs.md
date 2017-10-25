```sql
SELECT OWNER, CONSTRAINT_NAME, TABLE_NAME, SEARCH_CONDITION, INDEX_NAME FROM USER_CONSTRAINTS;
```

```
SQL> SELECT OWNER, CONSTRAINT_NAME, TABLE_NAME, SEARCH_CONDITION, INDEX_NAME FROM USER_CONSTRAINTS;

OWNER           CONSTRAINT_NAME      TABLE_NAME                SEARCH_CONDITION     INDEX_NAME
--------------- -------------------- ------------------------- -------------------- --------------------
C##S4392687     PK_STORES            STORES                                         PK_STORES
C##S4392687     PK_DOG_BREEDS        DOG_BREEDS                                     PK_DOG_BREEDS
C##S4392687     PK_SERVICES          SERVICES                                       PK_SERVICES
C##S4392687     PK_DOGS              DOGS                                           PK_DOGS
C##S4392687     PK_SERVICE_HISTORY   SERVICE_HISTORY                                PK_SERVICE_HISTORY
C##S4392687     PK_SHD               SERVICE_HISTORY_DETAIL                         PK_SHD
C##S4392687     NN_PRICE             SERVICES                  PRICE IS NOT NULL
C##S4392687     NN_DOG_NAME          DOGS                      DOG_NAME IS NOT NULL
C##S4392687     FK_DOG_BREED         DOGS
C##S4392687     FK_SH_STORE_ID       SERVICE_HISTORY
C##S4392687     FK_SH_DOG_ID         SERVICE_HISTORY
C##S4392687     FK_SHD_SERVICE_ID    SERVICE_HISTORY_DETAIL
C##S4392687     FK_SERVICE_NAME      SERVICE_HISTORY_DETAIL

13 rows selected.
```

```
SQL> ALTER TABLE CUSTOMERS ADD CONSTRAINT PK_CUSTOMERS PRIMARY KEY (C_ID);

Table altered.
```

```
SQL> ALTER TABLE CUSTOMERS MODIFY DOB DATE NOT NULL;

Table altered.
```

```
SQL> CREATE OR REPLACE TRIGGER "TR_CUSTOMER_ID"
  2  BEFORE INSERT ON CUSTOMERS
  3  FOR EACH ROW
  4  BEGIN
  5  SELECT "SEQ_CUSTOMER".NEXTVAL INTO :NEW.C_ID FROM DUAL;
  6  END;
  7  /

Trigger created.
```

```
SQL> CREATE OR REPLACE TRIGGER "TR_SERVICE_ID"
  2  BEFORE INSERT ON SERVICE_HISTORY
  3  FOR EACH ROW
  4  BEGIN
  5  SELECT SEQ_SERVICE_HISTORY.NEXTVAL INTO :NEW.SERVICE_ID FROM DUAL;
  6  END;
  7  /

Trigger created.
```

```
SQL> CREATE OR REPLACE TRIGGER "TR_SERVICE_HISTORY_MESSAGE"
  2  BEFORE INSERT ON SERVICE_HISTORY
  3  FOR EACH ROW
  4  BEGIN
  5  IF :NEW.FINISHED = 'T' THEN
  6     SELECT 'Hi '
  7  || C.F_NAME || ' '
  8  || C.L_NAME || ', your dog '
  9  || D.DOG_NAME || ' of breed: '
 10  || D.DOG_BREED || ' is ready for pick up at '
 11  || S.STORE_AREA || '.'
 12  INTO :NEW.MESSAGE
 13  FROM CUSTOMERS C, DOGS D, STORES S
 14  WHERE C.C_ID = D.C_ID
 15  AND :NEW.STORE_ID = S.STORE_ID
 16  AND :NEW.DOG_ID   = D.DOG_ID;
 17  ELSE
 18  SELECT 'Hi '
 19  || C.F_NAME || ' '
 20  || C.L_NAME || ', your dog '
 21  || D.DOG_NAME || ' of breed: '
 22  || D.DOG_BREED|| ' is not ready to be picked up yet.'
 23  INTO :NEW.MESSAGE
 24  FROM CUSTOMERS C, DOGS D
 25  WHERE C.C_ID = D.C_ID
 26  AND :NEW.DOG_ID = D.DOG_ID;
 27  END IF;
 28  END;
 29  /

Trigger created.
```

```
SQL> INSERT INTO CUSTOMERS (F_NAME, L_NAME, DOB)
  2  VALUES ('Luke', 'Cheung', '08-OCT-1996');

1 row created.
```

```
SQL> SELECT * FROM CUSTOMERS WHERE F_NAME='Luke' AND L_NAME='Cheung';

      C_ID F_NAME          L_NAME          DOB
---------- --------------- --------------- ---------------
     10000 Luke            Cheung          08-OCT-96
```

```
SQL> INSERT INTO SERVICE_HISTORY (DOG_ID, STORE_ID, FINISHED)
  2  VALUES (1234, 30, 'F');

1 row created.
```

```
SQL> SELECT * FROM SERVICE_HISTORY WHERE DOG_ID=1234 AND STORE_ID=30;

    DOG_ID   STORE_ID SERVICE_ID F MESSAGE
---------- ---------- ---------- - ------------------------------
      1234         30     125000 F Hi Lady Finland, your dog Jack
                                   son of breed: English Foxhound
                                    is not ready to be picked up
                                   yet.

```

```
SQL> CREATE VIEW "V_DOG_BREED_STATISTICS" AS
  2  SELECT D.DOG_BREED, SUM(S.PRICE) as TOTAL, AVG(S.PRICE) as MEAN, STDDEV(S.PRICE) as STANDARD_DEVIATION
  3  FROM DOGS D, SERVICE_HISTORY SH, SERVICE_HISTORY_DETAIL SHD, SERVICES S
  4  WHERE D.DOG_ID = SH.DOG_ID
  5  AND SH.SERVICE_ID = SHD.SERVICE_ID
  6  AND SHD.SERVICE_NAME = S.SERVICE_NAME
  7  GROUP BY D.DOG_BREED;

View created.
```

```
SQL> CREATE MATERIALIZED VIEW "MV_DOG_BREED_STATISTICS"
  2  BUILD IMMEDIATE
  3  AS
  4  SELECT D.DOG_BREED, SUM(S.PRICE) as TOTAL, AVG(S.PRICE) as MEAN, STDDEV(S.PRICE) as STANDARD_DEVIATION
  5  FROM DOGS D, SERVICE_HISTORY SH, SERVICE_HISTORY_DETAIL SHD, SERVICES S
  6  WHERE D.DOG_ID = SH.DOG_ID
  7  AND SH.SERVICE_ID = SHD.SERVICE_ID
  8  AND SHD.SERVICE_NAME = S.SERVICE_NAME
  9  GROUP BY D.DOG_BREED;

Materialized view created.
```
