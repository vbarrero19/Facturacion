
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
            getEntidadEmpresa();
            getItem();


            //getItemTabla();

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
                    url: '/Facturacion/cargosController/nuevoCargo.htm',
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
            });

            //Muestra datos de la entidadCliente al seleccionar algo en el combo
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

                    myObj["id_entidad"] = $("#comboClientes").val().trim();

                    var json = JSON.stringify(myObj);
                    $.ajax({
                        type: 'POST',
                        url: '/Facturacion/cargosController/getDatosEntidadCliente.htm',
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

            });

            //Muestra datos de la entidadCliente al seleccionar algo en el combo
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

                    myObj["id_entidad"] = $("#comboEmpresas").val().trim();

                    var json = JSON.stringify(myObj);
                    $.ajax({
                        type: 'POST',
                        url: '/Facturacion/cargosController/getDatosEntidadEmpresa.htm',
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
                                $("#id_entidad2").val(aux2.id_entidad);
                                $("#nombre_entidad2").val(aux2.nombre_entidad);
                                $("#nombre_contacto2").val(aux2.nombre_contacto);

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
                    $("#id_entidad2").val("");
                    $("#nombre_entidad2").val("");
                    $("#nombre_contacto2").val("");
                }

            });


            $("#comboItems").change(function () {

                //Si la opcion seleccionada es diferente a "Seleccionar" se muestran datos
                if ($("#comboItems").val() != "0") {

                    if (window.XMLHttpRequest) //mozilla
                    {
                        ajax = new XMLHttpRequest(); //No Internet explorer
                    } else
                    {
                        ajax = new ActiveXObject("Microsoft.XMLHTTP");
                    }

                    var myObj = {};

                    myObj["id_item"] = $("#comboItems").val().trim();

                    var json = JSON.stringify(myObj);
                    $.ajax({
                        type: 'POST',
                        url: '/Facturacion/cargosController/getDatosItem.htm',
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
                                $("#id_item").val(aux2.id_item);
                                $("#abreviatura").val(aux2.abreviatura);
                                $("#descripcion").val(aux2.descripcion);
                                $("#id_tipo_item").val(aux2.id_tipo_item);
                                $("#cuenta").val(aux2.cuenta);
                                $("#importe").val(aux2.importe);
                                $("#periodo").val(aux2.periodo);

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
                    $("#id_item").val("");
                    $("#abreviatura").val("");
                    $("#descripcion").val("");
                    $("#id_tipo_item").val("");
                    $("#cuenta").val("");
                    $("#importe").val("");
                    $("#periodo").val("");
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
                url: '/Facturacion/cargosController/getEntidadEmpresa.htm', //Vamos a cargosController/getEmpresa.htm a recoger los datos
                success: function (data) {

                    //Recogemos los datos del combo y los pasamos a objetos Cliente  
                    var empresaEntidad = JSON.parse(data);
                    //Identificamos el combo
                    select = document.getElementById('comboEmpresas');
                    //Añadimos la opcion Seleccionar al combo
                    var opt = document.createElement('option');
                    opt.value = 0;
                    opt.innerHTML = "Seleccionar";
                    select.appendChild(opt);

                    //Lo vamos cargando
                    empresaEntidad.forEach(function (valor, indice) {
                        //Cada objeto esta en String y lo pasmoa a TipoImpuesto
                        var empresaEntidad2 = JSON.parse(valor);
                        //Creamos las opciones del combo
                        var opt = document.createElement('option');
                        //Guardamos el id en el value de cada opcion
                        opt.value = empresaEntidad2.id_entidad;
                        //Guardamos el impuesto en el nombre de cada opcion                        
                        opt.innerHTML = empresaEntidad2.distinct_code;
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

        //Funcion para llenar el combo de item. Los datos nos vienen en un ArrayList de objetos item transformados en String
        //y estos a su vez en otra cadena String con json. Los datos se obtienen en cargosController/getEmpresa.htm.
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
                url: '/Facturacion/cargosController/getItem.htm', //Vamos a cargosController/getEmpresa.htm a recoger los datos
                success: function (data) {

                    //Recogemos los datos del combo y los pasamos a objetos Cliente  
                    var empresaEntidad = JSON.parse(data);
                    //Identificamos el combo
                    select = document.getElementById('comboItems');
                    //Añadimos la opcion Seleccionar al combo
                    var opt = document.createElement('option');
                    opt.value = 0;
                    opt.innerHTML = "Seleccionar";
                    select.appendChild(opt);

                    //Lo vamos cargando
                    empresaEntidad.forEach(function (valor, indice) {
                        //Cada objeto esta en String y lo pasmoa a TipoImpuesto
                        var empresaEntidad2 = JSON.parse(valor);
                        //Creamos las opciones del combo
                        var opt = document.createElement('option');
                        //Guardamos el id en el value de cada opcion
                        opt.value = empresaEntidad2.id_item;
                        //Guardamos el impuesto en el nombre de cada opcion                        
                        opt.innerHTML = empresaEntidad2.abreviatura;
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



        //Codigo para cargar los items en una tabla, para mas adelante.
        //  <editorfold desc="Metodo Main">
        function getItemTabla() {
//            if (window.XMLHttpRequest) //mozilla
//            {
//                ajax = new XMLHttpRequest(); //No Internet explorer
//            } else
//            {
//                ajax = new ActiveXObject("Microsoft.XMLHTTP");
//            }
//
//            $.ajax({
//                //Usamos GET ya que recibimos. 
//                type: 'GET',
//                url: '/Facturacion/cargosController/getItem.htm', //Vamos a cargosController/getItem.htm a recoger los datos
//                success: function (data) {
//
//                    //Creamos una tabla con 5 filas para insertar datos
//                    for (i = 0; i < 5; i++) {
//
//
//                        /* Codigo para cargar una tabla con varios combos. Solo vamos a cargar un combo con los items*/
//
//                        //cargamos de forma dinamica la tabla
//                        $('#tableContainer tbody').append(" <tr>\n\
//                                                                    <td scope=\"row\">" + (i + 1) + "</td>              \n\
//                                                                    <td>" + "<select class='form-control comboItems' id='comboItems" + (i + 1) + "' name='comboItems'></select> " + "</td>   \n\
//                                                                    <td>" + "<input type='text' id='id_adeudo" + (i + 1) + "' name='id_adeudo'>" + "</td>                        \n\
//                                                                    <td>" + "<input type='text' id='id_adeudo" + (i + 1) + "' name='id_adeudo'>" + "</td>                       \n\
//\n\                                                                 <td>" + "<input type='text' id='id_adeudo" + (i + 1) + "' name='id_adeudo'>" + "</td>                       \n\
//\n\                                                                 <td>" + "<input type='text' id='id_adeudo" + (i + 1) + "' name='id_adeudo'>" + "</td>                       \n\
//                                                                    <td>" + "<button value='actualizar' tittle='actualizar' id='btnedit' >Prueba</button>" + "</td>     \n\ \n\
//                                                                </tr>");
//                        //Recogemos los datos del combo y los pasamos a objetos Cliente  
//                        var aux = JSON.parse(data);
//
//                        //Identificamos el combo
//                        select = document.getElementById("comboItems" + (i + 1));
//                        //Añadimos la opcion Seleccionar al combo
//                        var opt = document.createElement('option');
//                        opt.value = 0;
//                        opt.innerHTML = "Seleccionar";
//                        select.append(opt);
//                        //Lo vamos cargando
//                        aux.forEach(function (valor, indice) {
//                            //Cada objeto esta en String y lo pasmoa a TipoImpuesto
//                            var aux2 = JSON.parse(valor);
//                            //Creamos las opciones del combo
//                            var opt = document.createElement('option');
//                            //Guardamos el id en el value de cada opcion
//                            opt.value = aux2.id_item;
//                            //Guardamos el impuesto en el nombre de cada opcion                        
//                            opt.innerHTML = aux2.abreviatura;
//                            //Añadimos la opcion
//                            select.append(opt);
//
//                        });
//
//
//
//
//                    }
//                    
//                    
//                    //Codigo para control del cambio en cualquiera de los combos. Codigo de David
//                    
//                    $(".comboItems").change(function () {
//                        if (window.XMLHttpRequest) //mozilla
//                        {
//                            ajax = new XMLHttpRequest(); //No Internet explorer
//                        } else
//                        {
//                            ajax = new ActiveXObject("Microsoft.XMLHTTP");
//                        }
//                        
//                        //Recogemos en una variable 
//                        var idOpcion = this.value;
//                        alert(idOpcion);
//                        
//                        var numFila = this.parentElement.previousElementSibling.textContent;
//                        //ajax
//                        //success               
//                        //
//                        //Codigo para identificar las cajas de texto
//                        $("#id_adeudo" + idfila).val("example");
//
//
//                    });
//
//                },
//                error: function (xhr, ajaxOptions, thrownError) {
//                    console.log(xhr.status);
//                    console.log(xhr.responseText);
//                    console.log(thrownError);
//                }
//
//
//            });
        }
        ;
        // </editorfold>


    </script>
    <body>
        <div class="container">
            <div class="col-xs-12">
                <div class="col-md-12 col-xs-5">
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
                                    <label for="id_cliente"> Id Entidad </label>
                                    <input type="text" class="form-control" id="id_entidad" name="id_entidad" disabled = "true">
                                </div> 
                                <div class="form-group col-xs-4">
                                    <label for="idCliente>">Nombre_entidad</label>
                                    <input type="text" class="form-control" id="nombre_entidad" name="nombre_entidad" disabled = "true">
                                </div>
                                <div class="form-group col-xs-3">
                                    <label for="idCliente>">País cliente</label>
                                    <input type="text" class="form-control" id="nombre_contacto" name="nombre_contacto">
                                </div>   
                                <br style="clear:both">
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
                                        <input type="text" class="form-control" id="id_entidad2" name="id_entidad2" disabled = "true">
                                    </div>
                                    <div class="form-group col-xs-4">
                                        <label for="idEmpresa>">Dirección física empresa</label>
                                        <input type="text" class="form-control" id="nombre_entidad2" name="nombre_entidad2" disabled = "true">
                                    </div>
                                    <div class="form-group col-xs-3">
                                        <label for="idEmpresa>">País empresa</label>
                                        <input type="text" class="form-control" id="nombre_contacto2" name="nombre_contacto2" disabled = "true">
                                    </div>
                                </div>                            
                                <br style="clear:both">
                                <div class="datos" class="col-xs-12">
                                    <!--Combo para Items-->
                                    <div class="form-group col-xs-3">
                                        <label for="comboItems">Items</label>
                                        <div class="form-group-combo">                                        
                                            <select class="form-control" id="comboItems" name="comboItems">
                                            </select>                                                            
                                        </div>
                                    </div>

                                    <div class="form-group col-xs-3">
                                        <label for="id_item>">Id.Item</label>
                                        <input type="text" class="form-control" id="id_item" name="id_item">
                                    </div>
                                    <div class="form-group col-xs-3">
                                        <label for="abreviatura>">Abreviatura</label>
                                        <input type="text" class="form-control" id="abreviatura" name="abreviatura">
                                    </div>
                                    <div class="form-group col-xs-3">
                                        <label for="descripcion>">Descripción</label>
                                        <input type="text" class="form-control" id="descripcion" name="descripcion">
                                    </div>
                                    <div class="form-group col-xs-3">
                                        <label for="tipo_item>">Tipo Item</label>
                                        <input type="text" class="form-control" id="id_tipo_item" name="id_tipo_item" disabled = "true">
                                    </div>
                                    <div class="form-group col-xs-3">
                                        <label for="cuenta>">Cuenta</label>
                                        <input type="text" class="form-control" id="cuenta" name="cuenta">
                                    </div>
                                    <div class="form-group col-xs-3">
                                        <label for="importe>">Importe</label>
                                        <input type="text" class="form-control" id="importe" name="importe">
                                    </div>
                                    <div class="form-group col-xs-3">
                                        <label for="importe>">Periodo</label>
                                        <input type="text" class="form-control" id="periodo" name="periodo">
                                    </div>
                                </div>
                                <br style="clear:both">
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

                                <!--                            <br style="clear:both">-->

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


                                <!--ALMACENAMOS LAS FECHAS DE LOS CARGOS -->  
                                <label class="fechaGeneral">FECHAS DE LOS CARGOS Borrar si no se usa</label>
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
                        </form>

                    </div>                            
                </div>
            </div>
        </div>  
    </body> 
</html>
