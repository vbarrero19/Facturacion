<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="jstl" uri="http://java.sun.com/jstl/core_rt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
    <%@ include file="infouser.jsp" %> 
    <head> 
        <title>MODIFICAR ITEMS VIEW</title>       </head>
    <style>
        .container{
            width: 1400px;

        }

        .verde{
            background-color: #ffe48d;
            margin-bottom: 25px;
        }


    </style>
    <script>
        $(document).ready(function () {

            var idItem = obtenerValorParametro("idItem");
            var idTipo;
            var idCuenta;

            getItem(idItem);
            
            //Cargamos el tipo y la cuenta dentro de getItem para que se carguen correctamente con los datos del item.
            //getTipoItem();
            //getTipoCuenta();

            var cont = 0;

            $('#conCostes').hide();

            //$("input[name=costesRadios]").attr('disabled', true);

            $("#costesRadios1").on("click", function () {
                $('#conCostes').hide();
                $('#sinCostes').show();
            });

            $("#costesRadios2").on("click", function () {
                $('#conCostes').show();
                //$('#importe').val(0);
                //getEntidadEmpresa();

            });

            //Codigo para añadir un coste de forma dinamica
            $('#conCostes').on('click', '#anadirCoste', function () {
                cont++;
                $('#tableContainer tbody').append(" <tr class='eliminar'>\n\
                                                            <td> <div class='form-group-combo'>\n\
                                                            <select class='form-control input-sm' id='comboClientes" + cont + "' name='comboClientes'></select></div> </td>     \n\
                                                            <td><input type='text' id='costeImporte" + cont + "' name='costeImporte' value='0'></td>        \n\
                                                            <td><button type='button' class='btn miBoton btn-danger' id='myBtn';>Eliminar</button></td>\n\
                                                    </tr>");
                getEntidadCliente("comboClientes" + cont);
            });


            //Codigo para eliminar un coste de forma dinamica
            $('#conCostes').on('click', '.miBoton', function () {
                var parent = $(this).parent().parent().remove();
                calcularTotal();
            });

            $('#conCostes').on('keyup', 'input[name=costeImporte]', function () {
                calcularTotal();
            });

            //Evento .click en el boton submit
            $("#modificarItem").click(function () {
                if (window.XMLHttpRequest) //mozilla
                {
                    ajax = new XMLHttpRequest(); //No Internet explorer
                } else
                {
                    ajax = new ActiveXObject("Microsoft.XMLHTTP");
                }

                //Variable para guardar los valores del formulario
                var myObj = {};

                //Codigo para recuperar los costes de un item
                //Creamos el array donde guardaremos los datos
                var arrayOption = [];

                $("#tableContainer tbody>tr option:checked").each(function (index) {
                    arrayOption.push(this.value + "-" + $("#tableContainer tbody>tr input").eq(index).val());
                });

                //alert(arrayOption.toString());

                alert($("input[name=costesRadios]:checked").val());
                //Cargamos el contenido de los campos del formulario
                myObj["id_item"] = $("#id_Item").text().trim();
                myObj["abreviatura"] = $("#abreviatura").val().trim();
                myObj["descripcion"] = $("#descripcion").val().trim();
                myObj["id_tipo_item"] = $("#id_tipo_item").val();
                myObj["importe"] = $("#importe").val().trim();
                myObj["estado"] = "0";
                myObj["importe"] = $("#importe").val().trim();
                myObj["id_cuenta"] = $("#id_cuenta").val();
                if ($("input[name=costesRadios]:checked").val() == "Si") {

                    myObj["costes"] = arrayOption.toString();
                } else {
                    myObj["costes"] = "No";
                }
                //Convertimos la variable myObj a String
                var json = JSON.stringify(myObj);
                $.ajax({
                    type: 'POST',
                    url: '/Facturacion/modificarItemsController/modificarItem.htm', //Vamos a newCustomer de itemsController
                    data: json,
                    datatype: "json",
                    contentType: "application/json",
                    success: function (data) {
                        alert("data");
                        //location.reload();
                        window.location.href="/Facturacion/verItemsController/start.htm";
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        console.log(xhr.status);
                        console.log(xhr.responseText);
                        console.log(thrownError);
                    }
                });
            })

        });


        //Funcion para llenar los datos del item seleccionado.
        function getItem(idItem) {
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
                url: '/Facturacion/modificarItemsController/getItem.htm?idItem=' + idItem,
                success: function (data) {

                    var item = JSON.parse(data);

                    //Lo vamos cargando
                    item.forEach(function (valor, indice) {
                        //Cada objeto esta en String y lo pasmoa a Cliente
                        item2 = JSON.parse(valor);
                        idTipo = item2.col4;
                        idCuenta = item2.col7;

                        $("#id_Item").text(item2.col1);

                        $("#abreviatura").val(item2.col2);
                        $("#descripcion").text(item2.col3);
                        $("#importe").val(item2.col5);

                        if (item2.col8 == "No") {
                            //alert(item2.col8);
                            $("#costesRadios1").attr('checked', true);
                            $('#conCostes').hide();
                            $('#sinCostes').show();

                        } else {
                            //alert(item2.col8);
                            $("#costesRadios2").attr('checked', true);
                            $('#conCostes').show();
                            $("#importe").val(item2.col5);
                            getCostes(idItem);
                        }
            getTipoItem();
            getTipoCuenta();

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

        //Funcion para llenar el combo de tipo de item.
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
                url: '/Facturacion/modificarItemsController/getTipoItem.htm', //Vamos a modificarItemsController/getTipoItem.htm a recoger los datos
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
                        //Gestionamos la opcion seleccionada

                        //Guardamos el id en el value de cada opcion
                        opt.value = tipoItem2.id_tipo_item;
                        //Guardamos la descripcion de item en el nombre de cada opcion                        //                 
                        opt.innerHTML = tipoItem2.item;
                        if (tipoItem2.id_tipo_item == idTipo) {
                            //La dejamos seleccionada
                            opt.selected = true;

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

        //Funcion para llenar el combo de cuentas.
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
                url: '/Facturacion/modificarItemsController/getTipoCuenta.htm', //Vamos a itemsController/getTipoItem.htm a recoger los datos
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

                        if (tipoCuenta2.col1 == idCuenta) {

                            //La dejamos seleccionada
                            opt.selected = true;
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
            var cant = 0;
            $("#tableContainer tbody>tr option:checked").each(function (index) {

                //arrayOption.push(this.value + "-" + $("#tableContainer tbody>tr input").eq(index).val());
                cant = cant + parseFloat($("#tableContainer tbody>tr input").eq(index).val().trim());

            });

            $("#importe").val(cant);

        }
        ;

        //Funcion para recuperar los costes de un item
        function getCostes(idItem) {
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
                url: '/Facturacion/modificarItemsController/getCostes.htm?idItem=' + idItem,
                success: function (data) {

                    alert(data);

                    var costes = JSON.parse(data);

                    //Lo vamos cargando
                    costes.forEach(function (valor, indice) {
                        //Cada objeto esta en String y lo pasmoa a Cliente
                        costes2 = JSON.parse(valor);
                        if (indice == 0) {
                            getEntidadEmpresa(costes2.col2);
                            $("#costeImporte").val(costes2.col3)
                        } else {

                            $('#anadirCoste').click();
                            alert(costes2.col2);
                            //$('#comboClientes' + indice + ' option[value=6]').attr("selected",true);
                            //getEntidadCliente("comboClientes" + indice,costes2.col2);

                            //$('#comboClientes1 option[value=6]').attr('selected', true);

                            $('#costeImporte' + indice).val(costes2.col3);

                            //$("#selector option[value=3]").attr('disabled','disabled');
                            //$("#menu option[value='2']").attr("selected", true);
                            //$("#provincia option[value="+ valor +"]").attr("selected",true);'+ costes2.col2 +'    ' + indice + '
                        }

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

        //Funcion para llenar el combo de empresa.
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

                        if (empresaEntidad2.id_entidad == idEmpresa) {
                            opt.selected = true;
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

        //Funcion para llenar el combo de cliente.
        function getEntidadCliente(idCombo) {
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
                    //$("#comboClientes1 option").remove();
                    //Recogemos los datos del combo y los pasamos a objetos Entidad  
                    var clienteEntidad = JSON.parse(data);
                    //Identificamos el combo
                    select = document.getElementById(idCombo);
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



    </script>
    <body>
        <div class="container">
            <div class="col-xs-12">

                <div class="form-area">  
                    <form role="form" action="">

                        <br style="clear:both">

                        <div class="col-xs-7 verde">                             
                            <h3 style="margin-bottom: 25px; text-align: center;">Modificar ITEMS</h3>

                            <div class="form-group row">
                                <div class="col-xs-4">
                                    <label for="id_Item">Item:</label>
                                </div>
                                <div class="col-xs-6">
                                    <label class="form-control" id="id_Item" name="id_Item"></label>
                                    <!--<input type="text" class="form-control" id="id_Item" name="id_Item" required>-->
                                </div>
                            </div>          

                            <div class="form-group row">
                                <div class="col-xs-4">
                                    <label for="abreviatura">Abreviatura:</label>
                                </div>
                                <div class="col-xs-6">
                                    <input type="text" class="form-control" id="abreviatura" name="abreviatura" required>
                                </div>
                            </div>                   

                            <div class="form-group row">
                                <div class="col-xs-4">
                                    <label for="descripcion:">Descripcion:</label>
                                </div>
                                <div class="col-xs-6">
                                    <!--<input type="text" class="form-control" id="descripcion" name="descripcion" required>-->
                                    <textarea rows="3" cols="50" maxlength="100" class="form-control" id="descripcion" name="descripcion" required></textarea>
                                </div>
                            </div>                                    

                            <div class="form-group-combo row">
                                <div class="col-xs-4">
                                    <label for="tipo_item">Tipo de Item:</label>      
                                </div>
                                <div class="col-xs-6">
                                    <!--Combo para tipos de items-->
                                    <select class="form-control" id="id_tipo_item" name="id_tipo_item">
                                    </select>                            
                                </div>
                            </div>

                            <div class="form-group-combo row">
                                <div class="col-xs-4">
                                    <label for="id_cuenta">Cuenta:</label>    
                                </div>
                                <div class="col-xs-6">
                                    <!--Combo para las cuentas-->
                                    <select class="form-control" id="id_cuenta" name="id_cuenta">
                                    </select>             
                                </div>     
                            </div>    

                            <div class="form-group row" id="sinCostes" name="sinCostes">
                                <div class="col-xs-4">
                                    <label for="importe">Importe:</label>
                                </div>
                                <div class="col-xs-6">
                                    <input type="text" class="form-control" id="importe" name="importe" required>
                                </div>
                            </div>

                            <div class="form-group row">
                                <!--Radio button para añadir costes-->                                     
                                <div class="col-xs-4">
                                    <label for="id_cuenta">Costes:</label>    
                                </div>
                                <div class="col-xs-6">
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="costesRadios" id="costesRadios1" value="No" checked>
                                        <label class="form-check-label" for="2">Sin costes</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="costesRadios" id="costesRadios2" value="Si">
                                        <label class="form-check-label" for="1">Con costes</label>
                                    </div>
                                </div>
                            </div>


                            <div id="conCostes" name="conCostes">

                                <div class="form-group row" >
                                    <div class="col-xs-4">
                                        <label>Añadir costes:</label>
                                    </div>
                                    <!--                                    <div class="col-xs-6">
                                                                            <button type="button" class="btn btn-success btn-sm" id="anadirCoste" name="anadirCoste" data-dismiss="modal" >Añadir Coste</button>
                                                                        </div>-->
                                </div>

                                <div class="form-group">
                                    <table id="tableContainer" class="table">                                    

                                        <thead>                                            
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
                                                    <input type="text" id="costeImporte" name="costeImporte" value="0">  
                                                </td>
                                                <td>

                                                    <button type="button" class="btn btn-success btn-sm" id="anadirCoste" name="anadirCoste" data-dismiss="modal" >Añadir Coste</button>

                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>

                        <br style="clear:both">

                        <a href="/Facturacion/MenuController/start.htm" class="btn btn-info" role="button">Menu principal</a>    
                        <button type="button" id="modificarItem" name="modificarItem" class="btn btn-primary">Modificar</button>
                        <!--<button type="button" id="modificarItem2" name="modificarItem2" class="btn btn-primary">Modificar Manteniendo Original</button>-->
                        <a href="/Facturacion/verItemsController/start.htm" class="btn btn-success" role="button" id="startItem">Ver Items</a>

                    </form>
                </div>
            </div>
        </div>

    </div>                  
</body>
</html>
