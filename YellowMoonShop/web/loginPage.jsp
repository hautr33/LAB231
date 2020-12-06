<%-- 
    Document   : loginPage
    Created on : Oct 1, 2020, 1:47:56 PM
    Author     : SE130205
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
        <c:import url="head.jsp"/>
        <style>
            body{
                background-image: url("images/background.png");
                height: 100%;
                width: 100%;
                background-position: top;
                background-repeat: no-repeat;
                background-size: cover;
            }
        </style>
    </head>
    <body>
        <div class="container-fluid col-3 float-right bg-white" style="height: 100%;overflow-y: scroll;">
            <div class="p-3">
                <h3 class="display-4 text-center text-muted">Login</h3>
                <h6 class="card-subtitle line-on-side text-muted text-center font-small-3 pt-2"><span>Easily Using</span></h6>
                <div class="text-center">
                    <a href="https://www.facebook.com/dialog/oauth?client_id=1310466739309231&redirect_uri=http://localhost:8084/SE1408_SE130205_YellowMoonShop/LoginFacebookController" class="col-8 btn btn-social mr-1 mb-1 btn-facebook"><span class="fa fa-facebook"></span>Login with Facebook</a>
                </div>
                <p class="card-subtitle line-on-side text-muted text-center font-small-3 mx-2 my-1"><span>OR Using Account Details</span></p>
                <form action="LoginController" method="POST">
                    <div class="form-group">
                        <label>Username</label>
                        <input type="text" class="form-control" name="txtUsername" autocomplete="off" required>
                    </div>
                    <div class="form-group">
                        <label>Password</label>
                        <input type="password" class="form-control" name="txtPassword" autocomplete="off" required>
                    </div>
                    <c:if test="${requestScope.LOGIN_ERROR != null}">
                        <div class="form-group">
                            <div class="alert alert-danger text-center rounded mt-1">
                                <c:out value="${requestScope.LOGIN_ERROR}"/>
                            </div>
                        </div>
                    </c:if>
                    <button class="btn btn-block btn-secondary" type="submit" name="btnAction" value="Login"><i class="fa fa-check"></i> Login</button>
                    <button class="btn btn-block btn-outline-light" type="reset"><i class="fa fa-refresh"></i> Reset</button>
                </form>
                <hr>
                <label><strong><a href="SearchAllCakesController">&larr; Back to Shopping!</a></strong></label>
            </div>
        </div>
        <c:import url="footer.jsp"/>
    </body>
</html>
