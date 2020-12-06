<%-- 
    Document   : checkout
    Created on : Oct 18, 2020, 9:59:08 PM
    Author     : SE130205
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Checkout Successful</title>
        <c:import url="head.jsp"/>
    </head>
    <body>
        <c:import url="navbar.jsp"/>
        <br/>
        <div class="container mt-5">
            <div class="col-8" style="margin: auto">
                <div class="card">
                    <div class="card-header">
                        <h4 class="card-title">You have successfully checkout!!</h4>
                    </div>
                    <div class="card-body">
                        <c:if test="${requestScope.ORDER_ID != null && not empty requestScope.ORDER_ID}">
                            <div class="container form-group mt-1">
                                <div class="alert alert-info text-center rounded mt-1 text-bold-700">
                                    <c:out value="Please keep the Order ID below to tracking your order:"/><br/>
                                    <c:out value="${requestScope.ORDER_ID}"/>
                                </div>
                            </div>
                        </c:if>
                    </div>
                </div> 
            </div>
        </div>
    </body>
</html>