

USE CRM_DEV_SDK

-- Show similarities of data
SELECT TEXTNOTE, SOUNDEX('stewarded'), SOUNDEX(TEXTNOTE) AS COMP FROM dbo.DESIGNATIONLEVELNOTE WHERE TEXTNOTE LIKE '%stewarded%' ORDER BY COMP DESC

-- Create temporary table to store migrated data.
CREATE TABLE #TEMP
(
ID UNIQUEIDENTIFIER,
DESIGNATIONLEVELID UNIQUEIDENTIFIER,
STATUS NVARCHAR (25),
STEWARDSHIPNAME NVARCHAR (255),
PREFERREDSCHOOL NVARCHAR (255),
ESTABLISHEDBY NVARCHAR (500),
CONSTITUENTTYPE NVARCHAR (255),
FUNDRESTRICTION NVARCHAR (MAX),
MOADATE NVARCHAR (500),
RESOLUTIONDATE NVARCHAR (MAX),
DEPARTMENT NVARCHAR (500),
ADDEDBYID UNIQUEIDENTIFIER,
CHANGEDBYID UNIQUEIDENTIFIER,
DATEADDED NVARCHAR (255),
DATECHANGED NVARCHAR (255),
TS TIMESTAMP,
TSLONG INT,
)

SP_HELP 'dbo.designationlevelnote'

DROP TABLE #TEMP

-- Insert unique ID's into temp table from note table.
INSERT INTO #TEMP (ID, DESIGNATIONLEVELID) SELECT DBO.DESIGNATIONLEVELNOTE.ID, DBO.DESIGNATIONLEVELNOTE.DESIGNATIONLEVELID FROM DBO.DESIGNATIONLEVELNOTE

-- Update temp table and set extended column 'status' to the designation level note title.
UPDATE #TEMP SET #TEMP.STATUS = dbo.DESIGNATIONLEVELNOTE.TEXTNOTE FROM DBO.DESIGNATIONLEVELNOTE 
INNER JOIN #TEMP ON #TEMP.DESIGNATIONLEVELID = DBO.DESIGNATIONLEVELNOTE.DESIGNATIONLEVELID
WHERE DBO.DESIGNATIONLEVELNOTE.TITLE LIKE '%status%'

-- Update temp table and set extended column 'stewardshipname' to the designation level note title.
UPDATE #TEMP SET #TEMP.STEWARDSHIPNAME = dbo.DESIGNATIONLEVELNOTE.TEXTNOTE FROM DBO.DESIGNATIONLEVELNOTE 
INNER JOIN #TEMP ON #TEMP.DESIGNATIONLEVELID = DBO.DESIGNATIONLEVELNOTE.DESIGNATIONLEVELID
WHERE DBO.DESIGNATIONLEVELNOTE.TITLE LIKE '%stewardship name%'

-- Update temp table and set extended column 'preferred school' to the designation level note title.
UPDATE #TEMP SET #TEMP.PREFERREDSCHOOL = dbo.DESIGNATIONLEVELNOTE.TEXTNOTE FROM DBO.DESIGNATIONLEVELNOTE 
INNER JOIN #TEMP ON #TEMP.DESIGNATIONLEVELID = DBO.DESIGNATIONLEVELNOTE.DESIGNATIONLEVELID
WHERE DBO.DESIGNATIONLEVELNOTE.TITLE LIKE '%preferred school%'

-- Update temp table and set extended column 'established by' to the designation level note title.
UPDATE #TEMP SET #TEMP.ESTABLISHEDBY = dbo.DESIGNATIONLEVELNOTE.TEXTNOTE FROM DBO.DESIGNATIONLEVELNOTE 
INNER JOIN #TEMP ON #TEMP.DESIGNATIONLEVELID = DBO.DESIGNATIONLEVELNOTE.DESIGNATIONLEVELID
WHERE DBO.DESIGNATIONLEVELNOTE.TITLE LIKE '%established by%'

-- Update temp table and set extended column 'constituent type' to the designation level note title.
UPDATE #TEMP SET #TEMP.CONSTITUENTTYPE = dbo.DESIGNATIONLEVELNOTE.TEXTNOTE FROM DBO.DESIGNATIONLEVELNOTE 
INNER JOIN #TEMP ON #TEMP.DESIGNATIONLEVELID = DBO.DESIGNATIONLEVELNOTE.DESIGNATIONLEVELID
WHERE DBO.DESIGNATIONLEVELNOTE.TITLE LIKE '%constituent type%'

-- Update temp table and set extended column 'fund restriction' to the designation level note title.
UPDATE #TEMP SET #TEMP.FUNDRESTRICTION = dbo.DESIGNATIONLEVELNOTE.TEXTNOTE FROM DBO.DESIGNATIONLEVELNOTE 
INNER JOIN #TEMP ON #TEMP.DESIGNATIONLEVELID = DBO.DESIGNATIONLEVELNOTE.DESIGNATIONLEVELID
WHERE DBO.DESIGNATIONLEVELNOTE.TITLE LIKE '%fund restriction%'

-- Update temp table and set extended column 'MOA date' to the designation level note title.
UPDATE #TEMP SET #TEMP.MOADATE = dbo.DESIGNATIONLEVELNOTE.TEXTNOTE FROM DBO.DESIGNATIONLEVELNOTE 
INNER JOIN #TEMP ON #TEMP.DESIGNATIONLEVELID = DBO.DESIGNATIONLEVELNOTE.DESIGNATIONLEVELID
WHERE DBO.DESIGNATIONLEVELNOTE.TITLE LIKE '%MOA Date%'

-- Update temp table and set extended column 'resolution date' to the designation level note title.
UPDATE #TEMP SET #TEMP.RESOLUTIONDATE = dbo.DESIGNATIONLEVELNOTE.TEXTNOTE FROM DBO.DESIGNATIONLEVELNOTE 
INNER JOIN #TEMP ON #TEMP.DESIGNATIONLEVELID = DBO.DESIGNATIONLEVELNOTE.DESIGNATIONLEVELID
WHERE DBO.DESIGNATIONLEVELNOTE.TITLE LIKE '%resolution%'

-- Update temp table and set extended column 'department' to the designation level note title.
--UPDATE #TEMP SET #TEMP.DEPARTMENT = dbo.DESIGNATIONLEVELNOTE.TEXTNOTE FROM DBO.DESIGNATIONLEVELNOTE 
--INNER JOIN #TEMP ON #TEMP.DESIGNATIONLEVELID = DBO.DESIGNATIONLEVELNOTE.DESIGNATIONLEVELID
--WHERE DBO.DESIGNATIONLEVELNOTE.TITLE LIKE '%department%'

UPDATE #TEMP 
SET #TEMP.ADDEDBYID = dbo.DESIGNATIONLEVELNOTE.ADDEDBYID 
FROM DBO.DESIGNATIONLEVELNOTE INNER JOIN #TEMP ON #TEMP.DESIGNATIONLEVELID = DBO.DESIGNATIONLEVELNOTE.DESIGNATIONLEVELID

UPDATE #TEMP 
SET #TEMP.CHANGEDBYID = dbo.DESIGNATIONLEVELNOTE.CHANGEDBYID
FROM DBO.DESIGNATIONLEVELNOTE INNER JOIN #TEMP ON #TEMP.DESIGNATIONLEVELID = DBO.DESIGNATIONLEVELNOTE.DESIGNATIONLEVELID

UPDATE #TEMP 
SET #TEMP.DATEADDED = dbo.DESIGNATIONLEVELNOTE.DATEADDED
FROM DBO.DESIGNATIONLEVELNOTE INNER JOIN #TEMP ON #TEMP.DESIGNATIONLEVELID = DBO.DESIGNATIONLEVELNOTE.DESIGNATIONLEVELID

UPDATE #TEMP 
SET #TEMP.DATECHANGED = dbo.DESIGNATIONLEVELNOTE.DATECHANGED
FROM DBO.DESIGNATIONLEVELNOTE INNER JOIN #TEMP ON #TEMP.DESIGNATIONLEVELID = DBO.DESIGNATIONLEVELNOTE.DESIGNATIONLEVELID

-- Show changes
SELECT * FROM #TEMP
