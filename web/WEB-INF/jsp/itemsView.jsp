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
            //al cargar la pagina llamamos a la funcion getImpuesto() para llenar el combo 
            getTipoItem();
            getTipoCuenta();            

            var cont = 0;

            $('#conCostes').hide();

            $("#costesRadios1").on("click", function () {
                $('#conCostes').hide();
                $('#sinCostes').show();
            });

            $("#costesRadios2").on("click", function () {
                $('#conCostes').show();
                $('#importe').val(0);
                getEntidadEmpresa();
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

                //Codigo para recuperar los costes de un item
                //Creamos el array donde guardaremos los datos
                var arrayOption = [];

                $("#tableContainer tbody>tr option:checked").each(function (index) {
                    arrayOption.push(this.value + "-" + $("#tableContainer tbody>tr input").eq(index).val());
                });             

                //Cargamos el contenido de los campos del formulario
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
                    url: '/Facturacion/itemsController/newItems.htm', //Vamos a newCustomer de itemsController
                    data: json,
                    datatype: "json",
                    contentType: "application/json",
                    success: function (data) {
                        alert(data);
                        location.reload();
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        console.log(xhr.status);
                        console.log(xhr.responseText);
                        console.log(thrownError);
                    }
                });
            })

        });
        //Funcion para llenar el combo de tipo de item. Los datos nos vienen en un ArrayList de objetos TipoImpuesto transformado en String
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

    </script>
    <body>
        <div class="container">
            <div class="col-xs-12">

                <div class="form-area">  
                    <form role="form" action="">

                        <br style="clear:both">

                        <div class="col-xs-7 azul">                             
                            <h3 style="margin-bottom: 25px; text-align: center;">Añadir ITEMS</h3>


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
                        <button type="button" id="guardarItem" name="guardarItem" class="btn btn-primary">Guardar</button>

                    </form>
                </div>
            </div>
        </div>

    </div>                  
</body>
</html>
