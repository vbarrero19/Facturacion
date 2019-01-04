<%-- 
    Document   : userform
    Created on : 24-ene-2017, 12:05:12
    Author     : nmohamed
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="jstl" uri="http://java.sun.com/jstl/core_rt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
    <%@ include file="infouser.jsp" %>
    <head> 
        <title>Welcome</title> 
    </head>
    <body>
        <div class="col-sm-12" style="margin-top: 10px;">
            <div class="panel panel-success">
                <div class="panel-body"align="center">
                    <div class="container " style="margin-top: 10%; margin-bottom: 10%;">

                        <div class="panel panel-success" style="max-width: 35%;" align="left">
                            <div class=" form-group fondoGris">
                                <img class="img-responsive center-block" src="recursos/img/iconos/logoBamboo_Inicio.svg" alt="logo"/>
                            </div>
                            <div class="panel-body" >
                                <form name ="form1" action="userform.htm?opcion=login" method="post" >                            
                                    <div
                                        <c:if test="${message != null}">
                                            <h5 style="color:blue">
                                                <c:out value="${message}"/>
                                            </h5>
                                        </c:if>
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleInputEmail1">User</label> 
                                        <input type="text" class="form-control" name="txtusuario" id="txtusuario" placeholder="User" required="required">    
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleInputPassword1">Password</label> 
                                        <input type="password" class="form-control" name="txtpassword" id="txtpassword" placeholder="Password" ><!--required="required"-->
                                    </div>
                                    <button type="submit" name="submit" value='Login' style="width: 100%; font-size:1.1em;" class="btn btn-large btn btn-success btn-lg btn-block" ><b>Login</b></button>

                                </form>

                            </div>
                        </div>

                    </div>

                </div>
                <div class="panel-footer" align="center"><font style="color: #111">Copyright @2016, EduWeb Group, All Rights Reserved. </font></div>
            </div>
        </div>                   
    </body>
</html>
