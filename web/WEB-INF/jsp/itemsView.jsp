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
        <script>
        $(document).ready(function () {
                //al cargar la pagina llamamos a la funcion getImpuesto() para llenar el combo 
                getTipoItem();
                getTipoCuenta();
                //getEntidadEmpresa();

                $('#conCostes').hide();
                
                $("input[name=costesRadios]").attr('disabled', true);
                
                $("#costesRadios1").on("click", function () {
                    $('#conCostes').hide();
                });

                $("#costesRadios2").on("click", function () {
                    $('#conCostes').show();
                    getEntidadEmpresa();
                    $("#costeImporte").val($("#importe").val().trim());
                    getEntidadCliente();
                });

                $('#conCostes').on('click', '#anadirCoste', function () {
                
                    $('#tableContainer tbody').append(" <tr>\n\
                                                                <td> <div class='form-group-combo'>\n\
                                                                <select class='form-control input-sm' id='comboClientes1' name='comboClientes'></select></div> </td>     \n\
                                                                <td><input type='text' id='costeImporte1' name='costeImporte' size'12'></td>        \n\
                                                                <td><button type='button' class='btn miBoton btn-success' id='myBtn';>Eliminar</button></td>\n\
                                                        </tr>");
                });
                
                
                
                
                
            
            //Evento .click en el boton submit
            $("#guardarItem").click(function () {
                if (window.XMLHttpRequest) //mozilla
                {
                    ajax = new XMLHttpRequest(); //No Internet explorer
                } else
                {
                    ajax = new ActiveXObject("Microsoft.XMLHTTP");
                }

                //Variable para guardar los valores del formulario
                var myObj = {};
                //Cargamos el contenido de los campos del formulario
                myObj["abreviatura"] = $("#abreviatura").val().trim();
                myObj["descripcion"] = $("#descripcion").val().trim();
                myObj["id_tipo_item"] = $("#id_tipo_item").val();
                myObj["importe"] = $("#importe").val().trim();
                myObj["estado"] = "0";
                myObj["id_cuenta"] = $("#id_cuenta").val();
                //Convertimos la variable myObj a String
                var json = JSON.stringify(myObj);
                $.ajax({
                    type: 'POST',
                    url: '/Facturacion/itemsController/newItems.htm', //Vamos a newCustomer de itemsController
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

            //Se ejecuta al cambiar el contenido del importe
            $("#importe").keyup(function () {
                //Si la opcion seleccionada en comboItems es diferente a "Seleccionar" se muestran datos
                if ($("#importe").val() != "") {
                    //Llamamos a la funcion calcularTotal() que calcula el total del cargo
                    $("input[name=costesRadios]").attr('disabled', false);
                }
            });
            //Se ejecuta al cambiar el contenido de la cantidad
            $("#costeImporte").keyup(function () {
                //Si la opcion seleccionada en comboItems es diferente a "Seleccionar" se muestran datos
                //if ($("#comboItems").val() != "0") {
                //Llamamos a la funcion calcularTotal() que calcula el total del cargo
                calcularTotal();
                //}
            });
        });
        //Funcion para llenar el combo de impuestos. Los datos nos vienen en un ArrayList de objetos TipoImpuesto transformado en String
        //con json. Los datos se obtienen en itemsController/getTipoItem.htm.
        function getTipoItem() {
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
                url: '/Facturacion/itemsController/getTipoItem.htm', //Vamos a itemsController/getTipoItem.htm a recoger los datos
                success: function (data) {

                    //Recogemos los datos del combo y pasamos el String a un Array de objetos tipoItem
                    //Estos objetos estan en formato String
                    var tipoItem = JSON.parse(data);
                    //Identificamos el combo por el ID
                    select = document.getElementById('id_tipo_item');
                    //Lo vamos cargando
                    tipoItem.forEach(function (valor, indice) {
                        //Cada objeto esta en String y lo pasmoa a TipoItem
                        var tipoItem2 = JSON.parse(valor);
                        //Creamos las opciones del combo
                        var opt = document.createElement('option');
                        //Guardamos el id en el value de cada opcion
                        opt.value = tipoItem2.id_tipo_item;
                        //Guardamos la descripcion de item en el nombre de cada opcion                        //                 
                        opt.innerHTML = tipoItem2.item;
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
        //Funcion para llenar el combo de cuentas. Los datos nos vienen en un ArrayList de objetos TipoCuenta transformado en String
        //con json. Los datos se obtienen en itemsController/getTipoCuenta.htm.
        function getTipoCuenta() {
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
                url: '/Facturacion/itemsController/getTipoCuenta.htm', //Vamos a itemsController/getTipoItem.htm a recoger los datos
                success: function (data) {

                    //Recogemos los datos del combo y pasamos el String a un Array de objetos tipoItem
                    //Estos objetos estan en formato String
                    var tipoCuenta = JSON.parse(data);
                    //Identificamos el combo por el ID
                    select = document.getElementById('id_cuenta');
                    //Lo vamos cargando
                    tipoCuenta.forEach(function (valor, indice) {
                        //Cada objeto esta en String y lo pasmoa a TipoItem
                        var tipoCuenta2 = JSON.parse(valor);
                        //Creamos las opciones del combo
                        var opt = document.createElement('option');
                        //Guardamos el id en el value de cada opcion
                        opt.value = tipoCuenta2.col1;
                        //Guardamos la descripcion de item en el nombre de cada opcion                        //                 
                        opt.innerHTML = tipoCuenta2.col2;
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
                url: '/Facturacion/itemsController/getEntidadEmpresa.htm', //Vamos a cargosController/getEmpresa.htm a recoger los datos
                success: function (data) {
                    //Vaciamos el combo clientes
                    $("#comboEmpresas option").remove();
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
                url: '/Facturacion/itemsController/getEntidadCliente.htm', //Vamos a cargosController/getCliente.htm a recoger los datos
                success: function (data) {
                //Vaciamos el combo clientes
                $("#comboClientes1 option").remove();
                        //Recogemos los datos del combo y los pasamos a objetos Entidad  
                        var clienteEntidad = JSON.parse(data);
                        //Identificamos el combo
                        select = document.getElementById('comboClientes1');
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
        //Funcion para los calculos de los importes e impuestos
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
                <div class="col-md-8">
                    <div class="form-area">  
                        <form role="form">

                            <br style="clear:both">
                            <h3 style="margin-bottom: 25px; text-align: center;">Formulario para ITEMS</h3>

                            <div class="col-xs-7"> 

                                <div class="form-group">
                                    <label for="abreviatura">Abreviatura:</label>
                                    <input type="text" class="form-control" id="abreviatura" name="abreviatura" required>
                                </div>                            
                                <div class="form-group">
                                    <label for="descripcion:">Descripcion:</label>
                                    <input type="text" class="form-control" id="descripcion" name="descripcion" required>
                                </div>                                    

                                <div class="form-group-combo">
                                    <label for="tipo_item">Tipo de Item:</label>                                        
                                    <!--Combo para tipos de items-->
                                    <select class="form-control" id="id_tipo_item" name="id_tipo_item">
                                    </select>                                                                    
                                </div>

                                <div class="form-group-combo">
                                    <label for="id_cuenta">Cuenta:</label>                                        
                                    <!--Combo para las cuentas-->
                                    <select class="form-control" id="id_cuenta" name="id_cuenta">
                                    </select>                                                                    
                                </div>                               

                                <div class="form-group">
                                    <label for="importe">Importe:</label>
                                    <input type="text" class="form-control" id="importe" name="importe" required>
                                </div>

                                <div class="datos row" class="col-xs-12">

                                    <div class="form-group col-xs-10">
                                        <!--Radio button para añadir costes-->                                     
                                        <div class="form_radio_button">

                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="costesRadios" id="costesRadios1" value="1" checked>
                                                <label class="form-check-label" for="2">Sin costes</label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="costesRadios" id="costesRadios2" value="2">
                                                <label class="form-check-label" for="1">Con costes</label>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div> 

                            <div class="col-xs-5"  id="conCostes" name="conCostes">

                                <div class="form-group">
                                    <label>Añadir costes:</label>      
                                    <button type="button" class="btn btn-success" id="anadirCoste" name="anadirCoste" data-dismiss="modal" onclick="anadirCoste()">Añadir</button>
                                </div>

                                <div class="form-group">
                                    <table id="tableContainer" class="table table-striped">                                    

                                        <thead class="thead-dark">                                            
                                            <tr>
                                                <th scope="col">Entidad</th>                                                    
                                                <th scope="col">Importe</th>                                                    
                                            </tr>                                            
                                        </thead>

                                        <tbody id="tbody-tabla-costes">
                                            <tr>
                                                <td>
                                                    <div class="form-group-combo">                                                                               
                                                        <!--Combo para las empresas-->
                                                        <select class="form-control input-sm" id="comboEmpresas" name="comboEmpresas">
                                                        </select>                                                                    
                                                    </div>          
                                                </td>
                                                <td>                                                      
                                                    <input type="text" id="costeImporte" name="costeImporte" size="12">  
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <div class="form-group-combo">                                                                               
                                                        <!--Combo para las empresas-->
                                                        <select class="form-control input-sm" id="comboClientes1" name="comboClientes">
                                                        </select>                                                                    
                                                    </div>          
                                                </td>
                                                <td>
                                                    <input type="text" id="costeImporte1" name="costeImporte" size="12">  
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>

                            </div>
                    </div>

                    <br style="clear:both">
                    <a href="<c:url value='/MenuController/start.htm'/>" class="btn btn-info" role="button">Menu principal</a>                             
                    <button type="button" id="guardarItem" name="guardarItem" class="btn btn-primary pull-right">Guardar</button>

                    </form>
                </div>
            </div>
        </div>
    </div>                  
</body>
</html>
