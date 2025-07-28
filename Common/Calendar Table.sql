SET DATEFIRST 6

DECLARE @StartDate DATE
DECLARE @EndDate DATE
SET @StartDate = '2025-01-01'
SET @EndDate = DATEADD(year , 5, @StartDate)

DROP TABLE IF EXISTS #Calendar
CREATE TABLE #Calendar(
                          ID INT IDENTITY(1, 1) NOT NULL,
                          DayDate DATE,
                          WeekNo INT,
                          UniqueWeekNo INT,
                          DayNo INT,
                          FullDate NVARCHAR(50),
                          ShortDate NVARCHAR(50),
                          YearMonthDate NVARCHAR(50),
                          CutoffDate DATE
)

    WHILE @StartDate <= @EndDate
BEGIN
INSERT INTO #Calendar (
    DayDate, WeekNo, UniqueWeekNo,
    DayNo, FullDate, ShortDate, YearMonthDate, CutoffDate)
SELECT @StartDate,
       DATEPART(week, @StartDate),
       CONVERT(INT, FORMAT( @StartDate, 'yyyy')) + DATEPART(week, @StartDate),
       DATEPART(Weekday, @StartDate),
       FORMAT(@StartDate, 'dddd dd-MMMM-yyyy'),
       FORMAT(@StartDate, 'dd/MM/yyyy'),
       FORMAT(@StartDate, 'MMM-yyyy'),
       DATEADD(day, 7 - DATEPART(Weekday, @StartDate), @StartDate)

    SET @StartDate = DATEADD(day, 1, @StartDate)
END

SELECT * FROM #Calendar

DROP TABLE IF EXISTS #Calendar