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
            
            $("#customer-tab").click();
            
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
                                <label> Num id </label>
                                <label> Distinct code </label>
                            </div>

                            <div class="form-group-combo">    
                                <div class="form-group col-xs-4">
                                    <input type="text" class="form-control" disabled=”disabled id="id_entidad" name="id_entidad" placeholder="Identificador entidad" required>
                                </div>
                                <div class="form-group col-xs-8">
                                    <input type="text" class="form-control" id="distinct_code" name="distinct_code" placeholder="Distinct code" required>
                                </div>
                            </div>

                            <!-- CREAMOS EL DISEÑO DE LAS PESTAÑAS DE CLIENTES -->
                            <div class="form-group" col-xs-12>						
                                <ul class="nav nav-tabs" id="myTab" role="tablist">
                                    <li class="nav-item">
                                        <a class="nav-link active" id="customer-tab" data-toggle="tab" href="#customer" role="tab" aria-controls="customer" aria-selected="true">Customer info</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" id="adress-tab" data-toggle="tab" href="#adress" role="tab" aria-controls="adress" aria-selected="false">Adress info</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" id="payment-tab" data-toggle="tab" href="#payment" role="tab" aria-controls="payment" aria-selected="false">Payment Info</a>
                                    </li>
                                </ul>
                            </div>  

                            <!-- DENTRO DE CADA PESTAÑA, METEMOS LA INFORMACIÓN DEL CLIENTE PARA CADA UNA DE ELLAS -->                        
                            <div class="tab-content" id="myTabContent">

                                <!----------------------------- INFORMACION DE LA PESTAÑA 1 --------------------------------------->  
                                <div class="tab-pane fade active" id="customer" role="tabpanel" aria-labelledby="customer-tab">
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

                                    <!--DENTRO DEL CONTAINER METEMOS LOS DOS DESPLEGABLES DE LAS FECHAS -->
<!--                                    <div class="container2 form-group col-xs-12">  
                                        <div class="row col-xs-6">
                                            <label class="fechasEntidad"> FECHA ALTA </label>
                                            <div class="form-group">
                                                <div class='input-group date' id='fecha_alta'>
                                                    <input  data-format="yyyy-MM-dd" type='text' class="form-control" />
                                                    <span class="input-group-addon">
                                                        <span class="glyphicon glyphicon-calendar"></span>
                                                    </span>
                                                </div>
                                            </div>
                                            <script type="text/javascript">
                                                $(function () {
                                                    $('#fecha_alta').datetimepicker();
                                                });
                                            </script>
                                        </div>

                                        <div class="row col-xs-6">
                                                <label class="fechasEntidad col-xs-offset-2"> FECHA BAJA </label>
                                                <div class="form-group col-xs-offset-2">
                                                    <div class='input-group date' id='fecha_baja'>
                                                        <input  data-format="yyyy-MM-dd" type='text' class="form-control" />
                                                        <span class="input-group-addon">
                                                            <span class="glyphicon glyphicon-calendar"></span>
                                                        </span>
                                                    </div>
                                                </div>
                                            <script type="text/javascript">
                                                $(function () {
                                                    $('#fecha_baja').datetimepicker();
                                                });
                                            </script>
                                        </div>
                                    </div> -->
                                        <button type="button" id="guardarEntidad" name="guardarEntidad" class="btn btn-primary pull-right">Modificar</button>
                                </div>

                                <!----------------------------- INFORMACION DE LA PESTAÑA 2 --------------------------------------->  
                                
                                <div class="tab-pane fade" id="adress" role="tabpanel" aria-labelledby="adress-tab">
                                    <div class="form-group col-xs-12" align="center">
                                        <h4>DIRECCION DE LA ENTIDAD</h4>
                                    </div>

                                    <div class="form-group">
                                        <!-- COMBO PARA CARGAR DE FORMA DINAMICA LOS TIPOS DE DIRECCION QUE EXISTEN -->
                                        <div class="form-group col-xs-2">
                                            <select id="id_tipo_direccion" name="id_tipo_direccion" class="form-control">
                                                <option> fisica </option>
                                                <option> fiscal </option>
                                                <option> facturacion </option>
                                            </select>
                                        </div>
                                        <div class="form-group col-xs-2">
                                            <input type="text" class="form-control" id="tipo_via" name="tipo_via" placeholder="Tipo via(c, avda..)" required>
                                        </div>

                                        <div class="form-group">
                                            <div class="form-group col-xs-8">
                                                <input type="text" class="form-control" id="nombre_via" name="nombre_via" placeholder="Nombre via" required>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <div class="form-group col-xs-2">
                                            <input type="text" class="form-control" id="numero_via" name="numero_via" placeholder="Numero vía" required>
                                        </div>
                                        <div class="form-group col-xs-2">
                                            <input type="text" class="form-control" id="numero_portal" name="numero_portal" placeholder="Numero portal" required>
                                        </div>

                                        <div class="form-group">
                                            <div class="form-group col-xs-8">
                                                <input type="text" class="form-control" id="resto_direccion" name="resto_direccion" placeholder="Resto direccion" required>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <div class="form-group col-xs-2">
                                            <input type="text" class="form-control" id="cod_postal" name="cod_postal" placeholder="Codigo postal" required>
                                        </div>
                                        <div class="form-group col-xs-4">
                                            <input type="text" class="form-control" id="localizacion" name="localizacion" placeholder="localizacion localizacion" required>
                                        </div>
                                        <div class="form-group col-xs-4">
                                            <input type="text" class="form-control" id="provincia" name="provincia" placeholder="provincia" required>
                                        </div>

                                        <div class="form-group">
                                            <div class="form-group col-xs-2">
                                                <input type="text" class="form-control" id="pais" name="pais" placeholder="pais" required>
                                            </div>
                                        </div>
                                    </div>
<!--MIRAR COMO COMPLETAR LA TABLA SI ES LA MISMA DIRECCION PARA TODOS LOS TIPOS(fisica, fiscal....) -->
                                    <label> ¿La direccion fisica es igual a la fiscal? </label>
                                    <!-- Creamos un radio button para preguntar si la direccion fisica es igual a la fiscal y autcompletamos en caso afirmativo -->
                                    <div id="direc" class="form_radio_button">
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" name="direc" id="direc1" value="no" checked>
                                            <label class="form-check-label" for="1">No</label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" name="direc" id="direc2" value="si">
                                            <label class="form-check-label" for="2">Si</label>
                                        </div>
                                    </div>   
                                </div>
                                <!--INFORMACION DE LA PESTAÑA 3 -->
                                <div class="tab-pane fade" id="payment" role="tabpanel" aria-labelledby="payment-tab">
                                    ALMACENAMOS LA INFORMACION DE PAGO DE LA ENTIDAD                                   
                                </div>

                                <a href="<c:url value='/MenuController/start.htm'/>" class="btn btn-info" role="button">Menu principal</a> 
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>                  
    </body>
</html>
