
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="jstl" uri="http://java.sun.com/jstl/core_rt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>

<html>
    <%@ include file="infouser.jsp" %>
    <head> 
        <title>MODIFICAR CARGOS</title> 
        <style>

            .container {
                width: 1170px;
            }
            .azul{
                color:blue;
            }

        </style>
    </head>

    <script>

        $(document).ready(function () {

            //Recuperamos valores de la url 
            var idCargo = obtenerValorParametro("idCar");
            var idCliente = obtenerValorParametro("idCli");
            var idEmpresa = obtenerValorParametro("idEmp");
            var idTipoImp = obtenerValorParametro("idTipImp");

            getEntidadCliente(idCliente);
            getEntidadEmpresa(idEmpresa);
            getCargo(idCargo, idTipoImp);

            alert(idCliente);
            var userLang = navigator.language || navigator.userLanguage;

            

            $("#volver").click(function () {
                cli = $("#id_entidad").text();
                alert(cli);
            });

            //Se pone dentro del ready porque se ejecuta cada vez que entramos en la pagina.
            //Constructor para el calendario Fecha-Cargo.
            $('#fecha_cargo').datetimepicker({
                format: 'YYYY-MM-DD',
                locale: userLang.valueOf(),
                daysOfWeekDisabled: [0, 6],
                useCurrent: false//Important! See issue #1075
                        //defaultDate: '08:32:33',
                        //                });
            });

            //Se pone dentro del ready porque se ejecuta cada vez que entramos en la pagina.
            //Constructor para el calendario Fecha-Cargo.
            $('#fecha_vencimiento').datetimepicker({
                format: 'YYYY-MM-DD',
                locale: userLang.valueOf(),
                daysOfWeekDisabled: [0, 6],
                useCurrent: false//Important! See issue #1075
                        //defaultDate: '08:32:33',
                        //                });
            });

            //Guarda los datos introducidos en el formulario en la tabla cargos
            $("#modificarCargos").click(function () {
                if (window.XMLHttpRequest) //mozilla
                {
                    ajax = new XMLHttpRequest(); //No Internet explorer
                } else
                {
                    ajax = new ActiveXObject("Microsoft.XMLHTTP");
                }

                var myObj = {};
                myObj["id_cargo"] = $("#id_cargo").text();
//                myObj["id_item"] = "1"; //$("#id_cargo").val().trim();
                myObj["abreviatura"] = $("#abreviatura").text();
                myObj["descripcion"] = $("#descripcion").text();
                myObj["id_tipo_item"] = $("#id_tipo_item").val().trim();
                myObj["cuenta"] = $("#cuenta").val().trim();
                myObj["importe"] = $("#importe").val().trim();
                myObj["cantidad"] = $("#cantidad").val().trim();


                //Codigo para introducir el tipo de impuesto
                //cogemos el valor del combo comboTipoImpuesto que trae el id y el valor
                tipoImpuesto = $("#comboTipoImpuesto").val();
                //separamos el id y el valor
                arrayDeCadenas = tipoImpuesto.split(",");
                var tipoImp = arrayDeCadenas[0];
                var valorImp = arrayDeCadenas[1];

                //Grabamos el tipo de impuesto
                myObj["impuesto"] = tipoImp;

                myObj["total"] = $("#total").val().trim();

                //dentro de fecha cargo tenemos que coger el valor que hay dentro de input.
                myObj["fecha_cargo"] = $("#fecha_cargo input").val().trim();
                //dentro de fecha vencimiento tenemos que coger el valor que hay dentro de input.
                myObj["fecha_vencimiento"] = $("#fecha_vencimiento input").val().trim();

                //Estas dos tendran valores fijos a true y 0
                //myObj["estado"] = true
                //myObj["id_factura"] = 0

                //Id de cliente y empresa
                myObj["id_cliente"] = $("#id_entidad").text();
                myObj["id_empresa"] = $("#id_entidad2").text();

                myObj["valor_impuesto"] = $("#valorImpuesto").val().trim();


                var json = JSON.stringify(myObj);
                $.ajax({
                    type: 'POST',
                    url: '/Facturacion/modificarCargosController/modificarCargo.htm',
                    data: json,
                    datatype: "json",
                    contentType: "application/json",
                    success: function (data) {
                        alert(data);
                        //Refrescando la pantalla 
                        location.reload();
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        console.log(xhr.status);
                        console.log(xhr.responseText);
                        console.log(thrownError);
                    }
                });
            });
        })
        ;

        //Funcion para obtener los valores pasados por URL
        function obtenerValorParametro(sParametroNombre) {
            var sPaginaURL = window.location.search.substring(1);
            var sURLVariables = sPaginaURL.split('&');
            for (var i = 0; i < sURLVariables.length; i++) {
                var sParametro = sURLVariables[i].split('=');
                if (sParametro[0] == sParametroNombre) {
                    return sParametro[1];
                }
            }
            return null;
        }
        ;

        function getEntidadCliente(idCliente) {
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
                url: '/Facturacion/modificarCargosController/getEntidadCliente.htm?idCli=' + idCliente, //Vamos a cargosController/getCliente.htm a recoger los datos
                success: function (data) {

                    var clienteEntidad = JSON.parse(data);

                    //Lo vamos cargando
                    clienteEntidad.forEach(function (valor, indice) {
                        //Cada objeto esta en String y lo pasmoa a Cliente
                        var clienteEntidad2 = JSON.parse(valor);

                        $("#dis_cod_cli").text(clienteEntidad2.col2);
                        $("#id_entidad").text(clienteEntidad2.col1);
                        $("#nombre_entidad").text(clienteEntidad2.col3);
                        $("#nombre_contacto").text(clienteEntidad2.col4);
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

        function getEntidadEmpresa(idEmpresa) {
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
                url: '/Facturacion/modificarCargosController/getEntidadEmpresa.htm?idEmp=' + idEmpresa, //Vamos a cargosController/getCliente.htm a recoger los datos
                success: function (data) {

                    var clienteEntidad = JSON.parse(data);

                    //Lo vamos cargando
                    clienteEntidad.forEach(function (valor, indice) {
                        //Cada objeto esta en String y lo pasmoa a Cliente
                        var clienteEntidad2 = JSON.parse(valor);

                        $("#dis_cod_emp").text(clienteEntidad2.col2);
                        $("#id_entidad2").text(clienteEntidad2.col1);
                        $("#nombre_entidad2").text(clienteEntidad2.col3);
                        $("#nombre_contacto2").text(clienteEntidad2.col4);
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

        function getCargo(idCargo, idTipoImp) {
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
                url: '/Facturacion/modificarCargosController/getCargo.htm?idCar=' + idCargo, //Vamos a cargosController/getCliente.htm a recoger los datos
                success: function (data) {

                    var clienteEntidad = JSON.parse(data);

                    //Lo vamos cargando
                    clienteEntidad.forEach(function (valor, indice) {
                        //Cada objeto esta en String y lo pasmoa a Cliente
                        var clienteEntidad2 = JSON.parse(valor);

                        $("#id_cargo").text(clienteEntidad2.col1);
                        $("#abreviatura").text(clienteEntidad2.col2);
                        $("#descripcion").text(clienteEntidad2.col3);
                        $("#id_tipo_item").text(clienteEntidad2.col4);
                        $("#cuenta").val(clienteEntidad2.col5);
                        $("#importe").val(clienteEntidad2.col6);
                        $("#cantidad").val(clienteEntidad2.col7);
                        //Llamamos a una funcion para llenar el combo
                        getTipoImpuesto(idTipoImp);
                        $("#valorImpuesto").val(clienteEntidad2.col9);
                        $("#total").val(clienteEntidad2.col10);
                        if (clienteEntidad2.col11 == 1) {
                            $("#periodicidad").text("Puntual");
                        } else {
                            $("#periodicidad").text("Periódico");
                        }
                        $("#fecha_cargo input").val(clienteEntidad2.col12.substr(0, 10));
                        $("#fecha_vencimiento input").val(clienteEntidad2.col13.substr(0, 10));

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

        function getTipoImpuesto(idTipoImp) {

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
                url: '/Facturacion/modificarCargosController/getTipoImpuesto.htm', //Vamos a modificarCargosController/getTipoImpuesto.htm a recoger los datos
                success: function (data) {

                    var tipoImpuesto = JSON.parse(data);
                    //Identificamos el combo
                    select = document.getElementById('comboTipoImpuesto');
                    //Añadimos la opcion Seleccionar al combo
//                    var opt = document.createElement('option');
//                    opt.value = "0,0";
//                    opt.innerHTML = "Seleccionar";
//                    select.appendChild(opt);

                    //Lo vamos cargando
                    tipoImpuesto.forEach(function (valor, indice) {
                        //Cada objeto esta en String y lo pasmoa a TipoImpuesto
                        var tipoImpuesto2 = JSON.parse(valor);
                        //Creamos las opciones del combo
                        var opt = document.createElement('option');
                        //Guardamos el valor del impuesto en el value de cada opcion
                        opt.value = tipoImpuesto2.id_tipo_impuesto + "," + tipoImpuesto2.valor;
                        //Guardamos el impuesto en el nombre de cada opcion
                        opt.innerHTML = tipoImpuesto2.impuesto;
                        //Controlamos que opcion estaba marcada
                        if (tipoImpuesto2.id_tipo_impuesto == idTipoImp) {
                            opt.selected = true;
                        }
                        //Añadimos la opcion
                        select.appendChild(opt);
                    });
                    //document.getElementById("comboTipoImpuesto").value = "0,0";

                },
                error: function (xhr, ajaxOptions, thrownError) {
                    console.log(xhr.status);
                    console.log(xhr.responseText);
                    console.log(thrownError);
                }
            });

            //Se ejecuta al cambiar el contenido del importe
            $("#importe").keyup(function () {
                //Llamamos a la funcion calcularTotal() que calcula el total del cargo
                calcularTotal();
            });

            //Se ejecuta al cambiar el contenido de la cantidad
            $("#cantidad").keyup(function () {
                //Llamamos a la funcion calcularTotal() que calcula el total del cargo
                calcularTotal();
            });

            //Se ejecuta al cambiar el contenido del comboTipoImpuesto
            $("#comboTipoImpuesto").change(function () {
                //Llamamos a la funcion calcularTotal() que calcula el total del cargo
                calcularTotal();
            });

        }
        ;

        //Funcion que realiza los calculos al modificar la cantidad, importe o impuesto
        function calcularTotal() {
            //cogemos el valor del combo comboTipoImpuesto que trae el id y el valor
            tipoImpuesto = $("#comboTipoImpuesto").val();

            //separamos el id y el valor
            arrayDeCadenas = tipoImpuesto.split(",");
            var tipoImp = arrayDeCadenas[0];
            var valorImp = arrayDeCadenas[1];

            //Hacemos los calculos de importes e impuestos
            importe = $("#importe").val().trim();
            cantidad = $("#cantidad").val().trim();
            subtotal = importe * cantidad;
            total = $("#total").val();

            //Quitamos decimales total sin impuestos
            var subTot = parseFloat(Math.round(subtotal * 100) / 100).toFixed(2);
            //Quitamos decimales al valorImpuestos
            var valImp = parseFloat(Math.round((subTot * valorImp / 100) * 100) / 100).toFixed(2);
            //Calculamos el total con impuestos
            var valTot = (subtotal * valorImp / 100) + subtotal;
            //Quitamos decimales al total con impuestos
            var valTotImp = parseFloat(Math.round(valTot * 100) / 100).toFixed(2);

            if (tipoImp == 0) {
                $("#valorImpuesto").val(0);
                $("#total").val(subTot);
                //$("#total").val(importe * cantidad);
            } else {
                $("#valorImpuesto").val(valImp);
                $("#total").val(valTotImp);
                //$("#valorImpuesto").val(subtotal * valorImp / 100);
                //$("#total").val((subtotal * valorImp / 100) + subtotal);
            }
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
                            <h3 style="margin-bottom: 25px; text-align: center;">Modificar CARGOS</h3>     

                            <!--DATOS CLIENTE-->
                            <div class="datos row" class="col-xs-12">                                

                                <div class="form-group col-xs-2">
                                    <label for="dis_cod_cli">Cliente </label>
                                    <br>
                                    <label class="azul" id="dis_cod_cli" name="dis_cod_cli"></label>                                    
                                </div> 
                                <div class="form-group col-xs-2">
                                    <label for="id_entidad">Id Cliente </label>
                                    <br>
                                    <label class="azul" id="id_entidad" name="id_entidad"></label>                                    
                                </div> 
                                <div class="form-group col-xs-4">
                                    <label for="nombre_entidad>">Nombre Cliente</label>
                                    <br>
                                    <label class="azul" id="nombre_entidad" name="nombre_entidad"></label>
                                </div>
                                <div class="form-group col-xs-3">
                                    <label for="nombre_contacto>">Nombre contacto</label>
                                    <br>
                                    <label class="azul" id="nombre_contacto" name="nombre_contacto"></label>
                                </div>   
                            </div>  

                            <br style="clear:both">

                            <!--DATOS EMPRESA--> 
                            <div class="datos row" class="col-xs-12">

                                <div class="form-group col-xs-2">
                                    <label for="dis_cod_emp">Empresa </label>
                                    <br>
                                    <label class="azul" id="dis_cod_emp" name="dis_cod_emp"></label>                                    
                                </div> 
                                <div class="form-group col-xs-2">
                                    <label for="id_entidad2>">Id Empresa</label>
                                    <br>
                                    <label class="azul" id="id_entidad2" name="id_entidad2"></label>                                    
                                </div>
                                <div class="form-group col-xs-4">
                                    <label for="nombre_entidad2>">Nombre Empresa</label>
                                    <br>
                                    <label class="azul" id="nombre_entidad2" name="nombre_entidad2"></label>                                    
                                </div>
                                <div class="form-group col-xs-3">
                                    <label for="nombre_contacto2>">Nombre Empresa</label>
                                    <br>
                                    <label class="azul" id="nombre_contacto2" name="nombre_contacto2"></label>

                                </div>
                            </div>           

                            <br style="clear:both">

                            <!--DATOS ITEMS--> 
                            <div class="datos row" class="col-xs-12">                                

                                <div class="form-group col-xs-2">
                                    <label for="id_cargo>">Id. Cargo</label>
                                    <br>
                                    <label class="azul" id="id_cargo" name="id_cargo"></label>     
                                </div>
                                <div class="form-group col-xs-3">
                                    <label for="abreviatura>">Abreviatura</label>
                                    <br>
                                    <label class="azul" id="abreviatura" name="abreviatura"></label>   
                                </div>
                                <div class="form-group col-xs-5">
                                    <label for="descripcion>">Descripción</label>
                                    <br>
                                    <label class="azul" id="descripcion" name="descripcion"></label>   
                                </div>
                                <div class="form-group col-xs-2">
                                    <label for="id_tipo_item>">Tipo Item</label>
                                    <br>
                                    <label class="azul" id="id_tipo_item" name="id_tipo_item"></label>   
                                </div>
                            </div>

                            <div class="datos row" class="col-xs-12">
                                <div class="form-group col-xs-2">
                                    <label for="importe>">Cuenta</label>
                                    <input type="text" class="form-control input-sm" id="cuenta" name="cuenta">
                                </div>   
                                <div class="form-group col-xs-2">
                                    <label for="importe>">Importe</label>
                                    <input type="text" class="form-control input-sm" id="importe" name="importe">
                                </div>
                                <div class="form-group col-xs-2">
                                    <label for="cantidad>">Cantidad</label>
                                    <input type="text" class="form-control input-sm" id="cantidad" name="cantidad" value="1">
                                </div>
                                <div class="form-group col-xs-2">
                                    <label for="comboTipoImpuesto">Tipo Impuesto</label>
                                    <div class="form-group-combo">                                        
                                        <select class="form-control input-sm" id="comboTipoImpuesto" name="comboTipoImpuesto">
                                        </select>                                                            
                                    </div>     
                                </div>                              
                                <div class="form-group col-xs-2">
                                    <label for="valorImpuesto">Impuestos</label>
                                    <input type="text" class="form-control input-sm" id="valorImpuesto" name="valorImpuesto" value="0" disabled>                                    
                                </div>

                                <div class="form-group col-xs-2">
                                    <label for="total>">Total</label>
                                    <input type="text" class="form-control input-sm" id="total" name="total" disabled>
                                </div>

                            </div>
                            <br style="clear:both">     

                            <div class="datos row" class="col-xs-12">
                                <div class="form-group col-xs-3">
                                    <label for="periodicidad">Tipo Periodicidad:</label>
                                    <label class="azul" id="periodicidad" name="periodicidad"></label>   
                                </div>                              
                                <div class='col-xs-4 col-md-4'>
                                    <label class="fechaCargos">Fecha Pago</label>
                                    <div class="form-group">
                                        <div class='input-group date' id='fecha_cargo' name='fecha_cargo'>
                                            <input  data-format="yyyy-MM-dd hh:mm:ss" type='text' class="form-control"/>
                                            <span class="input-group-addon">
                                                <span class="glyphicon glyphicon-calendar"></span>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <script type="text/javascript">
                                    $(function () {
                                        $('#fecha_cargo').datetimepicker();
                                    });
                                </script>

                                <div class='col-xs-4 col-md-4'>
                                    <label class="fechaCargos">Fecha Vencimiento</label>
                                    <div class="form-group">
                                        <div class='input-group date' id='fecha_vencimiento' name='fecha_vencimiento'>
                                            <input  data-format="yyyy-MM-dd hh:mm:ss" type='text' class="form-control"/>
                                            <span class="input-group-addon">
                                                <span class="glyphicon glyphicon-calendar"></span>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <script type="text/javascript">
                                    $(function () {
                                        $('#fecha_vencimiento').datetimepicker();
                                    });
                                </script>
                            </div>

                            <button type="button" id="modificarCargos" name="modificarCargos" class="btn btn-warning pull-right">Modificar</button>
                            <a href="/Facturacion/MenuController/start.htm" class="btn btn-info" role="button">Menu principal</a>   
                            
                            <a href="javaScript:window.close();" class="btn btn-info" role="button">Cerrar</a> 
                                                    

                        </form>
                    </div>
                </div>                            
            </div>
        </div>

    </body> 

</html>
