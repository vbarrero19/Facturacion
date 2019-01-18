
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
            var userLang = navigator.language || navigator.userLanguage;

            $("#consultarFac").click(function () {

                if (window.XMLHttpRequest) //mozilla
                {
                    ajax = new XMLHttpRequest(); //No Internet explorer
                } else
                {
                    ajax = new ActiveXObject("Microsoft.XMLHTTP");
                }

                var myObj = {};
//              
                myObj["id_cliente"] = $("#id_cliente").val().trim();

//              
                var json = JSON.stringify(myObj);

                $.ajax({
                    type: 'POST',
                    url: '/Facturacion/facturasController/getFacturas.htm',
                    data: json,
                    datatype: "json",
                    contentType: "application/json",
                    success: function (data) {

                        var aux = JSON.parse(data);
                        
                        var cantidad = 0;
                        var subtotal = 0;

                        //Vaciamos la tabla cada vez que entramos para que no se dupliquen los datos
                        $('#tableContainer tbody').empty();
                        aux.forEach(function (valor, indice) {
                            //Cada objeto esta en String y lo pasmoa a TipoImpuesto
                            var item = JSON.parse(valor);

                            $("#nombre_empresa").val(item.nombre_empresa);
                            $("#dir_fisica").val(item.dir_fisica);
                            $("#pais").val(item.pais);
                            subtotal = parseInt(item.cantidad);
                            cantidad = cantidad + subtotal;
                            //cargamos de forma dinamica la tabla
                            $('#tableContainer tbody').append(" <tr>\n\
                                                                    <th scope=\"row\">" + (indice + 1) + "</th>              \n\
                                                                    <td>" + item.id_cargo + "</td>                       \n\
                                                                    <td>" + item.cargo + "</td>                        \n\
                                                                    <td>" + item.cantidad + "</td>                       \n\ \n\
                                                                </tr>");


                        });
                        $("#subtotal").val(cantidad);
                        $("#impuesto").val(cantidad*0.21);
                        $("#total").val(cantidad*1.21);
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        console.log(xhr.status);
                        console.log(xhr.responseText);
                        console.log(thrownError);
                    }
                });
            })
        });
        ;


    </script>
    <body>
        <div class="container">
            <div class="col-xs-12">
                <div class="col-md-8">
                    <div class="form-area">  
                        <form role="form">
                            <br style="clear:both">
                            <h3 style="margin-bottom: 25px; text-align: center;">Facturas</h3>

                            <div class="col-xs-12">

                                <div class="col-xs-6 form-group">
                                    <label for="id_cliente">Identificador de cliente</label>
                                    <input type="text" class="form-control" id="id_cliente" name="id_cliente" placeholder="Identificador cliente" required>
                                </div> 

                                <button type="button" id="consultarFac" name="submit" class="btn btn-primary pull-right">Consultar Factura</button>
                            </div>

                            <br style="clear:both">
                            <hr>


                            <div class="col-xs-12" id="datos">

                                <div class="form-group col-xs-4">
                                    <label for="nombre_empresa">Nombre de empresa</label>
                                    <input type="text" class="form-control" id="nombre_empresa" name="nombre_empresa" placeholder="Identificador cargo" required>
                                </div>                            
                                <div class="form-group col-xs-4">
                                    <label for="dir_fisica">Dirección de empresa</label>
                                    <input type="text" class="form-control" id="dir_fisica" name="dir_fisica" placeholder="Identificador items" required>
                                </div>
                                <div class="form-group col-xs-4">
                                    <label for="pais">Pais de empresa</label>
                                    <input type="text" class="form-control" id="pais" name="pais" placeholder="Identificador factura" required>
                                </div>

                            </div>

                            <br style="clear:both">
                            <hr>

                            <div class="col-xs-12" id="tableContainer">
                                <table class="table table-striped">
                                    <thead class="thead-dark">
                                        <tr>
                                            <th scope="col">#</th>
                                            <th scope="col">Id_cargo</th>
                                            <th scope="col">Cargo</th> 
                                            <th scope="col">Importe</th> 
                                        </tr>
                                    </thead>
                                    <tbody>

                                    </tbody>
                                </table>

                            </div>

                            <br style="clear:both">
                            <hr>

                            <div class="col-xs-6"></div>

                            <div class="col-xs-6">

                                <div class="form-group">
                                    <div class="col-xs-3">
                                        <label>Subtotal:</label>
                                    </div>
                                    <div class="col-xs-5">
                                        <input type="text" class="form-control derecha" id="subtotal" name="subtotal" disabled="true">
                                    </div>
                                </div>           
                                <br style="clear:both">
                                <div class="form-group">
                                    <div class="col-xs-3">
                                        <label>Impuesto:</label>
                                    </div>
                                    <div class="col-xs-5">
                                        <input type="text" class="form-control derecha" id="impuesto" name="impuesto" disabled="true">
                                    </div>
                                </div>       
                                <br style="clear:both">
                                <div class="form-group">
                                    <div class="col-xs-3">
                                        <label>Total:</label>
                                    </div>
                                    <div class="col-xs-5">
                                        <input type="text" class="form-control derecha" id="total" name="total" disabled="true">
                                    </div>
                                </div>       

                            </div>

                            <br style="clear:both">
                            <hr>

                            <a href="<c:url value='/MenuController/start.htm'/>" class="btn btn-info" role="button">Menu principal</a>   
                            <button type="button" class="btn btn-primary">Primary</button> 

                        </form>
                    </div>
                </div>
            </div>
        </div>                  
    </body>
</html>
