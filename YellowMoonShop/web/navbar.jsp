<%-- 
    Document   : navbar
    Created on : Oct 1, 2020, 1:47:39 PM
    Author     : SE130205
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <body>
        <nav class="navbar navbar-expand-lg bg-white shadow fixed-top mb-5">
            <a class="navbar-brand" href="SearchAllCakesController">Yellow Moon Shop</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="teal"><i class="fa fa-th-list"></i></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="SearchAllCakesController">Home</a>
                    </li>
                    <c:if test="${sessionScope.USER != null}">
                        <c:if test="${sessionScope.USER.roleID eq 'AD'}">
                            <li class="nav-item">
                                <a class="nav-link" href="createCakePage.jsp">Create Cake</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="ViewAllUsersController">View All Users</a>
                            </li>
                        </c:if>
                    </c:if>
                    <c:if test="${sessionScope.USER == null or not (sessionScope.USER.roleID eq 'AD')}">
                        <c:if test="${sessionScope.CART != null}">
                            <li class="nav-item">
                                <a class="nav-link" href="viewCart.jsp">View Cart<span class="badge badge badge-danger badge-pill float-right">${sessionScope.CART.getSize()}</span></a>
                            </li>
                        </c:if>
                        <li class="nav-item">
                            <a class="nav-link" href="TrackOrdersController">Track Orders</a>
                        </li>
                    </c:if>
                </ul>
                <c:if test="${sessionScope.USER != null}">
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <a class="btn btn-outline-danger" href="LogoutController">Logout</a>
                        </li>
                    </ul>
                </c:if>
                <c:if test="${sessionScope.USER == null}">
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <a class="btn btn-outline-primary" href="loginPage.jsp">Login</a>
                        </li>
                    </ul>
                </c:if>
            </div>
        </nav>
    </body>
</html>
