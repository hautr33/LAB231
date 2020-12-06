<%-- 
    Document   : homePage
    Created on : Oct 13, 2020, 12:42:00 AM
    Author     : SE130205
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <c:if test="${requestScope.SEARCH_TITLE != null}">
            <title>${requestScope.SEARCH_TITLE}</title>
        </c:if>
        <c:if test="${requestScope.SEARCH_TITLE == null}">
            <title>Yellow Moon Shop</title>
        </c:if>

        <c:import url="head.jsp"/>
    </head>
    <body>
        <c:set var="listSize" value="0"></c:set>
        <c:import url="navbar.jsp"/>
        <br/>
        <div class="container mt-5 mb-1">
            <c:if test="${sessionScope.USER != null}">
                <div class="container form-group mt-1" style="padding: 0;">
                    <div class="alert alert-info rounded mt-1 text-bold-700">
                        <c:out value="Welcome, ${sessionScope.USER.name} to Yellow Moon Shop!"/>
                    </div>
                </div>
            </c:if>
            <div class="card">
                <div class="card-header">
                    <h4 class="card-title">Search</h4>
                </div>
                <div class="card-body">
                    <form action="SearchCakeController">
                        <div class="row">
                            <div class="col-lg-4 col-md-12 mb-1">
                                <fieldset>
                                    <div class="input-group">
                                        <c:if test="${param.txtSearchType eq 'name'}">
                                            <div class="input-group-prepend">
                                                <div class="input-group-text">
                                                    <input type="radio" name="txtSearchType" value="name" checked>
                                                </div>
                                            </div>
                                            <input type="text" name="txtSearch" class="form-control" autocomplete="off" placeholder="Search by cake name" value="${param.txtSearch.trim()}">
                                        </c:if>
                                        <c:if test="${not (param.txtSearchType eq 'name')}">
                                            <div class="input-group-prepend">
                                                <div class="input-group-text">
                                                    <input type="radio" name="txtSearchType" value="name">
                                                </div>
                                            </div>
                                            <input type="text" name="txtSearch" class="form-control" autocomplete="off" placeholder="Search by cake name">
                                        </c:if>
                                    </div>
                                </fieldset>
                            </div>
                            <div class="col-lg-4 col-md-12 mb-1">
                                <fieldset>
                                    <div class="input-group">
                                        <c:if test="${param.txtSearchType eq 'price'}">
                                            <div class="input-group-prepend">
                                                <div class="input-group-text">
                                                    <input type="radio" name="txtSearchType" value="price" checked>
                                                </div>
                                            </div>
                                            <div class="input-group-prepend">
                                                <span class="input-group-text">From</span>
                                            </div>
                                            <input type="number" name="txtFromPrice" class="form-control" autocomplete="off" placeholder="price" step="0.01" min="0.01" max="9999" value="${param.txtFromPrice}">
                                            <div class="input-group-prepend">
                                                <span class="input-group-text">To</span>
                                            </div>
                                            <input type="number" name="txtToPrice" class="form-control" autocomplete="off" placeholder="price" step="0.01" min="0.01" max="9999" value="${param.txtToPrice}">
                                        </c:if>
                                        <c:if test="${not (param.txtSearchType eq 'price')}">
                                            <div class="input-group-prepend">
                                                <div class="input-group-text">
                                                    <input type="radio" name="txtSearchType" value="price">
                                                </div>
                                            </div>
                                            <div class="input-group-prepend">
                                                <span class="input-group-text">From</span>
                                            </div>
                                            <input type="number" name="txtFromPrice" class="form-control" autocomplete="off" placeholder="price" step="0.01" min="0.01" max="9999">
                                            <div class="input-group-prepend">
                                                <span class="input-group-text">To</span>
                                            </div>
                                            <input type="number" name="txtToPrice" class="form-control" autocomplete="off" placeholder="price" step="0.01" min="0.01" max="9999">
                                        </c:if>
                                    </div>
                                </fieldset>
                            </div>
                            <div class="col-lg-4 col-md-12 mb-1">
                                <fieldset>
                                    <div class="input-group">
                                        <c:if test="${param.txtSearchType eq 'category'}">
                                            <div class="input-group-prepend">
                                                <div class="input-group-text">
                                                    <input type="radio" name="txtSearchType" value="category" checked>
                                                </div>
                                            </div>
                                            <div class="input-group-prepend">
                                                <span class="input-group-text">Category</span>
                                            </div>
                                            <select name="txtCategoryID" class="form-control">
                                                <option value="" selected>Select a category</option>
                                                <c:forEach items="${sessionScope.LIST_CATEGORY}" var="dto">
                                                    <c:if test="${param.txtCategoryID eq pageScope.dto.categoryID}">
                                                        <option value="${pageScope.dto.categoryID}" selected>${dto.categoryName}</option>
                                                    </c:if>
                                                    <c:if test="${not (param.txtCategoryID eq pageScope.dto.categoryID)}">
                                                        <option value="${pageScope.dto.categoryID}">${dto.categoryName}</option>
                                                    </c:if>
                                                </c:forEach>
                                            </select>
                                        </c:if>
                                        <c:if test="${not (param.txtSearchType eq 'category')}">
                                            <div class="input-group-prepend">
                                                <div class="input-group-text">
                                                    <input type="radio" name="txtSearchType" value="category">
                                                </div>
                                            </div>
                                            <div class="input-group-prepend">
                                                <span class="input-group-text">Category</span>
                                            </div>
                                            <select name="txtCategoryID" class="form-control">
                                                <option value="" selected>Select a category</option>
                                                <c:forEach items="${sessionScope.LIST_CATEGORY}" var="dto">
                                                    <option value="${pageScope.dto.categoryID}">${dto.categoryName}</option>
                                                </c:forEach>
                                            </select>
                                        </c:if>
                                    </div>
                                </fieldset>
                            </div>
                            <div class="col-12">
                                <button type="submit" class="btn btn-primary">
                                    <i class="fa fa-search"></i> Search
                                </button>
                                <a href="SearchAllCakesController" class="btn btn-outline-light"><i class="fa fa-refresh"></i> Reset</a>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <c:if test="${requestScope.MESSAGE != null && not empty requestScope.MESSAGE}">
            <div class="container form-group mt-1">
                <div class="alert alert-info text-center rounded mt-1 text-bold-700">
                    <c:out value="${requestScope.MESSAGE}"/>
                </div>
            </div>
        </c:if>
        <c:if test="${requestScope.SEARCH_ERROR != null && not empty requestScope.SEARCH_ERROR}">
            <div class="container form-group mt-1">
                <div class="alert alert-danger text-center rounded mt-1 text-bold-700">
                    <c:out value="${requestScope.SEARCH_ERROR}"/>
                </div>
            </div>
        </c:if>
        <c:if test="${requestScope.SEARCH_ERROR == null || empty requestScope.SEARCH_ERROR}">
            <c:if test="${requestScope.LIST_CAKE == null || empty requestScope.LIST_CAKE}">
                <div class="container form-group mt-1">
                    <div class="alert alert-danger text-center rounded mt-1 text-bold-700">
                        <c:out value="No record found!"/>
                    </div>
                </div>
            </c:if>
        </c:if>
        <c:if test="${requestScope.LIST_CAKE != null && not empty requestScope.LIST_CAKE}">
            <div class="container mt-1 mb-1">
                <div class="row match-height">
                    <c:forEach items="${requestScope.LIST_CAKE}" var="dto" varStatus="counter">
                        <c:set var="listSize" value="${counter.count}"/>
                        <div class="col-lg-4 col-md-12">
                            <div class="card">
                                <div class="card-content">
                                    <img class="card-img-top img-fluid" src="${pageScope.dto.imageURL}">
                                    <div class="card-body">
                                        <h4 class="card-title">${pageScope.dto.cakeName}</h4>
                                        <p class="card-text"><span class="badge badge-pill badge-primary">Category</span> 
                                            <c:forEach items="${sessionScope.LIST_CATEGORY}" var="category">
                                                <c:if test="${pageScope.category.categoryID eq pageScope.dto.categoryID}">
                                                    ${pageScope.category.categoryName}
                                                </c:if>
                                            </c:forEach>
                                        </p>
                                        <p class="card-text"><span class="badge badge-pill badge-primary">Description</span> ${pageScope.dto.description}</p>
                                        <p class="card-text"><span class="badge badge-pill badge-primary">Create Date</span> ${pageScope.dto.createDate}</p>
                                        <p class="card-text"><span class="badge badge-pill badge-warning">Expiration Date</span> ${pageScope.dto.expirationDate}</p>
                                    </div>
                                </div>
                                <c:if test="${sessionScope.USER.roleID eq 'AD'}">
                                    <div class="card-footer text-muted">
                                        <span class="float-left">$${pageScope.dto.price}</span>
                                        <a href="FowardUpdatePageController?txtCakeID=${pageScope.dto.cakeID}"><span class="float-right">Update Cake <i class="fa fa-pencil-square-o"></i></span></a>
                                    </div>
                                </c:if>
                                <c:if test="${sessionScope.USER == null || sessionScope.USER.roleID eq 'MB'}">
                                    <c:if test="${param.txtSearchType == null}">
                                        <div class="card-footer text-muted">
                                            <span class="float-left">$${pageScope.dto.price}</span>
                                            <a href="AddToCartController?txtCakeID=${pageScope.dto.cakeID}"><span class="float-right">Add To Cart <i class="fa fa-cart-plus"></i></span></a>
                                        </div>
                                    </c:if>
                                    <c:if test="${param.txtSearchType eq 'name'}">
                                        <div class="card-footer text-muted">
                                            <span class="float-left">$${pageScope.dto.price}</span>
                                            <a href="AddToCartController?txtCakeID=${pageScope.dto.cakeID}&txtSearchType=${param.txtSearchType}&txtSearch=${param.txtSearch}"><span class="float-right">Add To Cart <i class="fa fa-cart-plus"></i></span></a>
                                        </div>
                                    </c:if>
                                    <c:if test="${param.txtSearchType eq 'price'}">
                                        <div class="card-footer text-muted">
                                            <span class="float-left">$${pageScope.dto.price}</span>
                                            <a href="AddToCartController?txtCakeID=${pageScope.dto.cakeID}&txtSearchType=${param.txtSearchType}&txtFromPrice=${param.txtFromPrice}&txtToPrice=${param.txtToPrice}"><span class="float-right">Add To Cart <i class="fa fa-cart-plus"></i></span></a>
                                        </div>
                                    </c:if>
                                    <c:if test="${param.txtSearchType eq 'category'}">
                                        <div class="card-footer text-muted">
                                            <span class="float-left">$${pageScope.dto.price}</span>
                                            <a href="AddToCartController?txtCakeID=${pageScope.dto.cakeID}&txtSearchType=${param.txtSearchType}&txtCategoryID=${param.txtCategoryID}"><span class="float-right">Add To Cart <i class="fa fa-cart-plus"></i></span></a>
                                        </div>
                                    </c:if>

                                </c:if>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </c:if>
        <c:if test="${requestScope.CUR_PAGE < 3}">
            <nav>
                <ul class="pagination pagination-lg justify-content-center">
                    <li class="page-item <c:if test="${requestScope.CUR_PAGE == 1}">disabled</c:if>">
                        <a class="page-link" href="SearchAllCakesController?txtCurPage=${requestScope.CUR_PAGE - 1}">
                            <span aria-hidden="true">« Prev</span>
                            <span class="sr-only">Previous</span>
                        </a>
                    </li>
                    <c:forEach var="pageNum" begin="1" end="5" step="1">
                        <li class="page-item <c:if test="${requestScope.CUR_PAGE == pageScope.pageNum}">active</c:if> <c:if test="${requestScope.CUR_PAGE < pageScope.pageNum and pageScope.listSize < 20}">disabled</c:if>"><a class="page-link" href="SearchAllCakesController?txtCurPage=${pageScope.pageNum}">${pageScope.pageNum}</a></li>
                        </c:forEach>
                    <li class="page-item <c:if test="${pageScope.listSize < 20}">disabled</c:if>">
                        <a class="page-link" href="SearchAllCakesController?txtCurPage=${requestScope.CUR_PAGE + 1}">
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
                        <a class="page-link" href="SearchAllCakesController?txtCurPage=${requestScope.CUR_PAGE - 1}">
                            <span aria-hidden="true">« Prev</span>
                            <span class="sr-only">Previous</span>
                        </a>
                    </li>
                    <c:forEach var="pageNum" begin="${requestScope.CUR_PAGE - 2}" end="${requestScope.CUR_PAGE + 2}" step="1">
                        <li class="page-item <c:if test="${requestScope.CUR_PAGE == pageScope.pageNum}">active</c:if> <c:if test="${requestScope.CUR_PAGE < pageScope.pageNum}">disabled</c:if>"><a class="page-link" href="SearchAllCakesController?txtCurPage=${pageScope.pageNum}">${pageScope.pageNum}</a></li>
                        </c:forEach>
                    <li class="page-item disabled">
                        <a class="page-link" href="SearchAllCakesController?txtCurPage=${requestScope.CUR_PAGE + 1}">
                            <span aria-hidden="true">Next »</span>
                            <span class="sr-only">Next</span>
                        </a>
                    </li>
                </ul>
            </nav>
        </c:if>
        <br/>
        <br/>
        <c:import url="footer.jsp"/>
    </body>
</html>