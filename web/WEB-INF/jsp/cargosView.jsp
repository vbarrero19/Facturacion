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
        <title>CARGOS VIEW</title> 
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
                myObj["id_cargo"] = $("#id_cargo").val().trim();
                myObj["id_items"] = $("#id_items").val().trim();
                myObj["id_factura"] = $("#id_factura").val().trim();
                myObj["id_cliente"] = $("#id_cliente").val().trim();
                myObj["cantidad"] = $("#cantidad").val().trim();
                myObj["impuesto"] = $("#impuesto").val().trim();
                myObj["cargo"] = $("#cargo").val().trim();
                //myObj["fecha_cargo"] = $("#fecha_cargo").val().trim();
                //myObj["fecha_vencimiento"] = $("#fecha_vencimiento").val().trim();
 
              
                var json = JSON.stringify(myObj);
                $.ajax({
                    type: 'POST',
                    url: '/Facturacion/cargosController/newCustomer.htm',
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
                            <h3 style="margin-bottom: 25px; text-align: center;">Formulario para CARGOS</h3>
                            <div class="form-group">
                                <input type="text" class="form-control" id="id_cargo" name="id_cargo" placeholder="Identificador cargo" required>
                            </div>                            
                            <div class="form-group">
                                <input type="text" class="form-control" id="id_items" name="id_items" placeholder="Identificador items" required>
                            </div>
                            <div class="form-group">
                                <input type="text" class="form-control" id="id_factura" name="id_factura" placeholder="Identificador factura" required>
                            </div>
                            <div class="form-group">
                                <input type="text" class="form-control" id="id_cliente" name="id_cliente" placeholder="Identificador cliente" required>
                            </div>
                            <div class="form-group">
                                <input type="text" class="form-control" id="cantidad" name="cantidad" placeholder="Cantidad" required>
                            </div>
                            <div class="form-group">
                                <input type="text" class="form-control" id="impuesto" name="impuesto" placeholder="Impuesto" required>
                            </div>
                            <div class="form-group">
                                <textarea class="form-control" type="textarea" id="cargo" name="cargo" placeholder="Cargo" maxlength="140" rows="7"></textarea>
                                <span class="help-block"><p id="characterLeft" class="help-block ">You have reached the limit</p></span>                    
                            </div>
                            <div class="form-group">
                                <input type="text" class="form-control" id="fecha_cargo" name="fecha_cargo" placeholder="Fecha cargo" required>
                            </div>
                            <div class="form-group">
                                <input type="text" class="form-control" id="fecha_vencimiento" name="fecha_vencimiento" placeholder="Fecha vencimiento" required>
                            </div>
                            
                            <button type="button" id="submit" name="submit" class="btn btn-primary pull-right">Submit Form</button>
                        </form>
                    </div>
                </div>
            </div>


        </div>                  
    </body>
</html>
