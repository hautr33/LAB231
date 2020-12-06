<%-- 
    Document   : updateCakePage
    Created on : Oct 17, 2020, 1:00:10 AM
    Author     : SE130205
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Cake - ${requestScope.CAKE.cakeID}</title>
        <c:import url="head.jsp"/>
    </head>
    <body>
        <c:import url="navbar.jsp"/>
        <br/>
        <div class="container mt-5">
            <div class="col-12" style="margin: auto">

                <div class="card">
                    <div class="card-header">
                        <h4 class="card-title">Update Cake</h4>
                    </div>
                    <div class="card-body">
                        <form action="UpdateCakeController" enctype="multipart/form-data" method="POST">
                            <div class="row">
                                <div class="col-8">
                                    <div class="row">
                                        <div class="col-lg-6 col-md-12">
                                            <fieldset class="form-group">
                                                <label>Cake ID</label>
                                                <input type="text" name="txtCakeID" class="form-control" autocomplete="off" readonly value="${requestScope.CAKE.cakeID}"/>
                                            </fieldset>
                                        </div>
                                        <div class="col-lg-6 col-md-12">
                                            <fieldset class="form-group">
                                                <label>Cake Name</label>
                                                <input type="text" name="txtCakeName" class="form-control" autocomplete="off" required value="${requestScope.CAKE.cakeName}"/>
                                            </fieldset>
                                        </div>
                                        <div class="col-lg-6 col-md-12">
                                            <fieldset class="form-group">
                                                <label>Description</label>
                                                <input type="text" name="txtDescription" class="form-control" autocomplete="off" required value="${requestScope.CAKE.description}"/>
                                            </fieldset>
                                        </div>
                                        <div class="col-lg-6 col-md-12">
                                            <fieldset class="form-group">
                                                <label>Category</label>
                                                <select name="txtCategoryID" class="form-control" required>
                                                    <option value="" selected>Select a category</option>
                                                    <c:forEach items="${sessionScope.LIST_CATEGORY}" var="dto">
                                                        <option value="${pageScope.dto.categoryID}" <c:if test="${pageScope.dto.categoryID eq requestScope.CAKE.categoryID}">selected</c:if>>${dto.categoryName}</option>
                                                    </c:forEach>
                                                </select>
                                            </fieldset>
                                        </div>
                                        <div class="col-lg-6 col-md-12">
                                            <fieldset class="form-group">
                                                <label>Price</label>
                                                <input type="number" name="txtPrice" step="0.01" min="0.01" class="form-control" autocomplete="off" required value="${requestScope.CAKE.price}"/>
                                            </fieldset>
                                        </div>
                                        <div class="col-lg-6 col-md-12">
                                            <fieldset class="form-group">
                                                <label>Quantity</label>
                                                <input type="number" name="txtQuantity" step="1" min="1" class="form-control" autocomplete="off" required value="${requestScope.CAKE.quantity}"/>
                                            </fieldset>
                                        </div>
                                        <div class="col-lg-6 col-md-12">
                                            <fieldset class="form-group">
                                                <label>Create Date</label>
                                                <input type="date" name="txtCreateDate" class="form-control" max="${sessionScope.TODAY}" required value="${requestScope.CAKE.createDate}"/>
                                            </fieldset>
                                        </div>
                                        <div class="col-lg-6 col-md-12">
                                            <fieldset class="form-group">
                                                <label>Expiration Date</label>
                                                <input type="date" name="txtExpirationDate" class="form-control" min="${sessionScope.TOMORROW}" required value="${requestScope.CAKE.expirationDate}"/>
                                            </fieldset>
                                        </div>
                                        <div class="col-lg-6 col-md-12">
                                            <fieldset class="form-group">
                                                <label>Status</label>
                                                <select name="txtStatus" class="form-control" required>
                                                    <option value="Active" <c:if test="${requestScope.CAKE.status eq 'Active'}">selected</c:if>>Active</option>
                                                    <option value="Expired" <c:if test="${requestScope.CAKE.status eq 'Expired'}">selected</c:if>>Expired</option>
                                                    </select>
                                                </fieldset>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-4">
                                        <fieldset class="form-group">
                                            <label>Image</label>
                                            <img class="card-img-top img-fluid mb-1" src="${requestScope.CAKE.imageURL}"/>
                                        <div class="custom-file mb-1">
                                            <input type="text" name="txtImageURL" value="${requestScope.CAKE.imageURL}"/>
                                            <input type="file" name="image" accept="image/*" class="custom-file-input"/> 
                                            <label class="custom-file-label">Choose file</label>
                                        </div>
                                    </fieldset>
                                </div>
                                <div class="col-12 mb-1">
                                    <fieldset class="form-group float-right">
                                        <button type="reset" class="btn btn-outline-light">
                                            <i class="fa fa-refresh"></i> Reset
                                        </button>
                                        <button type="submit" class="btn btn-primary">
                                            <i class="fa fa-check"></i> Update
                                        </button>
                                    </fieldset>
                                </div>
                                <c:if test="${requestScope.CREATE_CAKE_SUCCESS != null}">
                                    <div class="col-12 form-group">
                                        <div class="alert alert-success text-center rounded">
                                            <c:out value="${requestScope.CREATE_CAKE_SUCCESS}"/>
                                        </div>
                                    </div>
                                </c:if>
                            </div>
                        </form>
                    </div>
                    <c:if test="${requestScope.UPDATE_CAKE_SUCCESS != null && not empty requestScope.UPDATE_CAKE_SUCCESS}">
                        <div class="container form-group">
                            <div class="alert alert-success text-center rounded text-bold-700">
                                <c:out value="${requestScope.UPDATE_CAKE_SUCCESS}"/>
                            </div>
                        </div>
                    </c:if>
                </div> 
            </div>
        </div>
    </body>
</html>
