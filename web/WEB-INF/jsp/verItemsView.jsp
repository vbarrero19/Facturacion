
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="jstl" uri="http://java.sun.com/jstl/core_rt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html>
    <%@ include file="infouser.jsp" %>
    <head> 
        <style>
            .container {
                width: 1500px;
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
                    //alert(data);
                    //Recogemos los datos del combo y los pasamos a objetos TipoImpuesto  
                    var aux = JSON.parse(data);
                    
                   
                    //Vamos cargando la tabla
                    aux.forEach(function (valor, indice) {
                        //Cada objeto esta en String y lo pasmoa a 
                        var item = JSON.parse(valor);
                        if (item.costes == "No") {
                            $('#tableContainer tbody').append(" <tr>\n\
                                    <th scope=\"row\">" + (indice + 1) + "</th>     \n\
                                    <td id='id" + indice + "'>" + item.id_item + "</td>         \n\
                                    <td id='ab" + indice + "'>" + item.abreviatura + "</td>         \n\
                                    <td>" + item.descripcion + "</td>         \n\
                                    <td>" + item.id_tipo_item + "</td>       \n\
                                    <td>" + item.id_cuenta + "</td>       \n\
                                    <td>" + item.importe + "</td>       \n\
                                    <td>" + item.costes + "</td>       \n\
                                    <td><a href='/Facturacion/itemsController/start.htm' class='btn btn-success' role='button'>\n\
                                        <span class='glyphicon glyphicon-plus'></span>&nbsp;&nbsp;Añadir</a></td>\n\
                                    <td><a href='/Facturacion/modificarItemsController/start.htm?idItem=" + item.id_item + "' class='btn btn-warning' role='button'>\n\
                                        <span class='glyphicon glyphicon-edit'></span>&nbsp;&nbsp;Modificar</a></td>\n\
                                    <td><button type='button' class='btn miBotonEliminar btn-danger'  data-idItem='" + item.id_item + "' data-idTipo='" + item.abreviatura +
                                        "' data-idIndice='" + indice + "'><span class='glyphicon glyphicon-remove'></span>&nbsp;&nbsp;Archivar</button></td>\n\    \n\
                                    </tr>");
                        } else {
                            $('#tableContainer tbody').append(" <tr>\n\
                                    <th scope=\"row\">" + (indice + 1) + "</th>     \n\
                                    <td id='id" + indice + "'>" + item.id_item + "</td>         \n\
                                    <td id='ab" + indice + "'>" + item.abreviatura + "</td>         \n\
                                    <td>" + item.descripcion + "</td>         \n\
                                    <td>" + item.id_tipo_item + "</td>       \n\
                                    <td>" + item.id_cuenta + "</td>       \n\
                                    <td>" + item.importe + "</td>       \n\
                                                                 \n\<td><button type='button' class='btn miBotonCostes btn-info'  data-idItem='" + item.id_item + "' data-idTipo='" + item.abreviatura +
                                                                         "' data-idIndice='" + indice + "'><span class='glyphicon glyphicon-info-sign'></span>&nbsp;&nbsp;Si</button></td>\n\    \n\
                                                                 \n\<td><a href='/Facturacion/itemsController/start.htm' class='btn btn-success' role='button'>\n\
                                                                           <span class='glyphicon glyphicon-plus'></span>&nbsp;&nbsp;Añadir</a></td>\n\
                                                                 \n\<td><a href='/Facturacion/modificarItemsController/start.htm?idItem=" + item.id_item + "' class='btn btn-warning' role='button'>\n\
                                                                           <span class='glyphicon glyphicon-edit'></span>&nbsp;&nbsp;Modificar</a></td>\n\
                                                                    <td><button type='button' class='btn miBotonEliminar btn-danger'  data-idItem='" + item.id_item + "' data-idTipo='" + item.abreviatura +
                                                                         "' data-idIndice='" + indice + "'><span class='glyphicon glyphicon-remove'></span>&nbsp;&nbsp;Archivar</button></td>\n\    \n\
                                                                </tr>");
                        }
                    });
                    
                    /*Creamos la funcion que al hacer click en el boton eliminar nos muestre el modal, identificamos el boton con el nombre miBoton*/
                    $(document).ready(function () {

                        $(".miBotonCostes").click(function () {

                            /*Guardamos los valores que recogemos de los parametros declarados en el boton(arriba) y lo recogemos con .val($this...) 
                             * en los campos ocultos que nos hemos declarado en el html para que al pinchar en el boton no se pierdan los datos.*/
                            $("#idCostItemHide").val($(this).attr("data-idItem"));
                            $("#idCostTipoHide").val($(this).attr("data-idTipo"));
                            $("#idCostFilaHide").val($(this).attr("data-idIndice"));

                            $("#abreviaturaItem").text("Costes del item: " + $("#idCostTipoHide").val());
                            
                            idItem = $("#idCostItemHide").val();  

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
                                /*en la url le pasamos como parametro el identificador del item*/
                                url: '/Facturacion/verItemsController/verCostes.htm?idItem=' + idItem,
                                success: function (data) {

                                    //Recogemos los datos del combo y los pasamos a objetos TipoImpuesto  
                                    var aux = JSON.parse(data);
                                    $('#tbody-tabla-costes').empty();

                                    var table = $('#table table-striped').DataTable();
                                    aux.forEach(function (valor, indice) {
                                        //Cada objeto esta en String 
                                        var aux2 = JSON.parse(valor);
                                        
                                        $('#tbody-tabla-costes').append(" <tr>\n\   \n\
                                                                    <td id='id" + (indice + 1) + "'>" + aux2.col2 + "'</td>         \n\
                                                                    <td>" + aux2.col3 + "</td>\n\
                                                               </tr>");
                                    });

                                },
                                error: function (xhr, ajaxOptions, thrownError) {
                                    console.log(xhr.status);
                                    console.log(xhr.responseText);
                                    console.log(thrownError);
                                }
                            });

                            /*Una vez guardados los datos en los campos ocultos, mostramos el modal con los datos*/
                            $("#myModalCostes").modal();
                        })
                                ;

                        $(".miBotonAnadir").click(function () {

                            /*Guardamos los valores que recogemos de los parametros declarados en el boton(arriba) y lo recogemos con .val($this...) 
                             * en los campos ocultos que nos hemos declarado en el html para que al pinchar en el boton no se pierdan los datos.*/
                            $("#idElimItemHide").val($(this).attr("data-idItem"));
                            $("#idElimTipoHide").val($(this).attr("data-idTipo"));
                            $("#idElimFilaHide").val($(this).attr("data-idIndice"));


                            $("#eliminarItem").text("Desea eliminar el item: " + $("#idElimTipoHide").val());

                            /*Una vez guardados los datos en los campos ocultos, mostramos el modal con los datos*/
                            $("#myModalAnadir").modal();
                        })
                                ;

                        $(".miBotonEliminar").click(function () {

                            /*Guardamos los valores que recogemos de los parametros declarados en el boton(arriba) y lo recogemos con .val($this...) 
                             * en los campos ocultos que nos hemos declarado en el html para que al pinchar en el boton no se pierdan los datos.*/
                            $("#idElimItemHide").val($(this).attr("data-idItem"));
                            $("#idElimTipoHide").val($(this).attr("data-idTipo"));
                            $("#idElimFilaHide").val($(this).attr("data-idIndice"));


                            $("#eliminarItem").text("Desea eliminar el item: " + $("#idElimTipoHide").val());

                            /*Una vez guardados los datos en los campos ocultos, mostramos el modal con los datos*/
                            $("#myModalEliminar").modal();
                        })
                                ;

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
        
        function archivarItem() {
            if (window.XMLHttpRequest) //mozilla
            {
                ajax = new XMLHttpRequest(); //No Internet explorer
            } else
            {
                ajax = new ActiveXObject("Microsoft.XMLHTTP");
            }

            var myObj = {};

            myObj["col1"] = $("#idElimItemHide").val().trim();

            var json = JSON.stringify(myObj);
            $.ajax({
                //Usamos GET ya que recibimos.
                type: 'POST',
                url: '/Facturacion/verItemsController/archivarItem.htm',
                data: json,
                datatype: "json",
                contentType: "application/json",
                success: function (data) {
                    $("#tbody-tabla-items").children().eq($("#idElimFilaHide").val()).hide();
                    alert("ITEM ARCHIVADO CORRECTAMETNE");
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
                <div class="col-md-12 col-xs-5">

                    <!--<form role="form">-->
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
                                    <th scope="col">Costes</th>   
                                    <th scope="col">Añadir</th>
                                    <th scope="col">Modificar</th>
                                    <th scope="col">Archivar</th>
                                </tr>                                            
                            </thead>

                            <tbody id="tbody-tabla-items">

                            </tbody>
                        </table>
                    </div>    

                    <a href="/Facturacion/MenuController/start.htm" class="btn btn-info" role="button">Menu principal</a>                     
                    <button type="button" id="submit" name="submit" class="btn btn-primary">Disponible</button>

                    <!-- ventana emergente Costes-->
                    <div class="modal fade" id="myModalCostes" role="dialog">
                        <!-- Declaramos los campos ocultos para en la funcion de ajax podamos guardar los datos -->
                        <input class="hidden"  id="idCostItemHide"/>
                        <input class="hidden"  id="idCostTipoHide"/>
                        <input class="hidden"  id="idCostFilaHide"/>

                        <div class="modal-dialog">

                            <!-- Modal content-->
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                    <h4 class="modal-title">Ver desglose costes item</h4>
                                </div>
                                <div class="modal-body">
                                    <p id="abreviaturaItem"></p>       
                                    <table class="table table-striped">                                    

                                        <thead>                                            
                                            <tr>
                                                <th scope="col">Entidad</th>
                                                <th scope="col">Cantidad</th>                                    
                                            </tr>                                            
                                        </thead>

                                        <tbody id="tbody-tabla-costes">

                                        </tbody>
                                    </table>
                                </div>
                                <div class="modal-footer">

                                    <button type="button" class="btn btn-primary" data-dismiss="modal">Aceptar</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- ventana emergente Archivar-->
                    <div class="modal fade" id="myModalEliminar" role="dialog">
                        <!-- Declaramos los campos ocultos para en la funcion de ajax podamos guardar los datos -->
                        <input class="hidden" id="idElimItemHide"/>
                        <input class="hidden" id="idElimTipoHide"/>
                        <input class="hidden" id="idElimFilaHide"/>

                        <div class="modal-dialog">

                            <!-- Modal content-->
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                    <h4 class="modal-title">Archivar Item</h4>
                                </div>
                                <div class="modal-body">
                                    <p id="eliminarItem"></p>                            
                                </div>
                                <div class="modal-footer">
                                    <!-- Llamamos a la funcion eliminarEntidad al pusar en si, al pulsar en no, no hacemos nada y volvemos a la pagina donde mostramos la lista-->
                                    <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="archivarItem()">Si</button>
                                    <button type="button" class="btn btn-danger" data-dismiss="modal">No</button>
                                </div>
                            </div>
                        </div>
                    </div>


                </div>
            </div>
        </div>
    </body> 
</html>



