/*

Cleaning Data in SQL Queries

*/
select *
from [Data Cleaning]..HouseData


select SaleDateConverted, CONVERT(Date,SaleDate)
from [Data Cleaning]..HouseData

ALTER TABLE HouseData
Add SaleDateConverted Date;

Update HouseData
SET SaleDateConverted = CONVERT(Date,SaleDate)

--Populate Property Address data null değer için

select PropertyAddress
from [Data Cleaning]..HouseData
where PropertyAddress is Null

--Join

Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
From [Data Cleaning]..HouseData a
JOIN [Data Cleaning]..HouseData b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null

Update a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
From [Data Cleaning]..HouseData a
JOIN [Data Cleaning]..HouseData b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null

--Adres verisi içinde hem adres hem şehir hem de state var bunları bölücez.

select PropertyAddress
from HouseData
order by ParcelID


select
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 ) as Address
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress)) as City
from [Data Cleaning]..HouseData

ALTER TABLE HouseData
Add PropertySplitAdress Nvarchar(300);

Update HouseData
SET PropertySplitAdress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 )

ALTER TABLE HouseData
Add PropertySplitCity Nvarchar(300);

Update HouseData
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress))

select *
from HouseData

---Owner Adresi revize etmek

Select OwnerAddress
From [Data Cleaning]..HouseData


Select
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
From [Data Cleaning]..HouseData

ALTER TABLE HouseData
Add OwnerSplitAddress Nvarchar(300);

Update HouseData
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)


ALTER TABLE HouseData
Add OwnerSplitCity Nvarchar(300);

Update HouseData
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)



ALTER TABLE HouseData
Add OwnerSplitState Nvarchar(300);

Update HouseData
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)

Select *
From [Data Cleaning]..HouseData

-- Yes,No verilerini değiştirmek

Select Distinct(SoldAsVacant), Count(SoldAsVacant)
From [Data Cleaning]..HouseData
Group by SoldAsVacant
order by 2

Select SoldAsVacant
, CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END
From [Data Cleaning]..HouseData

Update HouseData
SET SoldAsVacant = CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END

Select *
From [Data Cleaning]..HouseData

Select Distinct(SoldAsVacant), Count(SoldAsVacant)
From [Data Cleaning]..HouseData
Group by SoldAsVacant
order by 2

-- Remove Duplicates

WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num
From [Data Cleaning]..HouseData
)
Select *
From RowNumCTE
Where row_num > 1
Order by PropertyAddress

-- Kullanılmayan satırları silmek

Select *
From [Data Cleaning]..HouseData


ALTER TABLE [Data Cleaning]..HouseData
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate
