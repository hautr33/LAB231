<%-- 
    Document   : homePage
    Created on : Sep 24, 2020, 7:52:15 PM
    Author     : SE130205
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <c:if test="${param.txtSearch == null || empty param.txtSearch}">
            <title>Welcome: ${sessionScope.USER.name}</title>
        </c:if>
        <c:if test="${param.txtSearch != null && not empty param.txtSearch}">
            <title>Search "${param.txtSearch}" - Page ${requestScope.CUR_PAGE}</title>
        </c:if>
        <c:import url="head.jsp"/>
    </head>
    <body>
        <c:set var="listSize" value="0"></c:set>
        <c:import url="navbar.jsp"/>
        <br/>

        <c:if test="${requestScope.LIST_ARTICLE == null || empty requestScope.LIST_ARTICLE}">
            <div class="container form-group mt-5">
                <div class="alert alert-warning text-center rounded mt-1 text-bold-700">
                    <c:out value="No record found!"/>
                </div>
            </div>
        </c:if>
        <c:if test="${requestScope.LIST_ARTICLE != null && not empty requestScope.LIST_ARTICLE}">

            <div class="container mt-5">
                <div class="row">
                    <div class="col-md-12 mt-1 mb-1">
                        <div class="card-columns">
                            <c:forEach items="${requestScope.LIST_ARTICLE}" var="dto" varStatus="counter">
                                <c:set var="listSize" value="${counter.count}"/>
                                <div class="card border-top-primary">
                                    <div class="card-content">
                                        <div class="card-body">
                                            <h4 class="card-title mb-0">${pageScope.dto.title}</h4>
                                        </div>
                                        <c:if test="${pageScope.dto.image != null && not empty pageScope.dto.image}">
                                            <img class="img-fluid" src="${pageScope.dto.image}">
                                        </c:if>
                                        <div class="card-body">
                                            <p class="card-text">${pageScope.dto.description}</p>
                                            <p class="card-text">
                                                <span class="badge badge-pill badge-primary">${pageScope.dto.numLike} <i class="icon-like"></i></span>
                                                <span class="badge badge-pill badge-danger">${pageScope.dto.numDislike} <i class="icon-dislike"></i></span>
                                            </p>

                                        </div>
                                    </div>
                                    <div class="card-footer border-top-blue-grey border-top-lighten-5 text-muted">
                                        <span class="float-left">Last updated ${pageScope.dto.date}</span>
                                        <span class="float-right">
                                            <a href="MainController?btnAction=ViewDetail&txtID=${pageScope.dto.id}" class="card-link">Read More <i class="fa fa-angle-right"></i></a>
                                        </span>
                                        <br/>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>
        <c:if test="${param.txtSearch == null || empty param.txtSearch}">
            <c:if test="${requestScope.CUR_PAGE < 3}">
                <nav>
                    <ul class="pagination pagination-lg justify-content-center">
                        <li class="page-item <c:if test="${requestScope.CUR_PAGE == 1}">disabled</c:if>">
                            <a class="page-link" href="MainController?btnAction=SearchAll&txtCurPage=${requestScope.CUR_PAGE - 1}">
                                <span aria-hidden="true">« Prev</span>
                                <span class="sr-only">Previous</span>
                            </a>
                        </li>
                        <c:forEach var="pageNum" begin="1" end="5" step="1">
                            <li class="page-item <c:if test="${requestScope.CUR_PAGE == pageScope.pageNum}">active</c:if> <c:if test="${requestScope.CUR_PAGE < pageScope.pageNum and pageScope.listSize < 20}">disabled</c:if>"><a class="page-link" href="MainController?btnAction=SearchAll&txtCurPage=${pageScope.pageNum}">${pageScope.pageNum}</a></li>
                            </c:forEach>
                        <li class="page-item <c:if test="${pageScope.listSize < 20}">disabled</c:if>">
                            <a class="page-link" href="MainController?btnAction=SearchAll&txtCurPage=${requestScope.CUR_PAGE + 1}">
                                <span aria-hidden="true">Next »</span>
                                <span class="sr-only">Next</span>
                            </a>
                        </li>
                    </ul>
                </nav>
            </c:if>
            <c:if test="${requestScope.CUR_PAGE > 2 and pageScope.listSize < 20}">
                <nav>
                    <ul class="pagination pagination-lg justify-content-center">
                        <li class="page-item">
                            <a class="page-link" href="MainController?btnAction=SearchAll&txtCurPage=${requestScope.CUR_PAGE - 1}">
                                <span aria-hidden="true">« Prev</span>
                                <span class="sr-only">Previous</span>
                            </a>
                        </li>
                        <c:forEach var="pageNum" begin="${requestScope.CUR_PAGE - 2}" end="${requestScope.CUR_PAGE + 2}" step="1">
                            <li class="page-item <c:if test="${requestScope.CUR_PAGE == pageScope.pageNum}">active</c:if> <c:if test="${requestScope.CUR_PAGE < pageScope.pageNum}">disabled</c:if>"><a class="page-link" href="MainController?btnAction=SearchAll&txtCurPage=${pageScope.pageNum}">${pageScope.pageNum}</a></li>
                            </c:forEach>
                        <li class="page-item disabled">
                            <a class="page-link" href="MainController?btnAction=SearchAll&txtCurPage=${requestScope.CUR_PAGE + 1}">
                                <span aria-hidden="true">Next »</span>
                                <span class="sr-only">Next</span>
                            </a>
                        </li>
                    </ul>
                </nav>
            </c:if>
        </c:if>
        <c:if test="${param.txtSearch != null && not empty param.txtSearch}">
            <c:if test="${requestScope.CUR_PAGE < 3}">
                <nav>
                    <ul class="pagination pagination-lg justify-content-center">
                        <li class="page-item <c:if test="${requestScope.CUR_PAGE == 1}">disabled</c:if>">
                            <a class="page-link" href="MainController?btnAction=Search&txtSearch=${param.txtSearch}&txtCurPage=${requestScope.CUR_PAGE - 1}">
                                <span aria-hidden="true">« Prev</span>
                                <span class="sr-only">Previous</span>
                            </a>
                        </li>
                        <c:forEach var="pageNum" begin="1" end="5" step="1">
                            <li class="page-item <c:if test="${requestScope.CUR_PAGE == pageScope.pageNum}">active</c:if> <c:if test="${requestScope.CUR_PAGE < pageScope.pageNum and pageScope.listSize < 20}">disabled</c:if>"><a class="page-link" href="MainController?btnAction=Search&txtSearch=${param.txtSearch}&txtCurPage=${pageScope.pageNum}">${pageScope.pageNum}</a></li>
                            </c:forEach>
                        <li class="page-item <c:if test="${pageScope.listSize < 20}">disabled</c:if>">
                            <a class="page-link" href="MainController?btnAction=Search&txtSearch=${param.txtSearch}&txtCurPage=${requestScope.CUR_PAGE + 1}">
                                <span aria-hidden="true">Next »</span>
                                <span class="sr-only">Next</span>
                            </a>
                        </li>
                    </ul>
                </nav>
            </c:if>
            <c:if test="${requestScope.CUR_PAGE > 2 and pageScope.listSize < 20}">
                <nav>
                    <ul class="pagination pagination-lg justify-content-center">
                        <li class="page-item">
                            <a class="page-link" href="MainController?btnAction=Search&txtSearch=${param.txtSearch}&txtCurPage=${requestScope.CUR_PAGE - 1}">
                                <span aria-hidden="true">« Prev</span>
                                <span class="sr-only">Previous</span>
                            </a>
                        </li>
                        <c:forEach var="pageNum" begin="${requestScope.CUR_PAGE - 2}" end="${requestScope.CUR_PAGE + 2}" step="1">
                            <li class="page-item <c:if test="${requestScope.CUR_PAGE == pageScope.pageNum}">active</c:if> <c:if test="${requestScope.CUR_PAGE < pageScope.pageNum}">disabled</c:if>"><a class="page-link" href="MainController?btnAction=Search&txtSearch=${param.txtSearch}&txtCurPage=${pageScope.pageNum}">${pageScope.pageNum}</a></li>
                            </c:forEach>
                        <li class="page-item disabled">
                            <a class="page-link" href="MainController?btnAction=Search&txtSearch=${param.txtSearch}&txtCurPage=${requestScope.CUR_PAGE + 1}">
                                <span aria-hidden="true">Next »</span>
                                <span class="sr-only">Next</span>
                            </a>
                        </li>
                    </ul>
                </nav>
            </c:if>
        </c:if>
        <br/>
        <br/>
        <c:import url="footer.jsp"/>
    </body>
</html>
