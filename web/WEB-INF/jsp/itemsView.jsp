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
        <title>ITEMS VIEW</title> 
    </head>
    <script>
        $(document).ready(function () {
            getImpuesto();
            $("#submit").click(function () {
                if (window.XMLHttpRequest) //mozilla
                {
                    ajax = new XMLHttpRequest(); //No Internet explorer
                } else
                {
                    ajax = new ActiveXObject("Microsoft.XMLHTTP");
                }

                var myObj = {};

                myObj["id_item"] = $("#id_item").val().trim();
                myObj["abreviatura"] = $("#abreviatura").val().trim();
                myObj["nombre"] = $("#nombre").val().trim();
                myObj["precio"] = $("#precio").val().trim();
                myObj["id_impuesto"] = $("#id_impuesto").val().trim();
          
                var json = JSON.stringify(myObj);
                $.ajax({
                    type: 'POST',
                    url: '/Facturacion/itemsController/newCustomer.htm',
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
        
        function getImpuesto(){
            if (window.XMLHttpRequest) //mozilla
                {
                    ajax = new XMLHttpRequest(); //No Internet explorer
                } else
                {
                    ajax = new ActiveXObject("Microsoft.XMLHTTP");
                }                
                
                $.ajax({
                    type: 'GET',
                    url: '/Facturacion/itemsController/getImpuesto.htm',                    
                    success: function (data) {
                        alert(data);
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        console.log(xhr.status);
                        console.log(xhr.responseText);
                        console.log(thrownError);
                    }
                });
        }
    
        
    </script>
    <body>
        <div class="container">
            <div class="col-xs-12">
                <div class="col-md-5">
                    <div class="form-area">  
                        <form role="form">
                            <br style="clear:both">
                            <h3 style="margin-bottom: 25px; text-align: center;">Formulario para ITEMS</h3>
                            <div class="form-group">
                                <input type="text" class="form-control" id="id_item" name="id_item" placeholder="Identificador" required>
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
                            <div class="form-group">
                                <input type="text" class="form-control" id="id_impuesto" name="id_impuesto" placeholder="Identificador impuesto" required>
                            </div>  
                            <div class="form-group">
                                <select class="form-control" id="impuesto" name="impuesto">
                                    <option>1</option>
                                    <option>2</option>
                                    <option>3</option>
                                    <option>4</option>
                                    <option>5</option>
                                </select>
                            </div>
                            <a href="<c:url value='/MenuController/start.htm'/>" class="btn btn-info" role="button">Menu principal</a> 
                            <button type="button" id="submit" name="submit" class="btn btn-primary pull-right">Submit Form</button>
                        </form>
                    </div>
                </div>
            </div>


        </div>                  
    </body>
</html>
