<%-- 
    Document   : paymentInfo
    Created on : Oct 18, 2020, 8:57:50 PM
    Author     : SE130205
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Shipping & Billing</title>
        <c:import url="head.jsp"/>
    </head>
    <body>
        <c:import url="navbar.jsp"/>
        <br/>
        <div class="container mt-5">
            <div class="row">
                <div class="col-8">
                    <div class="card">
                        <div class="card-header">
                            <h4 class="card-title">Items</h4>
                        </div>
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
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="dto" items="${sessionScope.CART.cart.values()}" varStatus="counter">
                                                <tr>
                                                    <th>#${pageScope.counter.count}</th>
                                                    <td>${pageScope.dto.cakeName}</td>
                                                    <td><img class="img-fluid" src="${pageScope.dto.imageURL}" style="width: 250px;"></td>
                                                    <td>${pageScope.dto.quantity}</td>
                                                    <td>$${pageScope.dto.price}</td>
                                                    <td>$${pageScope.dto.total}</td>
                                                </tr>
                                            </c:forEach>
                                            <tr class="bg-teal bg-lighten-4">
                                                <th colspan="5">Total amount of money:</th>
                                                <th>$${sessionScope.CART.getTotalAmount()}</th>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div> 
                </div>
                <div class="col-4">
                    <div class="card">
                        <div class="card-header">
                            <h4 class="card-title">Shipping & Billing</h4>
                        </div>
                        <div class="card-body">
                            <form action="CheckoutController">
                                <input type="text" name="txtUserID" value="${sessionScope.USER.userID}" hidden/>
                                <div class="row">
                                    <div class="col-12">
                                        <fieldset class="form-group">
                                            <label>Name</label>
                                            <input type="text" name="txtName" class="form-control" maxlength="50" autocomplete="off" required value="${sessionScope.USER.name}">
                                        </fieldset>
                                    </div>
                                    <div class="col-12">
                                        <fieldset class="form-group">
                                            <label>Address</label>
                                            <input type="text" name="txtAddress" class="form-control" maxlength="100" autocomplete="off" required value="${sessionScope.USER.address}">
                                        </fieldset>
                                    </div>
                                    <div class="col-12">
                                        <fieldset class="form-group">
                                            <label>Phone</label>
                                            <input type="text" pattern="^[0][1-9][0-9]{8}" name="txtPhone" class="form-control" minlength="10" maxlength="10" autocomplete="off" required value="${sessionScope.USER.phone}">
                                        </fieldset>
                                    </div>
                                    <div class="col-12">
                                        <fieldset class="form-group">
                                            <label>Note</label>
                                            <input type="text" name="txtNote" class="form-control" maxlength="50" autocomplete="off">
                                        </fieldset>
                                    </div>
                                    <c:if test="${sessionScope.USER != null}">
                                        <div class="col-12">
                                            <fieldset class="checkboxsas">
                                                <label>
                                                    <input type="checkbox" name="chkInfo" value="Save">
                                                    Save Shipping & Billing Information
                                                </label>
                                            </fieldset>
                                        </div>
                                    </c:if>
                                    <div class="col-12 mb-1">
                                        <fieldset class="form-group float-right">
                                            <button type="reset" class="btn btn-outline-light">
                                                <i class="fa fa-refresh"></i> Reset
                                            </button>
                                            <button type="submit" class="btn btn-primary">
                                                <i class="fa fa-check"></i> Checkout
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
                    </div> 
                </div>
            </div>
        </div>
    </body>
</html>
