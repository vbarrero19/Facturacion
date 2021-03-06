<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="jstl" uri="http://java.sun.com/jstl/core_rt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>



<!DOCTYPE html>
<html>
    <%@ include file="infouser.jsp" %>
    <head> 
        <title>VER FACTURAS</title> 
        
    </head>
    <style>

        /*        #tableContainer{
                    overflow:scroll;
                    overflow-x: hidden;
                    height:400px;    
                    margin-bottom: 25px;            
                }*/

    </style>
    <script>
        $(document).ready(function () {

            $('#example').DataTable({
                "scrollY": "400px",
                "scrollCollapse": true,
                "paging": false,
                "ordering": false,
                'info': false,
                'searching': false,
            });

            //Al cargar la pagina llamamos a las funcion para que cargue el combo
            getVerEntidad();

            var userLang = navigator.language || navigator.userLanguage;

            //Muestra datos de la entidadCliente al seleccionar algo en el combo
            $("#comboEntidad").change(function () {
                //recogemos el valor del combo para utilizarlo luego al ver las facturas.
                var idEntidad = $("#comboEntidad").val();
                //Si la opcion seleccionada es diferente a Seleccionar se muestran datos
                if ($("#comboEntidad").val() != "0") {

                    if (window.XMLHttpRequest) //mozilla
                    {
                        ajax = new XMLHttpRequest(); //No Internet explorer
                    } else
                    {
                        ajax = new ActiveXObject("Microsoft.XMLHTTP");
                    }

                    var myObj = {};
                    //recogemos el valor de comboEntidad y lo metemos en id_entidad.
                    myObj["id_entidad"] = idEntidad;
                    var json = JSON.stringify(myObj);
                    $.ajax({
                        type: 'POST',
                        url: '/Facturacion/verFacturasController/getDatosEntidad.htm',
                        data: json,
                        datatype: "json",
                        contentType: "application/json",
                        success: function (data) {

                            var aux = JSON.parse(data);
                            aux.forEach(function (valor, indice) {
                                //Recogemos cada objeto en String y los pasamos a objetos Tipo cliente con JSON
                                var aux2 = JSON.parse(valor);
                                //Mostramos los datos en la cajas de texto
                                $("#id_entidad").val(aux2.id_entidad);

                                $("#idEntidadRecargar").val(aux2.id_entidad);


                                $("#nombre_entidad").val(aux2.nombre_entidad);
                                $("#nombre_contacto").val(aux2.nombre_contacto);
                            });
                        },
                        error: function (xhr, ajaxOptions, thrownError) {
                            console.log(xhr.status);
                            console.log(xhr.responseText);
                            console.log(thrownError);
                        }
                    });
                    //Si se seleciona lo opcion "Seleccionar" se limpian las cajas de texto
                } else {
                    $("#id_entidad").val("");
                    $("#nombre_entidad").val("");
                    $("#nombre_contacto").val("");
                }
                /*llamamos a la funcion para ver las facturas del cliente que seleccionamos en el combo
                 le pasamos por parametro el valor de idCliente a la funcion: verListaaFacturas(idEntidad)
                 Lo hacemos asi ya que son dos tablas diferentes*/
                verListaFacturas(idEntidad);
            });
        });
        //CREAMOS LA FUNCION PARA CARGAR EL COMBO DE TIPO ENTIDAD.
        function getVerEntidad() {

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
                //VAMOS A ENTIDADESCONTROLLER A RECOGER LOS DATOS DE LA FUNCION GETTIPOENTIDAD
                url: '/Facturacion/verFacturasController/getVerEntidad.htm?estado=activa',
                success: function (data) {
                    //RECOGEMOS LOS DATOS DEL COMBO Y PASAMOS EL STRING A UN ARRAY DE OBJETOS TIPO ENTIDAD
                    var verEntidad = JSON.parse(data);
                    //IDENTIFICAMOS EL COMBO POR EL ID DE LA TABLA TIPO_ENTIDAD
                    select = document.getElementById('comboEntidad');
                    var opt = document.createElement('option');
                    opt.value = 0;
                    opt.innerHTML = "Seleccionar";
                    select.appendChild(opt);
                    verEntidad.forEach(function (valor, indice) {
                        //CADA OBJETO TIPO STRING LO PASAMOS A TIPOENTIDAD CON JSON
                        var verEntidad2 = JSON.parse(valor);
                        //CREAMOS LAS OPTION DEL COMBO(CODIGO HTML)
                        var opt = document.createElement('option');
                        //GUARDAMOS EL ID EN EL VALUE DE CADA OPCION DE CADA VUELTA
                        opt.value = verEntidad2.id_entidad;
                        //GUARDAMOS LA DESCRIPCION DEL TIPO DE ENTIDAD
                        opt.innerHTML = verEntidad2.distinct_code;
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
        ;
        
        /*funcion para ver la lista de facturas del cliente seleccionado en el combo. Recoge por parametro el id del cliente  */
        function verListaFacturas(idEntidad) {
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
                /*en la url le pasamos como parametro el identificador de cliente que lo recogemos del combo comboEntidad
                 cuando modificamos el combo cargamos el valor del idCliente asi: var idEntidad = $("#comboEntidad").val();*/
                url: '/Facturacion/verFacturasController/getDatosFactura.htm?idCliente=' + idEntidad,
                success: function (data) {
                    
                    //Recogemos los datos del combo y los pasamos a objetos TipoImpuesto  
                    var aux = JSON.parse(data);
                    $('#tableContainer tbody').empty();
                    //Vamos cargando la tabla
                    //
                    /** 
                     * cogemos el boton de eliminar. creamos un mensaje de alerta si es si, lo que hacemos que creamos un campo oculto en el cual recogemos el valor del id:factura
                     * que enviaremos al controlador, una vez alli lo que tenemos que hacer es desactivar el booleano.
                     * */

                    /*PRUEBASS DATATABLE*/

                    var table = $('#table table-striped').DataTable();
                    aux.forEach(function (valor, indice) {
                        //Cada objeto esta en String 
                        var aux2 = JSON.parse(valor);
                        /*en las fechas, quitamos la hora con substring*/



                        $('#tableContainer tbody').append(" <tr>\n\
                                                                <th scope=\"row\">" + (indice + 1) + "</th>     \n\
                                                                    <td id='id" + indice + "'>" + aux2.col1 + "</td>         \n\
                                                                    <td>" + aux2.col3 + "</td>         \n\
                                                                    <td>" + aux2.col5 + "</td>         \n\
                                                                    <td>" + aux2.col7.substring(0, 10) + "</td>         \n\
                                                                    <td>" + aux2.col8.substring(0, 10) + "</td>         \n\
                                                                    <td>" + aux2.col6 + '€' + "</td>         \n\
                                                                    <td class ='est'>" + aux2.col9 + "</td>         \n\
\n\
                                                                    <td><a class='btn btn-success' target ='_blank' href='/Facturacion/verFacturasController/verDetalleFactura.htm?idFact=" + aux2.col1 +
                                "&idCliente=" + aux2.col2 + "&idEmpresa=" + aux2.col4 + "&idEstado=" + aux2.col9 + "'>Detalle</a>\n\</td> \n\\n\
                \n\
                                                                    <td><button type='button' class='btn miBotonEstado btn-info'  data-idFactura='" + aux2.col1 + "' data-idEstado='" + aux2.col9 +
                                "' data-idIndice='" + indice + "'>Estado</button></td>\n\
                \n\
                \n\                                                 <td><button type='button' class='btn myModalAnular btn-danger'  data-idFactura='" + aux2.col1 + "' data-idEstado='" + aux2.col9 +
                                "' data-idIndice='" + indice + "'>Anular</button></td>\n\
                \n\
                                                                    <td><button type='button' class='btn miBotonEliminar btn-warning'  data-idFactura='" + aux2.col1 + "' data-idCliente='" + aux2.col2 +
                                "' data-idIndice='" + indice + "'>Archivar</button></td>\n\
                                                        </tr>");
                    });

                    /*Creamos la funcion que al hacer click en el boton eliminar nos muestre el modal, identificamos el boton con el nombre miBotonEliminar*/
                    $(document).ready(function () {

                        $(".myModalAnular").click(function () {

                            /*Guardamos los valores que recogemos de los parametros declarados en el boton(arriba) y lo recogemos con .val($this...) 
                             * en los campos ocultos que nos hemos declarado en el html para que al pinchar en el boton no se pierdan los datos.*/
                            $("#idAnularFacturaHide").val($(this).attr("data-idFactura"));
                            $("#idAnularClienteHide").val($(this).attr("data-idCliente"));
                            $("#idAnularFilaHide").val($(this).attr("data-idIndice"));

                            /*Mostramos el texto de la desripcion del body de la ventana emergente, Necesitamos un id unico en el campo abreviatura*/
                            $("#anularFact").text("Desea ANULAR la factura: " + $("#id" + $(this).attr("data-idIndice")).text());
                            $("#advertencia").text("Esto implica BORRAR la factura y volver a activar todos los cargos");

                            /*Una vez guardados los datos en los campos ocultos, mostramos el modal con los datos*/
                            $("#myModalAnular").modal();
                        });

                        $(".miBotonEliminar").click(function () {

                            /*Guardamos los valores que recogemos de los parametros declarados en el boton(arriba) y lo recogemos con .val($this...) 
                             * en los campos ocultos que nos hemos declarado en el html para que al pinchar en el boton no se pierdan los datos.*/
                            $("#idFacturaHide").val($(this).attr("data-idFactura"));
                            $("#idClienteHide").val($(this).attr("data-idCliente"));
                            $("#idFilaHide").val($(this).attr("data-idIndice"));

                            /*Mostramos el texto de la desripcion del body de la ventana emergente, Necesitamos un id unico en el campo abreviatura*/
                            $("#eliminar").text("Desea archivar la factura: " + $("#id" + $(this).attr("data-idIndice")).text());

                            /*Una vez guardados los datos en los campos ocultos, mostramos el modal con los datos*/
                            $("#myModalEliminar").modal();
                        });

                        $(".miBotonEstado").click(function () {

                            /*Guardamos los valores que recogemos de los parametros declarados en el boton(arriba) y lo recogemos con .val($this...) 
                             * en los campos ocultos que nos hemos declarado en el html para que al pinchar en el boton no se pierdan los datos.*/
                            $("#idFacturaEstadoHide").val($(this).attr("data-idFactura"));
                            $("#idEstadoHide").val($(this).attr("data-idEstado"));
                            $("#idFilaEstadoHide").val($(this).attr("data-idIndice"));


                            /*Mostramos el texto de la desripcion del body de la ventana emergente, Necesitamos un id unico en el campo abreviatura*/
                            $("#estadoFact").text("Desea cambiar el estado de la factura: " + $("#idFacturaEstadoHide").val());


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
                                url: '/Facturacion/verFacturasController/getDatosEstado.htm',
                                success: function (data) {

                                    //alert(data);
                                    //
                                    //Recogemos los datos del combo y los pasamos a objetos TipoImpuesto  
                                    var aux = JSON.parse(data);
                                    $('#tbody-tabla-estados').empty();

                                    var table = $('#table table-striped').DataTable();
                                    aux.forEach(function (valor, indice) {
                                        //Cada objeto esta en String 
                                        var aux2 = JSON.parse(valor);

                                        //Comprobaciones para dejar seleccionado el estado
                                        if (aux2.col2 == $("#idEstadoHide").val()) {

                                            $('#tbody-tabla-estados').append(" <tr>\n\   \n\
                                                                    <td id='id" + (indice + 1) + "'><input type='radio' name='estado' value='" + aux2.col1 + "' checked/></td>         \n\
                                                                    <td>" + aux2.col2 + "</td>\n\
                                                                </tr>");
                                            //Guardamos el texto del estado en una caja de texto oculta
                                            $("#TextoEstadoNuevoHide").val(aux2.col2)
                                        } else {
                                            $('#tbody-tabla-estados').append(" <tr>\n\   \n\
                                                                    <td id='id" + (indice + 1) + "'><input type='radio' name='estado' value='" + aux2.col1 + "'/></td>         \n\
                                                                    <td>" + aux2.col2 + "</td>\n\
                                                               </tr>");
                                        }
                                    });

                                    $("#TextoEstadoNuevoHide").val()

                                    $(document).ready(function () {
                                        $("input[name=estado]").change(function () {
                                            $("#EstadoNuevoHide").val($('input[name=estado]:checked').val());
                                            //Guardamos el texto del estado en una caja de texto oculta
                                            $("#TextoEstadoNuevoHide").val($("#tbody-tabla-estados input:checked").parent().next().text());

                                        });
                                    });

                                },
                                error: function (xhr, ajaxOptions, thrownError) {
                                    console.log(xhr.status);
                                    console.log(xhr.responseText);
                                    console.log(thrownError);
                                }
                            });

                            $("#myModalEstado").modal();

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

        function anularFactura() {
            if (window.XMLHttpRequest) //mozilla
            {
                ajax = new XMLHttpRequest(); //No Internet explorer
            } else
            {
                ajax = new ActiveXObject("Microsoft.XMLHTTP");
            }

            var fact = $("#idAnularFacturaHide").val();

            alert(fact);


            $.ajax({
                type: 'POST',
                url: '/Facturacion/verFacturasController/anularFactura.htm?factura=' + fact,
                success: function (data) {

                    alert(data);

                    //Ocultamos la fila de la factura anulada
                    $("#tbody-tabla-facturas").children().eq($("#idAnularFilaHide").val()).hide();
                    //alert("Ocultada la fila correctamente");
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    console.log(xhr.status);
                    console.log(xhr.responseText);
                    console.log(thrownError);
                }
            });

        }
        ;

        function archivarFactura() {
            if (window.XMLHttpRequest) //mozilla
            {
                ajax = new XMLHttpRequest(); //No Internet explorer
            } else
            {
                ajax = new ActiveXObject("Microsoft.XMLHTTP");
            }

            var fact = $("#idFacturaHide").val();


            $.ajax({
                type: 'POST',
                url: '/Facturacion/verFacturasController/archivarFactura.htm?factura=' + fact,
                success: function (data) {

                    alert(data);

                    $("#tbody-tabla-facturas").children().eq($("#idFilaHide").val()).hide();
                    //alert("Ocultada la fila correctamente");
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    console.log(xhr.status);
                    console.log(xhr.responseText);
                    console.log(thrownError);
                }
            });

        }
        ;

        //Funcion para cambiar el estado de una facturta
        function cambiarEstado() {
            if (window.XMLHttpRequest) //mozilla
            {
                ajax = new XMLHttpRequest(); //No Internet explorer
            } else
            {
                ajax = new ActiveXObject("Microsoft.XMLHTTP");
            }

            var myObj = {};
            myObj["col1"] = $("#idFacturaEstadoHide").val();
            myObj["col2"] = $("#EstadoNuevoHide").val();

            var json = JSON.stringify(myObj);
            $.ajax({
                //Usamos GET ya que recibimos.
                type: 'POST',
                url: '/Facturacion/verFacturasController/cambiarEstado.htm',
                data: json,
                datatype: "json",
                contentType: "application/json",
                success: function (data) {

                    var entidadRefrescar = $("#idEntidadRecargar").val();

                    verListaFacturas(entidadRefrescar);
                    
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
                            <h3 style="margin-bottom: 25px; text-align: center;">VER FACTURAS ACTIVAS ENTIDAD</h3>                           

                            <div class="datos" class="col-xs-12">
                                <!--Combo para entidades-->
                                <div class="form-group col-xs-3">

                                    <input class="hidden" id="idEntidadRecargar" name="idFacturaRecargar">     

                                    <label for="comboEntidad"> Entidad Distinct code </label>
                                    <div class="form-group-combo">                                        
                                        <select class="form-control" id="comboEntidad" name="comboEntidad">

                                        </select>                                                            
                                    </div>
                                </div>
                                <div class="form-group col-xs-2">
                                    <label for="id_cliente"> Id Entidad </label>
                                    <input type="text" class="form-control" id="id_entidad" name="id_entidad" disabled = "true">
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

                                <hr size="10" />

                                <div class="col-xs-12" id="tableContainer">
                                    <table id="example" class="table table-striped">                                    

                                        <thead class="thead-dark">                                            
                                            <tr>
                                                <th scope="col">#</th>
                                                <th scope="col">Nº</th>
                                                <th scope="col">Cliente</th>
                                                <th scope="col">Empresa</th>
                                                <th scope="col">F. Emisión</th>
                                                <th scope="col">F. Vencimiento</th>
                                                <th scope="col">Total</th>
                                                <th scope="col">Estado</th>
                                                <th scope="col">Detalle</th>
                                                <th scope="col">Estado</th>
                                                <th scope="col">Anular</th>
                                                <th scope="col">Archivar</th>
                                            </tr>                                            
                                        </thead>

                                        <tbody id="tbody-tabla-facturas">                                        

                                        </tbody>

                                    </table>
                                </div>    

                                <!-- <button type="button" id="submit" name="submit" class="btn btn-primary pull-right">Submit</button>-->
                                <a href="<c:url value='/MenuController/start.htm'/>" class="btn btn-info" role="button">Menu principal</a> 
                            </div>
                        </form>

                    </div>                            
                </div>
            </div>
        </div>  

        <!-- ventana emergente Anular-->
        <div class="modal fade" id="myModalAnular" role="dialog">
            <!-- Declaramos los campos ocultos para en la funcion de ajax podamos guardar los datos -->
            <input class="hidden" id="idAnularFacturaHide"/>
            <input class="hidden" id="idAnularClienteHide"/>
            <input class="hidden" id="idAnularFilaHide"/>

            <div class="modal-dialog">

                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Archivar Factura</h4>
                    </div>
                    <div class="modal-body">
                        <p id="anularFact"></p>       
                        <p id="advertencia"></p>
                    </div>
                    <div class="modal-footer">
                        <!-- Llamamos a la funcion eliminarEntidad al pusar en si, al pulsar en no, no hacemos nada y volvemos a la pagina donde mostramos la lista-->
                        <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="anularFactura()">Si</button>
                        <button type="button" class="btn btn-danger" data-dismiss="modal">No</button>
                    </div>
                </div>
            </div>
        </div>


        <!-- ventana emergente Archivar-->
        <div class="modal fade" id="myModalEliminar" role="dialog">
            <!-- Declaramos los campos ocultos para en la funcion de ajax podamos guardar los datos -->
            <input class="hidden" id="idFacturaHide"/>
            <input class="hidden" id="idClienteHide"/>
            <input class="hidden" id="idFilaHide"/>

            <div class="modal-dialog">

                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Archivar Factura</h4>
                    </div>
                    <div class="modal-body">
                        <p id="eliminar"></p>                            
                    </div>
                    <div class="modal-footer">
                        <!-- Llamamos a la funcion eliminarEntidad al pusar en si, al pulsar en no, no hacemos nada y volvemos a la pagina donde mostramos la lista-->
                        <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="archivarFactura()">Si</button>
                        <button type="button" class="btn btn-danger" data-dismiss="modal">No</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- ventana emergente Estado-->
        <div class="modal fade" id="myModalEstado" role="dialog">
            <!-- Declaramos los campos ocultos para en la funcion de ajax podamos guardar los datos -->
            <input class="hidden" id="idFacturaEstadoHide"/>
            <input class="hidden" id="idEstadoHide"/>
            <input class="hidden" id="idFilaEstadoHide"/>
            <input class="hidden" id="EstadoNuevoHide"/>
            <input class="hidden" id="TextoEstadoNuevoHide"/>

            <div class="modal-dialog">

                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Cambiar estado Factura</h4>
                    </div>
                    <div class="modal-body">
                        <p id="estadoFact"></p>       
                        <table class="table table-striped">                                    

                            <thead class="thead-dark">                                            
                                <tr>
                                    <th scope="col">#</th>
                                    <th scope="col">Estado</th>                                    
                                </tr>                                            
                            </thead>

                            <tbody id="tbody-tabla-estados">

                            </tbody>
                        </table>
                    </div>
                    <div class="modal-footer">
                        <!-- Llamamos a la funcion eliminarEntidad al pusar en si, al pulsar en no, no hacemos nada y volvemos a la pagina donde mostramos la lista-->
                        <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="cambiarEstado()">Si</button>
                        <button type="button" class="btn btn-danger" data-dismiss="modal">No</button>
                    </div>
                </div>
            </div>
        </div>


    </body> 
</html>



