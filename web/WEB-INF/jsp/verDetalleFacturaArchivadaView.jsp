<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="jstl" uri="http://java.sun.com/jstl/core_rt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!-- para paginar los datos de factura -->
<link rel="stylesheet" type="text/css" href="DataTables/datatables.min.css"/> 
<script type="text/javascript" src="DataTables/datatables.min.js"></script>

<!DOCTYPE html>
<html>
    <%@ include file="infouser.jsp" %>
    <head> 
        <title>VER FACTURAS</title> 
        <style>
            .azul{
                color:blue;
            }

        </style>
    </head>
    <script>

        $(document).ready(function () {

            var idEmpresa = obtenerValorParametro('idEmpresa');
            var idCliente = obtenerValorParametro('idCliente');
            var idFactura = obtenerValorParametro('idFact');
            var idEstado = obtenerValorParametro('idEstado');
            
            //Funcionae para cargar todos los datos de la factura
            cargarDatosEmpresa(idEmpresa);
            cargarDatosCliente(idCliente);
            cargarDatosFactura(idFactura,idEstado);
            cargarDatosCargos(idFactura);

            //alert(idEmpresa);
            //alert(idCliente);

//            $("#archivar").click(function () {
//                archivarFactura(idFactura);
//            })
//            ;
            
        });


        //Funcion para recuperar el valor de la url. Hay que utilizar dos o mas valores ya que recupera a partir de los &
        function obtenerValorParametro(sParametroNombre) {
            var sPaginaURL = window.location.search.substring(1);
            var sURLVariables = sPaginaURL.split('&');
            for (var i = 0; i < sURLVariables.length; i++) {
                var sParametro = sURLVariables[i].split('=');
                if (sParametro[0] == sParametroNombre) {
                    return sParametro[1];
                }
            }
            return null;
        } //Fin funcion obtenerValorParametro
        ;


        //Funcion paracargar los datos de la empresa
        function cargarDatosEmpresa(idEmpresa) {

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
                /*en la url le pasamos como parametro el identificador de empresa*/
                url: '/Facturacion/verFacturasController/cargarEmpresa.htm?empresa=' + idEmpresa,
                success: function (data) {

                    if (data != "vacio") {

                        var aux = JSON.parse(data);
                        //Vaciamos la tabla cada vez que entramos para que no se dupliquen los datos
                        //$('#tableContainer tbody').empty();
                        aux.forEach(function (valor, indice) {
                            //Cada objeto esta en String y lo pasmoa a TipoImpuesto
                            var resource = JSON.parse(valor);
                            $("#nombreEmpresa").text(resource.col2);
                            $("#tratamientoEmp").text(resource.col3);
                            $("#nombreEmp").text(resource.col4);
                            $("#apellidoEmp").text(resource.col5);

                        });

                    } else {
                        //Si data viene vacio borramos el contenido de los campos                        
                        $("#nombreEmpresa").text("");
                        $("#tratamientoEmp").text("");
                        $("#nombreEmp").text("");
                        $("#apellidoEmp").text("");
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


        //Funcion para cargar los datos del cliente
        function cargarDatosCliente(idCliente) {

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
                /*en la url le pasamos como parametro el identificador de empresa*/
                url: '/Facturacion/verFacturasController/cargarCliente.htm?cliente=' + idCliente,
                success: function (data) {

                    if (data != "vacio") {

                        var aux = JSON.parse(data);
                        //Vaciamos la tabla cada vez que entramos para que no se dupliquen los datos
                        //$('#tableContainer tbody').empty();
                        aux.forEach(function (valor, indice) {
                            //Cada objeto esta en String y lo pasmoa a TipoImpuesto
                            var resource = JSON.parse(valor);
                            $("#nombreCliente").text(resource.col2);
                            $("#tratamientoCli").text(resource.col3);
                            $("#nombreCli").text(resource.col4);
                            $("#apellidoCli").text(resource.col5);
                        });

                    } else {
                        //Si data viene vacio borramos el contenido de los campos                        
                        $("#nombreCliente").text("");
                        $("#tratamientoCli").text("");
                        $("#nombreCli").text("");
                        $("#apellidoCli").text("");
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


        //Funcion paracargar los datos del cliente
        function cargarDatosFactura(idFactura,idEstado) {

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
                /*en la url le pasamos como parametro el identificador de empresa*/
                url: '/Facturacion/verFacturasController/cargarFactura.htm?factura=' + idFactura,
                success: function (data) {

                    if (data != "vacio") {

                        var aux = JSON.parse(data);

                        aux.forEach(function (valor, indice) {
                            //Cada objeto esta en String y lo pasmoa a TipoImpuesto
                            var factura = JSON.parse(valor);
                            $("#numeroFactura").text(factura.id_factura);
                            $("#fEmision").text(factura.fecha_emision.substring(0, 10));
                            $("#fVencimiento").text(factura.fecha_vencimiento.substring(0, 10));
                            $("#total").text(factura.total_factura);
                            $("#estado").text(idEstado);
                        });

                    } else {
                        //Si data viene vacio borramos el contenido de los campos                        
                        $("#numeroFactura").text("");
                        $("#fEmision").text("");
                        $("#fVencimiento").text("");
                        $("#total").text("");
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


        function cargarDatosCargos(idFactura) {

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
                url: '/Facturacion/verFacturasController/cargarCargos.htm?factura=' + idFactura,
                success: function (data) {

                    if (data != "vacio") {

                        var aux = JSON.parse(data);

                        var importe = 0;
                        var impuestos = 0;
                        var total = 0;

                        //Vaciamos la tabla cada vez que entramos para que no se dupliquen los datos
                        $('#tableContainer tbody').empty();
                        aux.forEach(function (valor, indice) {
                            //Cada objeto esta en String y lo pasmoa a TipoImpuesto
                            var resource = JSON.parse(valor);

                            //Calculamos los importes e impuestos que vamos a mostrar
                            importe = importe + parseFloat(resource.col4) * +parseFloat(resource.col5);
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
                                                                    <td>" + resource.col7 + "</td>                       \n\    \n\
                                                                </tr>");


                        });
                        $("#importe").text(importe);
                        $("#impuestos").text(impuestos);
                        $("#totales").text(importe + impuestos);
                    } else {
                        //Si data viene vacio borramos el contenido de los campos
                        $('#tableContainer tbody').empty();
                        $("#importe").text("");
                        $("#impuestos").text("");
                        $("#totales").text("");

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
        

        function archivarFactura(idFactura) {

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
                /*en la url le pasamos como parametro el identificador de empresa*/
                url: '/Facturacion/verFacturasController/archivarFactura.htm?factura=' + idFactura,
                success: function (data) {

                    if (data == "correcto") {  
                        alert("correcto")
                        location.href = "/Facturacion/verFacturasController/startArchivadas.htm";
                    } else {
                        alert("mal")
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


    </script>        


    <body>
        <div class="container">
            <div class="col-xs-12">
                <div class="col-md-12 col-xs-5">
                    <div class="form-area">  
                        <form role="form">
                            <br style="clear:both">
                            <h3 style="margin-bottom: 25px; text-align: center;">VER DETALLE FACTURA ARCHIVADA</h3>                           

                            <div class="datos" class="col-xs-12">
                                <!--Combo para entidades-->
                                <div class="form-group col-xs-4">
                                    <label for="nombreEmpresa">Empresa emisora: </label>
                                    <label id="nombreEmpresa" name="nombreEmpresa" class="azul" ></label>
                                </div> 
                                <div class="form-group col-xs-2">
                                    <label for="tratamientoEmp">Tto.: </label>
                                    <label id="tratamientoEmp" name="tratamientoEmp" class="azul" ></label>
                                </div> 
                                <div class="form-group col-xs-3">
                                    <label for="nombreEmp">Nombre: </label>
                                    <label id="nombreEmp" name="nombreEmp" class="azul" ></label>
                                </div> 
                                <div class="form-group col-xs-3">
                                    <label for="apellidoEmp">Apellido: </label>
                                    <label id="apellidoEmp" name="apellidoEmp" class="azul" ></label>
                                </div> 
                                <br style="clear:both">

                            </div>      

                            <div class="datos" class="col-xs-12">
                                <!--Combo para entidades-->
                                <div class="form-group col-xs-4">
                                    <label for="nombreCliente">Cliente: </label>
                                    <label id="nombreCliente" name="nombreCliente" class="azul" ></label>
                                </div> 
                                <div class="form-group col-xs-2">
                                    <label for="tratamientoCli">Tto.: </label>
                                    <label id="tratamientoCli" name="tratamientoCli" class="azul" ></label>
                                </div> 
                                <div class="form-group col-xs-3">
                                    <label for="nombreCli">Nombre: </label>
                                    <label id="nombreCli" name="nombreCli" class="azul" ></label>
                                </div> 
                                <div class="form-group col-xs-3">
                                    <label for="apellidoCli">Apellido: </label>
                                    <label id="apellidoCli" name="apellidoCli" class="azul" ></label>
                                </div> 
                                <br style="clear:both">
                                <hr size="10" />

                                <div class="datos" class="col-xs-12">
                                    <!--Combo para entidades-->
                                    <div class="form-group col-xs-2">
                                        <label for="numeroFactura">Numero Fact: </label>
                                        <label id="numeroFactura" name="numeroFactura" class="azul" ></label>
                                    </div> 
                                    <div class="form-group col-xs-3">
                                        <label for="fEmision">F. Emisión: </label>
                                        <label id="fEmision" name="fEmision" class="azul" ></label>
                                    </div> 
                                    <div class="form-group col-xs-3">
                                        <label for="fVencimiento">F. Vencimiento: </label>
                                        <label id="fVencimiento" name="fVencimiento" class="azul" ></label>
                                    </div> 
                                    <div class="form-group col-xs-2">
                                        <label for="total">Total: </label>
                                        <label id="total" name="total" class="azul" ></label>
                                    </div> 
                                    <div class="form-group col-xs-2">
                                        <label for="estado">Estado: </label>
                                        <label id="estado" name="estado" class="azul" ></label>
                                    </div> 
                                    <br style="clear:both">
                                </div>          

                                <hr size="10" />

                                <div class="col-xs-12" id="tableContainer">
                                    <table class="table table-striped">                                    

                                        <thead class="thead-dark">                                            
                                            <tr>
                                                <th scope="col">#</th>
                                                <th scope="col">Nº Cargo</th>
                                                <th scope="col">Abreviatura</th>
                                                <th scope="col">Cuenta</th>
                                                <th scope="col">Importe</th>
                                                <th scope="col">Cantidad</th>
                                                <th scope="col">Impuesto</th>
                                                <th scope="col">Total</th>
                                            </tr>                                            
                                        </thead>

                                        <tbody id="tbody-tabla-cargos">

                                        </tbody>
                                    </table>
                                </div>   

                                <div class="datos" class="col-xs-12">
                                    <!--Combo para entidades-->
                                    <div class="form-group col-xs-2 col-xs-offset-5">
                                        <label for="importe">Importe: </label>
                                        <label id="importe" name="importe" class="azul" ></label>
                                    </div> 
                                    <div class="form-group col-xs-2 col-xs-offset-1">
                                        <label for="impuestos">Impuestos: </label>
                                        <label id="impuestos" name="impuestos" class="azul" ></label>
                                    </div> 
                                    <div class="form-group col-xs-2">
                                        <label for="totales">Total: </label>
                                        <label id="totales" name="totales" class="azul" ></label>
                                    </div> 
                                    <br style="clear:both">
                                </div>          

                                <a href="/Facturacion/MenuController/start.htm" class="btn btn-info" role="button">Menu principal</a>     
                                <a href="javaScript:window.close();" class="btn btn-info" role="button">Cerrar</a> 
                                
                                <input type="button" value="Activar no funciona" class="btn btn-warning" id="archivar" name="activar">


                            </div>
                        </form>

                    </div>
                </div>
            </div>  
        </div>


    </body> 
</html>
