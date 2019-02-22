
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="jstl" uri="http://java.sun.com/jstl/core_rt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html>
    <%@ include file="infouser.jsp" %>
    <head> 
        <title>VER CARGOS</title> 
    </head>
    <script>
        $(document).ready(function () {
            
            //Al cargar la pagina llamamos a las funcion para que cargue el combo
            getVerEntidad();
            
            var userLang = navigator.language || navigator.userLanguage;


            //Muestra datos de la entidadCliente al seleccionar algo en el combo
            $("#comboEntidad").change(function () {
                //recogemos el valor del combo para utilizarlo luego al ver los cargos.
                var idEntidad = $("#comboEntidad").val();
                //Si la opcion seleccionada es diferente a Seleccionar se muestran datos
                if ($("#comboEntidad").val() !== "0") {

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
                        url: '/Facturacion/verCargosController/getDatosEntidad.htm',
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
                 le pasamos por parametro el valor de idCliente a la funcion: verListaaFacturas(idEntidad)*/
                verListaCargos(idEntidad);
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
                //VAMOS A ENTIDADESCONTROLLER A RECOGER LOS DATOS DE LA FUNCION getVerEntidad
                url: '/Facturacion/verCargosController/getVerEntidad.htm',
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

        function verListaCargos(idEntidad) {
            if (window.XMLHttpRequest) //mozilla
            {
                ajax = new XMLHttpRequest(); //No Internet explorer
            } else
            {
                ajax = new ActiveXObject("Microsoft.XMLHTTP");
            }


            $.ajax({
                //Usamos GET ya que recibimos.
                type: 'POST',
                url: '/Facturacion/verCargosController/getDatosCargos.htm?idCliente=' + idEntidad,
                success: function (data) {

                    //Recogemos los datos del combo y los pasamos a objetos TipoImpuesto  
                    var aux = JSON.parse(data);
                    $('#tableContainer tbody').empty();
                    //Vamos cargando la tabla
                    aux.forEach(function (valor, indice) {
                        //var id = cargo.id_cargo;
                        //Cada objeto esta en String 
                        var cargo = JSON.parse(valor);
                        /*en las fechas, quitamos la hora con substring*/
                        $('#tableContainer tbody').append(" <tr>\n\
                                                                <td id='id" + (indice + 1) + "'>" + (indice + 1) + "</td>     \n\
                                                                    <td id='abrev" + indice + "'>" + cargo.abreviatura + "</td>         \n\
                                                                    <td>" + cargo.id_tipo_item + "</td>         \n\
                                                                    <td class='hidden' id='descrip" + (indice + 1) + "'>" + cargo.descripcion + "</td>         \n\
                                                                    <td>" + cargo.cuenta + "</td>         \n\
                                                                    <td>" + cargo.importe + "</td>         \n\
                                                                    <td>" + cargo.cantidad + "</td>         \n\
                                                                    <td>" + cargo.valor_impuesto + "</td>         \n\
                                                                    <td>" + cargo.total + '€' + "</td>         \n\
                                                                    <td>" + cargo.fecha_cargo.substring(0, 10) + "</td>         \n\
                                                                    <td>" + cargo.fecha_vencimiento.substring(0, 10) + "</td>         \n\
                                                                    <td><button type='button' class='btn btn-info miBoton btn-success' id='myBtn' value='"+(indice+1)+"';>Ver Desc.</button></td>\n\
                                                                    <td><button type='button' class='btn btn-info btn-warning' id='' value='"+(indice+1)+"';>Modificar</button></td>\n\
\n\                                                                 <td><button type='button' class='btn btn-info miBotonEliminar btn-danger'  data-idCargo='" + cargo.id_cargo + "' data-idItem='" + cargo.id_item + "' data-idIndice='" + indice + "'> Borrar</button></td>\n\
                                                                </tr>");
                    });

                    $(document).ready(function () {
                        $(".miBoton").click(function () {       
                            //Con $(this).val() cogemos el value del boton, lo concatenamos a #descrip para tener el id del campo oculto con
                            //la descripcion correspondiente a esa fila. Cogemos el text de ese campo y lo añadimos al p del modal para visualizarlo
                            $("#descripcion").text($("#descrip"+$(this).val()).text());
                            $("#myModal").modal(); 
                        });
                    });
                    
                    /*Creamos la funcion que al hacer click en el boton eliminar nos muestre el modal, identificamos el boton con el nombre miBoton*/
                    $(document).ready(function () {
                        $(".miBotonEliminar").click(function () {                            
                            
                            /*Guardamos los valores que recogemos de los parametros declarados en el boton(arriba) y lo recogemos con .val($this...) 
                             * en los campos ocultos que nos hemos declarado en el html para que al pinchar en el boton no se pierdan los datos.*/
                            $("#idCargoHide").val($(this).attr("data-idCargo"));
                            $("#idItemHide").val($(this).attr("data-idItem"));
                            $("#idFilaHide").val($(this).attr("data-idIndice"));
                            
                            /*Mostramos el texto de la desripcion del body de la ventana emergente, Necesitamos un id unico en el campo abreiatura*/
                            $("#eliminar").text($("#abrev"+ $(this).attr("data-idindice")).text());

                            /*Una vez guardados los datos en los campos ocultos, mostramos el modal con los datos*/
                            $("#myModalEliminar").modal();
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
        
        
        function descrip(idDes) {
           
            $("#descripcion").text("ddd");
        };

    </script>


    <body>
        <div class="container">
            <div class="col-xs-12">
                <div class="col-md-12 col-xs-5">
                    <div class="form-area">  
                        <form role="form">
                            <br style="clear:both">
                            <h3 style="margin-bottom: 25px; text-align: center;">VER CARGOS ENTIDAD</h3>                           

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
                                                <th scope="col">Abreviatura</th>
                                                <th scope="col">Tipo Item</th>
                                                <th scope="col">Cuenta</th>
                                                <th scope="col">Importe</th>
                                                <th scope="col">Cantidad</th>
                                                <th scope="col">Impuestos</th>
                                                <th scope="col">Total</th>                                                
                                                <th scope="col">F. Cargo</th>
                                                <th scope="col">F. Vencimiento</th>
                                                <th scope="col">Ver Desc.</th>
                                                <th scope="col">Modificar</th>
                                                <th scope="col">Borrar</th>
                                            </tr>                                            
                                        </thead>

                                        <tbody id="tbody-tabla-entidades">

                                        </tbody>
                                    </table>
                                </div>    

                                <button type="button" id="submit" name="submit" class="btn btn-primary pull-right">Submit</button>
                                <a href="<c:url value='/MenuController/start.htm'/>" class="btn btn-info" role="button">Menu principal</a> 
                        </form>

                    </div>                            
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
            <input class="hidden" id="idCargodHide"/>
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
                        <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="eliminarEntidad()">Si</button>
                        <button type="button" class="btn btn-danger" data-dismiss="modal">No</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body> 
</html>



