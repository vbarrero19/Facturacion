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
                    $('#tableContainer1 tbody').empty();

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
                                                                    <td><button type='button' class='btn miBotonModificarCuenta btn-warning btn-sm'  data-idCuenta='" + cuenta.id_cuenta + "' data-cuenta='" + cuenta.cuenta + "' data-idIndice='" + indice + "'> Modificar</button></td>\n\
                                                                    <td><button type='button' class='btn miBotonEliminarCuenta btn-danger btn-sm'  data-idCuenta='" + cuenta.id_cuenta + "' data-cuenta='" + cuenta.cuenta + "' data-idIndice='" + indice + "'> Archivar </button></td>\n\
                                                                    </tr>");
                    });

                    /*Creamos la funcion que al hacer click en el boton eliminar nos muestre el modal, identificamos el boton con el nombre miBoton*/
                    $(document).ready(function () {

                        $(".miBotonActivarCuenta").click(function () {

                            /*Guardamos los valores que recogemos de los parametros declarados en el boton(arriba) y lo recogemos con .val($this...) 
                             * en los campos ocultos que nos hemos declarado en el html para que al pinchar en el boton no se pierdan los datos.*/
                            $("#idActivarCuentaHide").val($(this).attr("data-idCuenta"));

                            $("#denominacionModificar").val($("#idModifCuentaTipoHide").val());

                            /********Codigo */

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
                                url: '/Facturacion/cuentasController/getCuentasDesactivadas.htm',
                                success: function (data) {

                                   $('#activarCuentaCombo').empty();

                                    //Recogemos los datos del combo y los pasamos a objetos TipoImpuesto  
                                    var aux = JSON.parse(data);
                                    //Identificamos el combo
                                    select = document.getElementById('activarCuentaCombo');
                                    //Añadimos la opcion Seleccionar al combo
                                    var opt = document.createElement('option');
                                    opt.value = 0;
                                    opt.innerHTML = "Seleccionar";
                                    select.appendChild(opt);
                                    //Lo vamos cargando
                                    aux.forEach(function (valor, indice) {
                                        //Cada objeto esta en String y lo pasmoa a TipoImpuesto
                                        var aux2 = JSON.parse(valor);
                                        //Creamos las opciones del combo
                                        var opt = document.createElement('option');
                                        //Guardamos el id en el value de cada opcion
                                        opt.value = aux2.id_cuenta;
                                        //Guardamos el impuesto en el nombre de cada opcion
                                        //                 opt.innerHTML = aux2.id_impuesto;
                                        opt.innerHTML = aux2.cuenta;
                                        //Añadimos la opcion
                                        select.appendChild(opt);
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

                            /************************/

                            /*Una vez guardados los datos en los campos ocultos, mostramos el modal con los datos*/
                            $("#myModalActivarCuenta").modal();
                        })
                        ;

                        $(".miBotonModificarCuenta").click(function () {

                            /*Guardamos los valores que recogemos de los parametros declarados en el boton(arriba) y lo recogemos con .val($this...) 
                             * en los campos ocultos que nos hemos declarado en el html para que al pinchar en el boton no se pierdan los datos.*/
                            $("#idModifCuentaHide").val($(this).attr("data-idCuenta"));
                            $("#idModifCuentaTipoHide").val($(this).attr("data-cuenta"));
                            $("#idModifCuentaFilaHide").val($(this).attr("data-idIndice"));

                            $("#denominacionModificar").val($("#idModifCuentaTipoHide").val());

                            /*Una vez guardados los datos en los campos ocultos, mostramos el modal con los datos*/
                            $("#myModalModificarCuenta").modal();
                        })
                        ;

                        $(".miBotonAnadirCuenta").click(function () {

                            /*Guardamos los valores que recogemos de los parametros declarados en el boton(arriba) y lo recogemos con .val($this...) 
                             * en los campos ocultos que nos hemos declarado en el html para que al pinchar en el boton no se pierdan los datos.*/
                            $("#idAnadirCuentaHide").val($(this).attr("data-idCuenta"));

                            /*Una vez guardados los datos en los campos ocultos, mostramos el modal con los datos*/
                            $("#myModalAnadirCuenta").modal();

                        })
                        ;

                        $(".miBotonEliminarCuenta").click(function () {

                            /*Guardamos los valores que recogemos de los parametros declarados en el boton(arriba) y lo recogemos con .val($this...) 
                             * en los campos ocultos que nos hemos declarado en el html para que al pinchar en el boton no se pierdan los datos.*/
                            $("#idElimCuentaHide").val($(this).attr("data-idCuenta"));
                            $("#idElimCuentaTipoHide").val($(this).attr("data-cuenta"));
                            $("#idElimCuentaFilaHide").val($(this).attr("data-idIndice"));

                            $("#eliminarCuenta").text("Desea eliminar la cuenta: " + $("#idElimCuentaTipoHide").val());

                            /*Una vez guardados los datos en los campos ocultos, mostramos el modal con los datos*/
                            $("#myModalEliminarCuenta").modal();
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
                    $('#tableContainer2 tbody').empty();
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

            myObj["col1"] = $("#denominacionAnadir").val().trim();

            var json = JSON.stringify(myObj);
            $.ajax({
                //Usamos GET ya que recibimos.
                type: 'POST',
                url: '/Facturacion/CuentasController/anadirCuenta.htm',
                data: json,
                datatype: "json",
                contentType: "application/json",
                success: function (data) {
                    alert(data);
                    getCuentas();

                },
                error: function (xhr, ajaxOptions, thrownError) {
                    console.log(xhr.status);
                    console.log(xhr.responseText);
                    console.log(thrownError);
                }
            });
        }
        ;

        function modificarCuenta() {
            if (window.XMLHttpRequest) //mozilla
            {
                ajax = new XMLHttpRequest(); //No Internet explorer
            } else
            {
                ajax = new ActiveXObject("Microsoft.XMLHTTP");
            }

            var myObj = {};

            myObj["col1"] = $("#denominacionModificar").val().trim();
            myObj["col2"] = $("#idModifCuentaHide").val().trim();

            var json = JSON.stringify(myObj);
            $.ajax({
                //Usamos GET ya que recibimos.
                type: 'POST',
                url: '/Facturacion/CuentasController/modificarCuenta.htm',
                data: json,
                datatype: "json",
                contentType: "application/json",
                success: function (data) {
                    alert(data);
                    getCuentas();

                },
                error: function (xhr, ajaxOptions, thrownError) {
                    console.log(xhr.status);
                    console.log(xhr.responseText);
                    console.log(thrownError);
                }
            });
        }
        ;

        function activarCuenta() {
            if (window.XMLHttpRequest) //mozilla
            {
                ajax = new XMLHttpRequest(); //No Internet explorer
            } else
            {
                ajax = new ActiveXObject("Microsoft.XMLHTTP");
            }

            var myObj = {};

            myObj["col1"] = $("#activarCuentaCombo").val();
            //myObj["col2"] = $("#idModifCuentaHide").val().trim();

            var json = JSON.stringify(myObj);
            $.ajax({
                //Usamos GET ya que recibimos.
                type: 'POST',
                url: '/Facturacion/CuentasController/activarCuenta.htm',
                data: json,
                datatype: "json",
                contentType: "application/json",
                success: function (data) {
                    alert(data);
                    getCuentas();

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
                                    <th><button type="button" class='btn btn-info miBotonAnadirCuenta btn-success btn-sm' data-dismiss="modal">&nbsp;  Añadir &nbsp;&nbsp; </button></th>
                                    <th><button type="button" class='btn btn-info miBotonActivarCuenta btn-info btn-sm' data-dismiss="modal">Activar &nbsp;</button></th>
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


                    <!-- ventana emergente Modificar Cuenta-->
                    <div class="modal fade" id="myModalModificarCuenta" role="dialog">
                        <!-- Declaramos los campos ocultos para en la funcion de ajax podamos guardar los datos -->
                        <input id="idModifCuentaHide"/>
                        <input id="idModifCuentaTipoHide"/>
                        <input id="idModifCuentaFilaHide"/>

                        <div class="modal-dialog">

                            <!-- Modal content-->
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                    <h4 class="modal-title">Modificar Cuenta</h4>
                                </div>
                                <div class="modal-body">
                                    <p id="anadirItem"></p>  
                                    <div class="form-area">  
                                        <div class="row"> 
                                            <div class="form-group col-xs-3">
                                                <label for="denominacionModificar">Denominación:</label>
                                            </div>
                                            <div class="form-group col-xs-5">
                                                <input type="text" class="form-control" id="denominacionModificar" name="denominacionModificar">
                                            </div> 
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <!-- Llamamos a la funcion eliminarEntidad al pusar en si, al pulsar en no, no hacemos nada y volvemos a la pagina donde mostramos la lista-->
                                    <button type="button" class="btn btn-info btn-sm" data-dismiss="modal" onclick="modificarCuenta()">Modificar</button>
                                    <button type="button" class="btn btn-warning btn-sm" data-dismiss="modal">Cancelar</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- ventana emergente Añadir Cuenta-->
                    <div class="modal fade" id="myModalAnadirCuenta" role="dialog">
                        <!-- Declaramos los campos ocultos para en la funcion de ajax podamos guardar los datos -->
                        <input  id="idAnadirCuentaHide"/>
                        <!--                        <input  id="TextoCuentaHide"/>-->

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
                                                <label for="denominacionAnadir">Denominación:</label>
                                            </div>
                                            <div class="form-group col-xs-5">
                                                <input type="text" class="form-control" id="denominacionAnadir" name="denominacionAnadir">
                                            </div> 
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <!-- Llamamos a la funcion eliminarEntidad al pusar en si, al pulsar en no, no hacemos nada y volvemos a la pagina donde mostramos la lista-->
                                    <button type="button" class="btn btn-info btn-sm" data-dismiss="modal" onclick="anadirCuenta()">Añadir</button>
                                    <button type="button" class="btn btn-warning btn-sm" data-dismiss="modal">Cancelar</button>
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
                                    <button type="button" class="btn btn-danger btn-sm" data-dismiss="modal" onclick="archivarCuenta()">Archivar</button>
                                    <button type="button" class="btn btn-info btn-sm" data-dismiss="modal">Cancelar</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- ventana emergente Activar Cuenta-->
                    <div class="modal fade" id="myModalActivarCuenta" role="dialog">
                        <!-- Declaramos los campos ocultos para en la funcion de ajax podamos guardar los datos -->
                        <input  id="idActivarCuentaHide"/>                        

                        <div class="modal-dialog">

                            <!-- Modal content-->
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                    <h4 class="modal-title">Activar Cuenta</h4>
                                </div>
                                <div class="modal-body">
                                    <p id="anadirItem"></p>  
                                    <div class="form-area">  
                                        <div class="row"> 
                                            <div class="form-group col-xs-3">
                                                <label for="activarCuentaCombo">Denominación:</label>
                                            </div>
                                            <div class="form-group col-xs-5">
                                                <select class="form-control" id="activarCuentaCombo" name="activarCuentaCombo">
                                                </select>  
                                            </div> 
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">                                    
                                    <button type="button" class="btn btn-info btn-sm" data-dismiss="modal" onclick="activarCuenta()">Activar</button>
                                    <button type="button" class="btn btn-warning btn-sm" data-dismiss="modal">Cancelar</button>
                                </div>
                            </div>
                        </div>
                    </div>



                </div>
            </div>
        </div>
    </body> 
</html>
