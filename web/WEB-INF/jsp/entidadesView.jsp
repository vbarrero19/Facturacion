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
        <title>ENTIDADES</title> 
    </head>
    <script>
        $(document).ready(function () {
            getTipoEntidad();


            $("#customer-tab").click();

            // LA FUNCION QUE AL HACER CLICK, NOS EJECUTA TODO.
            $("#guardarEntidad").click(function () {

                if (window.XMLHttpRequest) //mozilla
                {
                    ajax = new XMLHttpRequest(); //No Internet explorer
                } else
                {
                    ajax = new ActiveXObject("Microsoft.XMLHTTP");
                }

                var myObj = {};

                myObj["distinct_code"] = $("#distinct_code").val().trim();
                myObj["nombre_entidad"] = $("#nombre_entidad").val().trim();


                var json = JSON.stringify(myObj);
                $.ajax({
                    type: 'POST',
                    url: '/Facturacion/entidadesController/nuevaEntidad.htm',
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

        //CREAMOS LA FUNCION PARA CARGAR EL COMBO DE TIPO ENTIDAD.
        function getTipoEntidad() {

            if (window.XMLHttpRequest) //mozilla
            {
                ajax = new XMLHttpRequest(); //No Internet explorer
            } else
            {
                ajax = new ActiveXObject("Microsoft.XMLHTTP");
            }

            $.ajax({
                //Usamos GET ya que recibimos.
                type: 'GET',
                url: '/Facturacion/entidadesController/getTipoEntidad.htm',
                success: function (data) {

                    var tipoEntidad = JSON.parse(data);
                    select = document.getElementById('id_tipo_entidad');
                    tipoEntidad.forEach(function (valor, indice) {
                        var tipoEntidad2 = JSON.parse(valor);
                        var opt = docutment.createElement('option');
                        opt.value = tipoEntidad2.id_tipo_entidad;
                        opt.innerHTML = tipoEntidad2.tipo_entidad;
                        select.appendChild(opt);
                    });
                }
            });
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
                            <h3 style="margin-bottom: 25px; text-align: center;">FORMULARIO PARA ENTIDADES</h3>

                            <!-- ALMACENAMOS EL ID_ENTIDAD -->

                            <div class="form-group-combo">
                                <input type="text" class="form-control" id="id_entidad" name="id_entidad" placeholder="Identificador entidad" required>
                                <input type="text" class="form-control" id="distinct_code" name="distinct_code" placeholder="Distinct code" required>
                            </div>


                            <!-- CREAMOS EL DISEÑO DE LAS PESTAÑAS DE CLIENTES -->
                            <div class="form-group">						
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
                                <!--INFORMACION DE LA PESTAÑA 1 -->
                                <div class="tab-pane fade active" id="customer" role="tabpanel" aria-labelledby="customer-tab">
                                    <div class="form-group">
                                        <input type="text" class="form-control" id="nombre_entidad" name="nombre_entidad" placeholder="Nombre entidad" required>
                                    </div>  

                                    <!-- COMBO PARA CARGAR DE FORMA DINAMICA LOS TIPOS DE ENTIDAD QUE EXISTEN -->
                                    <div class="form-group">
                                        <select id="id_tipo_entidad" name="id_tipo_entidad" class="form-control">

                                        </select>
                                    </div> 
                                    <!-- RADIO BUTTONS PARA EL TRATAMIENTO DE LA PERSONA DE CONTACTO -->
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

                                    <!--CARGAMOS EL COMBO CON LA INFORMACION DEL TIPO DE IDENTIFICACION DE LA ENTIDAD -->
                                    <div class="form-group-combo">
                                        <select class="form-control" id="id_tipo_documento" name="id_tipo_documento">
                                            <option> DNI </option>
                                            <option> CIF </option>
                                            <option> PASAPORTE </option>
                                            <option> NIT </option>
                                        </select>
                                        <input type="text" class="form-control" id="documento" name="documento" placeholder="Numero identificador" required>
                                    </div>

                                    <div class="form-group">
                                        <input type="text" class="form-control" id="nombre_contacto" name="nombre_contacto" placeholder="Nombre contacto" required>
                                    </div>

                                    <div class="form-group">
                                        <input type="text" class="form-control" id="apellido1" name="apellido1" placeholder="Apellido 1" required>
                                    </div>

                                    <div class="form-group">
                                        <input type="text" class="form-control" id="apellido2" name="apellido2" placeholder="Apellido 2 " >
                                    </div>


                                    <!-- CREAMOS COMBO DINAMICO PARA EL TIPO DE DEDICACION DE LA ENTIDAD -->
                                    <div class="form-group">
                                        <select class="form-control" id="id_dedicacion" name="id_dedicacion">
                                            <option></option>
                                            <option>Mantenimiento</option>                                            
                                            <option>Facturacion</option>
                                        </select>
                                    </div>


                                    <div class="form-group-combo">
                                        <input type="text" class="form-control" id="telefono1" name="telefono1" placeholder="Telefono 1" required>
                                        <input type="text" class="form-control" id="telefono2" name="telefono2" placeholder="Telefono 2" required>
                                    </div>
                                    <div class="form-group-combo">
                                        <input type="text" class="form-control" id="fax" name="fax" placeholder="FAX" required>
                                    </div>    
                                    <div class="form-group-combo">
                                        <input type="text" class="form-control" id="mail1" name="mail1" placeholder="mail 1" required>
                                        <input type="text" class="form-control" id="mail2" name="mail2" placeholder="mail 2" required>
                                    </div>


                                    <!--DENTRO DEL CONTAINER METEMOS LOS DOS DESPLEGABLES DE LAS FECHAS -->
                                    <div class="container2">                                   
                                        <div class="row">
                                            <div class='col-xs-12 col-md-4'>
                                                <label class="fechaCargos"> FECHA ALTA </label>
                                                <div class="form-group">
                                                    <div class='input-group date' id='fecha_cargo'>
                                                        <input  data-format="yyyy-MM-dd hh:mm:ss" type='text' class="form-control" />
                                                        <span class="input-group-addon">
                                                            <span class="glyphicon glyphicon-calendar"></span>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                            <script type="text/javascript">
                                                $(function () {
                                                    $('#fecha_cargo').datetimepicker();
                                                });
                                            </script>
                                        </div>

                                        <div class="row">
                                            <div class='col-xs-12 col-md-4'>
                                                <label class="fechaCargos"> FECHA BAJA </label>
                                                <div class="form-group">
                                                    <div class='input-group date' id='fecha_vencimiento'>
                                                        <input  data-format="yyyy-MM-dd hh:mm:ss" type='text' class="form-control" />
                                                        <span class="input-group-addon">
                                                            <span class="glyphicon glyphicon-calendar"></span>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                            <script type="text/javascript">
                                                $(function () {
                                                    $('#fecha_vencimiento').datetimepicker();
                                                });
                                            </script>
                                        </div>
                                    </div> 

                                    <button type="button" id="guardarEntidad" name="guardarEntidad" class="btn btn-primary pull-right">Alta</button>
                                </div>


                                <!--INFORMACION DE LA PESTAÑA 2 -->                                
                                <div class="tab-pane fade" id="adress" role="tabpanel" aria-labelledby="adress-tab">
                                    ALMACENAMOS LA INFORMACION DE LA DIRECCION DE LA ENTIDAD.
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
