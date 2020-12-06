<%-- 
    Document   : loginPage
    Created on : Sep 15, 2020, 2:00:14 PM
    Author     : SE130205
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mini Social Network Login</title>
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
                <form action="LoginController" method="POST">
                    <h3 class="display-4 text-center text-muted">Login</h3><hr/>
                    <div class="form-group">
                        <label>Email</label>
                        <input type="text" class="form-control" name="txtEmail" autocomplete="off" required id="input-email">
                    </div>
                    <div class="form-group">
                        <label>Password</label>
                        <input type="password" class="form-control" name="txtPassword" autocomplete="off" required id="input-password">
                    </div>
                    <c:if test="${requestScope.LOGIN_ERROR != null}">
                        <div class="form-group">
                            <div class="alert alert-danger text-center rounded mt-1">
                                <c:out value="${requestScope.LOGIN_ERROR}"/>
                            </div>
                        </div>
                    </c:if>
                    <button class="btn btn-block btn-secondary" type="submit" name="btnAction" value="Login">Login</button>
                    <button class="btn btn-block btn-outline-secondary" type="reset">Reset</button>
                </form>
                <hr/>
                <label>
                    <p class="mb-0 text-dark">Are you a new member? <strong><a class="text-dark" href="registerPage.jsp">Register now! &rarr;</a></strong></p>
                </label>
            </div>
        </div>
        <c:import url="footer.jsp"/>
    </body>
</html>
