
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
 

    <head>
        <jsp:include page="header.jsp" />
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
        <!-- SLIDER -->
        <link rel="stylesheet" href="assets/css/tiny-slider.css"/>
        <link rel="stylesheet" href="assets/css/slick.css"/> 
        <link rel="stylesheet" href="assets/css/slick-theme.css"/>
        <!-- Icons -->
        <link href="assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
        <!-- Css -->
        
        <link href="assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
<style>
section.section.py-5 {
    padding-top: 30px; /* T?o kho?ng cách 100px phía trên */
}
section.section.py-5 {
    margin-top: 30px; /* ??y s?n ph?m xu?ng 100px */
}
            * {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
    background-color: #f7f7f7;
}

.container {
    display: flex;
    max-width: 1200px;
    margin: 0 auto;
    padding: 20px;
}

.sidebar {
    width: 25%;
    background-color: #fff;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.sidebar ul {
    list-style: none;
}

.sidebar ul li {
    margin-bottom: 15px;
}

.sidebar ul li a {
    text-decoration: none;
    font-size: 16px;
    color: #333;
}

.sidebar ul li a:hover {
    color: #007bff;
}

.content {
    width: 75%;
    margin-left: 20px;
    background-color: #fff;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.content h1 {
    font-size: 24px;
    margin-bottom: 10px;
    color: #333;
}

.content h2 {
    font-size: 20px;
    margin-bottom: 15px;
}

.content p {
    font-size: 16px;
    color: #555;
    margin-bottom: 20px;
}

.image-section img {
    width: 100%;
    max-width: 500px;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    
    /* Container layout using flexbox */
.container {
    display: flex;
    max-width: 1200px;
    margin: 0 auto;
    padding: 20px;
}

/* Sidebar styling */
.sidebar {
    width: 25%;
    background-color: #fff;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.sidebar ul {
    list-style: none;
}

.sidebar ul li {
    margin-bottom: 15px;
}

.sidebar ul li a {
    text-decoration: none;
    font-size: 16px;
    color: #333;
}

.sidebar ul li a:hover {
    color: #007bff;
}

/* Smooth scrolling */
html {
    scroll-behavior: smooth;
}

/* Content section styling */
.content {
    width: 75%;
    margin-left: 20px;
    background-color: #fff;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}
h2 {
    padding-top: 100px; /* Tùy chỉnh khoảng cách này để phù hợp với header của bạn */
    margin-top: -100px; /* Khoảng cách này giúp đẩy phần tử lên trên một chút */
}
/* Phong cách mặc định */
.content-section {
    padding: 20px;
    margin-bottom: 20px;
    border-radius: 8px;
    background-color: #fff;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

/* Hiệu ứng khi được chọn/click */
.content-section.active {
    box-shadow: 0 0 15px rgba(0, 123, 255, 0.7); /* Bóng mờ rõ hơn */
    border: 1px solid #007bff; /* Đường viền xanh để nhấn mạnh */
}

}

       
    </style>
    
    </head>

    <body>
          
        
       

    
<section class="section py-5">
    <c:forEach var="productId" items="${productId}">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-10 col-md-12">
                    <!-- Card ch?a s?n ph?m -->
                    <div class="card border-0 shadow-lg rounded-lg overflow-hidden">
                        <div class="row g-0 align-items-center">
                            <!-- Ph?n hi?n th? hình ?nh -->
                            <div class="col-md-5">
                                <div class="slider slider-for position-relative p-3">
                                    <img src="${productId.imagePath}" alt="${productId.productName}" class="img-fluid rounded">
                                    <span class="badge bg-success position-absolute top-0 start-0 m-3">Bán ch?y</span>
                                </div>
                            </div>
                            <!-- Ph?n thông tin s?n ph?m -->
                            <div class="col-md-7">
                                <div class="card-body">
                                    
                                   

<h4 class="card-title text-primary fw-bold">${productId.productName}</h4>
                                    <h5 class="text-muted">Sold: ${productId.sold}</h5>
                                        

                                  
                                    <ul class="list-unstyled text-warning h5 mb-3">
                                        <li class="list-inline-item"><i class="mdi mdi-star"></i></li>
                                        <li class="list-inline-item"><i class="mdi mdi-star"></i></li>
                                        <li class="list-inline-item"><i class="mdi mdi-star"></i></li>
                                        <li class="list-inline-item"><i class="mdi mdi-star"></i></li>
                                        <li class="list-inline-item"><i class="mdi mdi-star"></i></li>
                                        <li class="list-inline-item me-2 h6 text-muted">(20 Ratting)</li>
                                    </ul>
                                    <p class="text-muted mb-2"><strong>Brand:</strong> ${productId.brand}</p>
                                    <p class="text-muted mb-2"><strong>Manufacturer:</strong> ${productId.manufacturer}</p>
                                    <p class="text-muted mb-2"><strong>Target Audience:</strong> ${productId.targetAudience}</p>
                                    <p class="text-muted mb-2"><strong>Short Description:</strong><p class="mb-4">${productId.shortDescription}</p>
                                    <p class="text-muted mb-3"><strong>Register Number:</strong> ${productId.registrationNumber}</p>
                                    
                                    <div class="d-flex shop-list align-items-center">
                                <h6 class="mb-0">Quantity:</h6>
                                <div class="qty-icons ms-3">
                                    <button onclick="this.parentNode.querySelector('input[type=number]').stepDown()" class="btn btn-icon btn-primary minus">-</button>
                                    <input min="0" name="quantity" value="0" type="number" class="btn btn-icon btn-primary qty-btn quantity">
                                    <button onclick="this.parentNode.querySelector('input[type=number]').stepUp()" class="btn btn-icon btn-primary plus">+</button>
                                </div>
                            </div>

                            <div class="mt-4 pt-2">
                                <a href="#" class="btn btn-primary">Shop Now</a>
                                <a href="#" class="btn btn-soft-primary ms-2">Add to Cart</a>
                            </div>
                                </div>
                            </div><!--end col-->
                        </div><!--end row-->
                    </div><!--end card-->
                </div><!--end col-->
            </div><!--end row-->
        </div><!--end container-->
    </c:forEach>
</section>
           <body>
    <div class="container">
        <!-- Sidebar -->
        <div class="sidebar">
            <ul>
                <li><a href="#nuoc-san-xuat">Nước Sản Xuất</a></li>
                <li><a href="#thanh-phan">Thành phần</a></li>
                <li><a href="#cong-dung">Công dụng</a></li>
                <li><a href="#cach-dung">Cách dùng</a></li>
                <li><a href="#luu-y">Lưu ý</a></li>
                <li><a href="#bao-quan">Bảo quản</a></li>
            </ul>
        </div>

        <!-- Content Section -->
        <div class="content">
            <h2 id="nuoc-san-xuat">Nước Sản Xuất</h2>
             ${productId.countryOfProduction}
            <h2 id="thanh-phan">Thành phần</h2>
            ${productId.productDescription}

            <!-- Công dụng Section -->
            <h2 id="cong-dung">Công dụng</h2> 
            ${productId.shortDescription}
            
            <h2 id="cach-dung">Cách dùng</h2>
             ${productId.contentReviewer}
            <h2 id="luu-y">Đối tượng sử dụng</h2>
            ${productId.targetAudience}

            <h2 id="bao-quan">Bảo quản</h2>
            ${productId.productReviews}
        </div>
    </div>

    <!-- Thêm đoạn JavaScript vào đây -->
    <script>
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function(e) {
                e.preventDefault();

                const target = document.querySelector(this.getAttribute('href'));
                const offset = 100; // khoảng cách bù trừ
                const elementPosition = target.getBoundingClientRect().top;
                const offsetPosition = elementPosition - offset;

                window.scrollBy({
                    top: offsetPosition,
                    behavior: 'smooth'
                });
            });
        });
        
        
    // Lấy tất cả các mục sidebar
    const sidebarLinks = document.querySelectorAll('.sidebar ul li a');
    
    // Lấy tất cả các phần nội dung tương ứng
    const contentSections = document.querySelectorAll('.content-section');
    
    // Lặp qua từng mục trong sidebar
    sidebarLinks.forEach(link => {
        link.addEventListener('click', function(event) {
            event.preventDefault();
            
            // Loại bỏ lớp 'active' từ tất cả các phần nội dung
            contentSections.forEach(section => {
                section.classList.remove('active');
            });

            // Thêm lớp 'active' cho phần nội dung được nhấp vào
            const targetSection = document.querySelector(this.getAttribute('href'));
            targetSection.classList.add('active');
        });
    });
</script>

   
</body>



            
            
<a href="home" class="btn btn-primary">Back Home</a>
        <!-- Start -->
        <footer class="bg-footer">
            <div class="container">
                <div class="row">
                    <div class="col-xl-5 col-lg-4 mb-0 mb-md-4 pb-0 pb-md-2">
                        <a href="#" class="logo-footer">
                            <img src="assets/images/logo-light.png" height="22" alt="">
                        </a>
                        <p class="mt-4 me-xl-5">Great doctor if you need your family member to get effective immediate assistance, emergency treatment or a simple consultation.</p>
                    </div><!--end col-->

                    <div class="col-xl-7 col-lg-8 col-md-12">
                        <div class="row">
                            <div class="col-md-4 col-12 mt-4 mt-sm-0 pt-2 pt-sm-0">
                                <h5 class="text-light title-dark footer-head">Company</h5>
                                <ul class="list-unstyled footer-list mt-4">
                                    <li><a href="#" class="text-foot"><i class="mdi mdi-chevron-right me-1"></i> About us</a></li>
                                    <li><a href="#" class="text-foot"><i class="mdi mdi-chevron-right me-1"></i> Services</a></li>
                                    <li><a href="#" class="text-foot"><i class="mdi mdi-chevron-right me-1"></i> Team</a></li>
                                    <li><a href="#" class="text-foot"><i class="mdi mdi-chevron-right me-1"></i> Project</a></li>
                                    <li><a href="#" class="text-foot"><i class="mdi mdi-chevron-right me-1"></i> Blog</a></li>
                                    <li><a href="#" class="text-foot"><i class="mdi mdi-chevron-right me-1"></i> Login</a></li>
                                </ul>
                            </div><!--end col-->
                            
                            <div class="col-md-4 col-12 mt-4 mt-sm-0 pt-2 pt-sm-0">
                                <h5 class="text-light title-dark footer-head">Departments</h5>
                                <ul class="list-unstyled footer-list mt-4">
                                    <li><a href="#" class="text-foot"><i class="mdi mdi-chevron-right me-1"></i> Eye Care</a></li>
                                    <li><a href="#" class="text-foot"><i class="mdi mdi-chevron-right me-1"></i> Psychotherapy</a></li>
                                    <li><a href="#" class="text-foot"><i class="mdi mdi-chevron-right me-1"></i> Dental Care</a></li>
                                    <li><a href="#" class="text-foot"><i class="mdi mdi-chevron-right me-1"></i> Orthopedic</a></li>
                                    <li><a href="#" class="text-foot"><i class="mdi mdi-chevron-right me-1"></i> Cardiology</a></li>
                                    <li><a href="#" class="text-foot"><i class="mdi mdi-chevron-right me-1"></i> Gynecology</a></li>
                                    <li><a href="#" class="text-foot"><i class="mdi mdi-chevron-right me-1"></i> Neurology</a></li>
                                </ul>
                            </div><!--end col-->
                            
                            <div class="col-md-4 col-12 mt-4 mt-sm-0 pt-2 pt-sm-0">
                                <h5 class="text-light title-dark footer-head">Contact us</h5>
                                <ul class="list-unstyled footer-list mt-4">
                                    <li class="d-flex align-items-center">
                                        <i data-feather="mail" class="fea icon-sm text-foot align-middle"></i>
                                        <a href="mailto:contact@example.com" class="text-foot ms-2">contact@example.com</a>
                                    </li>

                                    <li class="d-flex align-items-center">
                                        <i data-feather="phone" class="fea icon-sm text-foot align-middle"></i>
                                        <a href="tel:+152534-468-854" class="text-foot ms-2">+152 534-468-854</a>
                                    </li>

                                    <li class="d-flex align-items-center">
                                        <i data-feather="map-pin" class="fea icon-sm text-foot align-middle"></i>
                                        <a href="javascript:void(0)" class="video-play-icon text-foot ms-2">View on Google map</a>
                                    </li>
                                </ul>

                                <ul class="list-unstyled social-icon footer-social mb-0 mt-4">
                                    <li class="list-inline-item"><a href="#" class="rounded-pill"><i data-feather="facebook" class="fea icon-sm fea-social"></i></a></li>
                                    <li class="list-inline-item"><a href="#" class="rounded-pill"><i data-feather="instagram" class="fea icon-sm fea-social"></i></a></li>
                                    <li class="list-inline-item"><a href="#" class="rounded-pill"><i data-feather="twitter" class="fea icon-sm fea-social"></i></a></li>
                                    <li class="list-inline-item"><a href="#" class="rounded-pill"><i data-feather="linkedin" class="fea icon-sm fea-social"></i></a></li>
                                </ul><!--end icon-->
                            </div><!--end col-->
                        </div><!--end row-->
                    </div><!--end col-->
                </div><!--end row-->
            </div><!--end container-->

            <div class="container mt-5">
                <div class="pt-4 footer-bar">
                    <div class="row align-items-center">
                        <div class="col-sm-6">
                            <div class="text-sm-start text-center">
                                <p class="mb-0"><script>document.write(new Date().getFullYear())</script> © Doctris. Design with <i class="mdi mdi-heart text-danger"></i> by <a href="index.html" target="_blank" class="text-reset">Shreethemes</a>.</p>
                            </div>
                        </div><!--end col-->
    
                        <div class="col-sm-6 mt-4 mt-sm-0">
                            <ul class="list-unstyled footer-list text-sm-end text-center mb-0">
                                <li class="list-inline-item"><a href="terms.html" class="text-foot me-2">Terms</a></li>
                                <li class="list-inline-item"><a href="privacy.html" class="text-foot me-2">Privacy</a></li>
                                <li class="list-inline-item"><a href="aboutus.html" class="text-foot me-2">About</a></li>
                                <li class="list-inline-item"><a href="contact.html" class="text-foot me-2">Contact</a></li>
                            </ul>
                        </div><!--end col-->
                    </div><!--end row-->
                </div>
            </div><!--end container-->
        </footer><!--end footer-->
        <!-- End -->

        <!-- Back to top -->
        <a href="#" onclick="topFunction()" id="back-to-top" class="btn btn-icon btn-pills btn-primary back-to-top"><i data-feather="arrow-up" class="icons"></i></a>
        <!-- Back to top -->

        <!-- Offcanvas Start -->
        <div class="offcanvas bg-white offcanvas-top" tabindex="-1" id="offcanvasTop">
            <div class="offcanvas-body d-flex align-items-center align-items-center">
                <div class="container">
                    <div class="row">
                        <div class="col">
                            <div class="text-center">
                                <h4>Search now.....</h4>
                                <div class="subcribe-form mt-4">
                                    <form>
                                        <div class="mb-0">
                                            <input type="text" id="help" name="name" class="border bg-white rounded-pill" required="" placeholder="Search">
                                            <button type="submit" class="btn btn-pills btn-primary">Search</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div><!--end col-->
                    </div><!--end row-->
                </div><!--end container-->
            </div>
        </div>
        <!-- Offcanvas End -->

        

            <div class="offcanvas-footer p-4 border-top text-center">
                <ul class="list-unstyled social-icon mb-0">
                    <li class="list-inline-item mb-0"><a href="https://1.envato.market/doctris-template" target="_blank" class="rounded"><i class="uil uil-shopping-cart align-middle" title="Buy Now"></i></a></li>
                    <li class="list-inline-item mb-0"><a href="https://dribbble.com/shreethemes" target="_blank" class="rounded"><i class="uil uil-dribbble align-middle" title="dribbble"></i></a></li>
                    <li class="list-inline-item mb-0"><a href="https://www.facebook.com/shreethemes" target="_blank" class="rounded"><i class="uil uil-facebook-f align-middle" title="facebook"></i></a></li>
                    <li class="list-inline-item mb-0"><a href="https://www.instagram.com/shreethemes/" target="_blank" class="rounded"><i class="uil uil-instagram align-middle" title="instagram"></i></a></li>
                    <li class="list-inline-item mb-0"><a href="https://twitter.com/shreethemes" target="_blank" class="rounded"><i class="uil uil-twitter align-middle" title="twitter"></i></a></li>
                    <li class="list-inline-item mb-0"><a href="mailto:support@shreethemes.in" class="rounded"><i class="uil uil-envelope align-middle" title="email"></i></a></li>
                    <li class="list-inline-item mb-0"><a href="index.html" target="_blank" class="rounded"><i class="uil uil-globe align-middle" title="website"></i></a></li>
                </ul><!--end icon-->
            </div>
        
      
        
        <!-- javascript -->
        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/js/bootstrap.bundle.min.js"></script>
        <!-- SLIDER -->
        <script src="assets/js/tiny-slider.js"></script>
        <script src="assets/js/tiny-slider-init.js"></script>
        <script src="assets/js/slick.min.js"></script>
        <script src="assets/js/slick.init.js"></script>
        <!-- Icons -->
        <script src="assets/js/feather.min.js"></script>
        <!-- Main Js -->
        <script src="assets/js/app.js"></script>
    </body>

</html>