<%-- 
    Document   : modificarPagoView
    Created on : 18-feb-2019, 12:42:21
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
        <title>MODIFICAR METODO PAGO</title> 
    </head>

    <script>
        
        $(document).ready(function () {

            var userLang = navigator.language || navigator.userLanguage;

            var idEntidad = obtenerValorParametro("idEnt");
            var nombreEntidad = obtenerValorParametro("nombreEnt");

            //alert(idEntidad);
            //FUNCION PARA CARGAR LOS DATOS DE LA ENTIDAD.
            cargarDatosPago(idEntidad);

        });



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


        //FUNCION PARA CARGAR LOS DATOS DE LA ENTIDAD AL DARLE AL BOTON DE MODIFICAR.
        function cargarDatosPago(idEntidad) {
            

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
                /*en la url le pasamos como parametro el identificador de empresa*/
                url: '/Facturacion/verPagoController/modificarPago.htm?entidad=' + idEntidad,
                success: function (data) {
                //alert(data);
                    if (data != "vacio") {

                        var aux = JSON.parse(data);
                        //Vaciamos la tabla cada vez que entramos para que no se dupliquen los datos
                        //$('#tableContainer tbody').empty();
                        aux.forEach(function (valor, indice) {
                            //Cada objeto esta en String y lo pasmoa a TipoImpuesto
                            var pago = JSON.parse(valor);
                            $("#distinct_code").val(pago.distinct_code);
                            $("#nombre_entidad").val(pago.nombre_entidad);
                            $("#numero_cuenta").val(pago.numero_cuenta);
                            $("#titular_cuenta").val(pago.titular_cuenta);
                            $("#nombre_banco").val(pago.nombre_banco);
                            $("#direccion_banco").val(pago.direccion_banco);
                            $("#localidad").val(pago.localidad);
                            $("#pais").val(pago.pais);
                            $("#codigo1").val(pago.codigo1);
                            $("#codigo2").val(pago.codigo2);
                            $("#tarjeta_credito").val(pago.tarjeta_credito);
                            $("#titular_tarjeta").val(pago.titular_tarjeta);                            
                            $("#mes_caducidad").val(pago.mes_caducidad);
                            $("#anio_caducidad").val(pago.anio_caducidad);
                            $("#codigo_csc").val(pago.codigo_csc);
                            $("#cuenta_paypal").val(pago.cuenta_paypal);
                            $("#correo_paypal").val(pago.correo_paypal);
                            $("#cheque").val(pago.cheque);
                            
                        });

                    } else {
                        //Si data viene vacio borramos el contenido de los campos                        
                        $("#distinct_code").val("");
                        $("#nombre_entidad").val("");
                        $("#numero_cuenta").val("");
                        $("#titular_cuenta").val("");
                        $("#nombre_banco").val("");
                        $("#direccion_banco").val("");
                        $("#localidad").val("");
                        $("#pais").val("");
                        $("#codigo1").val("");
                        $("#codigo2").val("");
                        $("#tarjeta_credito").val("");
                        $("#titular_tarjeta").val("");
                        $("#mes_caducidad").val("");
                        $("#anio_caducidad").val("");
                        $("#codigo_csc").val("");
                        $("#cuenta_paypal").val("");
                        $("#correo_paypal").val("");
                        $("#cheque").val("");
                                
                        
                        
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
        <body>
        <div class="container col-xs-12">
            <div class="col-xs-12 col-md-offset-2 col-md-8 col-lg-offset-3 col-lg-6">
                <div class="form-area">  
                    <form role="form">
                        <br style="clear:both">
                        <h3 style="margin-bottom: 25px; text-align: center;">MODIFICAR PAGO</h3>

                        <!-- INFORMACIÓN DE LA ENTIDAD DONDE QUEREMOS ALMACENAR EL METODO DE PAGO -->
                        <div class="form-group">
                            <!-- COMBO PARA CARGAR DE FORMA DINAMICA LOS TIPOS DE DIRECCION QUE EXISTEN -->
                            <div class="form-group col-xs-6">
                                    <label for="distinct_code"> Distinct code </label>
                                        <input type="text" class="form-control" id="distinct_code" name="distinct_code" disabled = "true">                                             
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
                                        <input class="form-check-input inline-block" type="radio" name="tipo_tarjeta2" id="tipo_tarjeta2" value="masterCard">                                            
                                    </div>
                                    <div class="form-check">
                                        <label class="fm-check-label" for="3">American Express</label>
                                        <input class="form-check-input inline-block" type="radio" name="tipo_tarjeta3" id="tipo_tarjeta3" value="American Exrpress">
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
                        <button type="button" id="guardarPago" name="guardarPago" class="btn btn-primary pull-right">Modificar método pago</button>
                        <a href="<c:url value='/MenuController/start.htm'/>" class="btn btn-info" role="button">Menu principal</a>                                                    
                        <a href="<c:url value='/verPagoController/start.htm'/>" class="btn btn-info" role="button">Volver</a> 
                        </div>
                    </form>
                </div>
            </div>
        </div> 
    </body>
    </body>
</html>
