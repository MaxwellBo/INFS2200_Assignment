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