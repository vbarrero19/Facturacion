
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="jstl" uri="http://java.sun.com/jstl/core_rt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
    <%@ include file="infouser.jsp" %>
    <head> 
        <title>GESTION FACTURAS</title> 
    </head>
    <script>
        $(document).ready(function () {
            //al cargar la pagina llamamos a las funciones getEntidadCliente() y getEntidadEmpresa() para llenar el combo 
            getEntidadCliente();
            getEntidadEmpresa();

            var userLang = navigator.language || navigator.userLanguage;

            //Se pone dentro del ready porque se ejecuta cada vez que entramos en la pagina.
            //Constructor para el calendario Fecha-Cargo.
            $('#fecha_emision').datetimepicker({
                format: 'YYYY-MM-DD',
                locale: userLang.valueOf(),
                daysOfWeekDisabled: [0, 6],
                useCurrent: false//Important! See issue #1075
                        //defaultDate: '08:32:33',
                        //                });
            });

            //Se pone dentro del ready porque se ejecuta cada vez que entramos en la pagina.
            //Constructor para el calendario Fecha-Cargo.
            $('#fecha_vencimiento').datetimepicker({
                format: 'YYYY-MM-DD',
                locale: userLang.valueOf(),
                daysOfWeekDisabled: [0, 6],
                useCurrent: false//Important! See issue #1075
                        //defaultDate: '08:32:33',
                        //                });
            });

            //Al pulsar el boton de consultar facturas recogemos los datos del cliente y (sus cargos sin numero de factura) -> Esto ultimo falta por hacer    
            $("#comboClientes").change(function () {

                if ($("#comboClientes").val() != "0") {

                    if (window.XMLHttpRequest) //mozilla
                    {
                        ajax = new XMLHttpRequest(); //No Internet explorer
                    } else
                    {
                        ajax = new ActiveXObject("Microsoft.XMLHTTP");
                    }

                    var myObj = {};

                    myObj["col1"] = $("#comboClientes").val().trim();

                    var json = JSON.stringify(myObj);

                    $.ajax({
                        type: 'POST',
                        url: '/Facturacion/facturasController/getFacturas.htm',
                        data: json,
                        datatype: "json",
                        contentType: "application/json",
                        success: function (data) {


                            //alert(data);

                            //Controlamos que un cliente no tenga cargos. En el controller vemos si devuelve datos o no
                            //Si no devuelve datos ponemos resp = "vacio"
                            if (data != "vacio") {

                                var aux = JSON.parse(data);

                                var subtotal = 0.00;
                                var impuestos = 0.00;

                                //Vaciamos la tabla cada vez que entramos para que no se dupliquen los datos
                                $('#tableContainer tbody').empty();
                                aux.forEach(function (valor, indice) {
                                    //Cada objeto esta en String y lo pasmoa a resource
                                    var resource = JSON.parse(valor);

                                    idCargo = resource.col1;
                                    idCliente = resource.col8;

                                    $("#idCliente").val(resource.col8);
                                    $("#nombreEntidad").val(resource.col10);
                                    $("#nombreContactoCli").val(resource.col11);

                                    //Calculamos los importe e impuestos que vamos a mostrar
                                    subtotal = subtotal + (parseFloat(resource.col4) * parseFloat(resource.col5));
                                    impuestos = impuestos + parseFloat(resource.col6);

                                    //cargamos de forma dinamica la tabla
                                    $('#tableContainer tbody').append(" <tr>\n\
                                                                    <th scope=\"row\">" + (indice + 1) + "</th>              \n\
                                                                    <td id='id" + (indice + 1) + "'>" + resource.col1 + "</td>                       \n\
                                                                    <td>" + resource.col2 + "</td>                        \n\
                                                                    <td>" + resource.col3 + "</td>                       \n\
                                                                    <td>" + resource.col4 + "</td>                       \n\
                                                                    <td>" + resource.col5 + "</td>                       \n\
                                                                    <td>" + resource.col6 + "</td>                       \n\
                                                                    <td>" + resource.col7 + "</td>                       \n\
                                                                    <td class='hidden'>" + resource.col8 + "</td>                       \n\
                                                                    <td>" + resource.col12.substring(0, 10) + "</td>                       \n\
                                                                    <td>" + resource.col13.substring(0, 10) + "</td>                       \n\
                                                                    <td class='hidden' id='descrip" + (indice + 1) + "'>" + resource.col14 + "</td>         \n\
                                                                    <td><button type='button' class='btn btn-info miBoton btn-success' id='myBtn' value='" + (indice + 1) + "';>Ver Desc.</button></td>\n\
                                                                    <td><a class='btn btn-warning btn-md' href='javascript:;' onclick='refrescarCargos($(\"#id" + (indice + 1) + "\").text());' role='button'>Quitar</a></td>        \n\\n\
                                                                </tr>");


                                });

                                $(document).ready(function () {
                                    $(".miBoton").click(function () {
                                        //Con $(this).val() cogemos el value del boton, lo concatenamos a #descrip para tener el id del campo oculto con
                                        //la descripcion correspondiente a esa fila. Cogemos el text de ese campo y lo añadimos al p del modal para visualizarlo
                                        $("#descripcion").text($("#descrip" + $(this).val()).text());
                                        $("#myModal").modal();
                                    });
                                });

                                //Quitamos decimales al subtotal
                                var valSub = parseFloat(Math.round(subtotal * 100) / 100).toFixed(2);
                                $("#subtotal").val(valSub);
                                //Quitamos decimales al impuestos
                                var valImp = parseFloat(Math.round(impuestos * 100) / 100).toFixed(2);
                                $("#impuestos").val(valImp);
                                //Calculamos el total
                                var total = parseFloat(valSub) + parseFloat(valImp);
                                var valTot = parseFloat(Math.round(total * 100) / 100).toFixed(2);
                                $("#total_factura").val(valTot);

                            } else {
                                //Si data viene vacio borramos el contenido de los campos
                                $('#tableContainer tbody').empty();
                                $("#idCliente").val("");
                                $("#nombreEntidad").val("");
                                $("#nombreContactoCli").val("");
                                $("#subtotal").val("");
                                $("#impuestos").val("");
                                $("#total_factura").val("");
                            }
                        },
                        error: function (xhr, ajaxOptions, thrownError) {
                            console.log(xhr.status);
                            console.log(xhr.responseText);
                            console.log(thrownError);
                        }
                    });
                    //Si se seleciona lo opcion "Seleccionar" se limpian las cajas de texto
                } else {
                    $("#idCliente").val("");
                    $("#nombreEntidad").val("");
                    $("#nombreContactoCli").val("");

                    $('#tableContainer tbody').empty();

                    $("#subtotal").val("");
                    $("#impuestos").val("");
                    $("#total_factura").val("");
                }
            })

            //Muestra datos de la entidadEmpresa al seleccionar algo en el combo
            $("#comboEmpresas").change(function () {

                //Si la opcion seleccionada es diferente a "Seleccionar" se muestran datos
                if ($("#comboEmpresas").val() != "0") {

                    if (window.XMLHttpRequest) //mozilla
                    {
                        ajax = new XMLHttpRequest(); //No Internet explorer
                    } else
                    {
                        ajax = new ActiveXObject("Microsoft.XMLHTTP");
                    }

                    var myObj = {};

                    myObj["id_entidad"] = $("#comboEmpresas").val().trim();

                    var json = JSON.stringify(myObj);
                    $.ajax({
                        type: 'POST',
                        url: '/Facturacion/facturasController/getDatosEntidadEmpresa.htm',
                        data: json,
                        datatype: "json",
                        contentType: "application/json",
                        success: function (data) {

                            //En el data viene la informacion del combo en forma de String.
                            //Primero lo pasamos a objetos tipo String y luego estos a objetos tipo cliente
                            //Recogemos el data como una cadena String y los pasamos a objetos Tipo String con JSON
                            var aux = JSON.parse(data);

                            aux.forEach(function (valor, indice) {
                                //Recogemos cada objeto en String y los pasamos a objetos Tipo cliente con JSON
                                var aux2 = JSON.parse(valor);
                                //Mostramos los datos en la cajas de texto
                                $("#idEmpresa").val(aux2.id_entidad);
                                $("#nombreEmpresa").val(aux2.nombre_entidad);
                                $("#nombreContactoEmp").val(aux2.nombre_contacto);

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
                    $("#idEmpresa").val("");
                    $("#nombreEmpresa").val("");
                    $("#nombreContactoEmp").val("");
                }

            });

            //Guarda los datos introducidos en el formulario en la tabla facturas
            $("#generarFactura").click(function () {
                if (window.XMLHttpRequest) //mozilla
                {
                    ajax = new XMLHttpRequest(); //No Internet explorer
                } else
                {
                    ajax = new ActiveXObject("Microsoft.XMLHTTP");
                }

                var myObj = {};
                myObj["id_factura"] = ""; //Es automatico
                myObj["id_cliente"] = $("#idCliente").val().trim();
                myObj["id_empresa"] = $("#idEmpresa").val().trim();
                myObj["total_factura"] = $("#total_factura").val().trim();

                //dentro de fecha cargo tenemos que coger el valor que hay dentro de input.
                myObj["fecha_emision"] = $("#fecha_emision input").val().trim();
                //dentro de fecha vencimiento tenemos que coger el valor que hay dentro de input.
                myObj["fecha_vencimiento"] = $("#fecha_vencimiento input").val().trim();

                myObj["id_estado"] = ""; //Falta por definir               



                var json = JSON.stringify(myObj);
                $.ajax({
                    type: 'POST',
                    url: '/Facturacion/facturasController/nuevaFactura.htm',
                    data: json,
                    datatype: "json",
                    contentType: "application/json",
                    success: function (data) {
                        alert(data);

                        location.reload();

                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        console.log(xhr.status);
                        console.log(xhr.responseText);
                        console.log(thrownError);
                    }
                });
            });

        });

        //Se usa para refrescar el listado de cargos si se elimina alguno
        function refrescarCargos(cargo) {
            alert("Cargo: " + cargo);
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
                /*en la url le pasamos como parametro el identificador de cargo y cliente que lo recogemos cuando se quiere quitar un cargo de la lista de cargos*/
                url: '/Facturacion/facturasController/refrescarCargos.htm?cargo=' + cargo, // + '&cliente=' + cliente,
                success: function (data) {

                    alert(data);

                    //Controlamos que un cliente no tenga cargos. En el controller vemos si devuelve datos o no
                    //Si no devuelve datos ponemos resp = "vacio"
                    if (data != "vacio") {

                        var aux = JSON.parse(data);

                        var subtotal = 0.00;
                        var impuestos = 0.00;

                        //Vaciamos la tabla cada vez que entramos para que no se dupliquen los datos
                        $('#tableContainer tbody').empty();
                        aux.forEach(function (valor, indice) {
                            //Cada objeto esta en String y lo pasmoa a TipoImpuesto
                            var resource = JSON.parse(valor);

                            idCargo = resource.col1;
                            idCliente = resource.col8;

                            $("#idCliente").val(resource.col8);
                            $("#nombreEntidad").val(resource.col10);
                            $("#nombreContactoCli").val(resource.col11);

                            //Calculamos los importe e impuestos que vamos a mostrar
                            subtotal = subtotal + (parseFloat(resource.col4) * parseFloat(resource.col5));
                            impuestos = impuestos + parseFloat(resource.col6);

                            //cargamos de forma dinamica la tabla
                            $('#tableContainer tbody').append(" <tr>\n\
                                                                    <th scope=\"row\">" + (indice + 1) + "</th>              \n\
                                                                    <td id='id" + (indice + 1) + "'>" + resource.col1 + "</td>                       \n\
                                                                    <td>" + resource.col2 + "</td>                        \n\
                                                                    <td>" + resource.col3 + "</td>                       \n\
                                                                    <td>" + resource.col4 + "</td>                       \n\
                                                                    <td>" + resource.col5 + "</td>                       \n\
                                                                    <td>" + resource.col6 + "</td>                       \n\
                                                                    <td>" + resource.col7 + "</td>                       \n\
                                                                    <td class='hidden'>" + resource.col8 + "</td>                       \n\
                                                                    <td>" + resource.col12.substring(0, 10) + "</td>                       \n\
                                                                    <td>" + resource.col13.substring(0, 10) + "</td>                       \n\
                                                                    <td class='hidden' id='descrip" + (indice + 1) + "'>" + resource.col14 + "</td>         \n\
                                                                    <td><button type='button' class='btn btn-info miBoton btn-success' id='myBtn' value='" + (indice + 1) + "';>Ver Desc.</button></td>\n\
                                                                    <td><a class='btn btn-warning btn-md' href='javascript:;' onclick='refrescarCargos($(\"#id" + (indice + 1) + "\").text(),idCliente);' role='button'>Quitar</a></td>        \n\\n\
                                                                </tr>");


                        });

                        $(document).ready(function () {
                            $(".miBoton").click(function () {
                                //Con $(this).val() cogemos el value del boton, lo concatenamos a #descrip para tener el id del campo oculto con
                                //la descripcion correspondiente a esa fila. Cogemos el text de ese campo y lo añadimos al p del modal para visualizarlo
                                $("#descripcion").text($("#descrip" + $(this).val()).text());
                                $("#myModal").modal();
                            });
                        });

                        //Quitamos decimales al subtotal
                        var valSub = parseFloat(Math.round(subtotal * 100) / 100).toFixed(2);
                        $("#subtotal").val(valSub);
                        //Quitamos decimales al impuestos
                        var valImp = parseFloat(Math.round(impuestos * 100) / 100).toFixed(2);
                        $("#impuestos").val(valImp);
                        //Calculamos el total
                        var total = parseFloat(valSub) + parseFloat(valImp);
                        var valTot = parseFloat(Math.round(total * 100) / 100).toFixed(2);
                        $("#total_factura").val(valTot);
                    } else {
                        //Si data viene vacio borramos el contenido de los campos
                        $('#tableContainer tbody').empty();
                        $("#idCliente").val("");
                        $("#nombreEntidad").val("");
                        $("#nombreContactoCli").val("");
                        $("#subtotal").val("");
                        $("#impuestos").val("");
                        $("#total_factura").val("");
                    }
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    console.log(xhr.status);
                    console.log(xhr.responseText);
                    console.log(thrownError);
                }
            });
        }
        ;

        //Funcion para llenar el combo de cliente. Los datos nos vienen en un ArrayList de objetos TipoImpuesto transformado en String
        //con json. Los datos se obtienen en itemsController/getImpuesto.htm.
        function getEntidadCliente() {
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
                url: '/Facturacion/facturasController/getEntidadCliente.htm', //Vamos a facturasController/getEntidadCliente.htm a recoger los datos
                success: function (data) {

                    //Recogemos los datos del combo y los pasamos a objetos TipoImpuesto  
                    var aux = JSON.parse(data);
                    //Identificamos el combo
                    select = document.getElementById('comboClientes');
                    //Añadimos la opcion Seleccionar al combo
                    var opt = document.createElement('option');
                    opt.value = 0;
                    opt.innerHTML = "Seleccionar";
                    select.appendChild(opt);
                    //Lo vamos cargando
                    aux.forEach(function (valor, indice) {
                        //Cada objeto esta en String y lo pasmoa a TipoImpuesto
                        var aux2 = JSON.parse(valor);
                        //Creamos las opciones del combo
                        var opt = document.createElement('option');
                        //Guardamos el id en el value de cada opcion
                        opt.value = aux2.id_entidad;
                        //Guardamos el impuesto en el nombre de cada opcion
                        //                 opt.innerHTML = aux2.id_impuesto;
                        opt.innerHTML = aux2.distinct_code;
                        //Añadimos la opcion
                        select.appendChild(opt);
                    });
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    console.log(xhr.status);
                    console.log(xhr.responseText);
                    console.log(thrownError);
                }
            });
        }
        ;

        //Funcion para llenar el combo de empresa. Los datos nos vienen en un ArrayList de objetos cliente transformados en String
        //y estos a su vez en otra cadena String con json. Los datos se obtienen en cargosController/getEmpresa.htm.
        function getEntidadEmpresa() {
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
                url: '/Facturacion/facturasController/getEntidadEmpresa.htm', //Vamos a cargosController/getEmpresa.htm a recoger los datos
                success: function (data) {

                    //Recogemos los datos del combo y los pasamos a objetos Cliente  
                    var empresaEntidad = JSON.parse(data);
                    //Identificamos el combo
                    select = document.getElementById('comboEmpresas');
                    //Añadimos la opcion Seleccionar al combo
                    var opt = document.createElement('option');
                    opt.value = 0;
                    opt.innerHTML = "Seleccionar";
                    select.appendChild(opt);

                    //Lo vamos cargando
                    empresaEntidad.forEach(function (valor, indice) {
                        //Cada objeto esta en String y lo pasmoa a TipoImpuesto
                        var empresaEntidad2 = JSON.parse(valor);
                        //Creamos las opciones del combo
                        var opt = document.createElement('option');
                        //Guardamos el id en el value de cada opcion
                        opt.value = empresaEntidad2.id_entidad;
                        //Guardamos el impuesto en el nombre de cada opcion                        
                        opt.innerHTML = empresaEntidad2.distinct_code;
                        //Añadimos la opcion
                        select.appendChild(opt);
                    });

                },
                error: function (xhr, ajaxOptions, thrownError) {
                    console.log(xhr.status);
                    console.log(xhr.responseText);
                    console.log(thrownError);
                }
            });
        }
        ;


    </script>


    <!--
<td><button value="actualizar" tittle="actualizar" id="btnedit" class="btn btn-primary btn-edit"><i class="fas fa-edit"></i></i></button> </td>\n\
<td><button value="eliminar" tittle="eliminar" class="btn btn-danger btn-delete"><i class="fas fa-window-close"></i></button> </td>\n\\n\-->



    <body>
        <div class="container">
            <div class="col-xs-12">
                <div class="col-md-12">
                    <div class="form-area">  
                        <form role="form">
                            <br style="clear:both">
                            <h3 style="margin-bottom: 25px; text-align: center;">Generar Factura</h3>

                            <div class="col-xs-12" id="datos">

                                <div class="col-xs-3 form-group">
                                    <label for="comboClientes">Distincy Code Empresa</label>
                                    <div class="form-group-combo">
                                        <!--Combo para clientes-->
                                        <select class="form-control" id="comboEmpresas" name="comboClientes">
                                        </select>                                                            
                                    </div>
                                </div>

                                <div class="form-group col-xs-3">
                                    <label for="nombre_empresa">Id Empresa</label>
                                    <input type="text" class="form-control" id="idEmpresa" name="idEmpresa">
                                </div>                            
                                <div class="form-group col-xs-3">
                                    <label for="dir_fisica">Nombre Empresa</label>
                                    <input type="text" class="form-control" id="nombreEmpresa" name="nombreEmpresa">
                                </div>
                                <div class="form-group col-xs-3">
                                    <label for="pais">Nombre Contacto Empresa</label>
                                    <input type="text" class="form-control" id="nombreContactoEmp" name="nombreContactoEmp">
                                </div>

                            </div>

                            <div class="col-xs-12" id="datos2">

                                <div class="col-xs-3 form-group">
                                    <label for="comboClientes">Distincy Code Cliente</label>
                                    <div class="form-group-combo">
                                        <!--Combo para clientes-->
                                        <select class="form-control" id="comboClientes" name="comboClientes">
                                        </select>                                                            
                                    </div>
                                </div>

                                <div class="form-group col-xs-3">
                                    <label for="nombre_empresa">Id Cliente</label>
                                    <input type="text" class="form-control" id="idCliente" name="idCliente">
                                </div>                            
                                <div class="form-group col-xs-3">
                                    <label for="dir_fisica">Nombre Cliente</label>
                                    <input type="text" class="form-control" id="nombreEntidad" name="nombreEntidad">
                                </div>
                                <div class="form-group col-xs-3">
                                    <label for="pais">Nombre Contacto Cliente</label>
                                    <input type="text" class="form-control" id="nombreContactoCli" name="nombreContacto">
                                </div>

                            </div>

                            <br style="clear:both">
                            <hr>

                            <div class="col-xs-12" id="tableContainer">
                                <table class="table table-striped">
                                    <thead class="thead-dark">
                                        <tr>
                                            <th scope="col">#</th>
                                            <th scope="col">Id Cargo</th>
                                            <th scope="col">Abreviatura</th> 
                                            <th scope="col">Cuenta</th> 
                                            <th scope="col">Importe</th> 
                                            <th scope="col">Cantidad</th> 
                                            <th scope="col">Impuesto</th>                                            
                                            <th scope="col">Total</th>                                            
                                            <th scope="col">F. Cargo</th> 
                                            <th scope="col">F. Venc</th> 
                                        </tr>
                                    </thead>
                                    <tbody>

                                    </tbody>
                                </table>
                            </div>

                            <div class="col-xs-6">

                                <!--DENTRO DEL CONTAINER METEMOS LOS DOS DESPLEGABLES DE LAS FECHAS -->
                                <div class="container2">                                   
                                    <div class="row">
                                        <div class='col-xs-12 col-md-4'>
                                            <label class="fechaCargos"> Emision </label>
                                            <div class="form-group">
                                                <div class='input-group date' id='fecha_emision'>
                                                    <input  data-format="yyyy-MM-dd hh:mm:ss" type='text' class="form-control" />
                                                    <span class="input-group-addon">
                                                        <span class="glyphicon glyphicon-calendar"></span>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                        <script type="text/javascript">
                                            $(function () {
                                                $('#fecha_emision').datetimepicker();
                                            });
                                        </script>
                                    </div>

                                    <div class="row">
                                        <div class='col-xs-12 col-md-4'>
                                            <label class="fechaCargos"> Vencimiento </label>
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
                            </div>

                            <div class="col-xs-6">

                                <div class="form-group">
                                    <div class="col-xs-3">
                                        <label>Subtotal:</label>
                                    </div>
                                    <div class="col-xs-5">
                                        <input type="text" class="form-control" id="subtotal" name="subtotal" disabled="true">
                                    </div>
                                </div>           
                                <br style="clear:both">
                                <div class="form-group">
                                    <div class="col-xs-3">
                                        <label>Impuestos:</label>
                                    </div>
                                    <div class="col-xs-5">
                                        <input type="text" class="form-control" id="impuestos" name="impuestos" disabled="true">
                                    </div>
                                </div>       
                                <br style="clear:both">
                                <div class="form-group">
                                    <div class="col-xs-3">
                                        <label>Total:</label>
                                    </div>
                                    <div class="col-xs-5">
                                        <input type="text" class="form-control" id="total_factura" name="total_factura" disabled="true">
                                    </div>
                                </div>  
                            </div>

                            <br style="clear:both">
                            <hr>
                            <div id="datos3" class="col-xs-12">
                                <a href="<c:url value='/MenuController/start.htm'/>" class="btn btn-info" role="button">Menu principal</a>   
                                <button type="button" id="generarFactura" name="generarFactura" class="btn btn-primary">Generar factura</button> 
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- ventana emergente Modificar-->
            <div class="modal fade" id="myModal" role="dialog">
                <div class="modal-dialog">

                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">Descripción</h4>
                        </div>
                        <div class="modal-body">
                            <p id="descripcion"></p>                            
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        </div>
                    </div>

                </div>
            </div>
        </div>                  
    </body>
</html>
