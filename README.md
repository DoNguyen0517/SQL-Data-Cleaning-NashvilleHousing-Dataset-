# SQL Data Cleaning Project (NashvilleHousing Dataset)

### Giới thiệu

Kho lưu trữ này chứa code và tài liệu cho quy trình làm sạch dữ liệu của bộ dữ liệu NashvilleHousing. 
Mục tiêu của dự án này là làm sạch và cải thiện bộ dữ liệu cung cấp thông tin về nhà đất ở Nashville.

### Nguồn dữ liệu và tổng quan

Bộ dữ liệu NashvilleHousing được sử dụng trong dự án này được lấy từ chia sẻ trên trang github.
Nó bao gồm các thông tin nhà đất, số liệu thống kê và các thông tin liên quan khác.

Bộ dữ liệu gốc của NashvilleHousing chứa hơn 56.000 bản ghi dữ liệu nhà đất. Mỗi bản ghi đại diện cho một thông tin nhà đất duy nhất và bao gồm
các thuộc tính khác nhau như địa chỉ tài sản, ngày bán, giá bán, tên chủ sở hữu, các thông tin về giá đất, giá tài sản trên đất...

### Các vấn đề được tìm thấy trong dữ liệu

Trong quá trình khám phá và phân tích ban đầu bộ dữ liệu NashvilleHousing, một số vấn đề đã được xác định bao gồm:

- Missing Values - Các dữ liệu PropertyAddress bị thiếu cần được điền lại đầy đủ
- Inconsistent formatting - Cột SoldAsVacant có các định dạng Yes, No cần chưa nhất quán cần được điều chỉnh lại
- Duplicate Values - Các cột ParcelID, PropertyAddress, SalePrice, SaledDate, LegalReference có các giá trị trùng lắp cần loại bỏ để đảm bảo độ tin cậy và tối ưu hiệu suất cho quá trình phân tích
- Feature Issue - Các cột dữ liệu Address có nhiều thông tin đặc trưng cần được tách riêng ra để tạo điều kiện cho quá trình phân tích

### Các công cụ được sử dụng

**SQLServer** cho các tác vụ data cleaning.


### Quy trình thực hiện Data Cleaning 

1. **Data Understanding** - Tập dữ liệu đã được kiểm tra kỹ lưỡng để hiểu cấu trúc, các cột và ý nghĩa của chúng.
   Dữ liệu không có từ điển dữ liệu kèm theo. Với sự trợ giúp của các nguồn trực tuyến, tôi đã có thể tạo một nguồn 
   giúp tôi hiểu được ý nghĩa của tất cả các cột.
2. **Data Exploration** - Phân tích dữ liệu khám phá (EDA) đã được thực hiện để hiểu rõ hơn về dữ liệu, xác định các mẫu và phát hiện ra sự bất thường.
3. **Handling missing values** - Thông qua EDA, tôi nhanh chóng nhận ra rằng các dữ liệu bị thiếu trong cột PropertyAddress có thể được điền bằng các giá trị tương đương dựa trên các giá trị đối chiếu với ParcelID
4. **Standardizing formatting** - Các vấn đề về định dạng không nhất quán, ví dụ: các giá trị trong cột SoldAsVacant được lưu trữ với các giá trị khác nhau đã được giải quyết bằng cách áp dụng các câu điều kiện case when.
5. **Remove Duplicate Values** - Các cột ParcelID, PropertyAddress, SalePrice, SaledDate, LegalReference có các giá trị trùng lắp được loại bỏ bằng hàm delete 
6. **Feature Separation** - Tách các dữ liệu trong các cột Address ra riêng thành (Address, City, State) 
7. **Validation and quality checks** - Bộ dữ liệu đã được làm sạch trải qua quá trình xác thực nghiêm ngặt để đảm bảo chất lượng, độ chính xác và tính toàn vẹn của dữ liệu.