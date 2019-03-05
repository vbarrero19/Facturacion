
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="jstl" uri="http://java.sun.com/jstl/core_rt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html>
    <%@ include file="infouser.jsp" %>
    <head> 
        <style>
            .container {
                width: 1400px;
            }
            #tableContainer{
                overflow:scroll;
                overflow-x: hidden;
                height:400px;         
                margin-bottom: 25px;
            }

        </style>
        <title>VER ITEMS</title> 
    </head>
    <script>
        $(document).ready(function () {

            
            getCargarItems();            

            var userLang = navigator.language || navigator.userLanguage;

        });


        //CREAMOS LA FUNCION PARA CARGAR los items
        function getCargarItems() {
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
                url: '/Facturacion/verItemsController/verItems.htm',
                success: function (data) {

                    //Recogemos los datos del combo y los pasamos a objetos TipoImpuesto  
                    var aux = JSON.parse(data);
                    
                    //Vamos cargando la tabla
                    aux.forEach(function (valor, indice) {
                        //Cada objeto esta en String y lo pasmoa a 
                        var item = JSON.parse(valor);

                        $('#tableContainer tbody').append(" <tr>\n\
                                                                <th scope=\"row\">" + (indice + 1) + "</th>     \n\
                                                                    <td>" + item.id_item + "</td>         \n\
                                                                    <td>" + item.abreviatura + "</td>         \n\
                                                                    <td>" + item.descripcion + "</td>         \n\
                                                                    <td>" + item.id_tipo_item + "</td>       \n\
                                                                    <td>" + item.cuenta + "</td>       \n\
                                                                    <td>" + item.importe + "</td>       \n\
                                                                    <td class='hidden' id='idItem" + indice + "'>" + item.id_item + "</td>         \n\
                                                                    <td><a class='btn btn-danger miBoton' data-idEntidad='" + item.id_item +  "' data-idIndice='" + indice + "'> Eliminar </button>\n\ \n\
\n\
                                            </tr>");
        
        
                                                                      
                                                            
<%--                                                                 <td class='hidden' id='nombreEnt" + indice + "'>" + entidad.nombre_entidad + "</td>         \n\
                                                                    <td><a href='/Facturacion/verEntidadesController/startEntidad.htm?idEnt=" + entidad.id_entidad + "&distinctCode=" + entidad.distinct_code + "' class='btn btn-primary'> Modificar </button>\n\ \n\
                                                                    <td><a class='btn btn-danger miBoton' data-idEntidad='" + entidad.id_entidad +  "' data-idIndice='" + indice + "'> Eliminar </button>\n\ \n\
--%>                        
                    
                    });
                          /*Creamos la funcion que al hacer click en el boton eliminar nos muestre el modal, identificamos el boton con el nombre miBoton*/
                    $(document).ready(function () {
                        $(".miBoton").click(function () {                            
                            
                            /*Guardamos los valores que recogemos de los parametros declarados en el boton(arriba) y lo recogemos con .val($this...) 
                             * en los campos ocultos que nos hemos declarado en el html para que al pinchar en el boton no se pierdan los datos.*/
                            $("#idEntidadHide").val($(this).attr("data-idEntidad"));
                            $("#idFilaHide").val($(this).attr("data-idIndice"));
                            
                            /*Mostramos el texto de la desripcion del body de la ventana emergente*/
                            $("#eliminar").text($("#nombreEnt"+ $(this).attr("data-idindice")).text());

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
    </script>


    <body>
        <div class="container">
            <div class="col-xs-12">
                <div class="col-md-12 col-xs-5">
                    <div class="form-area">  
                        <form role="form">
                            <br style="clear:both">
                            <h3 style="margin-bottom: 25px; text-align: center;">VER ITEMS EDITAR</h3>  


                                <div class="col-xs-12" id="tableContainer">
                                    <table class="table table-striped">                                    

                                        <thead class="thead-dark">
                                            <tr>
                                                <th scope="col">#</th>
                                                <th scope="col">Id Item</th>
                                                <th scope="col">Abreviatura</th>
                                                <th scope="col">Descripción</th>
                                                <th scope="col">Tipo</th>
                                                <th scope="col">Cuenta</th>
                                                <th scope="col">Importe</th>                                                
                                                <th scope="col">Modificar</th>
                                                <th scope="col">Borrar</th>
                                            </tr>                                            
                                        </thead>

                                        <tbody id="tbody-tabla-cargos">

                                        </tbody>
                                    </table>
                                </div>    

                                <button type="button" id="submit" name="submit" class="btn btn-primary pull-right">Submit</button>
                                <a href="<c:url value='/MenuController/start.htm'/>" class="btn btn-info" role="button">Menu principal</a> 

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

            <!-- ventana emergente Eliminar-->
            <div class="modal fade" id="myModalEliminar" role="dialog">
                <!-- Declaramos los campos ocultos para en la funcion de ajax podamos guardar los datos -->
                <input class="hidden" id="idCargoHide"/>
                <input class="hidden" id="idItemHide"/>
                <input class="hidden" id="idFilaHide"/>

                <div class="modal-dialog">

                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">Eliminar cargo</h4>
                        </div>
                        <div class="modal-body">
                            <p id="eliminar"></p>                            
                        </div>
                        <div class="modal-footer">
                            <!-- Llamamos a la funcion eliminarEntidad al pusar en si, al pulsar en no, no hacemos nada y volvemos a la pagina donde mostramos la lista-->
                            <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="eliminarCargo()">Si</button>
                            <button type="button" class="btn btn-danger" data-dismiss="modal">No</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body> 
</html>



