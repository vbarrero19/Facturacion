
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="jstl" uri="http://java.sun.com/jstl/core_rt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
    <%@ include file="infouser.jsp" %>
    <head> 
        <title>CLIENTES</title> 
    </head>
    <script>
        $(document).ready(function () {
            // getTipoEmpresa();

            $("#submit").click(function () {
                if (window.XMLHttpRequest) //mozilla
                {
                    ajax = new XMLHttpRequest(); //No Internet explorer
                } else
                {
                    ajax = new ActiveXObject("Microsoft.XMLHTTP");
                }

                var myObj = {};
                //id cliente 
                myObj["id_cliente"] = $("#id_cliente").val().trim();
                //nombre empresa
                myObj["nombre_empresa"] = $("#nombre_empresa").val().trim();
                //tratamiento persona
                myObj["tratamiento"] = $(".form-check input:checked").val();
                //nombre de la persona  
                myObj["nombre_persona"] = $("#nombre_persona").val().trim();


                var json = JSON.stringify(myObj);
                $.ajax({
                    type: 'POST',
                    url: '/Facturacion/clientesController/newCustomer.htm',
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



    </script>
    <body>
        <div class="container">
            <div class="col-xs-12">
                <div class="col-md-5">
                    <div class="form-area">  
                        <form role="form">
                            <br style="clear:both">
                            <h3 style="margin-bottom: 25px; text-align: center;">Formulario para CLIENTES</h3>
                            <div class="form-group">
                                <input type="text" class="form-control" id="id_cliente" name="id_cliente" placeholder="Identificador cliente" required>
                            </div> 

                            <div class="form-group">
                                <input type="text" class="form-control" id="nombre_empresa" name="nombre_empresa" placeholder="Nombre empresa" required>
                            </div>                            


                            <div class="form-group">
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="tratamiento" id="tratamiento1" value="mr" checked>
                                    <label class="form-check-label" for="1">Mr</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="tratamiento" id="tratamiento2" value="mrs">
                                    <label class="form-check-label" for="2">Mrs</label>
                                </div>
                            </div>   

                            <div class="form-group">
                                <input type="text" class="form-control" id="nombre_persona" name="nombre_persona" placeholder="Nombre persona" required>
                            </div>

                            <!--    FALTA CREAR TODO EN JAVA Y JSP 
                                <div class="form-group">
                                    <select class="form-control" id="tipo_ident">
                                        <option></option>
                                        <option>CIF</option>
                                        <option>NIT</option>
                                        <option>IDENT3</option>
                                    </select>
                                </div>
    
                                
    
                                <div class="form-group">
                                    <input type="text" class="form-control" id="id_ident" name="id_ident" placeholder="Identificador empresa(CIF)" required>
                                </div>
                                
                              
    
                            <!--FALTA RECOGER LOS DATOS AL CREAR EL OBJETO DESDE EL STRING  
                            <div class="form-group">
                                <select class="form-control" id="id_tipo" name="id_tipo">
                                </select>
                            </div>
                            
                            <!-- *********** 
                            <div class="form-group">
                                <input type="text" class="form-control" id="direccion" name="direccion" placeholder="Dirección" required>
                            </div>
                            <div class="form-group">
                                <input type="text" class="form-control" id="telefono" name="telefono" placeholder="Teléfono" required>
                            </div>
                            <div class="form-group">
                                <input type="text" class="form-control" id="mail" name="mail" placeholder="E-mail" required>
                            </div>
                            -->
                            <a href="<c:url value='/MenuController/start.htm'/>" class="btn btn-info" role="button">Menu principal</a>                             
                            <button type="button" id="submit" name="submit" class="btn btn-primary pull-right">Submit Form</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>                  
    </body>
</html>
