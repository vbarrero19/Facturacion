
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="jstl" uri="http://java.sun.com/jstl/core_rt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
    <%@ include file="infouser.jsp" %>
    <head> 
        <title>TIPO EMPRESA VIEW</title> 
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
               
//                myObj["id_Impuesto"] = $("#id_impuesto").val().trim();    
                myObj["empresa"] = $("#empresa").val().trim();                
                 
                var json = JSON.stringify(myObj);
                $.ajax({
                    type: 'POST',
                    url: '/Facturacion/tipoEmpresaController/newCustomer.htm',
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
                            <h3 style="margin-bottom: 25px; text-align: center;">Formulario para IMPUESTOS</h3>
                                                        
<!--                            <div class="form-group">
                                <input type="text" class="form-control" id="id_impuesto" name="id_impuesto" placeholder="Id Impuesto" required>
                            </div>-->
                            
                            <div class="form-group">
                                <input type="text" class="form-control" id="empresa" name="empresa" placeholder="Empresa" required>
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

