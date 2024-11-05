<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
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
        <!-- Css -->
        <link href="assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <%@include file="header.jsp" %>

    </head>

    <style>
        .error-message {
            display: none;
            color: red;
            font-size: 0.9em;
        }

        input:invalid ~ .error-message {
            display: block;
        }

        input:invalid {
            border-color: red;
        }

        input:valid {
            border-color: green;
        }
    </style>
    <body>

        <!-- Start -->
        <section class="bg-dashboard">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-xl-4 col-lg-4 col-md-5 col-12">
                        <div class="rounded shadow overflow-hidden sticky-bar">
                            <div class="card border-0">
                                <img src="assets/images/doctors/profile-bg.jpg" class="img-fluid" alt="">
                            </div>

                            <div class="text-center avatar-profile margin-nagative mt-n5 position-relative pb-4 border-bottom">
                                <img src="${User.image}" class="rounded-circle shadow-md avatar avatar-md-md" alt="">
                                <h5 class="mt-3 mb-1">${User.fullName}</h5>
                                <p class="text-muted mb-0">Orthopedic</p>
                            </div>

                            <ul class="list-unstyled sidebar-nav mb-0">
                                <li class="navbar-item"><a href="#" id="show-profile-link" class="navbar-link"><i class="ri-user-line align-middle navbar-icon"></i> Profile</a></li>
                                <li class="navbar-item"><a href="#" id="change-password-link" class="navbar-link"><i class="ri-lock-fill align-middle navbar-icon"></i> Change Password</a></li>
                            </ul>
                        </div>
                    </div><!--end col-->

                    <div class="col-xl-8 col-lg-8 col-md-7 mt-4 pt-2 mt-sm-0 pt-sm-0">

                        <div class="rounded shadow mt-4">
                            <div class="p-4 border-bottom">
                                <h5 class="mb-0">Personal Information : ${User.fullName}</h5>
                            </div>

                            <!-- Profile Section -->
                            <div id="profile-section" style="display: block;">
                                <div class="p-4 border-bottom">

                                </div>

                                <div class="p-4">
                                    <form action="changeProfile" method="post" enctype="multipart/form-data">
                                        <input type="hidden" name="action" value="updateProfile">
                                        <div class="row">
                                            <div class="row align-items-center">
                                                <div class="col-lg-2 col-md-4">
                                                    <img src="${User.image}" class="avatar avatar-md-md rounded-pill shadow mx-auto d-block" alt="">
                                                </div>

                                                <div class="col-lg-5 col-md-8 text-center text-md-start mt-4 mt-sm-0">
                                                    <h5>Upload your picture</h5>
                                                    <p class="text-muted mb-0">For best results, use an image at least 256px by 256px in either .jpg or .png format</p>
                                                </div>

                                                <div class="col-lg-5 col-md-12 text-lg-end text-center mt-4 mt-lg-0">
                                                    <input type="file" class="form-control" id="imgProfile" name="imgProfile" required>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Full Name</label>
                                                    <input name="fullName" id="fullName" type="text" class="form-control" value="<c:out value='${User.fullName}'/>" required>
                                                </div>
                                            </div>

                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Address</label>
                                                    <input name="address" id="address" type="text" class="form-control" value="<c:out value='${User.address}'/>" required>
                                                </div>
                                            </div>

                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Email</label>
                                                    <input name="email" id="email" type="email" class="form-control"
                                                           value="<c:out value='${User.email}'/>"
                                                           pattern="[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.com$"
                                                           title="Please enter a valid email address."
                                                           required readonly>
                                                </div>
                                            </div>

                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Phone Number</label>
                                                    <input name="phone" id="phone" type="text" class="form-control"  value="${User.phone}" required pattern="0[0-9]{9}" title="Phone number must start with 0 and be exactly 10 digits long">
                                                    <div class="error-message">Phone number must start with 0 and be exactly 10 digits long.</div>
                                                </div>
                                            </div>

                                            <style>
                                                /* Ẩn thông báo lỗi theo mặc định */
                                                .error-message {
                                                    display: none;
                                                    color: red;
                                                    font-size: 0.9em;
                                                }

                                                /* Hiển thị thông báo lỗi nếu input không hợp lệ */
                                                input:invalid + .error-message {
                                                    display: block;
                                                }

                                                /* Thay đổi viền của input khi có lỗi */
                                                input:invalid {
                                                    border-color: red;
                                                }
                                            </style>

                                            <div class="row">
                                                <div class="col-sm-12">
                                                    <input type="submit" id="submit" name="send" class="btn btn-primary" value="Save changes">
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>

                            <div id="change-password-section" style="display: none;">
                                <div class="p-4 border-bottom">
                                    <h5 class="mb-0">Change Password :</h5>
                                </div>
                                <div class="p-4">
                                    <form action="changeProfile" method="post">
                                        <input type="hidden" name="action" value="changePassword">
                                        <div class="row">
                                            <div class="col-lg-12">
                                                <div class="mb-3">
                                                    <label class="form-label" for="oldPassword">Old password :</label>
                                                    <input id="oldPassword" name="oldPassword" type="password" class="form-control" placeholder="Old password" required>
                                                </div>
                                            </div>

                                            <div class="col-lg-12">
                                                <div class="mb-3">
                                                    <label class="form-label" for="newPassword">New password :</label>
                                                    <input id="newPassword" name="newPassword" type="password" class="form-control" placeholder="New password" required pattern=".{6,}">
                                                </div>
                                            </div>

                                            <div class="col-lg-12">
                                                <div class="mb-3">
                                                    <label class="form-label" for="confirmPassword">Re-type New password :</label>
                                                    <input id="confirmPassword" name="confirmPassword" type="password" class="form-control" placeholder="Re-type New password" required pattern=".{6,}">
                                                </div>
                                            </div>

                                            <div class="col-lg-12">
                                                <div id="passwordError" class="error-message">Passwords do not match or are less than 6 characters.</div>
                                            </div>

                                            <div class="col-lg-12 mt-2 mb-0">
                                                <button type="submit" class="btn btn-primary">Save password</button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>

                        </div>
                        <c:if test="${not empty errorMessage}">
                            <div class="alert alert-danger">
                                ${errorMessage}
                            </div>
                        </c:if>
                        <c:if test="${not empty successMessage}">
                            <div class="alert alert-success">
                                ${successMessage}
                            </div>
                        </c:if>

                        <!-- Footer Start -->
                        <footer class="bg-footer py-4">
                            <div class="container-fluid">
                                <div class="row align-items-center">
                                    <div class="col-sm-6">
                                        <div class="text-sm-start text-center">
                                            <p class="mb-0"><script>document.write(new Date().getFullYear())</script> © Doctris. Design with <i class="mdi mdi-heart text-danger"></i> by <a href="product/ShowProductInformation" target="_blank" class="text-reset">Shreethemes</a>.</p>
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

                        <!-- Offcanvas Start -->
                        <div class="offcanvas offcanvas-end bg-white shadow" tabindex="-1" id="offcanvasRight" aria-labelledby="offcanvasRightLabel">
                            <div class="offcanvas-header p-4 border-bottom">
                                <h5 id="offcanvasRightLabel" class="mb-0">
                                    <img src="assets/images/logo-dark.png" height="24" class="light-version" alt="">
                                    <img src="assets/images/logo-light.png" height="24" class="dark-version" alt="">
                                </h5>
                                <button type="button" class="btn-close d-flex align-items-center text-dark" data-bs-dismiss="offcanvas" aria-label="Close"><i class="uil uil-times fs-4"></i></button>
                            </div>
                            <div class="offcanvas-body p-4 px-md-5">
                                <div class="row">
                                    <div class="col-12">
                                        <!-- Style switcher -->
                                        <div id="style-switcher">
                                            <div>
                                                <ul class="text-center list-unstyled mb-0">
                                                    <li class="d-grid"><a href="javascript:void(0)" class="rtl-version t-rtl-light" onclick="setTheme('style-rtl')"><img src="assets/images/layouts/landing-light-rtl.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">RTL Version</span></a></li>
                                                    <li class="d-grid"><a href="javascript:void(0)" class="ltr-version t-ltr-light" onclick="setTheme('style')"><img src="assets/images/layouts/landing-light.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">LTR Version</span></a></li>
                                                    <li class="d-grid"><a href="javascript:void(0)" class="dark-rtl-version t-rtl-dark" onclick="setTheme('style-dark-rtl')"><img src="assets/images/layouts/landing-dark-rtl.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">RTL Version</span></a></li>
                                                    <li class="d-grid"><a href="javascript:void(0)" class="dark-ltr-version t-ltr-dark" onclick="setTheme('style-dark')"><img src="assets/images/layouts/landing-dark.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">LTR Version</span></a></li>
                                                    <li class="d-grid"><a href="javascript:void(0)" class="dark-version t-dark mt-4" onclick="setTheme('style-dark')"><img src="assets/images/layouts/landing-dark.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">Dark Version</span></a></li>
                                                    <li class="d-grid"><a href="javascript:void(0)" class="light-version t-light mt-4" onclick="setTheme('style')"><img src="assets/images/layouts/landing-light.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">Light Version</span></a></li>
                                                    <li class="d-grid"><a href="admin/index.html" target="_blank" class="mt-4"><img src="assets/images/layouts/light-dash.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">Admin Dashboard</span></a></li>
                                                </ul>
                                            </div>
                                        </div>
                                        <!-- end Style switcher -->
                                    </div><!--end col-->
                                </div><!--end row-->
                            </div>

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
                        </div>
                        <!-- Offcanvas End -->

                        <!-- javascript -->
                        <script>
                            // JavaScript to toggle sections
                            document.getElementById("show-profile-link").addEventListener("click", function (event) {
                                event.preventDefault();
                                document.getElementById("profile-section").style.display = "block";
                                document.getElementById("change-password-section").style.display = "none";
                            });

                            document.getElementById("change-password-link").addEventListener("click", function (event) {
                                event.preventDefault();
                                document.getElementById("profile-section").style.display = "none";
                                document.getElementById("change-password-section").style.display = "block";
                            });
                        </script>

                        <script src="assets/js/bootstrap.bundle.min.js"></script>
                        <!-- Icons -->
                        <script src="assets/js/feather.min.js"></script>
                        <!-- Main Js -->
                        <script src="assets/js/app.js"></script>
                        </body>

                        </html>