<%-- 
    Document   : modificarEntidades
    Created on : 08-feb-2019, 11:48:14
    Author     : vbarr
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
        <title>MODIFICAR ENTIDADES</title> 
    </head>
    <script>
        $(document).ready(function () {            
                        
            var userLang = navigator.language || navigator.userLanguage;
            
            $("#modificarEntidad").click(function () {
                if (window.XMLHttpRequest) //mozilla
                {
                    ajax = new XMLHttpRequest(); //No Internet explorer
                } else
                {
                    ajax = new ActiveXObject("Microsoft.XMLHTTP");
                }
                
                 var myObj = {};
                //GUARDAMOS EL DISTINCT CODE DE LA ENTIDAD
                myObj["nombre_contacto"] = $("#nombre_contacto").val().trim();
                /*TENEMOS QUE PONER TAMBIEN MYoBJ....ETC COMO EN ENTIDADESVIEW?*/
                  var json = JSON.stringify(myObj);
                $.ajax({
                    type: 'POST',
                    url: '/Facturacion/verEntidadesController/modificarEntidad.htm',
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
            });
        });




    </script>
    <body>
        <div class="container col-xs-12">
            <div class="col-xs-12">
                <div class="col-xs-12 col-md-offset-2 col-md-8 col-lg-offset-3 col-lg-6">
                    <div class="form-area">  
                        <form role="form">
                            <br style="clear:both">
                            <h3 style="margin-bottom: 25px; text-align: center;">MODIFICAR ENTIDAD</h3>

                            <!-- ALMACENAMOS EL ID_ENTIDAD -->
                            
                            <div class="form-group-combo">    
                                <div class="form-group col-xs-4">
                                    <input type="text" class="form-control" disabled=”disabled id="id_entidad" name="id_entidad" placeholder="Identificador entidad" required>
                                </div>
                                <div class="form-group col-xs-8">
                                    <input type="text" class="form-control" id="distinct_code" name="distinct_code" placeholder="Distinct code" required>
                                </div>
                            </div>
 


                                    <div class="form-group">
                                        <div class="form-group col-xs-6">
                                            <input type="text" class="form-control" id="nombre_entidad" name="nombre_entidad" placeholder="Nombre entidad" required>
                                        </div>
                                        <div class="form-group col-xs-6">
                                            <!-- COMBO PARA CARGAR DE FORMA DINAMICA LOS TIPOS DE ENTIDAD QUE EXISTEN -->
                                            <select id="id_tipo_entidad" name="id_tipo_entidad" class="form-control" disabled=”disabled>

                                            </select>
                                        </div>
                                    </div>

                                    <!--CARGAMOS EL COMBO CON LA INFORMACION DEL TIPO DE IDENTIFICACION DE LA ENTIDAD -->
                                    <div class="form-group">
                                        <div class="form-group col-xs-6">
                                            <select class="form-control" id="id_tipo_documento" name="id_tipo_documento" disabled=”disabled>

                                            </select>
                                        </div>
                                        <div class="form-group col-xs-6">
                                            <input type="text" class="form-control" id="numero_documento" name="numero_documento" placeholder="Numero identificador" required>
                                        </div>
                                    </div>


                                    <div class="form-group">
                                        <div class="form-group col-xs-12">
                                            <input type="text" class="form-control" id="nombre_contacto" name="nombre_contacto" placeholder="Nombre contacto" required>
                                        </div>
                                    </div>                                    

                                    <div class="form-group">
                                        <div class="form-group col-xs-6">
                                            <input type="text" class="form-control" id="apellido1" name="apellido1" placeholder="Apellido 1" required>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="form-group col-xs-6">
                                            <input type="text" class="form-control" id="apellido2" name="apellido2" placeholder="Apellido 2 " >
                                        </div>
                                    </div>


                                    <!-- CREAMOS COMBO DINAMICO PARA EL TIPO DE DEDICACION DE LA ENTIDAD -->
                                    <div class="form-group">
                                        <div class="form-group col-xs-12">
                                            <select class="form-control" id="id_dedicacion" name="id_dedicacion" disabled=”disabled>

                                            </select>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <div class="form-group col-xs-6">
                                            <input type="text" class="form-control" id="telefono1" name="telefono1" placeholder="Telefono 1" required>
                                        </div>

                                        <div class="form-group">
                                            <div class="form-group col-xs-6">
                                                <input type="text" class="form-control" id="telefono2" name="telefono2" placeholder="Telefono 2" required>
                                            </div>
                                        </div>


                                        <div class="form-group">
                                            <div class="form-group col-xs-12">
                                                <input type="text" class="form-control" id="fax" name="fax" placeholder="FAX" required>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="form-group col-xs-6">
                                                <input type="text" class="form-control" id="mail1" name="mail1" placeholder="mail 1" required>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <div class="form-group col-xs-6">
                                                <input type="text" class="form-control" id="mail2cc" name="mail2cc" placeholder="mail 2" required>
                                            </div>
                                        </div>
                                    </div>

                                        <button type="button" id="modificarEntidad" name="modificarEntidad" class="btn btn-primary pull-right">Modificar entidad</button>                               

                                <a href="<c:url value='/MenuController/start.htm'/>" class="btn btn-info" role="button">Menu principal</a> 
                        </form>
                    </div>
                </div>
            </div>
        </div>                  
    </body>
</html>
