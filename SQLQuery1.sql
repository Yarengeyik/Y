select*
from MüsteriAnalizi..CustomerData

-- Data Cleaning
UPDATE MüsteriAnalizi..CustomerData
SET Surname = REPLACE(Surname, '?', '')
WHERE Surname LIKE '%?%'

select Surname
from MüsteriAnalizi..CustomerData

select*
from MüsteriAnalizi..CustomerData

UPDATE MüsteriAnalizi..CustomerData
SET Age = NULL
WHERE Age < 0 OR Age > 120

DELETE FROM MüsteriAnalizi..CustomerData
WHERE CustomerId IN (
    SELECT CustomerId
    FROM (
        SELECT CustomerId,
            ROW_NUMBER() OVER(PARTITION BY CustomerId ORDER BY CustomerId) AS RowNumber
        FROM MüsteriAnalizi..CustomerData
    ) AS Temp
    WHERE RowNumber > 1
)

select *
from MüsteriAnalizi..CustomerData

--Data Analysis

Select COUNT(*)
from MüsteriAnalizi..CustomerData

select COUNT(*) as AyrılanMusteri
from MüsteriAnalizi..CustomerData
where Exited = 1

--Aktif müşteri sayısı 1000 kişi içerisinden 5151

select COUNT(*) as AktifMusteri
from MüsteriAnalizi..CustomerData
where IsActiveMember = 1

--Aktif müşteri olup bankadan ayrılan sayısı 735

select COUNT(*) as AktifMusteri
from MüsteriAnalizi..CustomerData
where IsActiveMember = 1 and Exited = 1


SELECT 
    Geography,
    Gender,
    AVG(Age) AS AvgAge,
    AVG(CreditScore) AS AvgCreditScore,
    AVG(Tenure) AS AvgTenure,
    AVG(Balance) AS AvgBalance,
    AVG(NumOfProducts) AS AvgNumOfProducts,
    AVG(HasCrCard) AS AvgHasCrCard,
    AVG(IsActiveMember) AS AvgIsActiveMember,
    AVG(EstimatedSalary) AS AvgEstimatedSalary,       
    COUNT(*) AS AyrılanMusteri
FROM 
    MüsteriAnalizi..CustomerData
WHERE 
    Exited = 1
GROUP BY 
    Geography, Gender


SELECT *, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS

SELECT *, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'CustomerData' AND TABLE_SCHEMA = 'MüsteriAnalizi'


ALTER TABLE MüsteriAnalizi..CustomerData
ALTER COLUMN HasCrCard FLOAT;

ALTER TABLE MüsteriAnalizi..CustomerData
ALTER COLUMN Balance FLOAT;
--Ortalama salary çalışmadı o yüzden birkaç sorgu denendi.
SELECT DISTINCT EstimatedSalary
FROM MüsteriAnalizi..CustomerData;

UPDATE MüsteriAnalizi..CustomerData
SET EstimatedSalary = REPLACE(EstimatedSalary, '.', ',')

ALTER TABLE MüsteriAnalizi..CustomerData
ALTER COLUMN EstimatedSalary FLOAT;

SELECT 
    Geography,
    Gender,
    AVG(Age) AS AvgAge,
    AVG(CreditScore) AS AvgCreditScore,
	AVG(Tenure) AS AvgTenure,
	AVG(NumOfProducts) AS AvgNumOfProducts,
	AVG(IsActiveMember) AS AvgIsActiveMember,
	AVG(HasCrCard) AS AvgHasCrCard,
	AVG(Balance) AS AvgBalance,
    COUNT(*) AS AyrılanMusteri
FROM 
    MüsteriAnalizi..CustomerData
WHERE 
    Exited = 1
GROUP BY 
    Geography, Gender

--Geography	Gender	Age	CreditScore	Tenure	NumOfProducts	IsActiveMember	HasCrCard	Balance	AyrılanMüşteri
--Germany	Male	44,97540984	643,9644809	4,920765027	1,43989071	0,357923497	0,710382514	121202,2424	366
--Germany	Female	44,828125	650,7321429	5,075892857	1,466517857	0,368303571	0,707589286	119673,8723	448
--Spain	Male	44,82967033	650,1758242	4,626373626	1,406593407	0,351648352	0,664835165	73167,8678	182
--Spain	Female	43,61038961	645,3636364	4,67965368	1,597402597	0,333333333	0,67965368	71997,67368	231
--France	Male	44,85754986	639,6923077	5,113960114	1,433048433	0,358974359	0,709401709	75760,13447	351
--France	Female	45,3326087	643,8978261	4,92173913	1,510869565	0,373913043	0,697826087	67755,16263	460


SELECT 
    Geography,
    Gender,
    AVG(Age) AS AvgAge,
    AVG(CreditScore) AS AvgCreditScore,
	AVG(Tenure) AS AvgTenure,
	AVG(NumOfProducts) AS AvgNumOfProducts,
	AVG(IsActiveMember) AS AvgIsActiveMember,
	AVG(HasCrCard) AS AvgHasCrCard,
	AVG(Balance) AS AvgBalance,
    COUNT(*) AS AyrılanMusteri
FROM 
    MüsteriAnalizi..CustomerData
WHERE 
    Exited = 1 and IsActiveMember = 1
GROUP BY 
    Geography, Gender

--Germany	Male	45	657,9770992	4,732824427	1,496183206	1	0,664122137	121841,6647	131
--Germany	Female	44,73333333	649,630303	4,963636364	1,503030303	1	0,678787879	119662,5758	165
--Spain	Male	44,703125	635	4	1,375	1	0,640625	71488,5625	64
--Spain	Female	43,31168831	636,2727273	4,532467532	1,675324675	1	0,61038961	82550,73312	77
--France	Male	44,88888889	638,4206349	4,968253968	1,555555556	1	0,650793651	69755,94865	126
--France	Female	45,19186047	644,1802326	4,941860465	1,575581395	1	0,656976744	67989,30669	172



SELECT 
    Geography,
    Gender,
    AVG(Age) AS AvgAge,
    AVG(CreditScore) AS AvgCreditScore,
	AVG(Tenure) AS AvgTenure,
	AVG(NumOfProducts) AS AvgNumOfProducts,
	AVG(IsActiveMember) AS AvgIsActiveMember,
	COUNT(HasCrCard) AS AvgHasCrCard,
	AVG(Balance) AS AvgBalance,
    COUNT(*) AS AyrılanMusteri
FROM 
    MüsteriAnalizi..CustomerData
WHERE 
    Exited = 1 and IsActiveMember = 0
GROUP BY 
    Geography, Gender

--Müşteri memnuniyet oranı

SELECT 
    Geography,
    Gender,
    AVG(Age) AS AvgAge,
    AVG(CreditScore) AS AvgCreditScore,
    AVG(Balance) AS AvgBalance,
    AVG([Satisfaction Score]) AS AvgSatisfactionScore
FROM 
    MüsteriAnalizi..CustomerData
GROUP BY 
    Geography, Gender;

SELECT 
    Geography,
    Gender,
    AVG(Age) AS AvgAge,
    AVG(CreditScore) AS AvgCreditScore,
    AVG(Balance) AS AvgBalance,
    AVG([Satisfaction Score]) AS AvgSatisfactionScore
FROM 
    MüsteriAnalizi..CustomerData
Where Exited = 1
GROUP BY 
    Geography, Gender;

	--Müşteri Segmentasyonu ve Hedefleme
SELECT 
    CASE 
        WHEN Age BETWEEN 18 AND 30 THEN 'Genç'
        WHEN Age BETWEEN 31 AND 50 THEN 'Orta yaş'
        ELSE 'Yaşlı' 
    END AS YasSegmenti,
    CASE 
        WHEN CreditScore BETWEEN 300 AND 600 THEN 'Düşük Kredi Puanı'
        WHEN CreditScore BETWEEN 601 AND 800 THEN 'Orta Kredi Puanı'
        ELSE 'Yüksek Kredi Puanı' 
    END AS KrediPuanıSegmenti,
    COUNT(*) AS SegmenttekiMüşteriSayısı
FROM 
    MüsteriAnalizi..CustomerData
GROUP BY 
    CASE 
        WHEN Age BETWEEN 18 AND 30 THEN 'Genç'
        WHEN Age BETWEEN 31 AND 50 THEN 'Orta yaş'
        ELSE 'Yaşlı' 
    END,
    CASE 
        WHEN CreditScore BETWEEN 300 AND 600 THEN 'Düşük Kredi Puanı'
        WHEN CreditScore BETWEEN 601 AND 800 THEN 'Orta Kredi Puanı'
        ELSE 'Yüksek Kredi Puanı' 
    END
	order by KrediPuanıSegmenti

--Yaş Segmenti	Kredi Puanı Segmenti	Segmentteki Müşteri Sayısı
--Yasli	Düsük Kredi Puani	388
--Genç	Düsük Kredi Puani	605
--Orta yas	Düsük Kredi Puani	2073
--Yasli	Orta Kredi Puani	794
--Genç	Orta Kredi Puani	1240
--Orta yas	Orta Kredi Puani	4255
--Yasli	Yüksek Kredi Puani	79
--Genç	Yüksek Kredi Puani	123
--Orta yas	Yüksek Kredi Puani	443

Select * 
from MüsteriAnalizi..CustomerData

