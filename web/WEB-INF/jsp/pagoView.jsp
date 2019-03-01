<%-- 
    Document   : pagoView
    Created on : 14-feb-2019, 10:08:39
    Author     : vbarr
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="jstl" uri="http://java.sun.com/jstl/core_rt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
    <%@ include file="infouser.jsp" %>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Método de pago</title>
    </head>

    <script>


        $(document).ready(function () {
            getVerEntidad();

            var userLang = navigator.language || navigator.userLanguage;

            /*FUNCION PARA VER LOS DATOS DE LA ENTIDAD SELECCIONADA EN EL COMBO. RECOGE POR PARAMETRO EL ID DEL CLIENTE. */


            $("#guardarPago").click(function () {

                if (window.XMLHttpRequest) //mozilla
                {
                    ajax = new XMLHttpRequest(); //No Internet explorer
                } else
                {
                    ajax = new ActiveXObject("Microsoft.XMLHTTP");
                }

                var myObj = {};
                //GUARDAMOS EL DISTINCT CODE DE LA ENTIDAD
                myObj["numero_cuenta"] = $("#numero_cuenta").val().trim();
                myObj["codigo1"] = $("#codigo1").val().trim();
                myObj["codigo2"] = $("#codigo2").val().trim();
                myObj["titular_cuenta"] = $("#titular_cuenta").val().trim();
                myObj["tarjeta_credito"] = $("#tarjeta_credito").val().trim();
                myObj["mes_caducidad"] = $("#mes_caducidad").val().trim();
                myObj["anio_caducidad"] = $("#anio_caducidad").val().trim();
                myObj["tipo_tarjeta"] = $(".form-check input:checked").val();
                myObj["codigo_csc"] = $("#codigo_csc").val().trim();
                myObj["titular_tarjeta"] = $("#titular_tarjeta").val().trim();
                myObj["cuenta_paypal"] = $("#cuenta_paypal").val().trim();
                myObj["correo_paypal"] = $("#correo_paypal").val().trim();
                myObj["cheque"] = $("#cheque").val().trim();
                myObj["nombre_banco"] = $("#nombre_banco").val().trim();
                myObj["direccion_banco"] = $("#direccion_banco").val().trim();
                myObj["localidad"] = $("#localidad").val().trim();
                myObj["pais"] = $("#pais").val().trim();
                myObj["por_defecto"] = $("#por_defecto").val().trim();

                //COGEMOS EL VALOR DEL COMBO (ID_ENTIDAD)
                var idEnt = $("#comboEntidad").val();

                var json = JSON.stringify(myObj);
                $.ajax({
                    type: 'POST',
                    url: '/Facturacion/pagoController/nuevoPago.htm?idEnt=' + idEnt,
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
                resetear();
            });


            /*FUNCION PARA LIMPIAR TODOS LOS CAMPOS DEL FORMULARIO TRAS DARLE CLICK AL BOTON ALTA */
            function resetear() {
                document.forms['formulario'].reset();
            }



            $("#comboEntidad").change(function () {
                //Si la opcion seleccionada es diferente a Seleccionar se muestran datos
                if ($("#comboEntidad").val() !== "0") {

                    if (window.XMLHttpRequest) //mozilla
                    {
                        ajax = new XMLHttpRequest(); //No Internet explorer
                    } else
                    {
                        ajax = new ActiveXObject("Microsoft.XMLHTTP");
                    }

                    var myObj = {};

                    //recogemos el valor de comboEntidad y lo metemos en id_entidad.
                    myObj["col1"] = $("#comboEntidad").val();

                    var json = JSON.stringify(myObj);
                    $.ajax({
                        type: 'POST',
                        url: '/Facturacion/pagoController/getDatosEntidad.htm',
                        data: json,
                        datatype: "json",
                        contentType: "application/json",
                        success: function (data) {


                            var aux = JSON.parse(data);

                            aux.forEach(function (valor, indice) {
                                //Recogemos cada objeto en String y los pasamos a objetos Tipo cliente con JSON
                                var aux2 = JSON.parse(valor);
                                //Mostramos los datos en la cajas de texto
                                $("#nombre_entidad").val(aux2.col2);

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
                    $("#nombre_entidad").val("");
                }
            });

        });


        /*  * *******************************************************************************************************
         * *********************************** FUNCIONES DE ALTA METODO DE PAGO  ************************************ 
         * ******************************************************************************************************* */


        //CREAMOS FUNCION PARA CARGAR LA LISTA DE ENTIDADES EN EL COMBO
        function getVerEntidad() {

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
                //VAMOS A ENTIDADESCONTROLLER A RECOGER LOS DATOS DE LA FUNCION GETTIPOENTIDAD
                url: '/Facturacion/pagoController/getVerEntidad.htm',
                success: function (data) {
                    //RECOGEMOS LOS DATOS DEL COMBO Y PASAMOS EL STRING A UN ARRAY DE OBJETOS TIPO ENTIDAD
                    var verEntidad = JSON.parse(data);
                    //IDENTIFICAMOS EL COMBO POR EL ID DE LA TABLA TIPO_ENTIDAD
                    select = document.getElementById('comboEntidad');
                    var opt = document.createElement('option');
                    opt.value = 0;
                    opt.innerHTML = "Seleccionar";
                    select.appendChild(opt);
                    verEntidad.forEach(function (valor, indice) {
                        //CADA OBJETO TIPO STRING LO PASAMOS A TIPOENTIDAD CON JSON
                        var verEntidad2 = JSON.parse(valor);
                        //CREAMOS LAS OPTION DEL COMBO(CODIGO HTML)
                        var opt = document.createElement('option');
                        //GUARDAMOS EL ID EN EL VALUE DE CADA OPCION DE CADA VUELTA
                        opt.value = verEntidad2.id_entidad;
                        //GUARDAMOS LA DESCRIPCION DEL TIPO DE ENTIDAD
                        opt.innerHTML = verEntidad2.distinct_code;
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

    </script>

    <body>
        <div class="container col-xs-12">
            <div class="col-xs-12 col-md-offset-2 col-md-8 col-lg-offset-3 col-lg-6">
                <div class="form-area">  
                    <form role="form" id="formulario">
                        <br style="clear:both">
                        <h3 style="margin-bottom: 25px; text-align: center;">FORMULARIO PARA DAR DE ALTA ENTIDAD</h3>

                        <div class="form-group col-xs-12" align="center">
                            <h4>DATOS DEL METODO DE PAGO</h4>
                        </div>
                        <!-- INFORMACIÓN DE LA ENTIDAD DONDE QUEREMOS ALMACENAR EL METODO DE PAGO -->
                        <div class="form-group">
                            <!-- COMBO PARA CARGAR DE FORMA DINAMICA LOS TIPOS DE DIRECCION QUE EXISTEN -->
                            <div class="form-group col-xs-6">
                                <label for="comboEntidad"> Distinct code </label>                                                                            
                                <select class="form-control" id="comboEntidad" name="comboEntidad">

                                </select>
                            </div> 
                            <div class="form-group col-xs-6">
                                <label for="idCliente>">Nombre entidad</label>
                                <input type="text" class="form-control" id="nombre_entidad" name="nombre_entidad" disabled = "true">
                            </div>  
                        </div>
                        <!-- ALMACENAMOS EL NUMERO DE CUENTA Y LOS CODIGOS -->
                        <div class="form-group">
                            <div class="form-group col-xs-8">
                                <label for="idCliente>">Numero cuenta</label>
                                <input type="text" class="form-control" id="numero_cuenta" name="numero_cuenta" placeholder="Num cuenta" required>
                            </div>                                        
                            <div class="form-group col-xs-2">
                                <label for="idCliente>">Cod1</label>
                                <input type="text" class="form-control" id="codigo1" name="codigo1" placeholder="Codigo1" required>
                            </div>                                        
                            <div class="form-group col-xs-2">
                                <label for="idCliente>">Cod2</label>
                                <input type="text" class="form-control" id="codigo2" name="codigo2" placeholder="Codigo2" required>
                            </div>
                        </div> 
                        <!-- ALMACENAMOS EL NOMBRE DEL TITULAR DE LA CUENTA -->
                        <div class="form-group col-xs-12">
                            <label for="idCliente>">Titular cuenta</label>
                            <input type="text" class="form-control" id="titular_cuenta" name="titular_cuenta" placeholder="Titular cuenta" required>
                        </div>

                        <!-- ALMACENAMOS LOS DATOS DE LA TARJETA -->

                        <div class="form-group">
                            <div class="form-group col-xs-8">
                                <label for="idCliente>">Numero tarjeta</label>
                                <input type="text" class="form-control" id="tarjeta_credito" name="tarjeta_credito" placeholder="Num tarjeta" required>
                            </div>                                        
                            <div class="form-group col-xs-2">
                                <label for="idCliente>">mes</label>
                                <input type="text" class="form-control" id="mes_caducidad" name="mes_caducidad" placeholder="mes cad" required>
                            </div>                                        
                            <div class="form-group col-xs-2">
                                <label for="idCliente>">año</label>
                                <input type="text" class="form-control" id="anio_caducidad" name="anio_caducidad" placeholder="año cad" required>
                            </div>
                        </div> 

                        <div class="form-group">
                            <div class="form-group col-xs-8">
                                <label for="idCliente>">Tipo tarjeta</label>
                                <div id="tipo_tarjeta" class="form_radio_button_tipo_tarjeta">
                                    <div class="form-check">                                            
                                        <label class="fm-check-label" for="1">Visa</label>
                                        <input class="form-check-input inline-block" type="radio" name="tipo_tarjeta" id="tipo_tarjeta1" value="visa" checked>
                                    </div>
                                    <div class="form-check">
                                        <label class="form-check-label" for="2">MasterCard</label>
                                        <input class="form-check-input inline-block" type="radio" name="tipo_tarjeta" id="tipo_tarjeta2" value="masterCard">                                            
                                    </div>
                                    <div class="form-check">
                                        <label class="fm-check-label" for="3">American Express</label>
                                        <input class="form-check-input inline-block" type="radio" name="tipo_tarjeta" id="tipo_tarjeta3" value="American Exrpress">
                                    </div>
                                </div>
                            </div>                        

                            <div class="form-group col-xs-4">
                                <label for="idCliente>">Codigo csc</label>
                                <input type="text" class="form-control" id="codigo_csc" name="codigo_csc" placeholder="cod_csc" required>
                            </div>
                        </div>
                        <div class="form-group col-xs-12">
                            <label for="idCliente>">Titular tarjeta</label>
                            <input type="text" class="form-control" id="titular_tarjeta" name="titular_tarjeta" placeholder="Titular tarjeta" required>
                        </div>

                        <div class="form-group">
                            <div class="form-group col-xs-6">
                                <label for="idCliente>">Cuenta paypal</label>
                                <input type="text" class="form-control" id="cuenta_paypal" name="cuenta_paypal" placeholder="cuenta paypal" required>
                            </div>                                        
                            <div class="form-group col-xs-6">
                                <label for="idCliente>">Correo paypal</label>
                                <input type="text" class="form-control" id="correo_paypal" name="correo_paypal" placeholder="correo paypal" required>
                            </div>
                        </div> 
                        <div class="form-group">
                            <div class="form-group col-xs-12">
                                <label for="idCliente>">cheque</label>
                                <input type="text" class="form-control" id="cheque" name="cheque" placeholder="cheque" required>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="form-group col-xs-6">
                                <label for="idCliente>">Nombre banco</label>
                                <input type="text" class="form-control" id="nombre_banco" name="nombre_banco" placeholder="nombre banco" required>
                            </div>                                        
                            <div class="form-group col-xs-6">
                                <label for="idCliente>">Direccion banco</label>
                                <input type="text" class="form-control" id="direccion_banco" name="direccion_banco" placeholder="direccion banco" required>
                            </div>
                        </div> 

                        <div class="form-group">
                            <div class="form-group col-xs-6">
                                <label for="idCliente>">Localidad</label>
                                <input type="text" class="form-control" id="localidad" name="localidad" placeholder="Localidad" required>
                            </div>                                        
                            <div class="form-group col-xs-6">
                                <label for="idCliente>">Pais</label>
                                <input type="text" class="form-control" id="pais" name="pais" placeholder="Pais" required>
                            </div>
                        </div>


                        <div class="form-group">
                            <div class="form-group col-xs-12">
                                <label for="idCliente>">Pago por defecto</label>
                                <div id="por_defecto" class="form_radio_button">
                                    <div class="form-check">                                            
                                        <label class="fm-check-label" for="1">Transferencia</label>
                                        <input class="form-check-input inline-block" type="radio" name="por_defecto" id="por_defecto1" value="transferencia" checked>
                                    </div>
                                    <div class="form-check">
                                        <label class="form-check-label" for="2" align="center">Tarjeta</label>
                                        <input class="form-check-input inline-block" type="radio" name="por_defecto" id="por_defecto2" value="tarjeta">                                            
                                    </div>
                                    <div class="form-check">
                                        <label class="fm-check-label" for="3">Pay Pal</label>
                                        <input class="form-check-input inline-block" type="radio" name="por_defecto" id="por_defecto3" value="paypal">
                                    </div>
                                    <div class="form-check">
                                        <label class="fm-check-label" for="4">Cheque</label>
                                        <input class="form-check-input inline-block" type="radio" name="por_defecto" id="por_defecto4" value="cheque">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group col-xs-12">
                            <button type="button" id="guardarPago" name="guardarPago" class="btn btn-primary pull-right">Alta método pago</button>
                            <a href="<c:url value='/MenuController/start.htm'/>" class="btn btn-info" role="button">Menu principal</a>  
                        </div>
                    </form>
                </div>
            </div>
        </div> 
    </body>
</html>