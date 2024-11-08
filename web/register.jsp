<%-- 
    Document   : register
    Created on : Sep 19, 2024, 3:06:55 PM
    Author     : trant
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Medicine Shop</title>
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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    </head>
    <body>
        <!-- Loader -->
        <div id="preloader">
            <div id="status">
                <div class="spinner">
                    <div class="double-bounce1"></div>
                    <div class="double-bounce2"></div>
                </div>
            </div>
        </div>
        <!-- Loader -->
        
        <div class="back-to-home rounded d-none d-sm-block">
            <a href="home.jsp" class="btn btn-icon btn-primary"><i data-feather="home" class="icons"></i></a>
        </div>

        <!-- Hero Start -->
        <section class="bg-half-150 d-table w-100 bg-light" style="background: url('assets/images/bg/bg-lines-one.png') center;">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-5 col-md-8">
                        <img src="assets/images/logo-dark.png" height="24" class="mx-auto d-block" alt="">
                        <div class="card login-page bg-white shadow mt-4 rounded border-0">
                            <div class="card-body">
                                <h4 class="text-center">Registration</h4>  
                                <form class="login-form mt-4" action="register" method="post">
                                    <c:if test="${requestScope.check == null || requestScope.check == 'false'}">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="mb-3">                                               
                                                    <label class="form-label">Full Name <span class="text-danger">*</span></label>
                                                    <input type="text" class="form-control" placeholder="Full Name" name="fullName" pattern="^[\p{L}\s]+$" title="Full name should only contain letters and spaces." value="${sessionScope.fullName}" required>
                                                </div>
                                            </div>

                                            <div class="col-md-12">
                                                <div class="mb-3">
                                                    <label class="form-label">Username <span class="text-danger">*</span></label>
                                                    <input type="text" class="form-control" placeholder="Username" name="username" value="${sessionScope.username}" required>
                                                </div>
                                            </div>
                                            <div class="col-md-12">
                                                <div class="mb-3">
                                                    <label class="form-label">Your Email <span class="text-danger">*</span></label>
                                                    <input type="email" class="form-control" placeholder="Email" name="email" pattern="[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$" title="Please enter a valid email address" value="${sessionScope.email}" required>
                                                </div>
                                            </div>
                                            <div class="col-md-12">
                                                <div class="mb-3">
                                                    <label class="form-label">Phone Number <span class="text-danger">*</span></label>
                                                    <input type="text" class="form-control" placeholder="Phone Number" name="phone" pattern="0[0-9]{9}" title="Phone number must start with 0 and be exactly 10 digits long" value="${sessionScope.phone}" required>
                                                </div>
                                            </div>
                                            <div class="col-md-12">
                                                <div class="mb-3">
                                                    <label class="form-label">Address <span class="text-danger">*</span></label>
                                                    <input type="text" class="form-control" placeholder="Address" name="address" value="${sessionScope.address}" required>
                                                </div>
                                            </div>
                                            <div class="col-md-12">
                                                <div class="mb-3">
                                                    <label class="form-label">Password <span class="text-danger">*</span></label>
                                                    <input type="password" class="form-control" placeholder="Password" name="password" required>
                                                </div>
                                            </div>
                                            <div class="col-md-12">
                                                <div class="mb-3">
                                                    <label class="form-label">Confirm Password <span class="text-danger">*</span></label>
                                                    <input type="password" class="form-control" placeholder="Confirm Password" name="confirmPassword" required>
                                                </div>
                                            </div>
                                            <div class="col-md-12">
                                                <div class="mb-3">
                                                    <div class="form-check">
                                                        <input class="form-check-input align-middle" type="checkbox" value="" id="accept-tnc-check" required>
                                                        <label class="form-check-label" for="accept-tnc-check">I Accept <a href="#" class="text-primary" style="font-weight: bold;">Terms And Condition</a></label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-12">
                                                <div class="d-grid">
                                                    <button class="btn btn-primary">Register</button>
                                                </div>
                                            </div>

                                            <div class="mx-auto">
                                                <p class="mb-0 mt-3"><small class="text-dark me-2">Already have an account ?</small> <a href="login" class="text-dark fw-bold">Log in</a></p>
                                            </div>

                                        </div>
                                        <c:if test="${requestScope.registerError != null}">
                                            <div style="padding-top: 15px;">${registerError}</div>
                                        </c:if>
                                    </c:if>
                                    <c:if test="${requestScope.check != null}">
                                        <c:if test="${requestScope.check == 'true' && !(requestScope.message == 'Sorry, verify code incorrect')}">
                                            <p style="padding-left: 15px;">${requestScope.message}</p>
                                        </c:if>
                                        <c:if test="${requestScope.check == 'false'}">
                                            <p style="padding-left: 15px;">${requestScope.message}</p>
                                        </c:if>
                                        <c:if test="${requestScope.check == 'true' && requestScope.message == 'Sorry, verify code incorrect'}">
                                            <p style="padding-left: 15px;">${requestScope.message}</p>
                                        </c:if>
                                    </c:if>
                                </form>
                                <c:if test="${requestScope.check != null && requestScope.check == 'true'}">
                                    <form action="verify" method="post">
                                        <div class="col-lg-12">
                                            <div class="mb-3">
                                                <label class="form-label">Verify Code <span class="text-danger">*</span></label>
                                                <input class="form-control" type="text" name="verifycode" placeholder="xxxxxx" required="required" value="${requestScope.code}">
                                            </div>
                                        </div>
                                        <c:if test="${requestScope.check != null && requestScope.check == 'true'}">
                                            <div class="col-lg-12">
                                                <div class="d-grid">
                                                    <button class="btn btn-primary" type="submit">Confirm Verify Code</button>
                                                </div>
                                            </div>
                                        </c:if>
                                    </form>
                                </c:if>
                            </div>
                        </div><!---->
                    </div> <!--end col-->
                </div><!--end row-->
            </div> <!--end container-->
        </section><!--end section-->
        <!-- Hero End -->

        <!-- javascript -->
        <script src="assets/js/bootstrap.bundle.min.js"></script>
        <!-- Icons -->
        <script src="assets/js/feather.min.js"></script>
        <!-- Main Js -->
        <script src="assets/js/app.js"></script>
    </body>
</html>
