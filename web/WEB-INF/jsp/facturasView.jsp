
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
            //al cargar la pagina llamamos a la funcion getCliente() para llenar el combo 
            getCliente();
            
            var userLang = navigator.language || navigator.userLanguage;

            //Al pulsar el boton de consultar facturas recogemos los datos del cliente y (sus cargos sin numero de factura) -> Esto ultimo falta por hacer
            $("#consultarFac").click(function () {

                if (window.XMLHttpRequest) //mozilla
                {
                    ajax = new XMLHttpRequest(); //No Internet explorer
                } else
                {
                    ajax = new ActiveXObject("Microsoft.XMLHTTP");
                }

                var myObj = {};

                myObj["id_entidad"] = $("#comboClientes").val().trim();
 
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
                                                                    <td>" + item.id_adeudo + "</td>                       \n\
                                                                    <td>" + item.adeudo + "</td>                        \n\
                                                                    <td>" + item.cantidad + "</td>                       \n\
                                                                    <td>" + "<button value='actualizar' tittle='actualizar' id='btnedit' >Prueba</button>" + "</td>                       \n\ \n\
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

        //Funcion para llenar el combo de cliente. Los datos nos vienen en un ArrayList de objetos TipoImpuesto transformado en String
        //con json. Los datos se obtienen en itemsController/getImpuesto.htm.
        function getCliente() {
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

    </script>
    
    
    <!--
<td><button value="actualizar" tittle="actualizar" id="btnedit" class="btn btn-primary btn-edit"><i class="fas fa-edit"></i></i></button> </td>\n\
<td><button value="eliminar" tittle="eliminar" class="btn btn-danger btn-delete"><i class="fas fa-window-close"></i></button> </td>\n\\n\-->
    
    
    
    <body>
        <div class="container">
            <div class="col-xs-12">
                <div class="col-md-8">
                    <div class="form-area">  
                        <form role="form">
                            <br style="clear:both">
                            <h3 style="margin-bottom: 25px; text-align: center;">Facturas</h3>

<!--                            <div class="form-group-combo">
                                Combo para tipo de impuestos
                                <select class="form-control" id="comboClientes" name="comboClientes">
                                </select>                                                            
                            </div>-->

                            <div class="col-xs-12">

<!--                        <div class="col-xs-6 form-group">
                                <label for="id_cliente">Identificador de cliente</label>
                                <input type="text" class="form-control" id="id_cliente" name="id_cliente" placeholder="Identificador cliente" required>
                            </div> -->
                            <div class="col-xs-6 form-group">
                                <label for="comboClientes">Nombre de cliente</label>
                                <div class="form-group-combo">
                                    <!--Combo para clientes-->
                                    <select class="form-control" id="comboClientes" name="comboClientes">
                                    </select>                                                            
                                </div>
                            </div>
                                <button type="button" id="consultarFac" name="consultarFac" class="btn btn-primary pull-right">Consultar datos</button>
                            </div>

                            <br style="clear:both">
                            <hr>


                            <div class="col-xs-12" id="datos">

                                <div class="form-group col-xs-4">
                                    <label for="nombre_empresa">Identificador Cliente</label>
                                    <input type="text" class="form-control" id="id_cliente" name="id_cliente">
                                </div>                            
                                <div class="form-group col-xs-4">
                                    <label for="dir_fisica">Dirección de empresa</label>
                                    <input type="text" class="form-control" id="dir_fisica" name="dir_fisica">
                                </div>
                                <div class="form-group col-xs-4">
                                    <label for="pais">Pais de empresa</label>
                                    <input type="text" class="form-control" id="pais" name="pais">
                                </div>

                            </div>

                            <br style="clear:both">
                            <hr>

                            <div class="col-xs-12" id="tableContainer">
                                <table class="table table-striped">
                                    <thead class="thead-dark">
                                        <tr>
                                            <th scope="col">#</th>
                                            <th scope="col">Id_adeudo</th>
                                            <th scope="col">Adeudo</th> 
                                            <th scope="col">Importe</th> 
                                            <th scope="col">Enlace</th> 
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
                                        <input type="text" class="form-control" id="subtotal" name="subtotal" disabled="true">
                                    </div>
                                </div>           
                                <br style="clear:both">
                                <div class="form-group">
                                    <div class="col-xs-3">
                                        <label>Impuesto:</label>
                                    </div>
                                    <div class="col-xs-5">
                                        <input type="text" class="form-control" id="impuesto21" name="impuesto21" disabled="true">
                                    </div>
                                </div>       
                                <br style="clear:both">
                                <div class="form-group">
                                    <div class="col-xs-3">
                                        <label>Total:</label>
                                    </div>
                                    <div class="col-xs-5">
                                        <input type="text" class="form-control" id="total" name="total" disabled="true">
                                    </div>
                                </div>  
                            </div>

                            <br style="clear:both">
                            <hr>
                            <div id="datos" class="col-xs-12">
                            <a href="<c:url value='/MenuController/start.htm'/>" class="btn btn-info" role="button">Menu principal</a>   
                            <button type="button" id="generarFact" class="btn btn-primary">Generar factura</button> 
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>                  
    </body>
</html>
