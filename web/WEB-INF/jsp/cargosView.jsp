
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="jstl" uri="http://java.sun.com/jstl/core_rt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
    <%@ include file="infouser.jsp" %>
    <head> 
        <title>GUARDAR CARGOS</title> 
        <style>

            .container {
                width: 1200px;
            }
            .azul{
                color:blue;
            }



        </style>
    </head>
    <script>
        $(document).ready(function () {
            //Al cargar la pagina llamamos a las funciones getCliente() y getEmpresa() para llenar los combos
            getEntidadCliente(); //Llenamos el combo de clientes
            //getEntidadEmpresa();//Llenamos el combo de empresas
            getItem(); //Llenamos el combo de items        

            var meses = new Array("Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre");
            

            $('#puntual').show();
            $('#periodico').hide();

            $("#exampleRadios1").on("click", function () {
                $('#puntual').show();
                $('#periodico').hide();
            });

            $("#exampleRadios2").on("click", function () {
                $('#puntual').hide();
                $('#periodico').show();
            });            

            //cargamos de forma dinamica la tabla
            for (var i = 0; i < 12; i = i + 6) {
                $('#tbody-tabla-meses').append(" <tr>\n\
                                            <td id='id" + (i + 1) + "'> <input type='checkbox' name='chkHos[]' value ='" + (i + 1) + "' > </td>              \n\
                                            <td>" + meses[i] + "</td>          \n\ \n\
                                            <td id='id" + (i + 2) + "'> <input type='checkbox' name='chkHos[]' value ='" + (i + 2) + "' > </td>              \n\
                                            <td>" + meses[i + 1] + "</td>          \n\ \n\
                                            <td id='id" + (i + 3) + "'> <input type='checkbox' name='chkHos[]' value ='" + (i + 3) + "' > </td>              \n\
                                            <td>" + meses[i + 2] + "</td>          \n\ \n\
                                            <td id='id" + (i + 4) + "'> <input type='checkbox' name='chkHos[]' value ='" + (i + 4) + "' > </td>              \n\
                                            <td>" + meses[i + 3] + "</td>          \n\ \n\
                                            <td id='id" + (i + 5) + "'> <input type='checkbox' name='chkHos[]' value ='" + (i + 5) + "' > </td>              \n\
                                            <td>" + meses[i + 4] + "</td>          \n\ \n\
                                            <td id='id" + (i + 6) + "'> <input type='checkbox' name='chkHos[]' value ='" + (i + 6) + "' > </td>              \n\
                                            <td>" + meses[i + 5] + "</td>          \n\ \n\
                                        </tr>");
            }


            var userLang = navigator.language || navigator.userLanguage;

            //Se pone dentro del ready porque se ejecuta cada vez que entramos en la pagina.
            //Constructor para el calendario Fecha-Cargo.
            $('#fecha_cargo').datetimepicker({
                format: 'YYYY-MM-DD',
                locale: userLang.valueOf(),
                daysOfWeekDisabled: [0, 6],
                useCurrent: false
            });

            //Se pone dentro del ready porque se ejecuta cada vez que entramos en la pagina.
            //Constructor para el calendario Fecha-Cargo.
            $('#fecha_vencimiento').datetimepicker({
                format: 'YYYY-MM-DD',
                locale: userLang.valueOf(),
                daysOfWeekDisabled: [0, 6],
                useCurrent: false
                
            });
            
            //Capturamos la fecha actual
            var f = new Date();
            var fecha = f.getDate() + "/" + (f.getMonth() + 1) + "/" + f.getFullYear();
            
            //tratando de mostrar fechas dinamicamente            
            var mes = f.getMonth();
            var nombreMes = meses[f.getMonth()];
            $('#anio').text(f.getFullYear());
            
            //Fecha para las cajas de fechas. Formato yyyy-mm-dd
            var fechaCajasEmision = f.getFullYear() + "-" + (f.getMonth() + 1) + "-" + f.getDate();
            $('#fecha_cargo input').val(fechaCajasEmision);
            var fechaCajasVencimiento = f.getFullYear() + "-" + (f.getMonth() + 2) + "-" + f.getDate();
            $('#fecha_vencimiento input').val(fechaCajasVencimiento);                       
            
            //$("#fecha_cargo input").change(function () {
            $("#fecha_cargo input").keyup(function () {
//                var fechaEmi = $("#fecha_cargo input").val();
//                //separamos el id y el valor
//                arrayEmi = fechaEmi.split("-");
//                //alert(arrayEmi[0]);
//                var valorDiaEmi = arrayEmi[0];
//                var valorMesEmi = arrayEmi[1];
//                var valorAnoEmi = arrayEmi[2];
//                
//                $("#fecha_vencimiento input").val(valorDiaEmi+"-"+(valorMesEmi+1)+"-"+valorAnoEmi);

            });
            
            
            $("#fecha_cargo input").change(function () {
//                var fechaEmi = $("#fecha_cargo input").val();
//                //separamos el id y el valor
//                arrayEmi = fechaEmi.split("-");
//                alert(arrayEmi[0]);
//                var valorDiaEmi = arrayEmi[0];
//                var valorMesEmi = arrayEmi[1];
//                var valorAnoEmi = arrayEmi[2];
//
//                $("#fecha_vencimiento input").val(valorDiaEmi+"-"+(valorMesEmi+1)+"-"+valorAnoEmi);
                
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

                myObj["id_tipo_item"] = $("#comboTipoItem").val().trim();
                myObj["cuenta"] = $("#comboCuenta").val();
                myObj["importe"] = $("#importe").val().trim();
                myObj["cantidad"] = $("#cantidad").val().trim();

                //Codigo para introducir el tipo de impuesto
                //cogemos el valor del combo comboTipoImpuesto que trae el id y el valor
                tipoImpuesto = $("#comboTipoImpuesto").val();
                //separamos el id y el valor
                arrayDeCadenas = tipoImpuesto.split("-"); //xxx
                var tipoImp = arrayDeCadenas[0];
                var valorImp = arrayDeCadenas[1];

                //Grabamos el tipo de impuesto
                myObj["impuesto"] = tipoImp;

                myObj["total"] = $("#total").val().trim();


                //Codigo para guardar la periodicidad. Si esta marcado puntual (1)
                //guardamos las fechas de los input. Si no guardamos los valores de los checkBox
                if ($("input[name=exampleRadios]:checked").val() == 1) {

                    //dentro de fecha cargo tenemos que coger el valor que hay dentro de input.
                    myObj["fecha_cargo"] = $("#fecha_cargo input").val().trim();
                    //dentro de fecha vencimiento tenemos que coger el valor que hay dentro de input.
                    myObj["fecha_vencimiento"] = $("#fecha_vencimiento input").val().trim();


                } else {
                    //Recuperamos los value de los checkBox marcados. Los pasamos al controlador 
                    //en las varables de las fechas.
                    var selected = '';
                    $('#formid input[type=checkbox]').each(function () {
                        if (this.checked) {
                            selected += $(this).val() + ',';
                        }
                    });

                    if (selected != '') {
                        alert('Has seleccionado: ' + selected);
                    } else {
                        alert('Debes seleccionar al menos una opción.');
                    }
                    ;

                    //Para pasar la cadena con los meses seleccionados al controlador. Lo
                    ////hacemos e las dos fechas para que no de errores por ir vacio                    
                    myObj["fecha_cargo"] = selected;
                    myObj["fecha_vencimiento"] = selected;

                }
                ;

                //Estas dos tendran valores fijos a true y 0
                //myObj["estado"] = $("#estado").val().trim();
                //myObj["id_factura"] = $("#id_factura").val().trim();

                //Id de cliente y empresa
                myObj["id_cliente"] = $("#id_entidad").text();
                myObj["id_empresa"] = 0;

                myObj["valor_impuesto"] = $("#valorImpuesto").val().trim();
                myObj["periodicidad"] = $("input[name=exampleRadios]:checked").val();


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
                                $("#id_entidad").text(aux2.id_entidad);
                                $("#nombre_entidad").text(aux2.nombre_entidad);
                                $("#nombre_contacto").text(aux2.nombre_contacto);

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
                    $("#id_entidad").text("");
                    $("#nombre_entidad").text("");
                    $("#nombre_contacto").text("");
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
                                $("#id_entidad2").text(aux2.id_entidad);
                                $("#nombre_entidad2").text(aux2.nombre_entidad);
                                $("#nombre_contacto2").text(aux2.nombre_contacto);

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
                    $("#id_entidad2").text("");
                    $("#nombre_entidad2").text("");
                    $("#nombre_contacto2").text("");
                }

            });

            //Muestra los datos del item al seleccionar algo en el combo
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
                                $("#importe").val(aux2.importe);
                                $("#costes").val(aux2.costes);
                                $("#estado").val(aux2.estado);
                                //Cargamos en el total el importe ya que de inicio tenemos: cantidad = 1, impuesto = 0
                                $("#total").val(aux2.importe);
                                //$("#comboTipoImpuesto").val("0-0"); //xxx
                                //Si se elige un item activamos el combo del tipo-valor de impuesto                                
                                document.getElementById("comboTipoItem").disabled = false;
                                document.getElementById("comboCuenta").disabled = false;
                                document.getElementById("comboTipoImpuesto").disabled = false;
                                document.getElementById("comboTipoImpuesto").value = "1-0"; //xxx
                                $("#valorImpuesto").val(0);
                                $("#cantidad").val(1);

                                //Funcion para cargar los tipos de item en un combo
                                cargarTipoItem(aux2.id_tipo_item);
                                //Funcion para cargar las cuentas en un combo                                
                                cargarCuentas(aux2.id_cuenta);

                                getTipoImpuesto()

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
                    $("#comboTipoItem").val("");
                    $("#comboCuenta").val(""); //xxx
                    $("#importe").val("");
                    $("#costes").val("");
                    $("#estado").val("");
                    document.getElementById("comboTipoItem").disabled = true;
                    document.getElementById("comboCuenta").disabled = true;
                    document.getElementById("comboTipoImpuesto").disabled = true;
                    document.getElementById("comboTipoImpuesto").value = "1-0"; //xxx
                    $("#valorImpuesto").val(0);
                    $("#cantidad").val(1);
                }

            });

            //Se ejecuta al cambiar el contenido del importe
            $("#importe").keyup(function () {
                //Si la opcion seleccionada en comboItems es diferente a "Seleccionar" se muestran datos
                if ($("#comboItems").val() != "0") {
                    //Llamamos a la funcion calcularTotal() que calcula el total del cargo
                    calcularTotal();
                }
            });
            
            //Se ejecuta al cambiar el contenido de la cantidad
            $("#cantidad").keyup(function () {
                //Si la opcion seleccionada en comboItems es diferente a "Seleccionar" se muestran datos
                if ($("#comboItems").val() != "0") {
                    //Llamamos a la funcion calcularTotal() que calcula el total del cargo
                    calcularTotal();
                }
            });
            
            //Se ejecuta al cambiar el contenido del comboTipoImpuesto
            $("#comboTipoImpuesto").change(function () {
                //Si la opcion seleccionada en comboItems es diferente a "Seleccionar" se muestran datos
                if ($("#comboItems").val() != "1") {
                    //Llamamos a la funcion calcularTotal() que calcula el total del cargo
                    calcularTotal();
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


        function getTipoImpuesto() {

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
                url: '/Facturacion/cargosController/getTipoImpuesto.htm', //Vamos a cargosController/getEmpresa.htm a recoger los datos
                success: function (data) {
                    //Vaciamos el combo
                    document.getElementById('comboTipoImpuesto').options.length = 0;
                    //Recogemos los datos del combo y los pasamos a objetos Cliente  
                    var tipoImpuesto = JSON.parse(data);
                    //Identificamos el combo
                    select = document.getElementById('comboTipoImpuesto');
                    //Añadimos la opcion Seleccionar al combo
//                    var opt = document.createElement('option');
//                    opt.value = "0-0"; //xxx
//                    opt.innerHTML = "Seleccionar";
//                    select.appendChild(opt);

                    //Lo vamos cargando, dejamos seleccionada la opcion 1
                    tipoImpuesto.forEach(function (valor, indice) {
                        //Cada objeto esta en String y lo pasamos a TipoImpuesto
                        var tipoImpuesto2 = JSON.parse(valor);
                        //Creamos las opciones del combo
                        var opt = document.createElement('option');
                        //Guardamos el valor del impuesto en el value de cada opcion
                        opt.value = tipoImpuesto2.id_tipo_impuesto + "-" + tipoImpuesto2.valor; //xxx
                        //Guardamos el impuesto en el nombre de cada opcion
                        opt.innerHTML = tipoImpuesto2.impuesto;

                        if (tipoImpuesto2.id_tipo_impuesto == 1) {
                            //Guardamos el valor del impuesto en el value de cada opcion
                            opt.value = tipoImpuesto2.id_tipo_impuesto + "-" + tipoImpuesto2.valor; //xxx
                            //Guardamos el impuesto en el nombre de cada opcion
                            opt.innerHTML = tipoImpuesto2.impuesto;
                            opt.selected = true;

                        } else {
                            //Guardamos el valor del impuesto en el value de cada opcion
                            opt.value = tipoImpuesto2.id_tipo_impuesto + "-" + tipoImpuesto2.valor; //xxx
                            //Guardamos el impuesto en el nombre de cada opcion
                            opt.innerHTML = tipoImpuesto2.impuesto;
                        }
                        //Añadimos la opcion
                        select.appendChild(opt);
                    });
                    //Si no se modifica el combo el valor es (0-0) //xxx
                    document.getElementById("comboTipoImpuesto").value = "1-0"; //xxx

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

        //Funcion para cargar los tipos de item en un combo
        function cargarTipoItem(idTipoItem) {

            if (window.XMLHttpRequest) //mozilla
            {
                ajax = new XMLHttpRequest(); //No Internet explorer
            } else
            {
                ajax = new ActiveXObject("Microsoft.XMLHTTP");
            }
            //alert(idTipoItem);
            $.ajax({
                //Usamos GET ya que recibimos.
                type: 'GET',
                url: '/Facturacion/cargosController/cargarTipoItem.htm', //Vamos a cargosController/getEmpresa.htm a recoger los datos
                success: function (data) {
                    //Vaciamos el combo
                    document.getElementById('comboTipoItem').options.length = 0;
                    //Recogemos los datos del combo y los pasamos a objetos Cliente  
                    var tipoItem = JSON.parse(data);
                    //Identificamos el combo
                    select = document.getElementById('comboTipoItem');

                    //Lo vamos cargando
                    tipoItem.forEach(function (valor, indice) {
                        //Cada objeto esta en String y lo pasmoa a TipoImpuesto
                        var tipoItem2 = JSON.parse(valor);
                        //Creamos las opciones del combo
                        var opt = document.createElement('option');

                        //Comtrolamos el tipo de item que es y lo dejamos seleccionado en el combo
                        if (idTipoItem == tipoItem2.col1) {
                            //Guardamos el id en el value de cada opcion
                            opt.value = tipoItem2.col1;
                            //Guardamos el impuesto en el nombre de cada opcion                        
                            opt.innerHTML = tipoItem2.col2;
                            //Dejamos marcada una opcion
                            opt.selected = true;
                        } else {
                            //Guardamos el id en el value de cada opcion
                            opt.value = tipoItem2.col1;
                            //Guardamos el impuesto en el nombre de cada opcion                        
                            opt.innerHTML = tipoItem2.col2;
                        }

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

        //Funcion para cargar las cuentas en un combo
        function cargarCuentas(idCuenta) {

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
                url: '/Facturacion/modificarCargosController/cargarCuentas.htm', //Vamos a cargosController/getEmpresa.htm a recoger los datos
                success: function (data) {

                    //Vaciamos el combo
                    document.getElementById('comboCuenta').options.length = 0;
                    //Recogemos los datos del combo y los pasamos a objetos Cliente  
                    var tipoCuenta = JSON.parse(data);
                    //Identificamos el combo
                    select = document.getElementById('comboCuenta');

                    //Lo vamos cargando
                    tipoCuenta.forEach(function (valor, indice) {
                        //Cada objeto esta en String y lo pasmoa a TipoImpuesto
                        var tipoCuenta2 = JSON.parse(valor);
                        //Creamos las opciones del combo
                        var opt = document.createElement('option');

                        //Comtrolamos el tipo de item que es y lo dejamos seleccionado en el combo
                        if (idCuenta == tipoCuenta2.col1) {
                            //Guardamos el id en el value de cada opcion
                            opt.value = tipoCuenta2.col1;
                            //Guardamos el impuesto en el nombre de cada opcion                        
                            opt.innerHTML = tipoCuenta2.col2;
                            //Dejamos marcada una opcion
                            opt.selected = true;
                        } else {
                            //Guardamos el id en el value de cada opcion
                            opt.value = tipoCuenta2.col1;
                            //Guardamos el impuesto en el nombre de cada opcion                        
                            opt.innerHTML = tipoCuenta2.col2;
                        }

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


        //Funcion para los calculos de los importes e impuestos
        function calcularTotal() {

            //cogemos el valor del combo comboTipoImpuesto que trae el id y el valor
            tipoImpuesto = $("#comboTipoImpuesto").val();

            //separamos el id y el valor
            arrayDeCadenas = tipoImpuesto.split("-");//xxx
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
                        <form role="form" id="formid">
                            <br style="clear:both">
                            <h3 style="margin-bottom: 25px; text-align: center;">Formulario para CARGOS</h3>                           

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
                                    <input type="text" class="form-control input-sm" id="id_item" name="id_item" disabled>
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
                                    <label for="comboTipoItem">Tipo de Item</label>
                                    <div class="form-group-combo">                                        
                                        <select class="form-control input-sm" id="comboTipoItem" name="comboTipoItem" disabled>
                                        </select>                                         
                                    </div>
                                </div>
                            </div>

                            <div class="datos row" class="col-xs-12">

                                <div class="form-group col-xs-2">
                                    <label for="comboCuenta>">Cuenta</label>
                                    <div class="form-group-combo">                                        
                                        <select class="form-control input-sm" id="comboCuenta" name="comboCuenta" disabled>
                                        </select>                                                            
                                    </div>
                                </div>   
                                <div class="form-group col-xs-2">
                                    <label for="importe>">Importe</label>&nbsp;&nbsp;&nbsp;
                                    <button type='button' class='btn miBotonEliminar btn-warning btn-xs'  data-idCargo='" + cargo.id_cargo + "' data-idItem='" + cargo.id_cliente + "' data-idIndice='" + indice + "'> Modificar</button>
                                    <input type="text" class="form-control input-sm" id="importe" name="importe" disabled>
                                </div>
                                <div class="form-group col-xs-1">
                                    <label for="importe>">Cantidad</label>
                                    <input type="text" class="form-control input-sm" id="cantidad" name="cantidad" value="1">
                                </div>
                                <div class="form-group col-xs-1">
                                    <label for="importe>">Costes</label>
                                    <input type="text" class="form-control input-sm" id="costes" name="costes" disabled>
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
                                            <input class="form-check-input" type="radio" name="exampleRadios" id="exampleRadios1" value="1" checked>
                                            <label class="form-check-label" for="2">Puntual</label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" name="exampleRadios" id="exampleRadios2" value="2">
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
                                            <label class="fechaCargos"> EMISIÓN </label>
                                            <div class="form-group">
                                                <div class='input-group date' id='fecha_cargo'>
                                                    <input id='inputFechaCargo' data-format="yyyy-MM-dd hh:mm:ss" type='text' class="form-control"/>
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
                                                    <th scope="col">Mes</th>
                                                    <th scope="col"></th>
                                                    <th scope="col">Año</th>
                                                    <th scope="col" id="anio"></th>
                                                </tr>                                            
                                            </thead>

                                            <tbody id="tbody-tabla-meses">

                                            </tbody>
                                        </table>
                                    </div>

                                </div>
                            </div>


                            <!--<button type="button" id="grabarCargos" name="grabarCargos" class="btn btn-primary pull-right">Guardar</button>-->

                            <button type="button" id="grabarCargos" name="grabarCargos" class="btn btn-primary pull-right">Guardar</button>

                            <a href="<c:url value='/MenuController/start.htm'/>" class="btn btn-info" role="button">Menu principal</a> 



                        </form>
                    </div>
                </div>                            
            </div>
        </div>


    </body> 
</html>
