CREATE TABLE #TableSizes (
    TableName NVARCHAR(128),
    Rows INT,
    Reserved VARCHAR(50),
    Data VARCHAR(50),
    IndexSize VARCHAR(50),
    Unused VARCHAR(50)
);

INSERT INTO #TableSizes
EXEC sp_msforeachtable 'EXEC sp_spaceused ''?'''

SELECT 
    TableName,
    Rows,
    Reserved,
    Data,
    IndexSize,
    Unused
FROM #TableSizes
ORDER BY 
    CAST(REPLACE(Reserved, ' KB', '') AS INT) DESC;

DROP TABLE #TableSizes;
