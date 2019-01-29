<%-- 
    Document   : entidadesView.jsp
    Created on : 29-ene-2019, 12:33:51
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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Entidades View</title>
    </head>
    <script>
        $(document).ready(function () {

            $("#home-tab").click();

        }
    </script>



    <body>
        <div class="container">
            <div class="col-xs-12">
                <!-- con col elegimos el tamaño xs:moviles md:tablets lg:pantallas de ordenador.
                para empujar las columnas usamos offset y el numero de columnas que queremos desplazar. tiene que estar 
                colocado por orden: tamaño de columnas y luego el offset con las que empujamos-->

                <div class="col-xs-12 col-md-offset-2 col-md-8 col-lg-offset-3 col-lg-6">
                    <div class="form-area">  
                        <form role="form">
                            <br style="clear:both">
                            <h3 style="margin-bottom: 25px; text-align: center;">FORMULARIO PARA CLIENTES</h3>

                            <!--MUESTRA EL ID DE LA ENTIDAD -->
                            <div class="form-group">
                                <input type="text" class="form-control" id="id_entidad" name="id_entidad" placeholder="Identificador entidad" required>
                            </div> 

                            <!-- ALMACENAMOS EL NOMBRE DE LA ENTIDAD -->
                            <div class="form-group">
                                <input type="text" class="form-control" id="distinct_code" name="distinct_code" placeholder="Distinct code" required>
                            </div>

                            <!-- CREAMOS EL DISEÑO DE LAS PESTAÑAS DE ENTIDADES -->
                            <div class="form-group">						
                                <ul class="nav nav-tabs" id="myTab" role="tablist">
                                    <li class="nav-item">
                                        <a class="nav-link active" id="home-tab" data-toggle="tab" href="#home" role="tab" aria-controls="home" aria-selected="true">Entidad</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" id="direccion-tab" data-toggle="tab" href="#direccion" role="tab" aria-controls="direccion" aria-selected="false">Dirección</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" id="pago-tab" data-toggle="tab" href="#pago" role="tab" aria-controls="pago" aria-selected="false">Pago</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" id="otrosDatos-tab" data-toggle="tab" href="#otrosDatos" role="tab" aria-controls="otrosDatos" aria-selected="false">Otros datos</a>
                                    </li>
                                </ul>
                            </div>  

                            <!-- DENTRO DE CADA PESTAÑA, METEMOS LA INFORMACIÓN DEL CLIENTE PARA CADA UNA DE ELLAS -->                        
                            <div class="tab-content" id="myTabContent">
                                <!--INFORMACION DE LA PESTAÑA 1 -->
                                <div class="tab-pane fade active" id="home" role="tabpanel" aria-labelledby="home-tab">
                                    <label>Nombre entidad</label>
                                    <div class="form-group">
                                        <input type="text" class="form-control" id="nombre_entidad" name="nombre_entidad" placeholder="Nombre entidad" required>
                                    </div> 
                                    <!-- COMBO PARA SELECCIONAR EL TIPO DE ENTIDAD(cliente, proveedor, profesor, mantenimiento, contable...) -->
                                    <label for="comboEntidad">Tipo de entidad</label>
                                    <div class="form-group-combo">
                                        <select class="form-control" id="tipo_Entidad" name="tipo_Entidad">
                                            <option>Cliente</option>
                                            <option>Proveedor</option>
                                            <option>Profesor</option>
                                            <option>Director</option>
                                            <option>Mantenimiento</option>
                                        </select>
                                    </div> 
                                    <label>Tratamiento</label>                                        
                                    <div id="tratamiento" class="form_radio_button">

                                        <div class="form-check">
                                            <input class="form-check-input inline-block" type="radio" name="tratamiento" id="tratamiento1" value="mr" checked>
                                            <label class="fm-check-label" for="1">Mr</label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" name="tratamiento" id="tratamiento2" value="mrs">
                                            <label class="form-check-label" for="2">Mrs</label>
                                        </div>
                                    </div> 

                                    <div class="form-group">
                                        <input type="text" class="form-control" id="mi_persona" name="mi_persona" placeholder="Inicial" required>
                                    </div>

                                    <div class="form-group">
                                        <input type="text" class="form-control" id="apellido_persona" name="apellido_persona" placeholder="Apellido" required>
                                    </div>

                                    <button type="button" id="submit" name="submit" class="btn btn-primary pull-right">Submit</button>
                                </div>
                                <!--INFORMACION DE LA PESTAÑA 2 -->

                                <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab">

                                    <!--CARGAMOS EL COMBO CON LA INFORMACION DEL TIPO DE IDENTIFICACION FISCAL DE LA EMRPESA -->
                                    <div class="form-group-combo">
                                        <select class="form-control" id="fiscal" name="fiscal">
                                        </select>
                                        <!-- </div>   
    
                                        <div class="form-group"> -->
                                        <input type="text" class="form-control" id="num_ident" name="num_ident" placeholder="Numero identificador de empresa" required>
                                    </div>

                                    <div class="form-group">
                                        <select class="form-control" id="empresa" name="empresa">
                                        </select>
                                    </div>

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

                                    <div class="form-group">
                                        <input type="text" class="form-control" id="dir_fisica" name="dir_fisica"  placeholder="Dirección física"  required>
                                    </div>

                                    <div class="form-group">
                                        <input type="text" class="form-control" id="dir_fiscal" name="dir_fiscal" placeholder="Dirección fiscal" required>
                                    </div>

                                    <div class="form-group">
                                        <input type="text" class="form-control" id="pais" name="pais" placeholder="País" required>
                                    </div>
                                </div>
                                <!--INFORMACION DE LA PESTAÑA 3 -->
                                <div class="tab-pane fade" id="contact" role="tabpanel" aria-labelledby="contact-tab">

                                    <div class="form-group">
                                        <input type="email" class="form-control" id="mail" name="mail" placeholder="E-mail" required>
                                    </div>

                                    <div class="form-group">
                                        <input type="text" class="form-control" id="telefono1" name="telefono1" placeholder="Teléfono" required>
                                    </div>

                                    <div class="form-group">
                                        <input type="text" class="form-control" id="telefono2" name="telefono2" placeholder="Teléfono2" required>
                                    </div>
                                    <div class="form-group">
                                        <input type="text" class="form-control" id="fax" name="fax" placeholder="FAX" required>
                                    </div>
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
