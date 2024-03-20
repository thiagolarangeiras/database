set statistics io on; --on liga e off desliga
set statistics time on; --on liga e off desliga

-- 1
SELECT * FROM MICRODADOS_ENEM_2021_SC

-- 2
-- SEEK
-- cara tanta coisa

-- 3
sp_helpindex MICRODADOS_ENEM_2021_SC
-- The object 'MICRODADOS_ENEM_2021_SC' does not have any indexes, or you do not have permissions.

-- 4
ALTER TABLE MICRODADOS_ENEM_2021_SC ADD CONSTRAINT pk_MICRODADOS_ENEM_2021_SC PRIMARY KEY (NU_INSCRICAO);
-- Table 'MICRODADOS_ENEM_2021_SC'. Scan count 1, logical reads 3072, physical reads 0, page server reads 0, read-ahead reads 0, page server read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob page server reads 0, lob read-ahead reads 0, lob page server read-ahead reads 0.

-- pk_MICRODADOS_ENEM_2021_SC || clustered, unique, primary key || NU_INSCRICAO

-- 5 
-- logical reads 3022 (sem pk)
-- logical reads 2977 (com pk)
-- Clustered index scan

-- 6
-- Não

-- 7 
-- SQL Server parse and compile time: 
--    CPU time = 0 ms, elapsed time = 0 ms.
-- SQL Server parse and compile time: 
--    CPU time = 0 ms, elapsed time = 0 ms.

-- (10 rows affected)
-- Table 'MICRODADOS_ENEM_2021_SC'. Scan count 1, logical reads 2977, physical reads 0, page server reads 0, read-ahead reads 0, page server read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob page server reads 0, lob read-ahead reads 0, lob page server read-ahead reads 0.

--  SQL Server Execution Times:
--    CPU time = 0 ms,  elapsed time = 6 ms.

-- Completion time: 2024-03-19T21:46:51.4135835-03:00

-- 8
-- São iguais

