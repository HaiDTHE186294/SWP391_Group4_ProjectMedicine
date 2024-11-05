<%-- 
    Document   : newpassword
    Created on : Sep 20, 2024, 9:47:38 PM
    Author     : trant
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
            i[id='iconsee']:hover {
                color: rgba(0, 0, 0, 0.5);
            }

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
        </style>
    </head>
    <body>
        <div class="back-to-home rounded d-none d-sm-block">
            <a href="testMenu.jsp" class="btn btn-icon btn-primary"><i data-feather="home" class="icons"></i></a>
        </div>

        <!-- Hero Start -->
        <section class="bg-home d-flex bg-light align-items-center" style="background: url('../assets/images/bg/bg-lines-one.png') center;">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-5 col-md-8">
                        <img src="../assets/images/logo-dark.png" height="24" class="mx-auto d-block" alt="">
                        <div class="card login-page bg-white shadow mt-4 rounded border-0">
                            <div class="card-body">
                                <h4 class="text-center">Choose a new password</h4>
                                <form class="tg-formtheme" action="confirmpass" method="post">
                                    <input name="userName" value="${requestScope.uName}" type="hidden">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="mb-3">
                                                <label class="form-label">New Password <span class="text-danger">*</span></label>                                               
                                                <div class="input-group">
                                                    <input id="pass1" style="text-transform: none;" type="password" name="password" class="form-control" placeholder="${requestScope.check == null ? 'Password' : 'New password'}" required value="${uPass}">
                                                    <span class="input-group-text"><i id="iconsee" style="cursor: pointer" onclick="changeIcon(this, '#pass1')" class="fa-solid fa-eye-slash"></i></span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-12">
                                            <div class="mb-3">
                                                <label class="form-label">Confirm New Password <span class="text-danger">*</span></label>
                                                <div class="input-group">
                                                    <input id="pass2" style="text-transform: none;" type="password" name="cfpassword" class="form-control" placeholder="${requestScope.check == null ? 'Confirm Password' : 'Confirm new password'}" required value="${uPass}">
                                                    <span class="input-group-text"><i id="iconsee" style="cursor: pointer" onclick="changeIcon(this, '#pass2')" class="fa-solid fa-eye-slash"></i></span>
                                                </div>
                                            </div>
                                        </div>                                       
                                        <div class="col-lg-12 mb-0">
                                            <div class="d-grid">
                                                <button type="submit" class="btn btn-primary">Save</button>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                                <div style="padding-top: 15px;">
                                    <c:if test="${not empty error}">
                                        ${error}
                                    </c:if>
                                </div>
                            </div>
                        </div><!---->
                    </div> <!--end col-->
                </div><!--end row-->
            </div> <!--end container-->
        </section><!--end section-->
        <!-- Hero End -->

        <!-- javascript -->
        <script src="../assets/js/bootstrap.bundle.min.js"></script>
        <!-- Icons -->
        <script src="../assets/js/feather.min.js"></script>
        <!-- Main Js -->
        <script src="../assets/js/app.js"></script>

        <script>
                                                        function changeIcon(obj, inputId) {
                                                            var inputP = document.querySelector(inputId);
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
