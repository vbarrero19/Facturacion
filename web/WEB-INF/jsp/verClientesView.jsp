
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="jstl" uri="http://java.sun.com/jstl/core_rt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
    <%@ include file="infouser.jsp" %>
    <head> 
        <title>CLIENTES</title> 
    </head>
    <script>
        $(document).ready(function () {
            getFiscal();
            getEmpresa();

            $("#home-tab").click();

            //Al cambiar la opcion del radio direc(igual direccion fisica y fiscal)
            //activamos la funcion que repite el texto en los dos campos de texto
            $('input[name=direc]').change(function () {//          

                if ($("#direc2").is(':checked')) {
                    //CUANDO ACTIVAMOS EL BOTON DEL SI
                    $("#dir_fisica").keyup(function () {
                        document.getElementById('dir_fiscal').value = this.value;
                    });
                    //DESHABILITAMOS EL CAJON2 DE LA DIRECCION FISCAL
                    $("#dir_fiscal").prop('disabled', true);

                } else {
                    // CUANDO CLICKAMOS EN EL BOTON DEL NO
                    $("#dir_fiscal").prop('disabled', false);
                    $('#dir_fiscal').val('');
                }
            })


            // LA FUNCION QUE AL HACER CLICK, NOS EJECUTA TODO.
            $("#submit").click(function () {

                if (window.XMLHttpRequest) //mozilla
                {
                    ajax = new XMLHttpRequest(); //No Internet explorer
                } else
                {
                    ajax = new ActiveXObject("Microsoft.XMLHTTP");
                }

                var myObj = {};
                //id cliente 
                myObj["id_cliente"] = $("#id_cliente").val().trim();

                var json = JSON.stringify(myObj);
                $.ajax({
                    type: 'POST',
                    url: '/Facturacion/clientesController/newCustomer.htm',
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
            
            
            /* VAMOS COMPLETANDO LA TABLA CON LOS DATOS DE LOS CLIENTES PARA QUE SE VISUALICEN TODOS.  */
            $("#consultarFac").click(function () {

                if (window.XMLHttpRequest) //mozilla
                {
                    ajax = new XMLHttpRequest(); //No Internet explorer
                } else
                {
                    ajax = new ActiveXObject("Microsoft.XMLHTTP");
                }

                var myObj = {};

                myObj["id_cliente"] = $("#comboClientes").val().trim();
 
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

                            $("#id_cliente").val(item.id_cliente);
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
                        $("#impuesto21").val(cantidad * 0.21);
                        $("#total").val(cantidad * 1.21);
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        console.log(xhr.status);
                        console.log(xhr.responseText);
                        console.log(thrownError);
                    }
                });
            })
        });



    </script>
    <body>
        <div class="container">
            <div class="col-xs-12">                               
                <div class="col-xs-12 col-md-offset-2 col-md-8 col-lg-offset-3 col-lg-6">
                    <div class="form-area">  
                        <form role="form">
                            <br style="clear:both">
                            <h3 style="margin-bottom: 25px; text-align: center;">FORMULARIO PARA CLIENTES</h3>

                            <!--EL ID DE CLIENTE TENEMOS QUE CAMBIARLO Y PONERLO SERIAL EN LA BASE DE DATOS PARA QUE SE AUTOINCREMENTE SOLO -->
                            <div class="form-group">
                                <input type="text" class="form-control" id="id_cliente" name="id_cliente" placeholder="Identificador cliente" required>
                            </div> 
                            
                            <!--CREAMOS TABLA DONDE VISUALIZAREMOS LA LISTA DE LOS CLIENTES -->                            
                            
                            <div class="col-xs-12" id="tableContainer">
                                <table class="table table-striped">
                                    <thead class="thead-dark">
                                        <tr>
                                            <th scope="col">#</th>
                                            <th scope="col">Nombre</th>
                                            <th scope="col">Id fiscal</th> 
                                            <th scope="col">País</th> 
                                        </tr>
                                    </thead>
                                    <tbody>

                                    </tbody>
                                </table>
                            </div>                            
                             <a href="<c:url value='/MenuController/start.htm'/>" class="btn btn-info" role="button">Menu principal</a> 
                        </form>
                    </div>
                </div>
            </div>
        </div>                  
    </body>
</html>
