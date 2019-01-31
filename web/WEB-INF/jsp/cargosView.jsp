
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="jstl" uri="http://java.sun.com/jstl/core_rt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
    <%@ include file="infouser.jsp" %>
    <head> 
        <title>ADEUDOS VIEW</title> 
    </head>
    <script>
        $(document).ready(function () {
            //Al cargar la pagina llamamos a las funciones getCliente() y getEmpresa() para llenar los combos
            getEntidadCliente(); //Llenamos el combo de clientes
            //getEntidadEmpresa();
            //getItem();

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
            $("#submit").click(function () {
                if (window.XMLHttpRequest) //mozilla
                {
                    ajax = new XMLHttpRequest(); //No Internet explorer
                } else
                {
                    ajax = new ActiveXObject("Microsoft.XMLHTTP");
                }

                var myObj = {};
                myObj["id_adeudo"] = $("#id_adeudo").val().trim();
                myObj["id_empresa"] = $("#id_empresa").val().trim();
                myObj["id_factura"] = $("#id_factura").val().trim();
                myObj["id_cliente"] = $("#id_cliente").val().trim();
                myObj["cantidad"] = $("#cantidad").val().trim();
                myObj["impuesto"] = $("#impuesto").val().trim();
                myObj["cargo"] = $("#cargo").val().trim();

                //dentro de fecha cargo tenemos que coger el valor que hay dentro de input.
                myObj["fecha_cargo"] = $("#fecha_cargo input").val().trim();
                //dentro de fecha vencimiento tenemos que coger el valor que hay dentro de input.
                myObj["fecha_vencimiento"] = $("#fecha_vencimiento input").val().trim();

                var json = JSON.stringify(myObj);
                $.ajax({
                    type: 'POST',
                    url: '/Facturacion/cargosController/newCustomer.htm',
                    data: json,
                    datatype: "json",
                    contentType: "application/json",
                    success: function (data) {
                        alert(data);
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        console.log(xhr.status);
                        console.log(xhr.responseText);
                        console.log(thrownError);
                    }
                });
            })

            //Muestra datos del cliente al seleccionar algo en el combo
            $("#comboClientes").change(function () {

                //Si la opcion seleccionada es diferente a "Seleccionar" se muestran datos
                if ($("#comboClientes").val() != "0") {

                    if (window.XMLHttpRequest) //mozilla
                    {
                        ajax = new XMLHttpRequest(); //No Internet explorer
                    } else
                    {
                        ajax = new ActiveXObject("Microsoft.XMLHTTP");
                    }

                    var myObj = {};

                    myObj["id_cliente"] = $("#comboClientes").val().trim();

                    var json = JSON.stringify(myObj);
                    $.ajax({
                        type: 'POST',
                        url: '/Facturacion/cargosController/getDatosCliente.htm',
                        data: json,
                        datatype: "json",
                        contentType: "application/json",
                        success: function (data) {

                            //En el data viene la informacion del combo en forma de String.
                            //Primero lo pasamos a objetos tipo String y luego estos a objetos tipo cliente

                            //Recogemos el data como una cadena String y los pasamos a objetos Tipo String con JSON
                            var aux = JSON.parse(data);

                            aux.forEach(function (valor, indice) {
                                //Recogemos cada objeto en String y los pasamos a objetos Tipo cliente con JSON
                                var aux2 = JSON.parse(valor);
                                //Mostramos los datos en la cajas de texto
                                $("#id_cliente").val(aux2.id_cliente);
                                $("#dir_fisica").val(aux2.dir_fisica);
                                $("#pais").val(aux2.pais);

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
                    $("#id_cliente").val("");
                    $("#dir_fisica").val("");
                    $("#pais").val("");
                }

            });

            //Muestra datos de la empresa al seleccionar en el combo
            $("#comboEmpresas").change(function () {

                //Si la opcion seleccionada es diferente a "Seleccionar" se muestran datos
                if ($("#comboEmpresas").val() != "0") {

                    if (window.XMLHttpRequest) //mozilla
                    {
                        ajax = new XMLHttpRequest(); //No Internet explorer
                    } else
                    {
                        ajax = new ActiveXObject("Microsoft.XMLHTTP");
                    }

                    var myObj = {};

                    myObj["id_cliente"] = $("#comboEmpresas").val().trim();

                    var json = JSON.stringify(myObj);
                    $.ajax({
                        type: 'POST',
                        url: '/Facturacion/cargosController/getEmpresa.htm',
                        data: json,
                        datatype: "json",
                        contentType: "application/json",
                        success: function (data) {

                            //En el data viene la informacion del combo en forma de String.
                            //Primero lo pasamos a objetos tipo String y luego estos a objetos tipo cliente

                            //Recogemos el data como una cadena String y los pasamos a objetos Tipo String con JSON
                            var aux = JSON.parse(data);

                            aux.forEach(function (valor, indice) {
                                //Recogemos cada objeto en String y los pasamos a objetos Tipo cliente con JSON
                                var aux2 = JSON.parse(valor);

                                $("#id_empresa").val(aux2.id_cliente);
                                $("#dir_fisica2").val(aux2.dir_fisica);
                                $("#pais2").val(aux2.pais);

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
                    $("#id_empresa").val("");
                    $("#dir_fisica2").val("");
                    $("#pais2").val("");
                }
            });
                  
        });

        //Funcion para llenar el combo de cliente. Los datos nos vienen en un ArrayList de objetos cliente transformados en String
        //y estos a su vez en otra cadena String con json. Los datos se obtienen en cargosController/getCliente.htm.
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
                url: '/Facturacion/cargosController/getEntidadCliente.htm', //Vamos a cargosController/getCliente.htm a recoger los datos
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
                        var aux2 = JSON.parse(valor);
                        //Creamos las opciones del combo
                        var opt = document.createElement('option');
                        //Guardamos el id en el value de cada opcion
                        opt.value = aux2.id_cliente;
                        //Guardamos el impuesto en el nombre de cada opcion
                        opt.innerHTML = aux2.nombre_empresa;
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

        //Funcion para llenar el combo de empresa. Los datos nos vienen en un ArrayList de objetos cliente transformados en String
        //y estos a su vez en otra cadena String con json. Los datos se obtienen en cargosController/getEmpresa.htm.
        function getEntidadEmpresa() {
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
                url: '/Facturacion/cargosController/getEmpresa.htm', //Vamos a cargosController/getEmpresa.htm a recoger los datos
                success: function (data) {

                    //Recogemos los datos del combo y los pasamos a objetos Cliente  
                    var aux = JSON.parse(data);
                    //Identificamos el combo
                    select = document.getElementById('comboEmpresas');
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
                        opt.value = aux2.id_cliente;
                        //Guardamos el impuesto en el nombre de cada opcion                        
                        opt.innerHTML = aux2.nombre_empresa;
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

        function getItem() {
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
                url: '/Facturacion/cargosController/getItem.htm', //Vamos a cargosController/getItem.htm a recoger los datos
                success: function (data) {
                    
                    //Creamos una tabla con 5 filas para insertar datos
                    for( i = 0; i < 5; i++) {
                    
                        //cargamos de forma dinamica la tabla
                        $('#tableContainer tbody').append(" <tr>\n\
                                                                    <th scope=\"row\">" + (i + 1) + "</th>              \n\
                                                                    <td>" + "<select class='form-control comboItems' id='comboItems"+(i+1)+"' name='comboItems'></select> " + "</td>   \n\
                                                                    <td>" + "<input type='text' id='id_adeudo' name='id_adeudo'>" + "</td>                        \n\
                                                                    <td>" + "<input type='text' id='id_adeudo' name='id_adeudo'>" + "</td>                       \n\
                                                                    <td>" + "<button value='actualizar' tittle='actualizar' id='btnedit' >Prueba</button>" + "</td>     \n\ \n\
                                                                </tr>");
                    //Recogemos los datos del combo y los pasamos a objetos Cliente  
                    var aux = JSON.parse(data);
                    //Identificamos el combo
                    
                    select = document.getElementById("comboItems"+(i+1));
                    //Añadimos la opcion Seleccionar al combo
                    var opt = document.createElement('option');
                    opt.value = 0;
                    opt.innerHTML = "Seleccionar";
                    select.append(opt);
                    //Lo vamos cargando
                    aux.forEach(function (valor, indice) {
                        //Cada objeto esta en String y lo pasmoa a TipoImpuesto
                        var aux2 = JSON.parse(valor);
                        //Creamos las opciones del combo
                        var opt = document.createElement('option');
                        //Guardamos el id en el value de cada opcion
                        opt.value = aux2.id_item;
                        //Guardamos el impuesto en el nombre de cada opcion                        
                        opt.innerHTML = aux2.nombre;
                        //Añadimos la opcion
                        select.append(opt);                        
                                                              
                     });                                               

                    }         

                },
                error: function (xhr, ajaxOptions, thrownError) {
                    console.log(xhr.status);
                    console.log(xhr.responseText);
                    console.log(thrownError);
                }
                

            });
        };       
 
        

    </script>
    <body>
        <div class="container">
            <div class="col-xs-12">
                <div class="col-md-8 col-xs-5">
                    <div class="form-area">  
                        <form role="form">
                            <br style="clear:both">
                            <h3 style="margin-bottom: 25px; text-align: center;">Formulario para ADEUDOS</h3>                           



                            <div class="datos" class="col-xs-12">
                                <!--Combo para clientes-->
                                <div class="form-group col-xs-3">
                                    <label for="comboClientes"> Nombre cliente </label>
                                    <div class="form-group-combo">                                        
                                        <select class="form-control" id="comboClientes" name="comboClientes">
                                        </select>                                                            
                                    </div>
                                </div>
                                <div class="form-group col-xs-2">
                                    <label for="id_cliente"> Id.cliente </label>
                                    <input type="text" class="form-control" id="id_cliente" name="id_cliente" placeholder="Identificador cliente" disabled = "true">
                                </div> 
                                <div class="form-group col-xs-4">
                                    <label for="idCliente>">Dirección física cliente</label>
                                    <input type="text" class="form-control" id="dir_fisica" name="dir_fisica" placeholder="direccion fisica" disabled = "true">
                                </div>
                                <div class="form-group col-xs-3">
                                    <label for="idCliente>">País cliente</label>
                                    <input type="text" class="form-control" id="pais" name="pais" placeholder="Pais" disabled = "true">
                                </div>
                                `
                            </div>   
                            <div class="datos" class="col-xs-12">
                                <!--Combo para Empresas-->
                                <div class="form-group col-xs-3">
                                    <label for="comboEmpresas">Nombre de empresa</label>
                                    <div class="form-group-combo">                                        
                                        <select class="form-control" id="comboEmpresas" name="comboEmpresas">
                                        </select>                                                            
                                    </div>
                                </div>
                                <div class="form-group col-xs-2">
                                    <label for="idEmpresa>">Id.Empresa</label>
                                    <input type="text" class="form-control" id="id_empresa" name="id_empresa" placeholder="Identificador empresa" disabled = "true">
                                </div>
                                <div class="form-group col-xs-4">
                                    <label for="idEmpresa>">Dirección física empresa</label>
                                    <input type="text" class="form-control" id="dir_fisica2" name="dir_fisica2" placeholder="direccion fisica" disabled = "true">
                                </div>
                                <div class="form-group col-xs-3">
                                    <label for="idEmpresa>">País empresa</label>
                                    <input type="text" class="form-control" id="pais2" name="pais2" placeholder="Pais" disabled = "true">
                                </div>
                            </div>

                            <div class="col-xs-12" id="tableContainer">
                                <table class="table table-striped">
                                    <thead class="thead-dark">
                                        <tr>
                                            <th scope="col">#</th>
                                            <th scope="col">Id_adeudo</th>
                                            <th scope="col">Adeudo</th> 
                                            <th scope="col">Importe</th> 
                                            <th scope="col">Enlace</th> 
                                        </tr>
                                    </thead>
                                    <tbody>

                                    </tbody>
                                </table>
                            </div>



                            <div class="form-group">
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
                            </div>

                            <!--ALMACENAMOS LAS FECHAS DE LOS CARGOS -->  
                            <label class="fechaGeneral">FECHAS DE LOS CARGOS</label>
                            <!--DENTRO DEL CONTAINER METEMOS LOS DOS DESPLEGABLES DE LAS FECHAS -->
                            <div class="container2">                                   
                                <div class="row">
                                    <div class='col-xs-12 col-md-4'>
                                        <label class="fechaCargos"> PAGO </label>
                                        <div class="form-group">
                                            <div class='input-group date' id='fecha_cargo'>
                                                <input  data-format="yyyy-MM-dd hh:mm:ss" type='text' class="form-control" />
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

                                <div class="row">
                                    <div class='col-xs-12 col-md-4'>
                                        <label class="fechaCargos"> VENCIMIENTO </label>
                                        <div class="form-group">
                                            <div class='input-group date' id='fecha_vencimiento'>
                                                <input  data-format="yyyy-MM-dd hh:mm:ss" type='text' class="form-control" />
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
                            <button type="button" id="submit" name="submit" class="btn btn-primary pull-right">Submit</button>

                            <a href="<c:url value='/MenuController/start.htm'/>" class="btn btn-info" role="button">Menu principal</a> 
                    </div>                            
                    </form>
                </div>
            </div>
        </div>
    </div>                  
</body> 
</html>
