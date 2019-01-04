<%-- 
    Document   : userform
    Created on : 24-ene-2017, 12:05:12
    Author     : nmohamed
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="jstl" uri="http://java.sun.com/jstl/core_rt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
    <%@ include file="infouser.jsp" %>
    <head> 
        <title>CLIENTES VIEW</title> 
    </head>
    <script>
        $(document).ready(function () {
            $("#submit").click(function () {
                if (window.XMLHttpRequest) //mozilla
                {
                    ajax = new XMLHttpRequest(); //No Internet explorer
                } else
                {
                    ajax = new ActiveXObject("Microsoft.XMLHTTP");
                }

                var myObj = {};
                myObj["id_items"] = $("#id_items").val().trim();
                myObj["abreviatura"] = $("#abreviatura").val().trim();
                myObj["nombre"] = $("#nombre").val().trim();
                myObj["precio"] = $("#precio").val().trim();
                /*myObj["col5"] = $("#message").val().trim();*/
 
                /*  var myObj = {
                 "col1": "$scope.usuario.dni", 
                 "col2": "$scope.usuario.contrasenia"
                 };*/
                var json = JSON.stringify(myObj);
                $.ajax({
                    type: 'POST',
                    url: '/Facturacion/ItemsController/newCustomer.htm',
                    data: json,
                    datatype: "json",
                    contentType: "application/json",
                    success: function (data) {
                       alert(data); 
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        console.log(xhr.status);
                        console.log(xhr.responseText);
                        console.log(thrownError);
                    }


                });
            })
        });
        ;
    </script>
    <body>
        <div class="container">
            <div class="col-xs-12">
                <div class="col-md-5">
                    <div class="form-area">  
                        <form role="form">
                            <br style="clear:both">
                            <h3 style="margin-bottom: 25px; text-align: center;">Items</h3>
                            <div class="form-group">
                                <input type="text" class="form-control" id="id_items" name="id_items" placeholder="Identificador" required>
                            </div>                            
                            <div class="form-group">
                                <input type="text" class="form-control" id="abreviatura" name="abreviatura" placeholder="Abreviatura" required>
                            </div>
                            <div class="form-group">
                                <input type="text" class="form-control" id="nombre" name="nombre" placeholder="Nombre" required>
                            </div>
                            <div class="form-group">
                                <input type="text" class="form-control" id="precio" name="precio" placeholder="Precio" required>
                            </div>
                            <!--
                            <div class="form-group">
                                <input type="text" class="form-control" id="mobile" name="mobile" placeholder="Mobile Number" required>
                            </div>
                            <div class="form-group">
                                <input type="text" class="form-control" id="subject" name="subject" placeholder="Subject" required>
                            </div>
                            <div class="form-group">
                                <textarea class="form-control" type="textarea" id="message" placeholder="Message" maxlength="140" rows="7"></textarea>
                                <span class="help-block"><p id="characterLeft" class="help-block ">You have reached the limit</p></span>                    
                            </div>
                            -->
                            <button type="button" id="submit" name="submit" class="btn btn-primary pull-right">Submit Form</button>
                        </form>
                    </div>
                </div>
            </div>


        </div>                  
    </body>
</html>
