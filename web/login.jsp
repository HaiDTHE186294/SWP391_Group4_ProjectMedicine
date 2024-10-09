<%-- 
    Document   : newjsp
    Created on : Sep 16, 2024, 11:18:21 AM
    Author     : trant
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <title>Medicine Shop</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Premium Bootstrap 4 Landing Page Template" />
        <meta name="keywords" content="Appointment, Booking, System, Dashboard, Health" />
        <meta name="author" content="Shreethemes" />
        <meta name="email" content="support@shreethemes.in" />
        <meta name="website" content="https://shreethemes.in" />
        <meta name="Version" content="v1.2.0" />
        <!-- favicon -->
        <link rel="shortcut icon" href="../assets/images/favicon.ico.png">
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

        <style>
            .input-group .form-control {
                border: 1px solid #ced4da;
                border-right: 0;
                outline: none;
            }

            .input-group .input-group-text {
                border-left: 0;
                background-color: white;
                color: black;
            }
            .input-group .form-control:focus {
                box-shadow: none;
            }

            i[id='iconsee']:hover {
                color: rgba(0, 0, 0, 0.5);
            }
        </style>
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
        <section class="bg-home d-flex bg-light align-items-center" style="background: url('assets/images/bg/bg-lines-one.png') center;">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-5 col-md-8">
                        <img src="assets/images/logo-dark.png" height="24" class="mx-auto d-block" alt="">
                        <div class="card login-page bg-white shadow mt-4 rounded border-0">
                            <div class="card-body">
                                <h4 class="text-center">Log In</h4>  
                                <form class="tg-formtheme" action="login" method="post">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="mb-3">
                                                <label class="form-label">Username <span class="text-danger">*</span></label>                                               
                                                <div class="input-group">
                                                    <input style="text-transform: none;" type="text" name="username" class="form-control" placeholder="Username" required value="${requestScope.user}">
                                                    <span class="input-group-text"><i class="fa-solid fa-user"></i></span>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-lg-12">
                                            <div class="mb-3">
                                                <label class="form-label">Password <span class="text-danger">*</span></label>
                                                <div class="input-group">
                                                    <input id="pass" style="text-transform: none;" type="password" name="password" class="form-control" placeholder="Password" required value="${requestScope.pass}">
                                                    <span class="input-group-text"><i id="iconsee" style="cursor: pointer" onclick="changeIcon(this)" class="fa-solid fa-eye-slash"></i></span>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-lg-12">
                                            <div class="d-flex justify-content-between">
                                                <div class="mb-3">
                                                    <div class="form-check">
                                                        <input class="form-check-input align-middle" type="checkbox" value="" id="remember-check" name="remember">
                                                        <label class="form-check-label" for="remember-check">Remember me</label>
                                                    </div>
                                                </div>
                                                <a href="forgot" class="text-dark h6 mb-0">Forgot password ?</a>
                                            </div>
                                        </div>
                                        <div class="col-lg-12 mb-0">
                                            <div class="d-grid">
                                                <button class="btn btn-primary">Log in</button>
                                            </div>
                                        </div>

                                        <div class="col-lg-12 mt-3 text-center">
                                            <h6 class="text-muted">Or</h6>
                                        </div><!--end col-->

                                        <!--<div class="col-6 mt-3">
                                            <div class="d-grid">
                                                <a href="#" class="btn btn-soft-primary"><i class="uil uil-facebook"></i> Facebook</a>
                                            </div>
                                        </div>-->

                                        <div class="col-lg-12 mb-0">
                                            <div class="d-grid">
                                                <a href="https://accounts.google.com/o/oauth2/auth?scope=email profile openid&redirect_uri=http://localhost:8080/MedicineShop/googlelogin&response_type=code&client_id=711113061195-11a5fvgn8jfimj32n0o7eo99irqgk4n5.apps.googleusercontent.com&approval_prompt=force" class="btn btn-soft-primary"><i class="uil uil-google"></i> Google</a>
                                            </div>
                                        </div><!--end col-->

                                        <div class="col-12 text-center">
                                            <p class="mb-0 mt-3"><small class="text-dark me-2">Don't have an account ?</small> <a href="register" class="text-dark fw-bold">Register here</a></p>
                                        </div>
                                    </div>
                                </form>
                            </div>
                            <div style="padding-left: 20px; padding-bottom:20px;">
                                <c:if test="${not empty error}">
                                    ${error}
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
        <script>
                                                        function changeIcon(obj) {
                                                            var inputP = document.querySelector("#pass");
                                                            console.log(inputP);
                                                            if (obj.className === 'fa-solid fa-eye-slash') {
                                                                obj.className = 'fa-solid fa-eye';
                                                                inputP.type = 'text';
                                                            } else {
                                                                obj.className = 'fa-solid fa-eye-slash';
                                                                inputP.type = 'password';
                                                            }
                                                        }
        </script>
    </body>
</html>