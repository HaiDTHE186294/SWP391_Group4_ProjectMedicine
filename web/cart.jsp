<%-- 
    Document   : cart
    Created on : Oct 28, 2024, 1:04:21 PM
    Author     : trant
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Doctris - Doctor Appointment Booking System</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Premium Bootstrap 4 Landing Page Template" />
        <meta name="keywords" content="Appointment, Booking, System, Dashboard, Health" />
        <meta name="author" content="Shreethemes" />
        <meta name="email" content="support@shreethemes.in" />
        <meta name="website" content="index.html" />
        <meta name="Version" content="v1.2.0" />
        <!-- favicon -->
        <link rel="shortcut icon" href="assets/images/favicon.ico.png">
        <!-- Bootstrap -->
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- simplebar -->
        <link href="assets/css/simplebar.css" rel="stylesheet" type="text/css" />
        <!-- Icons -->
        <link href="assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
        <!-- Css -->
        <link href="assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />

    </head>
    <body>

        <jsp:include page="header.jsp" />
        <section class="section"  style="padding-top: 17px;">
            <div class="page-wrapper doctris-theme">
                <!-- Start Page Content -->
                <main class="page-content bg-light">

                    <div class="container-fluid">
                        <div class="layout-specing">
                            <div class="d-md-flex justify-content-between">
                                <h5 class="mb-0">Shop cart</h5>
                            </div>

                            <div class="row mt-4">
                                <div class="col-12">
                                    <div class="table-responsive bg-white shadow rounded">
                                        <table class="table table-center table-padding mb-0">
                                            <thead>
                                                <tr>
                                                    <th class="border-bottom p-3" style="min-width:20px "></th>
                                                    <th class="border-bottom p-3" style="min-width: 300px;">Sản phẩm</th>
                                                    <th class="border-bottom text-center p-3" style="min-width: 80px;">Đơn vị</th>
                                                    <th hidden="" class="border-bottom text-center p-3" style="min-width: 80px;">Giá thành</th>
                                                    <th class="border-bottom text-center p-3" style="min-width: 190px;">Số lượng</th>
                                                    <th class="border-bottom text-end p-3" style="min-width: 50px;">Thành tiền</th>
                                                </tr>
                                            </thead>

                                            <tbody>


                                            <input hidden="" name="orderId" value="${order.getOrderId()}">

                                            <c:forEach items="${listOrderDetail}" var="orderDetail">

                                                <form action="cart" method="post">
                                                    <tr>

                                                    <input hidden="" value="${orderDetail.orderDetailId}" name="orderDetailId">
                                                    <input hidden="" value="${orderDetail.idOrder}" name="idOrder">
                                                    <input hidden="" value="${orderDetail.product.productID}" name="ProductID">

                                                    <!--<br>-->
                                                    <td class="h5 p-3 text-center"><a href="cart?action=deleteCart&&orderDetailId=${orderDetail.orderDetailId}" class="text-danger"><i class="uil uil-times"></i></a></td>
                                                    <td class="p-3">
                                                        <div class="d-flex align-items-center">
                                                            <img src="${orderDetail.product.imagePath}" class="img-fluid avatar avatar-small rounded shadow" style="height:auto;" alt="">
                                                            <h6 class="mb-0 ms-3">${orderDetail.product.productName}</h6>
                                                        </div>
                                                    </td>
                                                    <td class="text-center p-3">
                                                        <select name="productUnit" class="form-select">
                                                            <c:forEach items="${orderDetail.productPriceQuantity}" var="ppq">
                                                                <option value="${ppq.unit.unitID}" data-sale-price="${ppq.salePrice}"
                                                                        <c:if test="${productUnit == ppq.unit.unitID}">selected</c:if>
                                                                            >
                                                                        ${ppq.unit.unitName} - ${ppq.salePrice}
                                                                </option>
                                                            </c:forEach>
                                                        </select>

                                                        <input hidden="" type="text" name="salePrice" value="${orderDetail.productPriceQuantity[0].salePrice}">
                                                        <script>
                                                            document.querySelectorAll('select[name="productUnit"]').forEach(function (selectElement) {
                                                                selectElement.addEventListener('change', function () {
                                                                    let selectedOption = selectElement.options[selectElement.selectedIndex];
                                                                    let salePrice = selectedOption.getAttribute('data-sale-price');

                                                                    // Cập nhật giá trị của input ẩn
                                                                    let hiddenInput = selectElement.closest('td').querySelector('input[name="salePrice"]');
                                                                    hiddenInput.value = salePrice;

                                                                    // Cập nhật giá thành trong <td> kế tiếp
                                                                    let giaThanhCell = selectElement.closest('td').nextElementSibling;
                                                                    giaThanhCell.innerText = salePrice;
                                                                });
                                                            });
                                                        </script>
                                                    </td>

                                                    <td hidden="" class="gia-thanh">${orderDetail.productPriceQuantity[0].salePrice}</td>


                                                    <td class="text-center shop-list p-3">
                                                        <div class="qty-icons">
                                                            <button onclick="this.parentNode.querySelector('input[type=number]').stepDown()" class="btn btn-icon btn-primary minus">-</button>
                                                            <input min="0" name="quantity" value="${orderDetail.quantity}" type="number" class="btn btn-icon btn-primary qty-btn quantity">
                                                            <button onclick="this.parentNode.querySelector('input[type=number]').stepUp()" class="btn btn-icon btn-primary plus">+</button>
                                                        </div>
                                                    </td>
                                                    <td class="text-end font-weight-bold p-3">Price</td>

                                                    </tr>
                                                </form>

                                            </c:forEach>
                                            <script>
                                                document.querySelectorAll('.qty-icons').forEach(function (qtyContainer) {
                                                    // Lấy các phần tử cần thiết
                                                    let priceSelect = qtyContainer.closest('tr').querySelector('select[name="productUnit"]');
                                                    let quantityInput = qtyContainer.querySelector('input[name="quantity"]');
                                                    let priceDisplay = qtyContainer.closest('tr').querySelector('td.text-end.font-weight-bold.p-3');
                                                    let minusButton = qtyContainer.querySelector('.minus');
                                                    let plusButton = qtyContainer.querySelector('.plus');

                                                    function updatePrice() {
                                                        let selectedOption = priceSelect.options[priceSelect.selectedIndex];
                                                        let unitPrice = parseFloat(selectedOption.textContent.split('-')[1].trim()); // lấy giá từ option
                                                        let quantity = parseInt(quantityInput.value);
                                                        let totalPrice = unitPrice * quantity;

                                                        priceDisplay.textContent = totalPrice.toFixed(2) + ' VND'; // định dạng lại giá (có thể chỉnh sửa định dạng)
                                                    }

                                                    // Thêm sự kiện lắng nghe thay đổi số lượng cho nút trừ và cộng
                                                    minusButton.addEventListener('click', function () {
                                                        setTimeout(updatePrice, 50); // sử dụng setTimeout để đảm bảo input được cập nhật trước
                                                    });

                                                    plusButton.addEventListener('click', function () {
                                                        setTimeout(updatePrice, 50);
                                                    });

                                                    // Thêm sự kiện lắng nghe thay đổi đơn vị giá
                                                    priceSelect.addEventListener('change', updatePrice);

                                                    // Gọi hàm cập nhật giá lần đầu để hiển thị đúng giá ban đầu
                                                    updatePrice();
                                                });

                                            </script>
                                            </tbody>
                                        </table>
                                    </div>
                                </div><!--end col-->
                            </div><!--end row-->

                            <div class="row">

                                <div class="col-lg-4 col-md-6 ms-auto mt-4 pt-2">
                                    <form action="checkout" method="doget">


                                        <div class="table-responsive bg-white rounded shadow">


                                            <table class="table table-center table-padding mb-0">
                                                <tbody>

                                                    <tr class="bg-light">
                                                        <td class="h6 p-3">Tổng tiền</td>
                                                        <td class="text-end font-weight-bold p-3">
                                                            <input id="totalPriceDisplay" class="text-end font-weight-bold p-3 border-0" type="text" name="totalPrice" readonly> VND
                                                        </td>
                                                    </tr>

                                                <script>
                                                    function calculateTotalPrice() {
                                                        let total = 0;

                                                        // Loop through each row that contains a cart item
                                                        document.querySelectorAll('tr').forEach(function (row) {
                                                            // Find the quantity input for this row
                                                            let quantityInput = row.querySelector('input[name="quantity"]');
                                                            if (quantityInput) {
                                                                let quantity = parseInt(quantityInput.value); // Get the quantity value
                                                                let priceSelect = row.querySelector('select[name="productUnit"]'); // Get the unit price select
                                                                if (priceSelect) {
                                                                    let selectedOption = priceSelect.options[priceSelect.selectedIndex]; // Get selected option
                                                                    let unitPrice = parseFloat(selectedOption.textContent.split('-')[1].trim()); // Extract price from option text

                                                                    // Calculate total price for this item and add it to the overall total
                                                                    let itemTotalPrice = unitPrice * quantity;
                                                                    total += itemTotalPrice;
                                                                }
                                                            }
                                                        });

                                                        // Display total price in the input field (format it to 2 decimal places)
                                                        document.getElementById('totalPriceDisplay').value = total.toFixed(2);
                                                    }

                                                    // Call the function on page load
                                                    window.onload = calculateTotalPrice;

                                                    // Recalculate total price when quantity or unit price changes
                                                    document.querySelectorAll('input[name="quantity"], select[name="productUnit"]').forEach(function (element) {
                                                        element.addEventListener('change', calculateTotalPrice);
                                                    });

                                                    // Ensure the function runs immediately after definition in case the DOM is ready
                                                    calculateTotalPrice();
                                                </script>
                                                </tbody>
                                            </table>
                                        </div>
                                        <div class="mt-4 pt-2 text-end">
                                            <c:if test="${not empty listOrderDetail}">
                                                <button class="btn btn-primary">
                                                    Proceed to checkout
                                                </button>
                                            </c:if>
                                        </div>
                                    </form>
                                </div><!--end col-->
                            </div><!--end row-->
                        </div>
                    </div><!--end container-->
                </main>
                <!--End page-content" -->
            </div>
            <!-- page-wrapper -->
        </section>

        <jsp:include page="footer.jsp" />

        <!-- javascript -->
        <script src="assets/js/bootstrap.bundle.min.js"></script>
        <!-- simplebar -->
        <script src="assets/js/simplebar.min.js"></script>
        <!-- Icons -->
        <script src="assets/js/feather.min.js"></script>
        <!-- Main Js -->
        <script src="assets/js/app.js"></script>


    </body>
</html>
