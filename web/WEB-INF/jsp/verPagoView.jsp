<%-- 
    Document   : verDireccionView
    Created on : 15-feb-2019, 13:19:19
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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>MODIFICAR PAGO</title>
    </head>

    <script>

        $(document).ready(function () {

            cargarPago();

            var userLang = navigator.language || navigator.userLanguage;

            //al hacer clic en el boton para mostrar la ventana emergente


        });



        function cargarPago() {
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
                url: '/Facturacion/verPagoController/verPago.htm',
                success: function (data) {

                    //Recogemos los datos del combo y los pasamos a objetos TipoImpuesto  
                    var aux = JSON.parse(data);

                    //Vamos cargando la tabla
                    aux.forEach(function (valor, indice) {
                        //Cada objeto esta en String y lo pasmoa a  href='/Facturacion/pagoController/eliminarPago.htm?idEnt=" + EntidadPago.id_entidad + "&distinctCode=" + EntidadPago.id_metodo_pago + "' 
                        //En el boton de eliminar recogemos los parametros id_entidad y id_metodo_pago que recogemos de la tabla y tambien guaradmos el indice para seleccionar la fila que eiliminamos
                        var EntidadPago = JSON.parse(valor);

                        $('#tableContainer tbody').append(" <tr>\n\
                                                                <th scope=\"row\">" + (indice + 1) + "</th>     \n\
                                                                    <td>" + EntidadPago.nombre_entidad + "</td>         \n\
                                                                    <td>" + EntidadPago.titular_cuenta + "</td>         \n\
                                                                    <td>" + EntidadPago.nombre_banco + "</td>         \n\
\n\
                                                                    <td><a href='/Facturacion/pagoController/startPago.htm?idEnt=" + EntidadPago.id_entidad + "&distinctCode=" + EntidadPago.id_metodo_pago + "' class='btn btn-primary miBoton '> Modificar </button>\n\
                                                                    <td><a class='btn btn-danger miBoton' data-idEntidad='" + EntidadPago.id_entidad + "' data-idPago='" + EntidadPago.id_metodo_pago + "' data-idIndice='" + indice + "'> Eliminar </button>\n\ \n\
</tr>");
                    });
                    /*Creamos la funcion que al hacer click en el boton eliminar nos muestre el modal, identificamos el boton con el nombre miBoton*/
                    $(document).ready(function () {
                        $(".miBoton").click(function () {
                            /*Guardamos los valores que recogemos de los parametros declarados en el boton(arriba) y lo recogemos con .val($this...) 
                             * en los campos ocultos que nos hemos declarado en el html para que al pinchar en el boton no se pierdan los datos.*/
                            $("#idEntidadHide").val($(this).attr("data-idEntidad"));
                            $("#idPagoHide").val($(this).attr("data-idPago"));
                            $("#idFilaHide").val($(this).attr("data-idIndice"));
                            /*Una vez guardados los datos en los campos ocultos, mostramos el modal con los datos*/
                            $("#myModal").modal();
                        });
                    });

                },
                error: function (xhr, ajaxOptions, thrownError) {
                    console.log(xhr.status);
                    console.log(xhr.responseText);
                    console.log(thrownError);
                }
            });

        }
        function eliminarEntidad() {
            if (window.XMLHttpRequest) //mozilla
            {
                ajax = new XMLHttpRequest(); //No Internet explorer
            } else
            {
                ajax = new ActiveXObject("Microsoft.XMLHTTP");
            }

            var myObj = {};
            myObj["col1"] = $("#idEntidadHide").val().trim();
            myObj["col2"] = $("#idPagoHide").val().trim();

            var json = JSON.stringify(myObj);
            $.ajax({
                //Usamos GET ya que recibimos.
                type: 'POST',
                url: '/Facturacion/pagoController/eliminarPago.htm',
                data: json,
                datatype: "json",
                contentType: "application/json",
                success: function (data) {
                    $("#tbody-tabla-entidades").children().eq($("#idFilaHide").val()).hide();
                    alert("Ocultada la fila correctamente");
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    console.log(xhr.status);
                    console.log(xhr.responseText);
                    console.log(thrownError);
                }
            });

        }

        //funcion ventana emergente
        function eliminar(idElim) {

            $("#eliminar").text("Eliminar metodo de pago");
        }
        ;


    </script>
    <body>
        <div class="container col-xs-12">
            <div class="col-xs-12">                               
                <div class="col-xs-12 col-md-offset-2 col-md-8 col-lg-offset-3 col-lg-6">
                    <div class="form-area">  
                        <form role="form">
                            <br style="clear:both">
                            <h3 style="margin-bottom: 25px; text-align: center;">LISTA FORMAS DE PAGO</h3>
                            <div>
                                <div class="col-xs-12" id="tableContainer">
                                    <table class="table table-striped">                                    

                                        <thead class="thead-dark">
                                            <tr>
                                                <th scope="col">#</th>
                                                <th scope="col">Nombre entidad</th>
                                                <th scope="col">Titular cuenta</th>
                                                <th scope="col">Nombre banco</th>
                                            </tr>                                            
                                        </thead>

                                        <tbody id="tbody-tabla-entidades">

                                        </tbody>
                                    </table>
                                </div>    
                                <div>
                                    <a href="<c:url value='/MenuController/start.htm'/>" class="btn btn-info" role="button">Menu principal</a> 
                                </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>    

        <!-- ventana emergente -->

        <div class="modal fade" id="myModal" role="dialog">
            <!-- Declaramos los campos ocultos para en la funcion de ajax podamos guardar los datos -->
            <input class="hidden" id="idEntidadHide"/>
            <input class="hidden" id="idPagoHide"/>
            <input class="hidden" id="idFilaHide"/>
            <div class="modal-dialog">

                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Eliminar forma de pago</h4>
                    </div>
                    <div class="modal-body">
                        <p id="eliminar"></p>
                    </div>
                    <div class="modal-footer">
                        <!-- Llamamos a la funcion eliminarEntidad al pusar en si, al pulsar en no, no hacemos nada y volvemos a la pagina donde mostramos la lista-->
                        <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="eliminarEntidad()">Si</button>
                        <button type="button" class="btn btn-danger" data-dismiss="modal">No</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>


