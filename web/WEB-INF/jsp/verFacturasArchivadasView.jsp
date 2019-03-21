<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="jstl" uri="http://java.sun.com/jstl/core_rt"%>
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

        #tableContainer{
            overflow:scroll;
            overflow-x: hidden;
            height:400px;    
            margin-bottom: 25px;
        }



    </style>
    <script>
        $(document).ready(function () {
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
                verListaFacturasArchivadas(idEntidad);
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
                url: '/Facturacion/verFacturasController/getVerEntidad.htm?estado=archivada',
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

        /*funcion para ver la lista de facturas del cliente seleccionado en el combo. Recoge por parametro 
         el id del cliente 
         */
        function verListaFacturasArchivadas(idEntidad) {
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
                url: '/Facturacion/verFacturasController/getDatosFacturaArchivadas.htm?idCliente=' + idEntidad,
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
                                                                    <td id='id" + (indice + 1) + "'>" + aux2.col1 + "</td>         \n\
                                                                    <td>" + aux2.col3 + "</td>         \n\
                                                                    <td>" + aux2.col5 + "</td>         \n\
                                                                    <td>" + aux2.col7.substring(0, 10) + "</td>         \n\
                                                                    <td>" + aux2.col8.substring(0, 10) + "</td>         \n\
                                                                    <td>" + aux2.col6 + '€' + "</td>         \n\
                                                                    <td>" + aux2.col9 + "</td>         \n\
                                                                    <td><a class='btn btn-primary' target ='_blank' href='/Facturacion/verFacturasController/verDetalleFacturaArchivada.htm?idFact=" + aux2.col1 +
                                "&idCliente=" + aux2.col2 + "&idEmpresa=" + aux2.col4 + "&idEstado=" + aux2.col9 + "'>Detalle</a>\n\</td> \n\\n\
                        < /tr>");
                    });

                    $(document).ready(function () {
                        /*para cada boton hacer una funcion */
                        $(".btn-eliminar").on("click", function () {
                            //guardar id factura
                            $("#mi-modal").modal('show');
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
                            <h3 style="margin-bottom: 25px; text-align: center;">VER FACTURAS ARCHIVADAS ENTIDAD</h3>                           

                            <div class="datos" class="col-xs-12">
                                <!--Combo para entidades-->
                                <div class="form-group col-xs-3">
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
                                    <table class="table table-striped">                                    

                                        <thead class="thead-dark">                                            
                                            <tr>
                                                <th scope="col">#</th>
                                                <th scope="col">Nº factura</th>
                                                <th scope="col">Cliente</th>
                                                <th scope="col">Empresa</th>
                                                <th scope="col">Fecha Emision</th>
                                                <th scope="col">Fecha Vencimiento</th>
                                                <th scope="col">Total</th>
                                                <th scope="col">Estado</th>
                                            </tr>                                            
                                        </thead>

                                        <tbody id="tbody-tabla-entidades">

                                        </tbody>
                                    </table>
                                </div>    

                                <!-- <button type="button" id="submit" name="submit" class="btn btn-primary pull-right">Submit</button>-->
                                <a href="/Facturacion/MenuController/start.htm" class="btn btn-info" role="button">Menu principal</a>   
                        </form>

                    </div>                            
                </div>
            </div>
        </div>  
    </div>

    <!--- ----    ------>
    <div class="modal fade" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true" id="mi-modal">
        <div class="modal-dialog modal-sm">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">Confirmar</h4>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" id="modal-btn-si">Si</button>
                    <button type="button" class="btn btn-primary" id="modal-btn-no">No</button>
                </div>
            </div>
        </div>
    </div>
    <!----   ---------->
    <div class="alert" role="alert" id="result"></div>
</body> 
</html>



