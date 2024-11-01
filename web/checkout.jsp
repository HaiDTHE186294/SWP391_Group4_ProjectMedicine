<%-- 
    Document   : checkout
    Created on : Oct 28, 2024, 2:12:21 PM
    Author     : trant
--%>

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

        <div class="page-wrapper doctris-theme">
            <!-- Start Page Content -->
            <main class="page-content bg-light">
                <div class="container-fluid">
                    <div class="layout-specing" style="margin-top: 30px">
                        <div class="d-md-flex justify-content-between">
                            <h5 class="mb-0">Checkout</h5>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-5 col-lg-4 order-last mt-4 pt-2 pt-sm-0">
                                <div class="card rounded shadow p-4 border-0">
                                    <div class="d-flex justify-content-between align-items-center mb-3">
                                        <span class="h5 mb-0">Your cart</span>
                                        <span class="badge bg-primary rounded-pill">3</span>
                                    </div>
                                    <ul class="list-group mb-3 border">
                                        <li class="d-flex justify-content-between lh-sm p-3 border-bottom">
                                            <div>
                                                <h6 class="my-0">Product name</h6>
                                                <small class="text-muted">Brief description</small>
                                            </div>
                                            <span class="text-muted">$12</span>
                                        </li>
                                        <li class="d-flex justify-content-between lh-sm p-3 border-bottom">
                                            <div>
                                                <h6 class="my-0">Second product</h6>
                                                <small class="text-muted">Brief description</small>
                                            </div>
                                            <span class="text-muted">$8</span>
                                        </li>
                                        <li class="d-flex justify-content-between lh-sm p-3 border-bottom">
                                            <div>
                                                <h6 class="my-0">Third item</h6>
                                                <small class="text-muted">Brief description</small>
                                            </div>
                                            <span class="text-muted">$5</span>
                                        </li> 
                                        <li class="d-flex justify-content-between p-3">
                                            <span>Total (USD)</span>
                                            <strong>$20</strong>
                                        </li>
                                    </ul>
                            
                                    <form>
                                        <div class="input-group">
                                            <button class="w-100 btn btn-primary" type="submit">Continue to checkout</button>
                                        </div>
                                    </form>
                                </div>
                            </div><!--end col-->
                            
                            <div class="col-md-7 col-lg-8 mt-4">
                                <div class="card rounded shadow p-4 border-0">
                                    <h5 class="mb-3">Billing address</h5>
                                    <form class="needs-validation" novalidate>
                                        <div class="row g-3">
                                            <div class="col-sm-6">
                                                <label for="firstName" class="form-label">Full name</label>
                                                <input type="text" class="form-control" id="fullName" placeholder="Full Name" value=""
                                                    required>
                                                <div class="invalid-feedback">
                                                    Valid first name is required.
                                                </div>
                                            </div>
        
                                            <div class="col-sm-6">
                                                <label for="lastName" class="form-label">Phone number</label>
                                                <input type="text" class="form-control" id="phone" placeholder="Phone Number" value=""
                                                    required>
                                                <div class="invalid-feedback">
                                                    Valid last name is required.
                                                </div>
                                            </div>
        
                                            <div class="col-12">
                                                <label for="username" class="form-label">Username</label>
                                                <div class="input-group has-validation">
                                                    <span class="input-group-text bg-light text-muted border">@</span>
                                                    <input type="text" class="form-control" id="username" placeholder="Username" required>
                                                    <div class="invalid-feedback"> Your username is required. </div>
                                                </div>
                                            </div>
        
                                            <div class="col-12">
                                                <label for="email" class="form-label">Email <span
                                                        class="text-muted">(Optional)</span></label>
                                                <input type="email" class="form-control" id="email" placeholder="you@example.com">
                                                <div class="invalid-feedback">
                                                    Please enter a valid email address for shipping updates.
                                                </div>
                                            </div>
        
                                            <div class="col-12">
                                                <label for="address" class="form-label">Address</label>
                                                <input type="text" class="form-control" id="address" placeholder="1234 Main St"
                                                    required>
                                                <div class="invalid-feedback">
                                                    Please enter your shipping address.
                                                </div>
                                            </div>
                                        </div>
        
                                    <!--    <div class="col-12">
                                                <label for="address2" class="form-label">Address 2 <span
                                                        class="text-muted">(Optional)</span></label>
                                                <input type="text" class="form-control" id="address2"
                                                    placeholder="Apartment or suite">
                                            </div>
        
                                            <div class="col-md-5">
                                                <label for="country" class="form-label">Country</label>
                                                <select class="form-select form-control" id="country" required>
                                                    <option value="">Choose...</option>
                                                    <option>United States</option>
                                                </select>
                                                <div class="invalid-feedback">
                                                    Please select a valid country.
                                                </div>
                                            </div>
        
                                            <div class="col-md-4">
                                                <label for="state" class="form-label">State</label>
                                                <select class="form-select form-control" id="state" required>
                                                    <option value="">Choose...</option>
                                                    <option>California</option>
                                                </select>
                                                <div class="invalid-feedback">
                                                    Please provide a valid state.
                                                </div>
                                            </div>
        
                                            <div class="col-md-3">
                                                <label for="zip" class="form-label">Zip</label>
                                                <input type="text" class="form-control" id="zip" placeholder="" required>
                                                <div class="invalid-feedback">
                                                    Zip code required.
                                                </div>
                                            </div>
                                        </div>
        
        
                                        <div class="form-check mt-4 pt-4 border-top">
                                            <input type="checkbox" class="form-check-input" id="same-address">
                                            <label class="form-check-label" for="same-address">Shipping address is the same as my
                                                billing address</label>
                                        </div>
        
                                        <div class="form-check">
                                            <input type="checkbox" class="form-check-input" id="save-info">
                                            <label class="form-check-label" for="save-info">Save this information for next
                                                time</label>
                                        </div>
        
                                        <h5 class="mb-3 mt-4 pt-4 border-top">Payment</h5>
        
                                        <div class="my-3">
                                            <div class="form-check">
                                                <input id="credit" name="paymentMethod" type="radio" class="form-check-input"
                                                    checked required>
                                                <label class="form-check-label" for="credit">Credit card</label>
                                            </div>
                                            <div class="form-check">
                                                <input id="debit" name="paymentMethod" type="radio" class="form-check-input"
                                                    required>
                                                <label class="form-check-label" for="debit">Debit card</label>
                                            </div>
                                            <div class="form-check">
                                                <input id="paypal" name="paymentMethod" type="radio" class="form-check-input"
                                                    required>
                                                <label class="form-check-label" for="paypal">PayPal</label>
                                            </div>
                                        </div>
        
                                        <div class="row gy-3">
                                            <div class="col-md-6">
                                                <label for="cc-name" class="form-label">Name on card</label>
                                                <input type="text" class="form-control" id="cc-name" placeholder="" required>
                                                <small class="text-muted">Full name as displayed on card</small>
                                                <div class="invalid-feedback">
                                                    Name on card is required
                                                </div>
                                            </div>
        
                                            <div class="col-md-6">
                                                <label for="cc-number" class="form-label">Credit card number</label>
                                                <input type="text" class="form-control" id="cc-number" placeholder="" required>
                                                <div class="invalid-feedback">
                                                    Credit card number is required
                                                </div>
                                            </div>
        
                                            <div class="col-md-3 mb-3">
                                                <label for="cc-expiration" class="form-label">Expiration</label>
                                                <input type="text" class="form-control" id="cc-expiration" placeholder="" required>
                                                <div class="invalid-feedback">
                                                    Expiration date required
                                                </div>
                                            </div>
        
                                            <div class="col-md-3 mb-3">
                                                <label for="cc-cvv" class="form-label">CVV</label>
                                                <input type="text" class="form-control" id="cc-cvv" placeholder="" required>
                                                <div class="invalid-feedback">
                                                    Security code required
                                                </div>
                                            </div>
                                        </div>-->
                                    </form>
                                </div>
                            </div><!--end col-->
                        </div><!--end row-->
                    </div>
                </div><!--end container-->
            </main>
            <!--End page-content" -->
        </div>
        <!-- page-wrapper -->
        
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
