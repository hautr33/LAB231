<%-- 
    Document   : viewCart
    Created on : Oct 18, 2020, 6:24:09 PM
    Author     : SE130205
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Cart</title>
        <c:import url="head.jsp"/>
    </head>
    <body>
        <c:if test="${sessionScope.CART == null}">
            <c:redirect url="SearchAllCakesController"></c:redirect>
        </c:if>
        <c:import url="navbar.jsp"/>
        <br/>
        <div class="container mt-5">
            <div class="col-12" style="margin: auto">
                <div class="card">
                    <div class="card-header">
                        <h4 class="card-title">View Cart</h4>
                    </div>
                    <c:if test="${sessionScope.CART.getSize() == 0}">
                        <div class="container form-group mt-1">
                            <div class="alert alert-danger text-center rounded mt-1 text-bold-700">
                                <c:out value="Your cart is empty!!!"/>
                            </div>
                        </div>
                    </c:if>
                    <c:if test="${sessionScope.CART.getSize() > 0}">
                        <c:if test="${requestScope.NOT_ENOUGH_CAKE != null}">
                            <div class="container form-group">
                                <div class="alert alert-danger text-center rounded">
                                    There cakes is not enough: <strong>${requestScope.NOT_ENOUGH_CAKE}</strong>
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${requestScope.OUT_OF_STOCK != null}">
                            <div class="container form-group">
                                <div class="alert alert-danger text-center rounded">
                                    There cakes is out of stock: <strong>${requestScope.OUT_OF_STOCK}</strong>
                                </div>
                            </div>
                        </c:if>
                        <div class="card-body">
                            <div class="card-content collapse show">
                                <div class="table-responsive">
                                    <table class="table table-hover mb-0">
                                        <thead>
                                            <tr>
                                                <th>#No</th>
                                                <th>Cake Name</th>
                                                <th>Image</th>
                                                <th>Quantity</th>
                                                <th>Price</th>
                                                <th>Total</th>
                                                <th>Update</th>
                                                <th>Delete</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="dto" items="${sessionScope.CART.cart.values()}" varStatus="counter">
                                            <form action="UpdateCartController">
                                                <input type="text" name="txtCakeID" value="${pageScope.dto.cakeID}" hidden/>
                                                <tr>
                                                    <th>#${pageScope.counter.count}</th>
                                                    <td>${pageScope.dto.cakeName}</td>
                                                    <td><img class="img-fluid" src="${pageScope.dto.imageURL}" style="width: 250px;"></td>
                                                    <td><input type="number" name="txtQuantity" step="1" min="1" max="${pageScope.dto.stockQuantity}" value="${pageScope.dto.quantity}" class="form-control form-control-sm" autocomplete="off" required/></td>
                                                    <td>$${pageScope.dto.price}</td>
                                                    <td>$${pageScope.dto.total}</td>
                                                    <td><button type="submit" class="btn btn-primary">Update</button></td>
                                                    <td>
                                                        <button type="button" class="btn btn-danger" data-toggle="modal" data-target="#deleteArticle">Delete</button>
                                                        <div class="modal fade" id="deleteArticle">
                                                            <div class="modal-dialog">
                                                                <div class="modal-content">
                                                                    <div class="modal-header">
                                                                        <h5 class="modal-title" id="exampleModalLabel">Delete</h5>
                                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                            <span aria-hidden="true">&times;</span>
                                                                        </button>
                                                                    </div>
                                                                    <div class="modal-body">
                                                                        Are your sure to delete this cake from cart??
                                                                    </div>
                                                                    <div class="modal-footer">
                                                                        <a href="RemoveFromCartController?txtCakeID=${pageScope.dto.cakeID}" class="btn btn-danger">Delete</a>
                                                                        <button type="button" class="btn btn-outline-secondary" data-dismiss="modal">Cancel</button>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </form>
                                        </c:forEach>
                                        <tr class="bg-teal bg-lighten-4">
                                            <th colspan="5">Total amount of money:</th>
                                            <th>$${sessionScope.CART.getTotalAmount()}</th>
                                            <td colspan="2">
                                                <a href="paymentInfo.jsp" class="btn btn-primary float-right"><i class="fa fa-check"></i> CONFIRM CART</a>
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </div> 
            </div>
        </div>
    </body>
</html>