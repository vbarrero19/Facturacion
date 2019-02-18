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
    </head>
    <script>

        $(document).ready(function () {


            var idFact = obtenerValorParametro('idFact');
            var idCliente = obtenerValorParametro('idCliente');
            var idEmpresa = obtenerValorParametro('idEmpresa');
            alert(idFact);
            alert(idCliente);
            alert(idEmpresa);
            cargarDatosEmpresa(idEmpresa);
            //cargarDatosCliente(idFact);
            //cargarDatosFactura(idFact);

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

            alert("Empresa: " + idEmpresa);
            empresa = idEmpresa;
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

                    alert(data);
                    
                    if (data != "vacio") {

                        var aux = JSON.parse(data);
                        //Vaciamos la tabla cada vez que entramos para que no se dupliquen los datos
                        //$('#tableContainer tbody').empty();
                        aux.forEach(function (valor, indice) {
                            //Cada objeto esta en String y lo pasmoa a TipoImpuesto
                            var entidad = JSON.parse(valor);
                            $("#idEmpresa").val(entidad.col1);
                            $("#nombreEmpresa").val(entidad.col2);
                            $("#tratamientoEmpresa").val(entidad.col3);
                            $("#nombreContacto").val(entidad.col4);
                            $("#Apellido").val(entidad.col5);
//                            //cargamos de forma dinamica la tabla
//                            $('#tableContainer tbody').append(" <tr>\n\
//                                                                    <th scope=\"row\">" + (indice + 1) + "</th>              \n\
//                                                                    <td id='id" + (indice + 1) + "'>" + resource.col1 + "</td>                       \n\
//                                                                    <td>" + resource.col2 + "</td>                        \n\
//                                                                    <td>" + resource.col3 + "</td>                       \n\
//                                                                    <td>" + resource.col4 + "</td>                       \n\
//                                                                    <td>" + resource.col5 + "</td>                       \n\
//                                                                    <td>" + resource.col6 + "</td>                       \n\
//                                                                    <td>" + resource.col7 + "</td>                       \n\
//                                                                    <td>" + resource.col8 + "</td>                       \n\
//                                                                    <td><a class='btn btn-primary btn-lg' href='javascript:;' onclick='refrescarCargos($(\"#id" + (indice + 1) + "\").text(),idCliente);' role='button'>Quitar</a></td>        \n\\n\
//                                                                </tr>");
//
//
                        });
//                        $("#subtotal").val(subtotal);
//                        $("#impuestos").val(impuestos);
//                        $("#total_factura").val(subtotal + impuestos);
                    } else {
                        //Si data viene vacio borramos el contenido de los campos
                        $("#idEmpresa").val("");
                        $("#nombreEmpresa").val("");
                        $("#tratamientoEmpresa").val("");
                        $("#nombreContacto").val("");
                        $("#Apellido").val("");
                    }
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    console.log(xhr.status);
                    console.log(xhr.responseText);
                    console.log(thrownError);
                }
            });//fin ajax
        }//fin funcion
        ;

//
//        function cargarDatosFactura(idFact, idCliente, idFactura) {
//            alert("Factura: " + idFact);
//            alert("Cliente: " + idCliente);
//            alert("Empresa: " + idEmpresa);
//            if (window.XMLHttpRequest) //mozilla
//            {
//                ajax = new XMLHttpRequest(); //No Internet explorer
//            } else
//            {
//                ajax = new ActiveXObject("Microsoft.XMLHTTP");
//            }
//
//
//            $.ajax({
//                //Usamos GET ya que recibimos.
//                type: 'GET',
//                /*en la url le pasamos como parametro el identificador de cargo y cliente que lo recogemos cuando se quiere quitar un cargo de la lista de cargos*/
//                url: '/Facturacion/verFacturasController/cargarFactura.htm?factura=' + idFact + '&cliente=' + idCliente + '&empresa=' + idFactura,
//                success: function (data) {
//
//                    alert(data);
//
//                    //Controlamos que un cliente no tenga cargos. En el controller vemos si devuelve datos o no
//                    //Si no devuelve datos ponemos resp = "vacio"
//                    if (data != "vacio") {
//
//                        var aux = JSON.parse(data);
//
//                        var subtotal = 0;
//                        var impuestos = 0;
//
//                        //Vaciamos la tabla cada vez que entramos para que no se dupliquen los datos
//                        $('#tableContainer tbody').empty();
//                        aux.forEach(function (valor, indice) {
//                            //Cada objeto esta en String y lo pasmoa a TipoImpuesto
//                            var resource = JSON.parse(valor);
//
//                            idCargo = resource.col1;
//                            idCliente = resource.col8;
//
//                            $("#idCliente").val(resource.col8);
//                            $("#nombreEntidad").val(resource.col10);
//                            $("#nombreContactoCli").val(resource.col11);
//
//                            //Calculamos los importe e impuestos que vamos a mostrar
//                            subtotal = subtotal + (parseInt(resource.col4) * parseInt(resource.col5));
//                            impuestos = impuestos + parseInt(resource.col6);
//
//                            //cargamos de forma dinamica la tabla
//                            $('#tableContainer tbody').append(" <tr>\n\
//                                                                    <th scope=\"row\">" + (indice + 1) + "</th>              \n\
//                                                                    <td id='id" + (indice + 1) + "'>" + resource.col1 + "</td>                       \n\
//                                                                    <td>" + resource.col2 + "</td>                        \n\
//                                                                    <td>" + resource.col3 + "</td>                       \n\
//                                                                    <td>" + resource.col4 + "</td>                       \n\
//                                                                    <td>" + resource.col5 + "</td>                       \n\
//                                                                    <td>" + resource.col6 + "</td>                       \n\
//                                                                    <td>" + resource.col7 + "</td>                       \n\
//                                                                    <td>" + resource.col8 + "</td>                       \n\
//                                                                    <td><a class='btn btn-primary btn-lg' href='javascript:;' onclick='refrescarCargos($(\"#id" + (indice + 1) + "\").text(),idCliente);' role='button'>Quitar</a></td>        \n\\n\
//                                                                </tr>");
//
//
//                        });
//                        $("#subtotal").val(subtotal);
//                        $("#impuestos").val(impuestos);
//                        $("#total_factura").val(subtotal + impuestos);
//                    } else {
//                        //Si data viene vacio borramos el contenido de los campos
//                        $('#tableContainer tbody').empty();
//                        $("#idCliente").val("");
//                        $("#nombreEntidad").val("");
//                        $("#nombreContactoCli").val("");
//                        $("#subtotal").val("");
//                        $("#impuestos").val("");
//                        $("#total_factura").val("");
//                    }
//                },
//                error: function (xhr, ajaxOptions, thrownError) {
//                    console.log(xhr.status);
//                    console.log(xhr.responseText);
//                    console.log(thrownError);
//                }
//            });
//        }
//        ;

    </script>        


    <body>
        <div class="container">
            <div class="col-xs-12">
                <div class="col-md-12 col-xs-5">
                    <div class="form-area">  
                        <form role="form">
                            <br style="clear:both">
                            <h3 style="margin-bottom: 25px; text-align: center;">VER DETALLE FACTURA</h3>                           

                            <div class="datos" class="col-xs-12">
                                <!--Combo para entidades-->
                                <div class="form-group col-xs-2">
                                    <label for="id_cliente">Empresa emisora</label>
                                    <label class="form-control" id="vvv" name="vvv" ></label>
                                </div> 
                                <div class="form-group col-xs-2">
                                    <label for="id_cliente"> nombreEmpresa </label>
                                    <input type="text" class="form-control" id="nombreEmpresa" name="nombreEmpresa" disabled = "true">
                                </div> 
                                <div class="form-group col-xs-4">
                                    <label for="idCliente>">Nombre_entidad</label>
                                    <input type="text" class="form-control" id="nombre_entidad" name="nombre_entidad" disabled = "true">
                                </div>  
                                <div class="form-group col-xs-3">
                                    <label for="idCliente>">Nombre contacto</label>
                                    <input type="text" class="form-control" id="nombre_contacto" name="nombre_contacto" disabled = "true">
                                </div>  
                                <br style="clear:both">

                                <!--                                <hr size="10" />
                                
                                                                <div class="col-xs-12" id="tableContainer">
                                                                    <table class="table table-striped">                                    
                                
                                                                        <thead class="thead-dark">                                            
                                                                            <tr>
                                                                                <th scope="col">#</th>
                                                                                <th scope="col">Nº factura</th>
                                                                                <th scope="col">Cliente</th>
                                                                                <th scope="col">Empresa</th>
                                                                                <th scope="col">FechaCargo</th>
                                                                                <th scope="col">FechaVencimiento</th>
                                                                                <th scope="col">Total</th>
                                                                            </tr>                                            
                                                                        </thead>
                                
                                                                        <tbody id="tbody-tabla-entidades">
                                
                                                                        </tbody>
                                                                    </table>
                                                                </div>    -->

                                <!-- <button type="button" id="submit" name="submit" class="btn btn-primary pull-right">Submit</button>-->
                                <a href="<c:url value='/MenuController/start.htm'/>" class="btn btn-info" role="button">Menu principal</a> 
                        </form>

                    </div>                            
                </div>
            </div>
        </div>  
    </div>


</body> 
</html>
