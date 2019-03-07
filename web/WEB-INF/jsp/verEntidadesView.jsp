<%-- 
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
        <title>MODIFICAR ENTIDADES</title> 
    </head>
    <script>
        $(document).ready(function () {

            cargarEntidades();

            var userLang = navigator.language || navigator.userLanguage;

        });


        function cargarEntidades() {
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
                url: '/Facturacion/verEntidadesController/verEntidades.htm',
                success: function (data) {

                    //Recogemos los datos del combo y los pasamos a objetos TipoImpuesto  
                    var aux = JSON.parse(data);

                    //Vamos cargando la tabla
                    aux.forEach(function (valor, indice) {
                        //Cada objeto esta en String y lo pasmoa a 
                        var entidad = JSON.parse(valor);

                        $('#tableContainer tbody').append(" <tr>\n\
                                                                <th scope=\"row\">" + (indice + 1) + "</th>     \n\
                                                                    <td>" + entidad.id_entidad + "</td>         \n\
                                                                    <td>" + entidad.distinct_code + "</td>         \n\
                                                                    <td>" + entidad.nombre_entidad + "</td>         \n\
                                                                    <td>" + entidad.nombre_contacto + "</td>\n\
                                                                    <td class='hidden' id='nombreEnt" + indice + "'>" + entidad.nombre_entidad + "</td>         \n\
                                                                    <td><a href='/Facturacion/verEntidadesController/startEntidad.htm?idEnt=" + entidad.id_entidad + "&distinctCode=" + entidad.distinct_code + "' class='btn btn-primary'> Modificar </button>\n\ \n\
                                                                    <td><a class='btn btn-danger miBoton' data-idEntidad='" + entidad.id_entidad + "' data-idIndice='" + indice + "'> Eliminar </button>\n\ \n\
                        </tr>");
                    });
                    /*Creamos la funcion que al hacer click en el boton eliminar nos muestre el modal, identificamos el boton con el nombre miBoton*/
                    $(document).ready(function () {
                        $(".miBoton").click(function () {


                            /*Guardamos los valores que recogemos de los parametros declarados en el boton(arriba) y lo recogemos con .val($this...) 
                             * en los campos ocultos que nos hemos declarado en el html para que al pinchar en el boton no se pierdan los datos.*/
                            $("#idEntidadHide").val($(this).attr("data-idEntidad"));
                            $("#idFilaHide").val($(this).attr("data-idIndice"));

                            /*Mostramos el texto de la desripcion del body de la ventana emergente*/
                            $("#eliminar").text($("#nombreEnt" + $(this).attr("data-idindice")).text());

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
        ;



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

            var json = JSON.stringify(myObj);
            $.ajax({
                //Usamos GET ya que recibimos.
                type: 'POST',
                url: '/Facturacion/entidadesController/eliminarEntidad.htm',
                data: json,
                datatype: "json",
                contentType: "application/json",
                success: function (data) {
                    $("#tbody-tabla-entidades").children().eq($("#idFilaHide").val()).hide();
                    alert("ENTIDAD ELIMINADA CORRECTAMETNE");
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

            $("#eliminar").text("Eliminar entidad");
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
                            <h3 style="margin-bottom: 25px; text-align: center;">LISTA DE ENTIDADES</h3>
                            <div>
                                <div class="col-xs-12" id="tableContainer">
                                    <table class="table table-striped">                                    

                                        <thead class="thead-dark">
                                            <tr>
                                                <th scope="col">#</th>
                                                <th scope="col">Id entidad</th>
                                                <th scope="col">Distinct Code</th>
                                                <th scope="col">Nombre Entidad</th>
                                                <th scope="col">Nombre Contacto</th>
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
            <!-- ventana emergente -->

            <div class="modal fade" id="myModal" role="dialog">
                <!-- Declaramos los campos ocultos para en la funcion de ajax podamos guardar los datos -->
                <input class="hidden" id="idEntidadHide"/>
                <input class="hidden" id="idFilaHide"/>
                <div class="modal-dialog">

                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">Eliminar entidad</h4>
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



