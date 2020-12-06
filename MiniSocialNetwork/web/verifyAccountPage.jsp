<%-- 
    Document   : verifyAccountPage
    Created on : Oct 1, 2020, 12:07:07 AM
    Author     : SE130205
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Verify your account</title>
        <c:import url="head.jsp"/>
    </head>
    <body>
        <br/>
        <div class="container bg-white shadow rounded mt-5 col-4">
            <br/>
            <div>
                <span class="float-left">
                    <div class="h5">Verify your account</div>
                </span>
                <span class="float-right">
                    <a href="MainController?btnAction=Logout" class="btn btn-sm btn-outline-danger float-right">Logout</a>
                </span>
            </div>
            <br/>
            <hr/>
            <form action="VerifyAccountController" method="POST">
                <input type="text" name="txtSentCode" value="${requestScope.VERIFY_CODE}" hidden/>
                <label>We just sent a verification message via your email, please open your email to get the verification code and enter the form below</label>
                <div class="input-group">
                    <input type="text" name="txtCode" autocomplete="off" class="form-control" placeholder="Enter code here" minlength="6" maxlength="6" required>
                    <div class="input-group-append">
                        <button class="btn btn-primary" type="submit" name="btnAction" value="VerifyAccount">Next</button>
                    </div>
                </div>
                <c:if test="${requestScope.VERIFY_ERROR != null}">
                    <div class="form-group">
                        <div class="alert alert-danger text-center rounded mt-1">
                            <c:out value="${requestScope.VERIFY_ERROR}"/>
                        </div>
                    </div>
                </c:if>
                <br/>
            </form>
        </div>
        <c:import url="footer.jsp"/>
    </body>
</html>
