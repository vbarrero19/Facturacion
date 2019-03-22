<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="jstl" uri="http://java.sun.com/jstl/core_rt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
    <%@ include file="infouser.jsp" %> 
    <head> 
        <title>ITEMS VIEW</title>       </head>
    <style>
        .container{
            width: 1400px;

        }

        .azul{
            background-color: lightblue;
            margin-bottom: 25px;
        }


    </style>
    <script>
        $(document).ready(function () {

            //al cargar la pagina llamamos a la funcion getCuenta() para llenar la tabla
            getCuentas();
            getEmpresas();




//            getTipoCuenta();
//            //getEntidadEmpresa();
//
//            var cont = 0;
//
//            $('#conCostes').hide();
//
//            //$("input[name=costesRadios]").attr('disabled', true);
//
//            $("#costesRadios1").on("click", function () {
//                $('#conCostes').hide();
//                $('#sinCostes').show();
//            });
//
//            $("#costesRadios2").on("click", function () {
//                $('#conCostes').show();
//                $('#importe').val(0);
//                getEntidadEmpresa();
//
//            });
//
//            //Codigo para añadir un coste de forma dinamica
//            $('#conCostes').on('click', '#anadirCoste', function () {
//                cont++;
//                $('#tableContainer tbody').append(" <tr class='eliminar'>\n\
//                                                            <td> <div class='form-group-combo'>\n\
//                                                            <select class='form-control input-sm' id='comboClientes" + cont + "' name='comboClientes'></select></div> </td>     \n\
//                                                            <td><input type='text' id='costeImporte" + cont + "' name='costeImporte' value='0'></td>        \n\
//                                                            <td><button type='button' class='btn miBoton btn-danger' id='myBtn';>Eliminar</button></td>\n\
//                                                    </tr>");
//                getEntidadCliente("comboClientes" + cont);
//            });
//
//
//            //Codigo para eliminar un coste de forma dinamica
//            $('#conCostes').on('click', '.miBoton', function () {
//                var parent = $(this).parent().parent().remove();
//                calcularTotal();
//
//            });
//
//            $('#conCostes').on('keyup', 'input[name=costeImporte]', function () {
//                alert("HOLA");
//                calcularTotal();
//
//            });
//
//            //Evento .click en el boton submit
//            $("#guardarItem").click(function () {
//                if (window.XMLHttpRequest) //mozilla
//                {
//                    ajax = new XMLHttpRequest(); //No Internet explorer
//                } else
//                {
//                    ajax = new ActiveXObject("Microsoft.XMLHTTP");
//                }
//
//
//                //Variable para guardar los valores del formulario
//                var myObj = {};
//
//
//                //Codigo para recuperar los costes de un item
//                //Creamos el array donde guardaremos los datos
//                var arrayOption = [];
//
//                $("#tableContainer tbody>tr option:checked").each(function (index) {
//                    arrayOption.push(this.value + "-" + $("#tableContainer tbody>tr input").eq(index).val());
//                });
//
//
//                alert(arrayOption.toString());
//
//
//                //Cargamos el contenido de los campos del formulario
//                myObj["abreviatura"] = $("#abreviatura").val().trim();
//                myObj["descripcion"] = $("#descripcion").val().trim();
//                myObj["id_tipo_item"] = $("#id_tipo_item").val();
//                myObj["importe"] = $("#importe").val().trim();
//                myObj["estado"] = "0";
//                myObj["importe"] = $("#importe").val().trim();
//                myObj["id_cuenta"] = $("#id_cuenta").val();
//                if ($("input[name=costesRadios]:checked").val() == "Si") {
//
//                    myObj["costes"] = arrayOption.toString();
//                } else {
//                    myObj["costes"] = "No";
//                }
//                //Convertimos la variable myObj a String
//                var json = JSON.stringify(myObj);
//                $.ajax({
//                    type: 'POST',
//                    url: '/Facturacion/itemsController/newItems.htm', //Vamos a newCustomer de itemsController
//                    data: json,
//                    datatype: "json",
//                    contentType: "application/json",
//                    success: function (data) {
//                        alert(data);
//                        location.reload();
//                    },
//                    error: function (xhr, ajaxOptions, thrownError) {
//                        console.log(xhr.status);
//                        console.log(xhr.responseText);
//                        console.log(thrownError);
//                    }
//                });
//            })

        });


        function getCuentas() {
            if (window.XMLHttpRequest) //mozilla
            {
                ajax = new XMLHttpRequest(); //No Internet explorer
            } else
            {
                ajax = new ActiveXObject("Microsoft.XMLHTTP");
            }


            $.ajax({
                type: 'POST',
                url: '/Facturacion/cuentasController/getCuenta.htm',
                success: function (data) {

                    var aux = JSON.parse(data);
                    $('#tableContainer tbody').empty();
                    //Vamos cargando la tabla

                    aux.forEach(function (valor, indice) {
                        //var id = cargo.id_cargo;
                        //Cada objeto esta en String 
                        var cuenta = JSON.parse(valor);

                        $('#tableContainer1 tbody').append(" <tr>\n\
                                                                <td id='id" + (indice + 1) + "'>" + (indice + 1) + "</td>     \n\
                                                                    <td id='id" + indice + "'>" + cuenta.id_cuenta + "</td>         \n\
                                                                    <td>" + cuenta.cuenta + "</td>         \n\
                                                                    <td class='hidden' id='descrip" + (indice + 1) + "'>" + cuenta.cuenta + "</td>         \n\
                                                                    <td>" + cuenta.estado + "</td>         \n\
                                                                    <td><button type='button' class='btn btn-info miBotonAnadir btn-success btn-sm'  data-idCuenta='" + cuenta.id_cuenta + "' data-idIndice='" + indice + "'> Añadir</button></td>\n\
                                                                    <td><button type='button' class='btn btn-info miBotonModificar btn-warning btn-sm'  data-idCuenta='" + cuenta.id_cuenta + "' data-cuenta='" + cuenta.cuenta + "' data-idIndice='" + indice + "'> Modificar</button></td>\n\
                                                                    <td><button type='button' class='btn btn-info miBotonEliminar btn-danger btn-sm'  data-idCuenta='" + cuenta.id_cuenta + "' data-cuenta='" + cuenta.cuenta + "' data-idIndice='" + indice + "'> Borrar</button></td>\n\
                                                                    </tr>");
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

                            /***** codigo nuevo *****/

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

                                    $(document).ready(function () {

                                        $("input[name=estado]").change(function () {
                                            $("#EstadoNuevoHide").val($('input[name=estado]:checked').val());
                                        });


                                    });

                                },
                                error: function (xhr, ajaxOptions, thrownError) {
                                    console.log(xhr.status);
                                    console.log(xhr.responseText);
                                    console.log(thrownError);
                                }
                            });


                            /***** codigo nuevo *****/




                            /*Una vez guardados los datos en los campos ocultos, mostramos el modal con los datos*/
                            $("#myModalCostes").modal();
                        })
                                ;

                        $(".miBotonAnadir").click(function () {

                            /*Guardamos los valores que recogemos de los parametros declarados en el boton(arriba) y lo recogemos con .val($this...) 
                             * en los campos ocultos que nos hemos declarado en el html para que al pinchar en el boton no se pierdan los datos.*/
                            $("#idAnadirCuentaHide").val($(this).attr("data-idCuenta"));
                            $("#idAnadirCuentaFilaHide").val($(this).attr("data-idIndice"));

                            //$("#eliminarItem").text("Desea eliminar el item: " + $("#idElimTipoHide").val());

                            /*Una vez guardados los datos en los campos ocultos, mostramos el modal con los datos*/
                            $("#myModalAnadirCuenta").modal();
                        })
                                ;

                        $(".miBotonEliminar").click(function () {

                            /*Guardamos los valores que recogemos de los parametros declarados en el boton(arriba) y lo recogemos con .val($this...) 
                             * en los campos ocultos que nos hemos declarado en el html para que al pinchar en el boton no se pierdan los datos.*/
                            $("#idElimCuentaHide").val($(this).attr("data-idCuenta"));
                            $("#idElimCuentaTipoHide").val($(this).attr("data-cuenta"));
                            $("#idElimCuentaFilaHide").val($(this).attr("data-idIndice"));

                            $("#eliminarCuenta").text("Desea eliminar la cuenta: " + $("#idElimCuentaTipoHide").val());

                            /*Una vez guardados los datos en los campos ocultos, mostramos el modal con los datos*/
                            $("#myModalEliminarCuenta").modal();
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

        function getEmpresas() {
            if (window.XMLHttpRequest) //mozilla
            {
                ajax = new XMLHttpRequest(); //No Internet explorer
            } else
            {
                ajax = new ActiveXObject("Microsoft.XMLHTTP");
            }


            $.ajax({
                type: 'POST',
                url: '/Facturacion/cuentasController/getEmpresa.htm',
                success: function (data) {

                    var aux = JSON.parse(data);
                    $('#tableContainer tbody').empty();
                    //Vamos cargando la tabla

                    aux.forEach(function (valor, indice) {
                        //var id = cargo.id_cargo;
                        //Cada objeto esta en String 
                        var cuenta = JSON.parse(valor);

                        $('#tableContainer2 tbody').append(" <tr>\n\
                                                                <td id='id" + (indice + 1) + "'>" + (indice + 1) + "</td>     \n\
                                                                    <td id='id" + indice + "'>" + cuenta.id_cuenta + "</td>         \n\
                                                                    <td>" + cuenta.cuenta + "</td>         \n\
                                                                    <td class='hidden' id='descrip" + (indice + 1) + "'>" + cuenta.cuenta + "</td>         \n\
                                                                    <td>" + cuenta.estado + "</td>         \n\
                                                                    <td><button type='button' class='btn btn-info miBotonAnadir btn-success btn-sm'  data-idCuenta='" + cuenta.id_cuenta + "' data-cuenta='" + cuenta.cuenta + "' data-idIndice='" + indice + "'> Añadir</button></td>\n\
                                                                    <td><button type='button' class='btn btn-info miBotonModificar btn-warning btn-sm'  data-idCuenta='" + cuenta.id_cuenta + "' data-cuenta='" + cuenta.cuenta + "' data-idIndice='" + indice + "'> Modificar</button></td>\n\
                                                                    <td><button type='button' class='btn btn-info miBotonEliminar btn-danger btn-sm'  data-idCuenta='" + cuenta.id_cuenta + "' data-cuenta='" + cuenta.cuenta + "' data-idIndice='" + indice + "'> Borrar</button></td>\n\
                                                                    </tr>");
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


        function archivarCuenta() {
            if (window.XMLHttpRequest) //mozilla
            {
                ajax = new XMLHttpRequest(); //No Internet explorer
            } else
            {
                ajax = new ActiveXObject("Microsoft.XMLHTTP");
            }

            var myObj = {};

            myObj["col1"] = $("#idElimCuentaHide").val().trim();

            var json = JSON.stringify(myObj);
            $.ajax({
                //Usamos GET ya que recibimos.
                type: 'POST',
                url: '/Facturacion/CuentasController/archivarCuenta.htm',
                data: json,
                datatype: "json",
                contentType: "application/json",
                success: function (data) {
                    $("#tbody-tabla-cuentas").children().eq($("#idElimCuentaFilaHide").val()).hide();
                    alert("Cuenta Archivada Correctamente");
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    console.log(xhr.status);
                    console.log(xhr.responseText);
                    console.log(thrownError);
                }
            });
        }
        ;

        function anadirCuenta() {
            if (window.XMLHttpRequest) //mozilla
            {
                ajax = new XMLHttpRequest(); //No Internet explorer
            } else
            {
                ajax = new ActiveXObject("Microsoft.XMLHTTP");
            }

            var myObj = {};

            myObj["col1"] = $("#denominacion").val().trim();

            var json = JSON.stringify(myObj);
            $.ajax({
                //Usamos GET ya que recibimos.
                type: 'POST',
                url: '/Facturacion/CuentasController/anadirCuenta.htm',
                data: json,
                datatype: "json",
                contentType: "application/json",
                success: function (data) {
                    
                    getCuentas();
                    
                    //$("#tbody-tabla-cuentas").children().eq($("#idElimCuentaFilaHide").val()).hide();
                    //alert("Cuenta Archivada Correctamente");
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

                    <!--<form role="form">-->
                    <br style="clear:both">

                    <h3 style="margin-bottom: 25px; text-align: center;">CARTA DE CUENTAS</h3>  


                    <div class="col-xs-6" id="tableContainer1">
                        <table class="table table-striped">                                    

                            <thead class="thead-dark">
                                <tr>
                                    <th scope="col" colspan="4" style="text-align:center;">Cuentas</th>        
                                </tr>    
                                <tr>
                                    <th scope="col">#</th>
                                    <th scope="col">ID CUENTA</th>
                                    <th scope="col">DENOMINACIÓN</th>
                                    <th scope="col">ACTIVA</th>

                                </tr>                                            
                            </thead>

                            <tbody id="tbody-tabla-cuentas">

                            </tbody>
                        </table>
                    </div>    

                    <div class="col-xs-6" id="tableContainer2">
                        <table class="table table-striped">                                    

                            <thead class="thead-dark">
                                <tr>
                                    <th scope="col" colspan="4" style="text-align:center;">Empresas</th>        
                                </tr>    
                                <tr>
                                    <th scope="col">#</th>
                                    <th scope="col">ID EMPRESA</th>
                                    <th scope="col">DISTINCT CODE</th>                                    
                                    <th scope="col">ACTIVA</th>
                                </tr>                                            
                            </thead>

                            <tbody id="tbody-tabla-empresas">

                            </tbody>
                        </table>
                    </div>       


                    <br style="clear:both">

                    <a href="/Facturacion/MenuController/start.htm" class="btn btn-info" role="button">Menu principal</a>                     
                    <button type="button" id="submit" name="submit" class="btn btn-primary">Submit</button>


                    <!-- ventana emergente Añadir-->
                    <div class="modal fade" id="myModalAnadirCuenta" role="dialog">
                        <!-- Declaramos los campos ocultos para en la funcion de ajax podamos guardar los datos -->
                        <input  id="idAnadirCuentaHide"/>
                        <input  id="idAnadirCuentaFilaHide"/>

                        <div class="modal-dialog">

                            <!-- Modal content-->
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                    <h4 class="modal-title">Añadir Cuenta</h4>
                                </div>
                                <div class="modal-body">
                                    <p id="anadirItem"></p>  
                                    <div class="form-area">  
                                        <div class="row"> 
                                            <div class="form-group col-xs-3">
                                                <label for="denominacion">Denominación:</label>
                                            </div>
                                            <div class="form-group col-xs-5">
                                                <input type="text" class="form-control" id="denominacion" name="denominacion">
                                            </div> 
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <!-- Llamamos a la funcion eliminarEntidad al pusar en si, al pulsar en no, no hacemos nada y volvemos a la pagina donde mostramos la lista-->
                                    <button type="button" class="btn btn-info" data-dismiss="modal" onclick="anadirCuenta()">Añadir</button>
                                    <button type="button" class="btn btn-warning" data-dismiss="modal">Cancelar</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- ventana emergente Archivar Cuenta-->
                    <div class="modal fade" id="myModalEliminarCuenta" role="dialog">
                        <!-- Declaramos los campos ocultos para en la funcion de ajax podamos guardar los datos -->
                        <input id="idElimCuentaHide"/>
                        <input id="idElimCuentaTipoHide"/>
                        <input id="idElimCuentaFilaHide"/>

                        <div class="modal-dialog">

                            <!-- Modal content-->
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                    <h4 class="modal-title">Archivar Cuenta</h4>
                                </div>
                                <div class="modal-body">
                                    <p id="eliminarCuenta"></p>                            
                                </div>
                                <div class="modal-footer">
                                    <!-- Llamamos a la funcion eliminarEntidad al pusar en si, al pulsar en no, no hacemos nada y volvemos a la pagina donde mostramos la lista-->
                                    <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="archivarCuenta()">Archivar</button>
                                    <button type="button" class="btn btn-info" data-dismiss="modal">Cancelar</button>
                                </div>
                            </div>
                        </div>
                    </div>


                </div>
            </div>
        </div>
    </body> 
</html>
