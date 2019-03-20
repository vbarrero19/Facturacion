<%-- 
    Document   : modificarDireccionView
    Created on : 15-feb-2019, 12:42:57
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
        <title>MODIFICAR ENTIDADES</title> 
    </head>
    <script>
        $(document).ready(function () {
            var userLang = navigator.language || navigator.userLanguage;

            var idEntidad = obtenerValorParametro("idEnt");
            //var nombreEntidad = obtenerValorParametro("nombreEnt");
            
        

           // alert(idEntidad);
            cargarDatosDireccion(idEntidad);

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
        };
        
        
        //FUNCION PARA CARGAR LOS DATOS DE LA DIRECCION AL DARLE AL BOTON DE MODIFICAR.
        function cargarDatosDireccion(idEntidad) {
            

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
                url: '/Facturacion/verDireccionController/modificarDireccion.htm?entidad=' + idEntidad,
                success: function (data) {
//                alert(data);
                    if (data != "vacio") {

                        var aux = JSON.parse(data);
                        //Vaciamos la tabla cada vez que entramos para que no se dupliquen los datos
                        //$('#tableContainer tbody').empty();
                        aux.forEach(function (valor, indice) {
                            //Cada objeto esta en String y lo pasmoa a TipoImpuesto
                            var entidadDireccion = JSON.parse(valor);
                            $("#distinct_code").val(entidadDireccion.distinct_code);
                            $("#nombre_entidad").val(entidadDireccion.nombre_entidad);
                            $("#tipo_via").val(entidadDireccion.tipo_via);
                            $("#nombre_via").val(entidadDireccion.nombre_via);
                            $("#numero_via").val(entidadDireccion.numero_via);
                            $("#numero_portal").val(entidadDireccion.numero_portal);
                            $("#resto_direccion").val(entidadDireccion.resto_direccion);
                            $("#codigo_postal").val(entidadDireccion.codigo_postal);
                            $("#localidad").val(entidadDireccion.localidad);
                            $("#provincia").val(entidadDireccion.provincia);
                            $("#pais").val(entidadDireccion.pais);
                            
                            
                        });

                    } else {
                        //Si data viene vacio borramos el contenido de los campos                        
                        $("#distinct_code").val("");
                        $("#nombre_entidad").val("");    
                        $("#tipo_via").val("");
                        $("#nombre_via").val("");
                        $("#numero_via").val("");
                        $("#numero_portal").val("");
                        $("#resto_direccion").val("");
                        $("#codigo_postal").val("");
                        $("#localidad").val("");
                        $("#provincia").val("");
                        $("#pais").val("");
                        
                    }
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    console.log(xhr.status);
                    console.log(xhr.responseText);
                    console.log(thrownError);
                }
            });
        };
        
        /*** FUNCION PARA MODIFICAR LOS DATOS DE LA ENTIDAD EN LA BASE DE DATOS AL DARLE AL BOTON MODIFICAR DIRECCION */
        
        $("#modificarDireccion").click(function () {
                if (window.XMLHttpRequest) //mozilla
                {
                    ajax = new XMLHttpRequest(); //No Internet explorer
                } else
                {
                    ajax = new ActiveXObject("Microsoft.XMLHTTP");
                }

                var myObj = {};
                myObj["tipo_via"] = $("#tipo_via").text();



                var json = JSON.stringify(myObj);
                $.ajax({
                    type: 'POST',
                    url: '/Facturacion/modificarDireccionController/modificarDireccion.htm',
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
        
                
        
        /*************/
        
         function getEntidad(idEntidad) {
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
                url: '/Facturacion/modificarDireccionController/getEntidad.htm?idEnt=' + idEntidad, 
                success: function (data) {

                    var entidad = JSON.parse(data);

                    //Lo vamos cargando
                    entidad.forEach(function (valor, indice) {
                        //Cada objeto esta en String y lo pasmoa a Cliente
                        var entidad2 = JSON.parse(valor);

                        //$("#dis_cod_cli").text(clienteEntidad2.col2)
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

        <div class="container col-xs-12">
            <div class="col-xs-12">
                <!-- con col elegimos el tamaño xs:moviles md:tablets lg:pantallas de ordenador.
                para empujar las columnas usamos offset y el numero de columnas que queremos desplazar. tiene que estar 
                colocado por orden: tamaño de columnas y luego el offset con las que empujamos-->

                <div class="col-xs-12 col-md-offset-2 col-md-8 col-lg-offset-3 col-lg-6">
                    <div class="form-area">  
                        <form role="form">
                            <br style="clear:both">
                            <h3 style="margin-bottom: 25px; text-align: center;">MODIFICAR DIRECCION</h3>


                            <div class="form-group">
                                <!-- COMBO PARA CARGAR DE FORMA DINAMICA LOS TIPOS DE DIRECCION QUE EXISTEN -->
                                <div class="form-group col-xs-6">
                                    <label for="distinct_code"> Distinct code </label>
                                    <input type="text" class="form-control" id="distinct_code" name="distinct_code" disabled = "true">                                             
                                </div> 
                                <div class="form-group col-xs-6">
                                    <label for="idCliente>">Nombre_entidad</label>
                                    <input type="text" class="form-control" id="nombre_entidad" name="nombre_entidad" disabled = "true">
                                </div>  
                            </div>

                            <div class="form-group">
                                <!-- COMBO PARA CARGAR DE FORMA DINAMICA LOS TIPOS DE DIRECCION QUE EXISTEN -->
                                <div class="form-group col-xs-6 ">
                                    <label for="idCliente>">Tipo direccion</label>
                                    <select id="id_tipo_direccion" name="id_tipo_direccion" class="form-control">

                                    </select>
                                </div>
                                <div class="form-group col-xs-6">
                                    <label for="idCliente>">Tipo via</label>
                                    <input type="text" class="form-control" id="tipo_via" name="tipo_via" placeholder="Tipo via(c, avda..)" required>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="form-group col-xs-12">
                                    <label for="idCliente>">Nombre via</label>
                                    <input type="text" class="form-control" id="nombre_via" name="nombre_via" placeholder="Nombre via" required>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="form-group col-xs-3">
                                    <label for="idCliente>">Numero via</label>
                                    <input type="text" class="form-control" id="numero_via" name="numero_via" placeholder="Numero vía" required>
                                </div>
                                <div class="form-group col-xs-3">
                                    <label for="idCliente>">Portal</label>
                                    <input type="text" class="form-control" id="numero_portal" name="numero_portal" placeholder="Numero portal" required>
                                </div>

                                <div class="form-group">
                                    <div class="form-group col-xs-6">
                                        <label for="idCliente>">Resto direccion</label>
                                        <input type="text" class="form-control" id="resto_direccion" name="resto_direccion" placeholder="Resto direccion" required>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">   
                                <div class="form-group col-xs-2">
                                    <input type="text" class="form-control" id="codigo_postal" name="codigo_postal" placeholder="Codigo postal" required>
                                </div>   
                                <div class="form-group col-xs-4">
                                    <input type="text" class="form-control" id="localidad" name="localidad" placeholder="Localidad" required>
                                </div>
                                <div class="form-group col-xs-4">
                                    <input type="text" class="form-control" id="provincia" name="provincia" placeholder="Provincia" required>
                                </div>

                                <div class="form-group">
                                    <div class="form-group col-xs-2">
                                        <input type="text" class="form-control" id="pais" name="pais" placeholder="pais" required>
                                    </div>
                                </div>

                            </div> 
                            <button type="button" id="modificarDireccion" name="modificarDireccion" class="btn btn-primary pull-right">Modificar direccion</button>

                            <a href="<c:url value='/MenuController/start.htm'/>" class="btn btn-info" role="button">Menu principal</a>                             
                            <a href="<c:url value='/verDireccionController/start.htm'/>" class="btn btn-info" role="button">Volver</a> 
                        </form>
                    </div>
                </div>
            </div>
        </div>       
    </body>
</html>
