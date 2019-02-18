<%-- 
    Document   : modificarDireccionView
    Created on : 15-feb-2019, 12:42:57
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


        });




    </script>

    <body>
        
        <div class="container col-xs-12">
            <div class="col-xs-12">
                <!-- con col elegimos el tamaño xs:moviles md:tablets lg:pantallas de ordenador.
                para empujar las columnas usamos offset y el numero de columnas que queremos desplazar. tiene que estar 
                colocado por orden: tamaño de columnas y luego el offset con las que empujamos-->

                <div class="col-xs-12 col-md-offset-2 col-md-8 col-lg-offset-3 col-lg-6">
                    <div class="form-area">  
                        <form role="form">
                            <br style="clear:both">
                            <h3 style="margin-bottom: 25px; text-align: center;">FORMULARIO PARA DAR DE ALTA ENTIDAD</h3>

                        <div class="form-group col-xs-12" align="center">
                            <h4>DATOS DE LA DIRECCION</h4>
                        </div>

                            <div class="form-group">
                                <!-- COMBO PARA CARGAR DE FORMA DINAMICA LOS TIPOS DE DIRECCION QUE EXISTEN -->
                                <div class="form-group col-xs-6">
                                    <label for="distinct_code"> Distinct code </label>
                                        <input type="text" class="form-control" id="distinct_code" name="distinct_code" disabled = "true">                                             
                                </div> 
                                <div class="form-group col-xs-6">
                                    <label for="idCliente>">Nombre_entidad</label>
                                    <input type="text" class="form-control" id="nombre_entidad" name="nombre_entidad" disabled = "true">
                                </div>  
                            </div>

                            <div class="form-group">
                                <!-- COMBO PARA CARGAR DE FORMA DINAMICA LOS TIPOS DE DIRECCION QUE EXISTEN -->
                                <div class="form-group col-xs-6 ">
                                    <label for="idCliente>">Tipo direccion</label>
                                    <select id="id_tipo_direccion" name="id_tipo_direccion" class="form-control">

                                    </select>
                                </div>
                                <div class="form-group col-xs-6">
                                    <label for="idCliente>">Tipo via</label>
                                    <input type="text" class="form-control" id="tipo_via" name="tipo_via" placeholder="Tipo via(c, avda..)" required>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="form-group col-xs-12">
                                    <label for="idCliente>">Nombre via</label>
                                    <input type="text" class="form-control" id="nombre_via" name="nombre_via" placeholder="Nombre via" required>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="form-group col-xs-3">
                                    <label for="idCliente>">Numero via</label>
                                    <input type="text" class="form-control" id="numero_via" name="numero_via" placeholder="Numero vía" required>
                                </div>
                                <div class="form-group col-xs-3">
                                    <label for="idCliente>">Portal</label>
                                    <input type="text" class="form-control" id="numero_portal" name="numero_portal" placeholder="Numero portal" required>
                                </div>

                                <div class="form-group">
                                    <div class="form-group col-xs-6">
                                        <label for="idCliente>">Resto direccion</label>
                                        <input type="text" class="form-control" id="resto_direccion" name="resto_direccion" placeholder="Resto direccion" required>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">   
                                <div class="form-group col-xs-2">
                                    <input type="text" class="form-control" id="codigo_postal" name="codigo_postal" placeholder="Codigo postal" required>
                                </div>   
                                <div class="form-group col-xs-4">
                                    <input type="text" class="form-control" id="localidad" name="localidad" placeholder="Localidad" required>
                                </div>
                                <div class="form-group col-xs-4">
                                    <input type="text" class="form-control" id="provincia" name="provincia" placeholder="Provincia" required>
                                </div>

                                <div class="form-group">
                                    <div class="form-group col-xs-2">
                                        <input type="text" class="form-control" id="pais" name="pais" placeholder="pais" required>
                                    </div>
                                </div>

                            </div> 
                            <button type="button" id="guardarDireccion" name="guardarDireccion" class="btn btn-primary pull-right">Alta direccion</button>
                            <a href="<c:url value='/MenuController/start.htm'/>" class="btn btn-info" role="button">Menu principal</a> 
                        </form>
                    </div>
                </div>
            </div>
        </div>       
    </body>
</html>
