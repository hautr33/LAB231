<%-- 
    Document   : registerPage
    Created on : Sep 15, 2020, 2:01:24 PM
    Author     : SE130205
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register Page</title>
        <c:import url="head.jsp"/>
        <style>
            body{
                background-image: url("https://i.pinimg.com/originals/de/1d/df/de1ddf9ee30e08e15460626b919ef87e.jpg");
                height: 100%;
                width: 100%;
                background-position: top;
                background-repeat: no-repeat;
                background-size: cover;
            }
        </style>
    </head>
    <body>
        <div class="container pt-5 pb-5">
            <div class="col-5 bg-white p-3" style="margin: auto">
                <form action="RegisterController" method="POST">
                    <h3 class="display-4 text-center text-muted">Register</h3><hr/>
                    <div class="form-group">
                        <label>Email</label>
                        <input type="email" name="txtEmail" maxlength="50" pattern="^[a-z0-9][a-z0-9_.]{1,32}@[a-z0-9]{2,}(\.[a-z0-9]{2,4}){1,2}$" title="example@example.com.vn" autocomplete="off" class="form-control" required/>
                    </div>
                    <div class="form-group">
                        <label>Name</label>
                        <input type="text" class="form-control" name="txtName" maxlength="50" autocomplete="off" required/>
                    </div>
                    <div class="form-group">
                        <label>Password</label>
                        <input type="password" class="form-control" name="txtPassword" maxlength="20" autocomplete="off" required/>
                    </div>
                    <div class="form-group">
                        <label>Confirm Password</label>
                        <input type="password" class="form-control" name="txtConfirmPassword" maxlength="50" autocomplete="off" required/>
                    </div>
                    <c:if test="${requestScope.REGISTER_ERROR != null}">
                        <div class="form-group">
                            <div class="alert alert-danger text-center rounded mt-1">
                                <c:out value="${requestScope.REGISTER_ERROR}"/>
                            </div>
                        </div>
                    </c:if>
                    <c:if test="${requestScope.REGISTER_SUCCESS != null}">
                        <div class="form-group">
                            <div class="alert alert-success text-center rounded mt-1">
                                <c:out value="${requestScope.REGISTER_SUCCESS}"/>
                            </div>
                        </div>
                    </c:if>
                    <button class="btn btn-block btn-secondary" type="submit" name="btnAction" value="Register">Register</button>
                    <button class="btn btn-block btn-outline-secondary" type="reset">Reset</button>
                </form>
                <hr/>
                <label><strong><a class="text-dark" href="loginPage.jsp">&larr; Back to Login Page!</a></strong>
                </label>
            </div>
        </div>
        <c:import url="footer.jsp"/>
    </body>
</html>
