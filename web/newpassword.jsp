<%-- 
    Document   : newpassword
    Created on : Sep 20, 2024, 9:47:38 PM
    Author     : trant
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <div class="fxt-form">
            <h2 style="color: green">Choose a new password</h2>
            <p id="rule" style="font-size: 14px">
            <form id="f1" action="confirmpass" method="post">
                <input name="userName" value="${requestScope.uName}" type="hidden">
                <div class="form-group">
                    <div class="fxt-transformY-50 fxt-transition-delay-2">
                        <input oninput="checkNumberCharacter(this)" id="pass1" type="password" class="form-control" name="password" placeholder="${requestScope.check == null ? 'Password' : 'New password'}" required value="${uPass}">
                        <i id="iconsee" style="cursor: pointer" onclick="changeIcon(this)" class="fa-solid fa-eye-slash"></i>
                    </div>
                    <label style="color: red; display:none; font-size: 14px" class="mb-1" id="text1"></label>
                </div>
                <div class="form-group">
                    <div class="fxt-transformY-50 fxt-transition-delay-2">
                        <input oninput="checkSame(this)" id="pass2" type="password" class="form-control" name="cfpassword" placeholder="${requestScope.check == null ? 'Confirm Password' : 'Confirm new password'}" required value="${uPass}">
                        <i id="iconsee" style="cursor: pointer" onclick="changeIcon(this)" class="fa-solid fa-eye-slash"></i>
                    </div>
                    <label style="color: red; display:none ; font-size: 14px" class="mb-1" id="text"></label>
                </div>
                <div class="form-group">
                    <div class="fxt-transformY-50 fxt-transition-delay-3">
                        <div class="fxt-content-between">
                           <button id="buttionsubmit" type="submit" class="fxt-btn-fill">Continue</button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </body>
</html>
