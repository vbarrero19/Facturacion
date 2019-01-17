
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="jstl" uri="http://java.sun.com/jstl/core_rt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
    <%@ include file="infouser.jsp" %>
    <head> 
        <title>FACTURAS GENERAR VIEW</title> 
    </head>
    <script>
        $(document).ready(function () {
            var userLang = navigator.language || navigator.userLanguage;
            //*************************************//
            //ejecutarlo dentro del ready porque se ejecuta cada vez que entramos en la pagina.
            //constructor para el calendario. uno por cada calendario.
            $('#fecha_cargo').datetimepicker({
                format: 'YYYY-MM-DD',
                locale: userLang.valueOf(),
                daysOfWeekDisabled: [0, 6],
                useCurrent: false//Important! See issue #1075
                        //defaultDate: '08:32:33',
                        //                });
            });
            $('#fecha_vencimiento').datetimepicker({
                format: 'YYYY-MM-DD',
                locale: userLang.valueOf(),
                daysOfWeekDisabled: [0, 6],
                useCurrent: false//Important! See issue #1075
                        //defaultDate: '08:32:33',
                        //                });
            });
            $("#submit").click(function () {

                if (window.XMLHttpRequest) //mozilla
                {
                    ajax = new XMLHttpRequest(); //No Internet explorer
                } else
                {
                    ajax = new ActiveXObject("Microsoft.XMLHTTP");
                }

                var myObj = {};
//                myObj["id_cargo"] = $("#id_cargo").val().trim();
//                myObj["id_items"] = $("#id_items").val().trim();
//                myObj["id_factura"] = $("#id_factura").val().trim();
                myObj["id_cliente"] = $("#id_cliente").val().trim();
//                myObj["cantidad"] = $("#cantidad").val().trim();
//                myObj["impuesto"] = $("#impuesto").val().trim();
//                myObj["cargo"] = $("#cargo").val().trim();
//                
//                //dentro de fecha cargo tenemos que coger el valor que hay dentro de input.
//                myObj["fecha_cargo"] = $("#fecha_cargo input").val().trim();
//                myObj["fecha_vencimiento"] = $("#fecha_vencimiento input").val().trim();



                var json = JSON.stringify(myObj);
                $.ajax({
                    type: 'POST',
                    url: '/Facturacion/facturasController/getFacturas.htm',
                    data: json,
                    datatype: "json",
                    contentType: "application/json",
                    success: function (data) {

                        /*
                         *   <div class="col-xs-12" id="tableContainer">
                         <table class="table table-striped">
                         <thead class="thead-dark">
                         <tr>
                         <th scope="col">#</th>
                         <th scope="col">id_cargo</th>
                         <th scope="col">cargo</th> 
                         </tr>
                         </thead>
                         <tbody>
                         <tr>
                         <th scope="row">1</th>
                         <td>Mark</td>
                         <td>Otto</td>
                         <td>@mdo</td>
                         </tr>
                         </tbody>
                         </table> 
                         </div>
                         
                         * @type Array|Object
                         * 
                         * 
                         */
                        var aux = JSON.parse(data);
                        //Identificamos el combo
                        select = document.getElementById('id_cargo');
                        //Lo vamos cargando

                        //Vaciamos la tabla cada vez que entramos para que no se dupliquen los datos
                        $('#tableContainer tbody').empty();
                        aux.forEach(function (valor, indice) {
                            //Cada objeto esta en String y lo pasmoa a TipoImpuesto
                            var item = JSON.parse(valor);
                            //cargamos de forma dinamica la tabla
                            $('#tableContainer tbody').append(" <tr>\n\
                                                                    <th scope=\"row\">" + (indice + 1) + "</th>              \n\
                                                                    <td>" + item.id_cargo + "</td>                       \n\
                                                                    <td>" + item.cargo + "</td>                       \n\ \n\
                                                                </tr>");
                            /* $('#id_cargo ').val(aux2.id_cargo);
                             $('#cargo').val(aux2.cargo);*/

                        });
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
        function getCargos() {
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
                url: '/Facturacion/facturasController/getFacturas.htm', //Vamos a itemsController/getImpuesto.htm a recoger los datos
                success: function (data) {

                    //Recogemos los datos del combo y los pasamos a objetos TipoImpuesto  
                    var aux = JSON.parse(data);
                    //Identificamos el combo
                    select = document.getElementById('id_cargo');
                    //Lo vamos cargando
                    aux.forEach(function (valor, indice) {
                        //Cada objeto esta en String y lo pasmoa a TipoImpuesto
                        var aux2 = JSON.parse(valor);
                        $('#id_cargo').text(aux2.id_cargo);
                        $('#cargo').text(aux2.cargo);
                        //Creamos las opciones del combo
                        //var opt = document.createElement('option');
                        //Guardamos el id en el value de cada opcion
                        //opt.value = aux2.id_Impuesto;
                        //Guardamos el impuesto en el nombre de cada opcion
                        //opt.innerHTML = aux2.id_impuesto;
                        //opt.innerHTML = aux2.impuesto;
                        //Añadimos la opcion
                        //select.appendChild(opt);
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
    <body>
        <div class="container">
            <div class="col-xs-12">
                <div class="col-md-5">
                    <div class="form-area">  
                        <form role="form">
                            <br style="clear:both">
                            <h3 style="margin-bottom: 25px; text-align: center;">Formulario para CARGOS</h3>




                            <div class="form-group">
                                <input type="text" class="form-control" id="id_cliente" name="id_cliente" placeholder="Identificador cliente" required>
                            </div>
                            <button type="button" id="submit" name="submit" class="btn btn-primary pull-right">Submit Form</button>


                            <div class="form-group">
                                <input type="text" class="form-control" id="id_cargo" name="id_cargo" placeholder="Identificador cargo" required>
                            </div>                            
                            <div class="form-group">
                                <input type="text" class="form-control" id="cargo" name="cargo" placeholder="Identificador items" required>
                            </div>
                            <div class="form-group">
                                <input type="text" class="form-control" id="id_factura" name="id_factura" placeholder="Identificador factura" required>
                            </div>

                            <div class="col-xs-12" id="tableContainer">
                                <table class="table table-striped">
                                    <thead class="thead-dark">
                                        <tr>
                                            <th scope="col">#</th>
                                            <th scope="col">id_cargo</th>
                                            <th scope="col">cargo</th> 
                                        </tr>
                                    </thead>
                                    <tbody>

                                    </tbody>
                                </table>

                            </div>


<!--                            <ul class="nav nav-tabs">
                                <li class="active"><a href="#">Inicio</a></li>
                                <li><a href="#">Perfil</a></li>
                                <li><a href="#">Mensajes</a></li>
                            </ul>                          -->

                            <a href="<c:url value='/MenuController/start.htm'/>" class="btn btn-info" role="button">Menu principal</a>   

                        </form>
                    </div>
                </div>
            </div>
        </div>                  
    </body>
</html>
