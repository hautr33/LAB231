<%-- 
    Document   : navbar
    Created on : Sep 22, 2020, 10:39:54 AM
    Author     : SE130205
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <body>
        <nav class="navbar navbar-expand-lg bg-white shadow fixed-top">
            <a class="navbar-brand" href="#">Hi! ${sessionScope.USER.name}</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarColor01" id="menu">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarColor01">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="MainController?btnAction=SearchAll">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="postArticlePage.jsp">Post Article</a>
                    </li>

                </ul>
                <form action="MainController" class="form-inline">
                    <input class="form-control mr-sm-2" type="search" name="txtSearch" value="${param.txtSearch}" placeholder="Search by Description" required>
                    <input type="text" name="txtCurPage" value="1" hidden/>
                    <button class="btn btn-outline-primary my-2 my-sm-0" type="submit" name="btnAction" value="Search">Search</button>
                </form>
            </div>
            <form action="MainController">
                <input class="btn btn-outline-danger my-2 my-sm-0 ml-1" type="submit" name="btnAction" value="Logout" id="btn-logout"/>
            </form>
        </nav>
    </body>
</html>
