<%-- 
    Document   : listbook
    Created on : Oct 15, 2024, 12:35:09 PM
    Author     : trant
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        <meta name="website" content="https://shreethemes.in" />
        <meta name="Version" content="v1.2.0" />
        <!-- favicon -->
        <link rel="shortcut icon" href="assets/images/favicon.ico.png">
        <!-- Bootstrap -->
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- Icons -->
        <link href="assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
        <!-- SLIDER -->
        <link rel="stylesheet" href="assets/css/tiny-slider.css"/>
        <!-- Css -->
        <link href="assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <link href="assets/css/listproduct.css" rel="stylesheet" type="text/css" />

        <style>
            .filter-form::-webkit-scrollbar {
                width: 8px; /* Set width of the scrollbar */
            }

            /* Background of the scrollbar */
            .filter-form::-webkit-scrollbar-track {
                background: #f1f1f1; /* Track color */
            }

            /* Handle of the scrollbar */
            .filter-form::-webkit-scrollbar-thumb {
                background: #888; /* Scrollbar color */
                border-radius: 10px; /* Rounded corners for the scrollbar */
            }

            /* Handle on hover */
            .filter-form::-webkit-scrollbar-thumb:hover {
                background: #555; /* Darker color when hovering */
            }

            .price-filter-buttons button {
                display: block; /* Make each button take up the full width */
                width: 90%; /* Full width of the container */
                margin-bottom: 10px; /* Space between buttons */
                background-color: white; /* White background */
                color: black; /* Black text */
                border: 2px solid black; /* Add a 2px black border */
                padding: 10px 20px; /* Add padding */
                font-size: 16px; /* Increase font size */
                cursor: pointer; /* Add pointer cursor */
                border-radius: 5px; /* Rounded corners */
                transition: background-color 0.3s ease, transform 0.2s ease, border-color 0.3s ease, color 0.3s ease; /* Smooth hover effect */
            }

            .price-filter-buttons button:hover {
                background-color: white; /* Darker green on hover */
                color: blue; /* Change text color to blue on hover */
                border-color: blue; /* Change border to blue on hover */
                transform: scale(1.05); /* Slight zoom on hover */
            }

            .price-filter-buttons button:active {
                background-color: #388e3c; /* Even darker green on click */
                transform: scale(0.98); /* Slight press effect */
            }

            .price-filter-buttons button.active {
                background-color: blue; /* Highlight color for active state */
                color: white; /* Text color for active state */
            }
        </style>

    </head>
    <body>
        <jsp:include page="header.jsp" />

        <div class="container-product">
            <div class="row">
                <!-- Bộ lọc nâng cao -->
                <div class="col-lg-3 col-md-4">
                    <div class="filter-form" style="max-height: 700px; overflow-y: auto;">
                        <!-- Đối tượng sử dụng -->
                        <h5>Bộ lọc nâng cao</h5>
                        <h6>Đối tượng sử dụng</h6>
                        <div>
                            <c:forEach var="audience" items="${sessionScope.audienceList}">
                                <input type="checkbox" name="targetAudience" value="${audience}" onclick="filterByAudience()"> ${audience}<br>
                            </c:forEach>
                        </div>

                        <!-- Giá bán -->
                        <h6>Giá bán</h6>
                        <div class="price-filter-buttons">
                            <button onclick="filterByPrice('duoi100')">Dưới 100.000đ</button>
                            <button onclick="filterByPrice('100-300')">100.000đ - 300.000đ</button>
                            <button onclick="filterByPrice('300-500')">300.000đ - 500.000đ</button>
                            <button onclick="filterByPrice('tren500')">Trên 500.000đ</button>
                        </div>

                        <!-- Nước sản xuất -->
                        <h6>Nước sản xuất</h6>
                        <div id="countryContainer">
                            <!-- Search bar for filtering countries -->
                            <input type="text" id="countrySearch" placeholder="Tìm theo tên" onkeyup="filterCountries()" />

                            <!-- Country checkboxes -->
                            <div id="countryList">
                                <c:forEach var="country" items="${countryList}" varStatus="status">
                                    <div class="country-item" style="display: none;">
                                        <input type="checkbox" name="countryofproduction" value="${country}" onclick="filterByCountry()"> ${country}<br>
                                    </div>
                                </c:forEach>
                            </div>

                            <!-- 'See More' button -->
                            <a href="javascript:void(0);" id="seeMore" onclick="showMoreCountries()">Xem thêm</a>
                        </div>
                    </div>
                </div>

                <!-- Danh sách sản phẩm -->               
                <div class="col-lg-9 col-md-8">       
                    <div class="d-flex justify-content-between align-items-center mb-0">
                        <h5>Danh sách sản phẩm</h5>
                        <div>
                            <button onclick="sortProducts('asc')" class="btn btn-outline-primary">Giá thấp</button>
                            <button onclick="sortProducts('desc')" class="btn btn-outline-danger">Giá cao</button>
                        </div>
                    </div>
                    <div class="row" id="productContainer">
                        <c:forEach var="product" items="${productList}">
                            <div class="col-lg-3 col-md-6 col-12 mt-4 pt-2 product-item" data-price="${product.salePrice}" data-audience="${product.audience}" data-country="${product.countryofproduction}">
                                <div class="card shop-list border-0">
                                    <div class="shop-image position-relative overflow-hidden rounded shadow">
                                        <a href="product-detail.jsp?productId=${product.ProductID}"><img src="${product.imagePath}" class="img-fluid" alt="${product.productName}"></a>
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
                                        <a href="pharmacy-product-detail.html" class="text-dark product-name h6">${product.productName}</a>
                                        <div class="d-flex justify-content-between mt-1">
                                            <h6 class="text-muted small font-italic mb-0 mt-1">${product.salePrice}đ / ${product.unitName}</h6>
                                        </div>
                                    </div>
                                </div>
                            </div><!--end col-->
                        </c:forEach>
                    </div><!--end row-->

                    <div class="row" id="productContainer">
                        <c:forEach var="product" items="${searchproduct}">
                            <div class="col-lg-3 col-md-6 col-12 mt-4 pt-2 product-item" data-price="${product.salePrice}" data-audience="${product.audience}" data-country="${product.countryofproduction}">
                                <div class="card shop-list border-0">
                                    <div class="shop-image position-relative overflow-hidden rounded shadow">
                                        <a href="product-detail.jsp?productId=${product.ProductID}"><img src="${product.imagePath}" class="img-fluid" alt="${product.productName}"></a>
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
                                        <a href="pharmacy-product-detail.html" class="text-dark product-name h6">${product.productName}</a>
                                        <div class="d-flex justify-content-between mt-1">
                                            <h6 class="text-muted small font-italic mb-0 mt-1">${product.salePrice}đ / ${product.unitName} </h6>
                                        </div>
                                    </div>
                                </div>
                            </div><!--end col-->
                        </c:forEach>
                    </div><!--end row-->

                <!--<div id="pagination" class="text-center mt-4">
                        <button id="prevButton" onclick="changePage(-1)">Previous</button>
                        <span id="pageInfo"></span>
                        <button id="nextButton" onclick="changePage(1)">Next</button>
                    </div>

                    <!-- 'See More' button -->
                    <!--<div id="moreProductsContainer" class="text-center mt-4">
                        <a href="javascript:void(0);" id="seeMoreProduct" onclick="showMoreProducts()">Xem thêm</a>
                        <p id="endMessage" style="display: none;">Bạn đã xem hết danh sách</p>
                    </div>-->
                </div>
            </div>
        </div>

        <jsp:include page="footer.jsp" />

        <!-- javascript -->
        <script src="assets/js/bootstrap.bundle.min.js"></script>
        <!-- SLIDER -->
        <script src="assets/js/tiny-slider.js"></script>
        <script src="assets/js/tiny-slider-init.js"></script>
        <!-- Icons -->
        <script src="assets/js/feather.min.js"></script>
        <!-- Main Js -->
        <script src="assets/js/app.js"></script>

        <script>

                            // Function to sort products
                            function sortProducts(order) {
                                let productContainer = document.getElementById('productContainer');
                                let products = Array.from(document.getElementsByClassName('product-item'));

                                // Sort the products based on price (data-price attribute)
                                products.sort(function (a, b) {
                                    let priceA = parseFloat(a.getAttribute('data-price'));
                                    let priceB = parseFloat(b.getAttribute('data-price'));

                                    if (order === 'asc') {
                                        return priceA - priceB;
                                    } else if (order === 'desc') {
                                        return priceB - priceA;
                                    }
                                });

                                // Clear the product container and append the sorted products
                                productContainer.innerHTML = "";
                                products.forEach(function (product) {
                                    productContainer.appendChild(product);
                                });
                            }

                            let currentFilter = ''; // To track the current price filter

                            // Function to apply filters based on price, audience, and country together
                            function applyFilters() {
                                // Get all products
                                const products = document.querySelectorAll('#productContainer .product-item');

                                // Get the selected price range
                                const selectedPrice = currentFilter;

                                // Get all selected audiences (checkboxes that are checked)
                                const selectedAudiences = Array.from(document.querySelectorAll('input[name="targetAudience"]:checked')).map(cb =>
                                    cb.value.replace(/,|\s+/g, '').toLowerCase()
                                );

                                // Get all selected countries (checkboxes that are checked)
                                const selectedCountries = Array.from(document.querySelectorAll('input[name="countryofproduction"]:checked')).map(cb =>
                                    cb.value
                                );

                                // Filter products based on selected filters
                                products.forEach(product => {
                                    const price = parseFloat(product.getAttribute('data-price'));
                                    const productAudience = product.getAttribute('data-audience').replace(/,|\s+/g, '').toLowerCase();
                                    const productCountry = product.getAttribute('data-country');

                                    // Check if the product matches the selected price
                                    let priceMatch = false;
                                    if (selectedPrice === 'duoi100' && price < 100000) {
                                        priceMatch = true;
                                    } else if (selectedPrice === '100-300' && price >= 100000 && price <= 300000) {
                                        priceMatch = true;
                                    } else if (selectedPrice === '300-500' && price >= 300000 && price <= 500000) {
                                        priceMatch = true;
                                    } else if (selectedPrice === 'tren500' && price > 500000) {
                                        priceMatch = true;
                                    } else if (!selectedPrice) {
                                        priceMatch = true; // No price filter selected, so treat it as a match
                                    }

                                    // Check if the product matches the selected audiences
                                    const audienceMatch = selectedAudiences.length === 0 || selectedAudiences.some(audience =>
                                        productAudience.includes(audience)
                                    );

                                    // Check if the product matches the selected countries
                                    const countryMatch = selectedCountries.length === 0 || selectedCountries.includes(productCountry);

                                    // Show the product if it matches all selected filters
                                    if (priceMatch && audienceMatch && countryMatch) {
                                        product.style.display = 'block';
                                    } else {
                                        product.style.display = 'none';
                                    }
                                });
                            }

                            // Function to filter by price and apply all filters
                            function filterByPrice(priceRange) {
                                const buttons = document.querySelectorAll('.price-filter-buttons button');

                                // If the same button is clicked again, clear the filter and remove the active state
                                if (currentFilter === priceRange) {
                                    currentFilter = ''; // Reset the price filter
                                    buttons.forEach(btn => btn.classList.remove('active')); // Remove active state from all buttons
                                } else {
                                    currentFilter = priceRange; // Set the current filter

                                    // Add the active class to the clicked button and remove it from others
                                    buttons.forEach(btn => {
                                        if (btn.getAttribute('onclick').includes(priceRange)) {
                                            btn.classList.add('active');
                                        } else {
                                            btn.classList.remove('active');
                                        }
                                    });
                                }

                                applyFilters(); // Apply all filters
                            }

                            // Function to filter by audience and apply all filters
                            function filterByAudience() {
                                applyFilters(); // Apply all filters
                            }

                            // Function to filter by country and apply all filters
                            function filterByCountry() {
                                applyFilters(); // Apply all filters
                            }



                            const countriesPerPage = 5; // Number of countries to display per click
                            let currentCountryIndex = 0; // Index of the last displayed country

                            document.addEventListener('DOMContentLoaded', function () {
                                let countries = document.querySelectorAll('#countryList .country-item');

                                // Initially display the first 5 countries
                                for (let i = 0; i < countriesPerPage && i < countries.length; i++) {
                                    countries[i].style.display = 'block';
                                    currentCountryIndex++;
                                }

                                // If there are fewer than 5 countries, hide the "See More" link
                                if (countries.length <= countriesPerPage) {
                                    document.getElementById('seeMore').style.display = 'none';
                                }
                            });

                            function showMoreCountries() {
                                const countries = document.querySelectorAll('#countryList .country-item');
                                const seeMoreButton = document.getElementById('seeMore');

                                // Display the next set of countries
                                let newCountriesDisplayed = false;
                                for (let i = currentCountryIndex; i < currentCountryIndex + countriesPerPage && i < countries.length; i++) {
                                    countries[i].style.display = 'block';
                                    currentCountryIndex++;
                                    newCountriesDisplayed = true;
                                }

                                // Check if we have displayed all countries
                                if (currentCountryIndex >= countries.length) {
                                    seeMoreButton.textContent = 'Thu hẹp'; // Change button text to "Thu hẹp"
                                    seeMoreButton.setAttribute('onclick', 'hideCountries()'); // Change the function for the button
                                }

                                // If there are no more countries to show, hide the button
                                if (!newCountriesDisplayed) {
                                    seeMoreButton.style.display = 'none';
                                }
                            }

                            function hideCountries() {
                                const countries = document.querySelectorAll('#countryList .country-item');
                                const seeMoreButton = document.getElementById('seeMore');

                                // Hide all countries
                                countries.forEach((country, index) => {
                                    if (index >= countriesPerPage) {
                                        country.style.display = 'none'; // Hide country
                                    }
                                });

                                // Reset currentCountryIndex and button text
                                currentCountryIndex = countriesPerPage;
                                seeMoreButton.textContent = 'Xem thêm'; // Change button text back to "Xem thêm"
                                seeMoreButton.setAttribute('onclick', 'showMoreCountries()'); // Reset the function for the button
                            }

                            function filterCountries() {
                                // Get the value of the search input
                                const input = document.getElementById('countrySearch');
                                const filter = input.value.toLowerCase();
                                const countryItems = document.querySelectorAll('.country-item');

                                // Loop through all country items and hide those that don't match the search query
                                countryItems.forEach(item => {
                                    const countryName = item.textContent.toLowerCase();
                                    if (countryName.includes(filter)) {
                                        item.style.display = 'block'; // Show item
                                    } else {
                                        item.style.display = 'none'; // Hide item
                                    }
                                });

                                // Reset the current country index and button visibility after filtering
                                currentCountryIndex = 0; // Reset index
                                // Show the first 5 matching countries
                                const visibleItems = Array.from(countryItems).filter(item => item.style.display === 'block');
                                visibleItems.forEach((item, index) => {
                                    if (index < countriesPerPage) {
                                        item.style.display = 'block'; // Show first 5 matching countries
                                        currentCountryIndex++; // Update index
                                    } else {
                                        item.style.display = 'none'; // Hide others
                                    }
                                });

                                // Update "See More" button visibility
                                const seeMoreButton = document.getElementById('seeMore');
                                seeMoreButton.style.display = visibleItems.length > countriesPerPage ? 'block' : 'none';
                            }

//                            //Phân trang
//                            const productsPerPage = 8; // Number of products per page
//                            let currentPage = 1; // Current page number
//
//                            document.addEventListener('DOMContentLoaded', function () {
//                                const totalProducts = document.querySelectorAll('.product-item').length;
//                                const totalPages = Math.ceil(totalProducts / productsPerPage);
//
//                                // Show the first page of products
//                                showPage(currentPage, totalPages);
//                            });
//
//                            function showPage(page, totalPages) {
//                                const products = document.querySelectorAll('.product-item');
//
//                                // Hide all products initially
//                                products.forEach(product => {
//                                    product.style.display = 'none';
//                                });
//
//                                // Calculate start and end index for the current page
//                                const startIndex = (page - 1) * productsPerPage;
//                                const endIndex = startIndex + productsPerPage;
//
//                                // Show products for the current page
//                                for (let i = startIndex; i < endIndex; i++) {
//                                    if (i < products.length) {
//                                        products[i].style.display = 'block'; // Show product
//                                    }
//                                }
//
//                                // Update pagination buttons
//                                updatePaginationButtons(page, totalPages);
//                            }
//
//                            function changePage(direction) {
//                                const totalProducts = document.querySelectorAll('.product-item').length;
//                                const totalPages = Math.ceil(totalProducts / productsPerPage);
//
//                                // Update the current page based on direction
//                                if (direction === 1 && currentPage < totalPages) {
//                                    currentPage++;
//                                } else if (direction === -1 && currentPage > 1) {
//                                    currentPage--;
//                                }
//
//                                showPage(currentPage, totalPages);
//                            }
//
//                            function updatePaginationButtons(page, totalPages) {
//                                const totalProducts = document.querySelectorAll('.product-item').length;
//
//                                // Update the page info display
//                                const pageInfo = document.getElementById('pageInfo');
//                                if (totalProducts <= productsPerPage) {
//                                    pageInfo.style.display = 'none'; // Hide page info if products are <= 8
//                                } else {
//                                    pageInfo.style.display = 'inline'; // Show page info otherwise
//                                    pageInfo.textContent = `Page ${page} of ${totalPages}`;
//                                }
//
//                                document.getElementById('prevButton').style.display = page === 1 ? 'none' : 'inline-block'; // Hide 'Previous' button on first page
//                                document.getElementById('nextButton').style.display = page === totalPages ? 'none' : 'inline-block'; // Hide 'Next' button on last page
//                            }
        </script>
    </body>
</html>
