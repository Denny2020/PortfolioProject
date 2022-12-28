

/*
Cleaning Data in SQL Queries in MYSQL
*/


SELECT * FROM PortfolioProjects.housing2;

--------------------------------------------------------------------------------------------------------------------------

-- Standardize Date Format


Select CONVERT(SaleDate,Date)
From PortfolioProjects.Housing2;

Select CAST(SaleDate AS Date)
From PortfolioProjects.Housing2;


-- If it doesn't Update properly

ALTER TABLE PortfolioProjects.Housing2
Add SaleDateConverted Date;
SET SQL_SAFE_UPDATES=0;
Update PortfolioProjects.Housing
SET SaleDateConverted = CONVERT(SaleDate,Date);

 -------------------------------------------------------------------------------------------------------------------------

-- Populate Property Address data

Select *
From PortfolioProjects.Housing2
-- Where PropertyAddress is null
order by ParcelID;


Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
From PortfolioProject.housing2 a
JOIN PortfolioProject.housing2 b
on a.ParcelID = b.ParcelID
AND a.UniqueID <> b.UniqueID
Where a.PropertyAddress is null;


Update a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
From PortfolioProjects.housing2 a
JOIN PortfolioProjects.housing2 b
on a.ParcelID = b.ParcelID
AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null;




--------------------------------------------------------------------------------------------------------------------------

-- Breaking out Address into Individual Columns (Address, City, State)


Select PropertyAddress
From PortfolioProjects.housing2
-- Where PropertyAddress is null;
order by ParcelID;

Use PortfolioProjects;
SELECT
SUBSTRING(PropertyAddress, 1, INSTR(PropertyAddress, ',') -1 ) as Address,
SUBSTRING(PropertyAddress,INSTR(PropertyAddress, ',') + 1, length(PropertyAddress)) as Address
From PortfolioProjects.housing2;

SET SQL_SAFE_UPDATES=0;
ALTER TABLE housing2
Add PropertySplitAddress Varchar(255);

Update Housing2
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, INSTR(PropertyAddress, ',') -1 );


ALTER TABLE housing2
Add PropertySplitCity Varchar(255);

Update housing2
SET PropertySplitCity = SUBSTRING(PropertyAddress,INSTR(PropertyAddress, ',') + 1, length(PropertyAddress));




Select *
From PortfolioProjects.housing2;





Select OwnerAddress
From PortfolioProjects.housing2;


Select
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
From PortfolioProjects.housing2;


SELECT 
SUBSTRING_INDEX(OwnerAddress, ',', 1) 
AS Owner_address_one
From PortfolioProjects.housing2;

SELECT 
SUBSTRING_INDEX(SUBSTRING_INDEX(OwnerAddress, ',', 2),',', -1)
AS Owner_City
From PortfolioProjects.housing2;

SELECT
SUBSTRING_INDEX(OwnerAddress, ',', -1) 
AS Owner_State
From PortfolioProjects.housing2;



ALTER TABLE housing2
Add OwnerSplitAddress Varchar(255);

Update housing2
SET OwnerSplitAddress = SUBSTRING_INDEX(OwnerAddress, ',', 1); 


ALTER TABLE housing2
Add OwnerSplitCity Varchar(255);

Update housing2
SET OwnerSplitCity = SUBSTRING_INDEX(SUBSTRING_INDEX(OwnerAddress, ',', 2),',', -1);



ALTER TABLE housing2
Add OwnerSplitState Varchar(255);

Update housing2
SET OwnerSplitState = SUBSTRING_INDEX(OwnerAddress, ',', -1);



Select *
From PortfolioProjects.housing2;




--------------------------------------------------------------------------------------------------------------------------


-- Change Y and N to Yes and No in "Sold as Vacant" field


SELECT DISTINCT
    (SoldAsVacant), COUNT(SoldAsVacant)
FROM
    PortfolioProjects.housing2
GROUP BY SoldAsVacant
ORDER BY 2;




SELECT 
    SoldAsVacant,
    CASE
        WHEN SoldAsVacant = 'Y' THEN 'Yes'
        WHEN SoldAsVacant = 'N' THEN 'No'
        ELSE SoldAsVacant
    END
FROM
    PortfolioProjects.housing2;


UPDATE housing2 
SET 
    SoldAsVacant = CASE
        WHEN SoldAsVacant = 'Y' THEN 'Yes'
        WHEN SoldAsVacant = 'N' THEN 'No'
        ELSE SoldAsVacant
    END;






-----------------------------------------------------------------------------------------------------------------------------------------------------------

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
					) AS row_num
From PortfolioProjects.housing2
-- order by ParcelID
)
Select *
From RowNumCTE
Where row_num > 1
Order by PropertyAddress;



Select *
From PortfolioProjects.housing2;




-- ---------------------------------------------------------------------------------------------------------

-- Delete Unused Columns



Select *
From PortfolioProjects.housing2;


ALTER TABLE PortfolioProjects.housing2
DROP COLUMN OwnerAddress,
DROP COLUMN TaxDistrict,
DROP COLUMN PropertyAddress,
DROP COLUMN SaleDate;










