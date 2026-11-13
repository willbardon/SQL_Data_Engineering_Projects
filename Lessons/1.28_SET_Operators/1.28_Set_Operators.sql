--We can create lists in SQL using []

SELECT [1,1,1,2];

--To put into rows we use the UNNEST() function:

SELECT UNNEST([1,1,1,2]);

--We create table B:


SELECT UNNEST([1,1,3]);

--To combine these tables without duplictation we use the UNION operator:

SELECT UNNEST([1,1,1,2])
UNION
SELECT UNNEST([1,1,3]);

--To combine these tables with all values from each we use the UNION ALL operator:

SELECT UNNEST([1,1,1,2])
UNION ALL
SELECT UNNEST([1,1,3]);

--To return only rows in both tables without duplication we use the INTERSECT operator:

SELECT UNNEST([1,1,1,2])
INTERSECT
SELECT UNNEST([1,1,3]);

-- To return only rows in both tables with duplication we use the INTERSECT ALL operator.
-- Repeat instances of values in one table that do not have a corresponding repeat value in the other table will not be returned however.

SELECT UNNEST([1,1,1,2])
INTERSECT ALL
SELECT UNNEST([1,1,3]);

-- To return values that exist only in Table A without duplication, we use the EXCEPT operator:

SELECT UNNEST([1,1,1,2])
EXCEPT
SELECT UNNEST([1,1,3]);

-- To return values in Table A that do not have a correponding pair value in Table B, we use the INTERSECT ALL operator.
-- This is the complement of INTERSECT ALL. Only pairs across tables are removed. Unlike EXCEPT, EXCEPT ALL returns "1" once from A here because there is one instance of it without a corresponding "1" in B. 

SELECT UNNEST([1,1,1,2])
EXCEPT ALL
SELECT UNNEST([1,1,3]);