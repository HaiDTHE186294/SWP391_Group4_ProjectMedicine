// Lưu thông tin sản phẩm vào sessionStorage khi người dùng nhấn vào sản phẩm
function saveProduct(event) {
    event.preventDefault(); // Ngăn hành động mặc định của liên kết
    const link = event.currentTarget; // Lấy liên kết đã nhấn

    // Lấy thông tin sản phẩm từ các thuộc tính dữ liệu
    const product = {
        name: link.getAttribute('data-name'),
        image: link.getAttribute('data-image'),
        price: link.getAttribute('data-price'),
        unitName: link.getAttribute('data-unitname'),
        url: link.href // Lưu liên kết chi tiết sản phẩm
    };

    // Lấy danh sách sản phẩm đã xem từ sessionStorage hoặc tạo mảng rỗng
    let viewedProducts = JSON.parse(sessionStorage.getItem('viewedProducts')) || [];

    // Kiểm tra xem sản phẩm đã có trong danh sách chưa
    const existingProductIndex = viewedProducts.findIndex(p => p.url === product.url);
    if (existingProductIndex === -1) {
        // Nếu chưa có, thêm sản phẩm mới vào đầu mảng
        viewedProducts.unshift(product);
    } else {
        // Nếu có, di chuyển sản phẩm đã có lên đầu
        viewedProducts.splice(existingProductIndex, 1);
        viewedProducts.unshift(product);
    }

    // Giới hạn chỉ giữ lại 8 sản phẩm gần đây nhất
    if (viewedProducts.length > 8) {
        viewedProducts = viewedProducts.slice(0, 8);
    }

    // Lưu danh sách sản phẩm đã xem vào sessionStorage
    sessionStorage.setItem('viewedProducts', JSON.stringify(viewedProducts));

    // Chuyển hướng người dùng đến trang chi tiết sản phẩm
    window.location.href = link.href;
}


// Hàm hiển thị sản phẩm đã xem
function displayRecentlyViewed() {
    const recentlyViewedContainer = document.getElementById('recently-viewed-products');
    const viewedProducts = JSON.parse(sessionStorage.getItem('viewedProducts')) || [];

    // Xóa nội dung hiện tại trong container
    recentlyViewedContainer.innerHTML = '';

    // Kiểm tra xem có sản phẩm đã xem không
    if (viewedProducts.length === 0) {
        // Nếu không có, ẩn container
        document.getElementById('recently-viewed-container').style.display = 'none';
    } else {
        // Nếu có sản phẩm, hiển thị container
        document.getElementById('recently-viewed-container').style.display = 'block';

        // Giới hạn số sản phẩm hiển thị chỉ 8 sản phẩm gần đây nhất
        const limitedProducts = viewedProducts.slice(0, 8);

        // Duyệt qua danh sách sản phẩm và tạo HTML cho từng sản phẩm
        limitedProducts.forEach(product => {
            const productHTML = `
                <div class="col-lg-3 col-md-6 col-12 mt-4 pt-2">
                    <div class="card shop-list border-0">
                        <div class="shop-image position-relative overflow-hidden rounded shadow">
                            <a href="${product.url}">
                                <img src="${product.image}" class="img-fluid" alt="${product.name}">
                            </a>
                            <ul class="list-unstyled shop-icons">
                                <li><a href="#" class="btn btn-icon btn-pills btn-soft-danger"><i data-feather="heart" class="icons"></i></a></li>
                                <li class="mt-2"><a href="#" class="btn btn-icon btn-pills btn-soft-primary"><i data-feather="eye" class="icons"></i></a></li>
                                <li class="mt-2"><a href="#" class="btn btn-icon btn-pills btn-soft-warning"><i data-feather="shopping-cart" class="icons"></i></a></li>
                            </ul>
                            <div class="qty-icons">
                                <button onclick="this.parentNode.querySelector('input[type=number]').stepDown()" class="btn btn-pills btn-icon btn-primary minus">-</button>
                                <input min="0" name="quantity" value="0" type="number" class="btn btn-pills btn-icon btn-primary qty-btn quantity">
                                <button onclick="this.parentNode.querySelector('input[type=number]').stepUp()" class="btn btn-pills btn-icon btn-primary plus">+</button>
                            </div>
                        </div>
                        <div class="card-body content pt-4 p-2">
                            <a href="${product.url}" class="text-dark product-name h6">${product.name}</a>
                            <div class="d-flex justify-content-between mt-1">
                                <h6 class="text-muted small font-italic mb-0 mt-1">${product.price}đ / ${product.unitName}</h6>
                            </div>
                        </div>
                    </div>
                </div>
            `;

            recentlyViewedContainer.innerHTML += productHTML; // Thêm HTML vào container
        });
        // Gọi feather.replace() để thay thế các biểu tượng
        feather.replace();
    }
}

// Gọi hàm khi trang được tải
document.addEventListener('DOMContentLoaded', function () {
     //localStorage.removeItem('viewedProducts'); 
    displayRecentlyViewed(); // Hiển thị sản phẩm đã xem khi trang được tải
});
