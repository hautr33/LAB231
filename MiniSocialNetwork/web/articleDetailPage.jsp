<%-- 
    Document   : articleDetailPage
    Created on : Sep 27, 2020, 2:04:51 PM
    Author     : SE130205
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>${requestScope.ARTICLE.title}</title>
        <c:import url="head.jsp"/>
    </head>
    <body>
        <c:import url="navbar.jsp"/>
        <br/>
        <c:if test="${requestScope.DELETE_ARTICLE_SUCCESS != null && not empty requestScope.DELETE_ARTICLE_SUCCESS}">
            <div class="container form-group mt-5">
                <div class="alert alert-success text-center rounded mt-1 text-bold-700">
                    <c:out value="${requestScope.DELETE_ARTICLE_SUCCESS}"/>
                </div>
            </div>
        </c:if>
        <c:if test="${requestScope.DELETE_ARTICLE_SUCCESS == null || empty requestScope.DELETE_ARTICLE_SUCCESS}">
            <div class="container mt-3 col-6">
                <br/>
                <div class="card border-top-primary">
                    <div class="card-content">
                        <div class="card-body">
                            <h4 class="card-title">${requestScope.AUTHOR_NAME}</h4>
                            <p class="card-subtitle"><small class="text-muted">Last updated ${requestScope.ARTICLE.date}</small></p>
                        </div>
                        <c:if test="${requestScope.ARTICLE.image != null && not empty requestScope.ARTICLE.image}">
                            <img class="img-fluid" src="${requestScope.ARTICLE.image}">
                        </c:if>
                        <div class="card-body">
                            <h6 class="card-title text-muted">${requestScope.ARTICLE.title}</h6>
                            <p class="card-text">${requestScope.ARTICLE.description}</p>
                            <p class="card-text">
                                <span class="badge badge-pill badge-primary">${requestScope.ARTICLE.numLike} <i class="icon-like"></i></span>
                                <span class="badge badge-pill badge-danger">${requestScope.ARTICLE.numDislike} <i class="icon-dislike"></i></span>
                            </p>
                        </div>
                    </div>
                    <div class="card-footer border-top-blue-grey border-top-lighten-5 text-muted">
                        <span class="float-left">
                            <a href="MainController?btnAction=MakeEmotion&txtStatus=Like&txtArticleID=${requestScope.ARTICLE.id}&txtEmail=${sessionScope.USER.email}" class="card-link primary <c:if test="${'Like' eq requestScope.EMOTION}">text-bold-700</c:if>"><i class="icon-like"></i> Like</a>
                            <a href="MainController?btnAction=MakeEmotion&txtStatus=Dislike&txtArticleID=${requestScope.ARTICLE.id}&txtEmail=${sessionScope.USER.email}" class="card-link danger <c:if test="${'Dislike' eq requestScope.EMOTION}">text-bold-700</c:if>"><i class="icon-dislike"></i> Dislike</a>
                            </span>
                            <span class="float-right">
                            <c:if test="${sessionScope.USER.email eq requestScope.ARTICLE.email}">
                                <button type="button" class="btn btn-sm btn-outline-danger float-right" data-toggle="modal">Delete</button>
                            </c:if>
                            <div class="modal fade" id="deleteArticle">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="exampleModalLabel">Delete Article</h5>
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <div class="modal-body">
                                            Are your sure to delete this article??
                                        </div>
                                        <div class="modal-footer">
                                            <a href="MainController?btnAction=DeleteArticle&txtID=${requestScope.ARTICLE.id}" class="btn btn-danger">Delete</a>
                                            <button type="button" class="btn btn-outline-secondary" data-dismiss="modal">Cancel</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </span>
                        <br/>
                    </div>
                </div>
            </div>
        </c:if>
        <br/>
        <c:import url="footer.jsp"/>
    </body>
</html>
