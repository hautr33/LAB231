<%-- 
    Document   : postArticlePage
    Created on : Sep 16, 2020, 4:06:23 PM
    Author     : SE130205
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Post Article Page</title>
        <c:import url="head.jsp"/>
    </head>
    <body>
        <c:import url="navbar.jsp"/>
        <br/>
        <div class="container bg-white shadow rounded mt-5">
            <br/>
            <div class="h5">Post an article!</div>
            <hr/>
            <form action="MainController" enctype="multipart/form-data" method="POST">
                <input type="text" name="txtEmail" value="${sessionScope.USER.email}" hidden/>
                <label>Tittle</label>
                <input class="form-control" type="text" name="txtTitle" maxlength="50" placeholder="What's on your mind?" autocomplete="off" required/>
                <label>Description</label>
                <textarea class="form-control" name="txtDescription" maxlength="500" rows="3" autocomplete="off" required></textarea>
                <label>Image</label>
                <div class="custom-file mb-1">
                    <input type="file" name="image" accept="image/*" class="custom-file-input" id="inputGroupImage">
                    <label class="custom-file-label" for="inputGroupImage">Choose file</label>
                </div>
                <br/>
                <input class="btn btn-primary darken btn-block" type="submit" name="btnAction" value="Post"/>
                <c:if test="${requestScope.POST_ARTICLE_SUCCESS != null}">
                    <div class="form-group" style="margin-top: 1%; margin-bottom: 0;">
                        <div class="alert alert-success text-center rounded">
                            <c:out value="${requestScope.POST_ARTICLE_SUCCESS}"/>
                        </div>
                    </div>
                </c:if>
                <br/>
            </form>
        </div>
        <c:import url="footer.jsp"/>
    </body>
</html>
