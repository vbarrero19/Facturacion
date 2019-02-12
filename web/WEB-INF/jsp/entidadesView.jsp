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
            //LLAMAMOS A LAS FUNCIONCIONES QUE CARGAN LOS COMBOS DINAMICOS    
            getTipoEntidad();
            getTipoDedicacion();
            getTipoDocumento();
            getVerEntidad();
            getTipoDireccion();

            var userLang = navigator.language || navigator.userLanguage;

            //EVENTO CLICK PARA CARGAR LA PRIMERA PESTAÑA AL INICIAR LA PAGINA
            $("#customer-tab").click();

            $('#fecha_alta').datetimepicker({
                format: 'YYYY-MM-DD',
                locale: userLang.valueOf(),
                daysOfWeekDisabled: [0, 6],
                useCurrent: false
            });

            $('#fecha_baja').datetimepicker({
                format: 'YYYY-MM-DD',
                locale: userLang.valueOf(),
                daysOfWeekDisabled: [0, 6],
                useCurrent: false
            });


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
                //GUARDAMOS EL DISTINCT CODE DE LA ENTIDAD
                myObj["distinct_code"] = $("#distinct_code").val().trim();
                //GUARDAMOS EL NOMBRE DE LA ENTIDAD
                myObj["nombre_entidad"] = $("#nombre_entidad").val().trim();
                //GUARDAMOS LOS VALORES DEL COMBO DEL TIPO ENTIDAD.
                myObj["id_tipo_entidad"] = $("#id_tipo_entidad").val();
                //GUARDAMOS LOS VALORES DEL COMBO DEL TIPO DEDICACION
                myObj["id_dedicacion"] = $("#id_dedicacion").val();
                //GUARDAMOS EL VALOR DEL TRATAMIENTO
                myObj["tratamiento"] = $(".form-check input:checked").val();
                //GUARDAMOS EL VALOR DEL TIPO DE DOCUMENTO
                myObj["id_tipo_documento"] = $("#id_tipo_documento").val();
                //GUARDAMOS EL NUMERO DE DOCUMENTO
                myObj["numero_documento"] = $("#numero_documento").val();
                //GUARDAMOS EL NOMBRE DE CONTACTO
                myObj["nombre_contacto"] = $("#nombre_contacto").val().trim();
                //GUARDAMOS EL APELLIDO 1 Y APELLIDO2
                myObj["apellido1"] = $("#apellido1").val().trim();
                myObj["apellido2"] = $("#apellido2").val().trim();
                //GUARDAMOS LOS TELEFONOS DE CONTACTO
                myObj["telefono1"] = $("#telefono1").val().trim();
                myObj["telefono2"] = $("#telefono2").val().trim();
                //GUARDAMOS EL FAX
                myObj["fax"] = $("#fax").val().trim();
                //GUARDAMOS LOS MAIL DE CONTACTO
                myObj["mail1"] = $("#mail1").val().trim();
                myObj["mail2cc"] = $("#mail2cc").val().trim();
                //GUARDAMOS LAS FECHAS, DE ALTA Y BAJA
                myObj["fecha_alta"] = $('#fecha_alta input').val().trim();
                myObj["fecha_baja"] = $('#fecha_baja input').val().trim();

                /****************DATOS ALMACENADOS EN LA PESTAÑA 2*******************/
                myObj["id_tipo_direccion"] = $('#id_tipo_direccion').val();
                myObj["tipo_direccion"] = $('#tipo_direccion').val();


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
            });

            /*funcion para ver los datos de la entidad seleccionada en el combo. Recoge por parametro 
             el id del cliente 
             */
            //Muestra datos de la entidadCliente al seleccionar algo en el combo
            $("#comboEntidad").change(function () {
                //recogemos el valor del combo para utilizarlo luego al ver las facturas.
                var idEntidad = $("#comboEntidad").val();
                //Si la opcion seleccionada es diferente a Seleccionar se muestran datos
                if ($("#comboEntidad").val() !== "0") {

                    if (window.XMLHttpRequest) //mozilla
                    {
                        ajax = new XMLHttpRequest(); //No Internet explorer
                    } else
                    {
                        ajax = new ActiveXObject("Microsoft.XMLHTTP");
                    }

                    var myObj = {};

                    //recogemos el valor de comboEntidad y lo metemos en id_entidad.
                    myObj["id_entidad"] = idEntidad;

                    var json = JSON.stringify(myObj);
                    $.ajax({
                        type: 'POST',
                        url: '/Facturacion/entidadesController/verDatosEntidad.htm',
                        data: json,
                        datatype: "json",
                        contentType: "application/json",
                        success: function (data) {

                            var aux = JSON.parse(data);

                            aux.forEach(function (valor, indice) {
                                //Recogemos cada objeto en String y los pasamos a objetos Tipo cliente con JSON
                                var aux2 = JSON.parse(valor);
                                //Mostramos los datos en la cajas de texto
                                $("#nombre_entidad").val(aux2.nombre_entidad);

                            });
                        },
                        error: function (xhr, ajaxOptions, thrownError) {
                            console.log(xhr.status);
                            console.log(xhr.responseText);
                            console.log(thrownError);
                        }
                    });

                    //Si se seleciona lo opcion "Seleccionar" se limpian las cajas de texto
                } else {
                    $("#nombre_entidad").val("");
                }
            });
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
                //VAMOS A ENTIDADESCONTROLLER A RECOGER LOS DATOS DE LA FUNCION GETTIPOENTIDAD
                url: '/Facturacion/entidadesController/getTipoEntidad.htm',
                success: function (data) {
                    //RECOGEMOS LOS DATOS DEL COMBO Y PASAMOS EL STRING A UN ARRAY DE OBJETOS TIPO ENTIDAD
                    var tipoEntidad = JSON.parse(data);
                    //IDENTIFICAMOS EL COMBO POR EL ID DE LA TABLA TIPO_ENTIDAD
                    select = document.getElementById('id_tipo_entidad');
                    //LO CARGAMOS
                    tipoEntidad.forEach(function (valor, indice) {
                        //CADA OBJETO TIPO STRING LO PASAMOS A TIPOENTIDAD CON JSON
                        var tipoEntidad2 = JSON.parse(valor);
                        //CREAMOS LAS OPTION DEL COMBO(CODIGO HTML)
                        var opt = document.createElement('option');
                        //GUARDAMOS EL ID EN EL VALUE DE CADA OPCION DE CADA VUELTA
                        opt.value = tipoEntidad2.id_tipo_entidad;
                        //GUARDAMOS LA DESCRIPCION DEL TIPO DE ENTIDAD
                        opt.innerHTML = tipoEntidad2.tipo_entidad;
                        //AÑADIMOS UNA NUEVA OPCION
                        select.appendChild(opt);
                    });
                }
            });
        }


        //CREAMOS LA FUNCION PARA CARGAR EL COMBO DE TIPO DEDICACION.
        function getTipoDedicacion() {

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
                //VAMOS A ENTIDADESCONTROLLER A RECOGER LOS DATOS DE LA FUNCION GETTIPOENTIDAD
                url: '/Facturacion/entidadesController/getTipoDedicacion.htm',
                success: function (data) {
                    //RECOGEMOS LOS DATOS DEL COMBO Y PASAMOS EL STRING A UN ARRAY DE OBJETOS TIPO ENTIDAD
                    var tipoDedicacion = JSON.parse(data);
                    //IDENTIFICAMOS EL COMBO POR EL ID DE LA TABLA TIPO_ENTIDAD
                    select = document.getElementById('id_dedicacion');
                    //LO CARGAMOS
                    tipoDedicacion.forEach(function (valor, indice) {
                        //CADA OBJETO TIPO STRING LO PASAMOS A TIPOENTIDAD CON JSON
                        var tipoDedicacion2 = JSON.parse(valor);
                        //CREAMOS LAS OPTION DEL COMBO(CODIGO HTML)
                        var opt = document.createElement('option');
                        //GUARDAMOS EL ID EN EL VALUE DE CADA OPCION DE CADA VUELTA
                        opt.value = tipoDedicacion2.id_dedicacion;
                        //GUARDAMOS LA DESCRIPCION DEL TIPO DE ENTIDAD
                        opt.innerHTML = tipoDedicacion2.dedicacion;
                        //AÑADIMOS UNA NUEVA OPCION
                        select.appendChild(opt);
                    });
                }
            });
        }

        //CREAMOS LA FUNCION PARA CARGAR EL COMBO DE TIPO DOCUMENTO

        function getTipoDocumento() {

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
                //VAMOS A ENTIDADESCONTROLLER A RECOGER LOS DATOS DE LA FUNCION GETTIPOENTIDAD
                url: '/Facturacion/entidadesController/getTipoDocumento.htm',
                success: function (data) {
                    //RECOGEMOS LOS DATOS DEL COMBO Y PASAMOS EL STRING A UN ARRAY DE OBJETOS TIPO ENTIDAD
                    var tipoDocumento = JSON.parse(data);
                    //IDENTIFICAMOS EL COMBO POR EL ID DE LA TABLA TIPO_ENTIDAD
                    select = document.getElementById('id_tipo_documento');
                    //LO CARGAMOS
                    tipoDocumento.forEach(function (valor, indice) {
                        //CADA OBJETO TIPO STRING LO PASAMOS A TIPOENTIDAD CON JSON
                        var tipoDocumento2 = JSON.parse(valor);
                        //CREAMOS LAS OPTION DEL COMBO(CODIGO HTML)
                        var opt = document.createElement('option');
                        //GUARDAMOS EL ID EN EL VALUE DE CADA OPCION DE CADA VUELTA
                        opt.value = tipoDocumento2.id_tipo_documento;
                        //GUARDAMOS LA DESCRIPCION DEL TIPO DE ENTIDAD
                        opt.innerHTML = tipoDocumento2.documento;
                        //AÑADIMOS UNA NUEVA OPCION
                        select.appendChild(opt);
                    });
                }
            });
        }



        /*  * *******************************************************************************************************
         * ************************ FUNCIONES PARA LA SEGUNDA PESTAÑA DE ENTIDADESVIEW ****************************** */


        //CREAMOS FUNCION PARA CARGAR LA LISTA DE ENTIDADES EN EL COMBO
        function getVerEntidad() {

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
                //VAMOS A ENTIDADESCONTROLLER A RECOGER LOS DATOS DE LA FUNCION GETTIPOENTIDAD
                url: '/Facturacion/entidadesController/getVerEntidad.htm',
                success: function (data) {
                    //RECOGEMOS LOS DATOS DEL COMBO Y PASAMOS EL STRING A UN ARRAY DE OBJETOS TIPO ENTIDAD
                    var verEntidad = JSON.parse(data);
                    //IDENTIFICAMOS EL COMBO POR EL ID DE LA TABLA TIPO_ENTIDAD
                    select = document.getElementById('comboEntidad');
                    var opt = document.createElement('option');
                    opt.value = 0;
                    opt.innerHTML = "Seleccionar";
                    select.appendChild(opt);
                    verEntidad.forEach(function (valor, indice) {
                        //CADA OBJETO TIPO STRING LO PASAMOS A TIPOENTIDAD CON JSON
                        var verEntidad2 = JSON.parse(valor);
                        //CREAMOS LAS OPTION DEL COMBO(CODIGO HTML)
                        var opt = document.createElement('option');
                        //GUARDAMOS EL ID EN EL VALUE DE CADA OPCION DE CADA VUELTA
                        opt.value = verEntidad2.id_entidad;
                        //GUARDAMOS LA DESCRIPCION DEL TIPO DE ENTIDAD
                        opt.innerHTML = verEntidad2.distinct_code;
                        select.appendChild(opt);
                    });
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    console.log(xhr.status);
                    console.log(xhr.responseText);
                    console.log(thrownError);
                }
            });
        };


        //CREAMOS UNA FUNCION PARA CARGAR EL COMBO TIPO_DIRECCION
        function getTipoDireccion() {

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
                //VAMOS A ENTIDADESCONTROLLER A RECOGER LOS DATOS DE LA FUNCION GETTIPOENTIDAD
                url: '/Facturacion/entidadesController/getTipoDireccion.htm',
                success: function (data) {
                    //RECOGEMOS LOS DATOS DEL COMBO Y PASAMOS EL STRING A UN ARRAY DE OBJETOS TIPO ENTIDAD
                    var tipoDireccion = JSON.parse(data);
                    //IDENTIFICAMOS EL COMBO POR EL ID DE LA TABLA TIPO_ENTIDAD
                    select = document.getElementById('id_tipo_direccion');
                    //LO CARGAMOS
                    tipoDireccion.forEach(function (valor, indice) {
                        //CADA OBJETO TIPO STRING LO PASAMOS A TIPOENTIDAD CON JSON
                        var tipoDireccion2 = JSON.parse(valor);
                        //CREAMOS LAS OPTION DEL COMBO(CODIGO HTML)
                        var opt = document.createElement('option');
                        //GUARDAMOS EL ID EN EL VALUE DE CADA OPCION DE CADA VUELTA
                        opt.value = tipoDireccion2.id_tipo_direccion;
                        //GUARDAMOS LA DESCRIPCION DEL TIPO DE ENTIDAD
                        opt.innerHTML = tipoDireccion2.tipo_direccion;
                        //AÑADIMOS UNA NUEVA OPCION
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
                                <label> Num id </label>
                                <label> Distinct code </label>
                            </div>

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

                                <!----------------------------- INFORMACION DE LA PESTAÑA 1 DATOS DE LA ENTIDAD --------------------------------------->  
                                <div class="tab-pane fade active" id="customer" role="tabpanel" aria-labelledby="customer-tab">
                                    <div class="form-group col-xs-12" align="center">
                                        <h4>DATOS DE LA ENTIDAD</h4>
                                    </div>
                                    <div class="form-group">
                                        <div class="form-group col-xs-6">
                                            <input type="text" class="form-control" id="nombre_entidad" name="nombre_entidad" placeholder="Nombre entidad" required>
                                        </div>
                                        <div class="form-group col-xs-6">
                                            <!-- COMBO PARA CARGAR DE FORMA DINAMICA LOS TIPOS DE ENTIDAD QUE EXISTEN -->
                                            <select id="id_tipo_entidad" name="id_tipo_entidad" class="form-control">

                                            </select>
                                        </div>
                                    </div>

                                    <!--CARGAMOS EL COMBO CON LA INFORMACION DEL TIPO DE IDENTIFICACION DE LA ENTIDAD -->
                                    <div class="form-group">
                                        <div class="form-group col-xs-6">
                                            <select class="form-control" id="id_tipo_documento" name="id_tipo_documento">

                                            </select>
                                        </div>
                                        <div class="form-group col-xs-6">
                                            <input type="text" class="form-control" id="numero_documento" name="numero_documento" placeholder="Numero identificador" required>
                                        </div>
                                    </div>


                                    <div class="form-group">
                                        <div class="form-group col-xs-10">
                                            <input type="text" class="form-control" id="nombre_contacto" name="nombre_contacto" placeholder="Nombre contacto" required>
                                        </div>
                                    </div>

                                    <!-- RADIO BUTTONS PARA EL TRATAMIENTO DE LA PERSONA DE CONTACTO -->
                                    <div class="form-group">
                                        <div class="form-group col-xs-2">
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
                                            <select class="form-control" id="id_dedicacion" name="id_dedicacion">

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
                                    </div>

                                    <div class="form-group">
                                        <div class="form-group col-xs-12">
                                            <input type="text" class="form-control" id="fax" name="fax" placeholder="FAX" required>
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
                                    <div class="container2 form-group col-xs-12">  
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
                                    </div> 

                                    <button type="button" id="guardarEntidad" name="guardarEntidad" class="btn btn-primary pull-right">Alta</button>
                                </div>


                                <!----------------------------- INFORMACION DE LA PESTAÑA 2 DIRECCION DE LA ENTIDAD --------------------------------------->  

                                <div class="tab-pane fade" id="adress" role="tabpanel" aria-labelledby="adress-tab">
                                    <div class="form-group col-xs-12" align="center">
                                        <h4>DIRECCION DE LA ENTIDAD</h4>
                                    </div>


                                    <div class="form-group col-xs-12">
                                        <!-- COMBO PARA CARGAR DE FORMA DINAMICA LOS TIPOS DE DIRECCION QUE EXISTEN -->
                                        <div class="form-group col-xs-6">
                                            <label for="comboEntidad"> Distinct code </label>
                                            <div class="form-group-combo">                                        
                                                <select class="form-control" id="comboEntidad" name="comboEntidad">

                                                </select>                                                            
                                            </div>
                                        </div> 
                                        <div class="form-group col-xs-6">
                                            <label for="idCliente>">Nombre_entidad</label>
                                            <input type="text" class="form-control" id="nombre_entidad2" name="nombre_entidad2" disabled = "true">
                                        </div>  
                                    </div>


                                    <div class="form-group">
                                        <!-- COMBO PARA CARGAR DE FORMA DINAMICA LOS TIPOS DE DIRECCION QUE EXISTEN -->
                                        <div class="form-group col-xs-6 ">
                                            <select id="id_tipo_direccion" name="id_tipo_direccion" class="form-control">

                                            </select>
                                        </div>
                                         <div class="form-group col-xs-6">
                                            <input type="text" class="form-control" id="tipo_via" name="tipo_via" placeholder="Tipo via(c, avda..)" required>
                                        </div>
                                    </div>

                                        <div class="form-group">
                                            <div class="form-group col-xs-12">
                                                <input type="text" class="form-control" id="nombre_via" name="nombre_via" placeholder="Nombre via" required>
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

                                <!----------------------------- INFORMACION DE LA PESTAÑA 3 METODO DE PAGO ---------------------------------------> 
                                <div class="tab-pane fade" id="payment" role="tabpanel" aria-labelledby="payment-tab">
                                    <div class="form-group col-xs-12" align="center">
                                        <h4>DATOS DE PAGO DE LA ENTIDAD</h4>
                                    </div> 
                                    <div class="form-group">
                                        <div class="form group col-xs-12">
                                            <input type="text" class="form-control" id="nombre_entidad" name="nombre_entidad" placeholder="Nombre entidad" required>
                                        </div>                                        
                                    </div>

                                    <div class="form-group">
                                        <div class="form-group col-xs-8">
                                            <input type="text" class="form-control" id="numero_cuenta" name="numero_cuenta" placeholder="Num cuenta" required>
                                        </div>                                        
                                        <div class="form-group col-xs-2">
                                            <input type="text" class="form-control" id="cod1" name="cod1" placeholder="Codigo1" required>
                                        </div>                                        
                                        <div class="form-group col-xs-2">
                                            <input type="text" class="form-control" id="cod2" name="cod2" placeholder="Codigo2" required>
                                        </div>
                                    </div>    


                                    <div class="form-group col-xs-12">
                                        <input type="text" class="form-control" id="titular_cuenta" name="titular_cuenta" placeholder="Titular cuenta" required>
                                    </div>

                                    <div class="form-group">
                                        <div class="form col-xs-4">
                                            <input type="text" class="form-control" id="nombre_banco" name="nombre_banco" placeholder="Nombre banco" required>
                                        </div>
                                        <div class="form-group col-xs-8">
                                            <input type="text" class="form-control" id="direccion_banco" name="direccion_banco" placeholder="direccion banco" required>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <div class="form col-xs-6">
                                            <input type="text" class="form-control" id="localidad_banco" name="localidad_banco" placeholder="Localidad" required>
                                        </div>
                                        <div class="form-group col-xs-6">
                                            <input type="text" class="form-control" id="pais_banco" name="pais_banco" placeholder="pais" required>
                                        </div>
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
