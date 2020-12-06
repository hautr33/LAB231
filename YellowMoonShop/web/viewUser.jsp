<%-- 
    Document   : viewUser
    Created on : Oct 29, 2020, 12:40:26 PM
    Author     : SE130205
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View All User</title>
        <c:import url="head.jsp"/>
    </head>
    <body>
        <c:import url="navbar.jsp"/>
        <br/>
        <div class="container mt-5">
            <div class="col-12" style="margin: auto">
                <div class="card">
                    <div class="card-header">
                        <h4 class="card-title">View All User</h4>
                    </div>
                    <c:if test="${requestScope.LIST_USER == null}">
                        <div class="container form-group mt-1">
                            <div class="alert alert-danger text-center rounded mt-1 text-bold-700">
                                <c:out value="No record found!!!"/>
                            </div>
                        </div>
                    </c:if>
                    <c:if test="${requestScope.LIST_USER != null}">
                        <div class="card-body">
                            <div class="card-content collapse show">
                                <div class="table-responsive">
                                    <table class="table table-hover mb-0">
                                        <thead>
                                            <tr>
                                                <th>#No</th>
                                                <th>User ID</th>
                                                <th>Username</th>
                                                <th>Facebook ID</th>
                                                <th>Full Name</th>
                                                <th>Phone Number</th>
                                                <th>Address</th>
                                                <th>Role</th>
                                                <th>Status</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="dto" items="${requestScope.LIST_USER}" varStatus="counter">
                                                <tr>
                                                    <th>#${pageScope.counter.count}</th>
                                                    <td>${pageScope.dto.userID}</td>
                                                    <td>${pageScope.dto.username}</td>
                                                    <td>${pageScope.dto.facebookID}</td>
                                                    <td>${pageScope.dto.name}</td>
                                                    <td>${pageScope.dto.phone}</td>
                                                    <td>${pageScope.dto.address}</td>
                                                    <td>${pageScope.dto.roleName}</td>
                                                    <td>${pageScope.dto.status}</td>
                                                </tr>
                                            </c:forEach>
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