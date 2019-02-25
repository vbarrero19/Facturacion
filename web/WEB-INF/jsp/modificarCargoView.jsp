
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
            //Al cargar la pagina llamamos a las funciones getCliente() y getEmpresa() para llenar los combos
            getEntidadCliente();
            //getEntidadEmpresa(); 
            //getItem();
            //getTipoImpuesto();

            //Recuperamos valores de la url 
            var idCargo = obtenerValorParametro("idCar");
            var idCliente = obtenerValorParametro("idCli");
            var idEmpresa = obtenerValorParametro("idEmp");

            alert(idCargo);
            alert(idCliente);
            alert(idEmpresa);

            //Mostramos la fecha actual
//            var f = new Date();
//            var fecha = f.getDate() + "/" + (f.getMonth() + 1) + "/" + f.getFullYear();
//
//            var meses = new Array("Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre");
//            //alert(fecha)
//
//            $('#puntual').show();
//            $('#periodico').hide();
//
//            $("#exampleRadios1").on("click", function () {
//                $('#puntual').show();
//                $('#periodico').hide();
//            });
//
//            $("#exampleRadios2").on("click", function () {
//                $('#puntual').hide();
//                $('#periodico').show();
//            });
//
//
//            //tratando de omstrar fechas dinamicamente            
//            var mes = f.getMonth();
//            var nombreMes = meses[f.getMonth()];
//            //alert(nombreMes);
//            //cargamos de forma dinamica la tabla
//            for (var i = 0; i < 12; i = i + 6) {
//                $('#tbody-tabla-meses').append(" <tr>\n\
//                                                                    <td id='id" + (i + 1) + "'> <input type='checkbox' name='chkHos' value ='mes' > </td>              \n\
//                                                                    <td>" + meses[i] + "</td>          \n\ \n\
//                                                                    <td id='id" + (i + 2) + "'> <input type='checkbox' name='chkHos' value ='mes' > </td>              \n\
//                                                                    <td>" + meses[i + 1] + "</td>          \n\ \n\
//                                                                    <td id='id" + (i + 3) + "'> <input type='checkbox' name='chkHos' value ='mes' > </td>              \n\
//                                                                    <td>" + meses[i + 2] + "</td>          \n\ \n\
//                                                                    <td id='id" + (i + 4) + "'> <input type='checkbox' name='chkHos' value ='mes' > </td>              \n\
//                                                                    <td>" + meses[i + 3] + "</td>          \n\ \n\
//                                                                    <td id='id" + (i + 5) + "'> <input type='checkbox' name='chkHos' value ='mes' > </td>              \n\
//                                                                    <td>" + meses[i + 4] + "</td>          \n\ \n\
//                                                                    <td id='id" + (i + 6) + "'> <input type='checkbox' name='chkHos' value ='mes' > </td>              \n\
//                                                                    <td>" + meses[i + 5] + "</td>          \n\ \n\
//                                                                </tr>");
//            }


            var userLang = navigator.language || navigator.userLanguage;

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
            $("#grabarCargos").click(function () {
                if (window.XMLHttpRequest) //mozilla
                {
                    ajax = new XMLHttpRequest(); //No Internet explorer
                } else
                {
                    ajax = new ActiveXObject("Microsoft.XMLHTTP");
                }

                var myObj = {};
                myObj["id_item"] = $("#id_item").val().trim();
                myObj["abreviatura"] = $("#abreviatura").val().trim();
                myObj["descripcion"] = $("#descripcion").val().trim();

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

                myObj["id_impuesto"] = tipoImp;

                myObj["total"] = $("#total").val().trim();

                //dentro de fecha cargo tenemos que coger el valor que hay dentro de input.
                myObj["fecha_cargo"] = $("#fecha_cargo input").val().trim();
                //dentro de fecha vencimiento tenemos que coger el valor que hay dentro de input.
                myObj["fecha_vencimiento"] = $("#fecha_vencimiento input").val().trim();

                //Estas dos tendran valores fijos a true y 0
                //myObj["estado"] = $("#estado").val().trim();
                //myObj["id_factura"] = $("#id_factura").val().trim();

                //Id de cliente y empresa
                myObj["id_cliente"] = $("#id_entidad").text();
                myObj["id_empresa"] = $("#id_entidad2").text();

                myObj["valor_impuesto"] = $("#valorImpuesto").val().trim();


                var json = JSON.stringify(myObj);
                $.ajax({
                    type: 'POST',
                    url: '/Facturacion/cargosController/nuevoCargo.htm',
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

        function getEntidadCliente() {
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
                url: '/Facturacion/verCargosController/getEntidadCliente.htm', //Vamos a cargosController/getCliente.htm a recoger los datos
                success: function (data) {

                    //Recogemos los datos del combo y los pasamos a objetos Entidad  
                    var clienteEntidad = JSON.parse(data);
                    //Identificamos el combo
                    select = document.getElementById('comboClientes');
                    //Añadimos la opcion Seleccionar al combo
                    var opt = document.createElement('option');
                    opt.value = 0;
                    opt.innerHTML = "Seleccionar";
                    select.appendChild(opt);

                    //Lo vamos cargando
                    clienteEntidad.forEach(function (valor, indice) {
                        //Cada objeto esta en String y lo pasmoa a Cliente
                        var clienteEntidad2 = JSON.parse(valor);
                        //Creamos las opciones del combo
                        var opt = document.createElement('option');
                        //Guardamos el id en el value de cada opcion
                        opt.value = clienteEntidad2.id_entidad;
                        //Guardamos el impuesto en el nombre de cada opcion
                        opt.innerHTML = clienteEntidad2.distinct_code;
                        //Añadimos la opcion
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

    </script>







    <body>

        <div class="container">
            <div class="col-xs-12">
                <div class="col-md-12 col-xs-5">
                    <div class="form-area">  
                        <form role="form">
                            <br style="clear:both">
                            <h3 style="margin-bottom: 25px; text-align: center;">Modificar CARGOS</h3>                           

                            <div class="datos row" class="col-xs-12">
                                <!--Combo para clientes-->
                                <div class="form-group col-xs-3">
                                    <label for="comboClientes"> Nombre cliente </label>
                                    <div class="form-group-combo">                                        
                                        <select class="form-control input-sm" id="comboClientes" name="comboClientes">
                                        </select>                                                            
                                    </div>
                                </div>

                                <!--DATOS CLIENTE--> 
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
                                <div class="form-group col-xs-3">
                                    <label for="comboEmpresas">Nombre de empresa</label>
                                    <div class="form-group-combo">                                        
                                        <select class="form-control input-sm" id="comboEmpresas" name="comboEmpresas">
                                        </select>                                                            
                                    </div>
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
                                    <label for="comboItems">Items</label>
                                    <div class="form-group-combo">                                        
                                        <select class="form-control input-sm" id="comboItems" name="comboItems">
                                        </select>                                                            
                                    </div>
                                </div>
                                <div class="form-group col-xs-1">
                                    <label for="id_item>">Id.Item</label>
                                    <input type="text" class="form-control input-sm" id="id_item" name="id_item">
                                </div>
                                <div class="form-group col-xs-2">
                                    <label for="abreviatura>">Abreviatura</label>
                                    <input type="text" class="form-control input-sm" id="abreviatura" name="abreviatura">
                                </div>
                                <div class="form-group col-xs-5">
                                    <label for="descripcion>">Descripción</label>
                                    <input type="text" class="form-control input-sm" id="descripcion" name="descripcion">
                                </div>
                                <div class="form-group col-xs-2">
                                    <label for="id_tipo_item>">Tipo Item</label>
                                    <input type="text" class="form-control input-sm" id="id_tipo_item" name="id_tipo_item">
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
                                    <label for="importe>">Cantidad</label>
                                    <input type="text" class="form-control input-sm" id="cantidad" name="cantidad" value="1">
                                </div>
                                <div class="form-group col-xs-2">
                                    <label for="comboTipoImpuesto">Tipo Impuesto</label>
                                    <div class="form-group-combo">                                        
                                        <select class="form-control input-sm" id="comboTipoImpuesto" name="comboTipoImpuesto" disabled>
                                        </select>                                                            
                                    </div>     
                                </div>                              
                                <div class="form-group col-xs-2">
                                    <label for="valorImpuesto">Impuestos</label>
                                    <input type="text" class="form-control input-sm" id="valorImpuesto" name="valorImpuesto" value="0" disabled>                                    
                                </div>

                                <div class="form-group col-xs-2">
                                    <label for="importe>">Total</label>
                                    <input type="text" class="form-control input-sm" id="total" name="total" disabled>
                                </div>

                            </div>

                            <div class="datos row" class="col-xs-12">
                                <div class="form-group col-xs-2">
                                    <label>Tipo Periodicidad:</label>                                    
                                </div>
                                <div class="form-group col-xs-10">
                                    <!--Radio button para tipo de periodicidad-->                                     
                                    <div class="form_radio_button">

                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" name="exampleRadios" id="exampleRadios1" value="puntual" checked>
                                            <label class="form-check-label" for="2">Puntual</label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" name="exampleRadios" id="exampleRadios2" value="periodico">
                                            <label class="form-check-label" for="1">Periódico</label>
                                        </div>
                                    </div>
                                </div>

                            </div>

                            <br style="clear:both">                                


                            <div class="datos row" class="col-xs-12">
                                <div class="col-xs-4" id="puntual">

                                    <div class="row col-xs-12">
                                        <div class='col-xs-12 col-md-4'>
                                            <label class="fechaCargos"> PAGO </label>
                                            <div class="form-group">
                                                <div class='input-group date' id='fecha_cargo'>
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
                                    </div>

                                    <div class="row col-xs-12">
                                        <div class='col-xs-12 col-md-4'>
                                            <label class="fechaCargos"> VENCIMIENTO </label>
                                            <div class="form-group">
                                                <div class='input-group date' id='fecha_vencimiento'>
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
                                </div>

                                <div class="col-xs-8 col-xs-offset-4"  id="periodico">


                                    <div class="form-group">
                                        <table class="table table-striped">                                    

                                            <thead class="thead-dark">                                            
                                                <tr>
                                                    <th scope="col">#</th>
                                                    <th scope="col">Mes</th>

                                                </tr>                                            
                                            </thead>

                                            <tbody id="tbody-tabla-meses">

                                            </tbody>
                                        </table>
                                    </div>

                                </div>
                            </div>


                            <button type="button" id="grabarCargos" name="grabarCargos" class="btn btn-primary pull-right">Guardar</button>

                            <a href="<c:url value='/MenuController/start.htm'/>" class="btn btn-info" role="button">Menu principal</a> 


                            <!--    Codigo para insertar una tabla con varios combos Para mas adelante --> 
                            <!--                            <div class="col-xs-12" id="tableContainer">
                                                            <table class="table table-striped">
                                                                <thead class="thead-dark">
                                                                    <tr>
                                                                        <th scope="col">Item</th>
                                                                        <th scope="col">Abreviatura</th>
                                                                        <th scope="col">Descripción</th>
                                                                        <th scope="col">Tipo Item</th> 
                                                                        <th scope="col">Cuenta</th> 
                                                                        <th scope="col">Importe</th> 
                                                                        <th scope="col">Botón</th> 
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                            
                                                                </tbody>
                                                            </table>
                                                        </div>-->


                            <!--                            <div class="form-group">
                                                            <input type="text" class="form-control" id="id_adeudo" name="id_adeudo">
                                                        </div>                          
                            
                                                        <div class="form-group">
                                                            <input type="text" class="form-control" id="id_factura" name="id_factura">
                                                        </div>
                            
                                                        <div class="form-group">
                                                            <input type="text" class="form-control" id="cantidad" name="cantidad">
                                                        </div>
                            
                                                        <div class="form-group">
                                                            <input type="text" class="form-control" id="impuesto" name="impuesto">
                                                        </div>
                            
                                                        <div class="form-group">
                                                            <input type="text" class="form-control" id="cargo" name="cargo">                                                    
                                                        </div>-->





                        </form>
                    </div>
                </div>                            
            </div>
        </div>

    </body> 

</html>
