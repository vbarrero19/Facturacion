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
        }
        ;


        function cargarDatosEmpresa(idEmpresa) {
            alert("Factura: " + idFact);
            alert("Cliente: " + idCliente);
            alert("Empresa: " + idEmpresa);
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
                url: '/Facturacion/verFacturasController/cargarEmpresa.htm?empresa=' + idEmpresa,
                success: function (data) {

                    alert(data);

                    //Controlamos que un cliente no tenga cargos. En el controller vemos si devuelve datos o no
                    //Si no devuelve datos ponemos resp = "vacio"
                    if (data != "vacio") {

                        var aux = JSON.parse(data);
                        
                        //Vaciamos la tabla cada vez que entramos para que no se dupliquen los datos
                        //$('#tableContainer tbody').empty();
                        aux.forEach(function (valor, indice) {
                            //Cada objeto esta en String y lo pasmoa a TipoImpuesto
                            var resource = JSON.parse(valor);                            

                            $("#idEmpresa").val(resource.col8);
                            $("#nombreEmpresa").val(resource.col10);
                            $("#tratamientoEmpresa").val(resource.col11);
                            $("#nombreContacto").val(resource.col10);
                            $("#Apellido").val(resource.col11);

                            

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
            });
        }
        ;
    };


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
        <div class="form-group col-xs-3">
                                    <label for="nombre_empresa">Id Empresa</label>
                                    <input type="text" class="form-control" id="idEmpresa" name="idEmpresa"> 
                                </div>  
    </body>
</html>
