select *
from [Nashville Housing]

-- 1. CHUẨN HÓA ĐỊNH DẠNG NGÀY THÁNG
UPDATE [Nashville Housing]
Set SaleDate = convert(date,SaleDate)

-- 2. ĐIỀN DỮ LIỆU PROPERTYADDRESS
-- Kiểm tra các dữ liệu PropertyAddress bị Null 
select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
from [Nashville Housing] a 
join [Nashville Housing] b 
on a.ParcelID = b.ParcelID
and a.UniqueID <> b.UniqueID
where a.PropertyAddress is null

-- Điền các dữ liệu bị Null
Update a
Set PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
From [Nashville Housing] a 
join [Nashville Housing] b 
on a.ParcelID = b.ParcelID
and a.UniqueID <> b.UniqueID
where a.PropertyAddress is null

-- 3. TÁCH ADDRESS THÀNH CÁC CỘT (ADDRESS, CITY, STATE)
select *
from [Nashville Housing]

-- Cột PropertyAddress
Select 
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) as Address,
SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, len(PropertyAddress)) as Address
from [Nashville Housing]

alter table [Nashville Housing]
add PropertySplitAddress nvarchar(255);
update [Nashville Housing]
set PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1)

alter table [Nashville Housing]
add PropertySplitCity nvarchar(255);
update [Nashville Housing]
set PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, len(PropertyAddress))

-- Cột OwnerAddress
select OwnerAddress
from [Nashville Housing]

select 
PARSENAME(Replace(OwnerAddress, ',', '.'), 3)
,PARSENAME(Replace(OwnerAddress, ',', '.'), 2)
,PARSENAME(Replace(OwnerAddress, ',', '.'), 1)
from [Nashville Housing]

alter table [Nashville Housing]
add OwnerSplitAddress nvarchar(255);
update [Nashville Housing]
set OwnerSplitAddress = PARSENAME(Replace(OwnerAddress, ',', '.'), 3)

alter table [Nashville Housing]
add OwnerSplitCity nvarchar(255);
update [Nashville Housing]
set OwnerSplitCity = PARSENAME(Replace(OwnerAddress, ',', '.'), 2)

alter table [Nashville Housing]
add OwnerSplitState nvarchar(255);
update [Nashville Housing]
set OwnerSplitState = PARSENAME(Replace(OwnerAddress, ',', '.'), 1)

-- 4. ĐỔI N VÀ Y TRONG CỘT SoldAsVacant THÀNH NO VÀ YES

select distinct(SoldAsVacant), COUNT(SoldAsVacant) count
from [Nashville Housing]
group by SoldAsVacant
order by 2

select SoldAsVacant
,case when SoldAsVacant = 'Y' then 'Yes'
      when SoldAsVacant = 'N' then 'No'
      else SoldAsVacant
      end
from [Nashville Housing]

UPDATE [Nashville Housing]
set SoldAsVacant = 
    case when SoldAsVacant = 'Y' then 'Yes'
         when SoldAsVacant = 'N' then 'No'
         else SoldAsVacant
         end

-- 5. LOẠI BỎ CÁC GIÁ TRỊ TRÙNG LẮP

with rownum as(
Select *,
    ROW_NUMBER() over
    (Partition by ParcelID,
                  PropertyAddress,
                  SalePrice,
                  SaleDate, 
                  LegalReference
                  order by 
                    uniqueID 
    ) row_num
from [Nashville Housing]
)
Delete
from rownum
where row_num > 1

-- 6. XÓA CÁC CỘT KHÔNG SỬ DỤNG ĐẾN

SELECT *
from [Nashville Housing]

alter TABLE [Nashville Housing]
drop column OwnerAddress, TaxDistrict, PropertyAddress