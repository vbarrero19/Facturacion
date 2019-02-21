<%-- 
    Document   : direccionView
    Created on : 13-feb-2019, 9:35:36
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
        <title>Direccion</title>
    </head>
    <script>
        $(document).ready(function () {
            //LLAMAMOS A LAS FUNCIONCIONES QUE CARGAN LOS COMBOS DINAMICOS    

            getVerEntidad();
            getTipoDireccion();

            var userLang = navigator.language || navigator.userLanguage;

//FUNCION QUE AL HACER CLICK EN EL BOTON GUARDARDIRECCION NOS EJECUTA LOS INSERT.

            $("#guardarDireccion").click(function () {

                if (window.XMLHttpRequest) //mozilla
                {
                    ajax = new XMLHttpRequest(); //No Internet explorer
                } else
                {
                    ajax = new ActiveXObject("Microsoft.XMLHTTP");
                }

                var myObj = {};
                //GUARDAMOS EL DISTINCT CODE DE LA ENTIDAD
                myObj["id_tipo_direccion"] = $("#id_tipo_direccion").val();
                myObj["tipo_via"] = $("#tipo_via").val().trim();
                myObj["nombre_via"] = $("#nombre_via").val().trim();
                myObj["numero_via"] = $("#numero_via").val().trim();
                myObj["numero_portal"] = $("#numero_portal").val().trim();
                myObj["resto_direccion"] = $("#resto_direccion").val().trim();
                myObj["codigo_postal"] = $("#codigo_postal").val().trim();
                myObj["localidad"] = $("#localidad").val().trim();
                myObj["provincia"] = $("#provincia").val().trim();
                myObj["pais"] = $("#pais").val().trim();
                /*guaradmos el valor del comboEntidad, de la entidad seleccionada */
                var idEnt = $("#comboEntidad").val();
/*recogemos el valor por parametro de la entidad seleccionada en el combo y lo pasamos al controlador para que lo almacene en la entidad seleccionada*/
                var json = JSON.stringify(myObj);
                $.ajax({
                    type: 'POST',
                    url: '/Facturacion/direccionController/nuevaDireccion.htm?idEnt='+idEnt,
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
            function resetear(){
		document.forms['formulario'].reset();
		}
                


            /*FUNCION PARA VER LOS DATOS DE LA ENTIDAD SELECCIONADA EN EL COMBO. RECOGE POR PARAMETRO EL ID DEL CLIENTE. */
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
                        url: '/Facturacion/direccionController/getDatosEntidad.htm',
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
         * ************************************** FUNCIONES DE ALTA DIRECCION  ************************************** 
         * ******************************************************************************************************* */



 //recogemos el valor del combo(id_entidad) para utilizarlo luego al ver las facturas.
                var idEntidad = $("#comboEntidad").val();


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
                url: '/Facturacion/direccionController/getVerEntidad.htm',
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

        //CREAMOS UNA FUNCION PARA CARGAR EL COMBO TIPO_DIRECCION
        function getTipoDireccion() {

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
                url: '/Facturacion/direccionController/getTipoDireccion.htm',
                success: function (data) {
                    //RECOGEMOS LOS DATOS DEL COMBO Y PASAMOS EL STRING A UN ARRAY DE OBJETOS TIPO ENTIDAD
                    var tipoDireccion = JSON.parse(data);
                    //IDENTIFICAMOS EL COMBO POR EL ID DE LA TABLA TIPO_ENTIDAD
                    select = document.getElementById('id_tipo_direccion');
                    //LO CARGAMOS
                    tipoDireccion.forEach(function (valor, indice) {
                        //CADA OBJETO TIPO STRING LO PASAMOS A TIPOENTIDAD CON JSON
                        var tipoDireccion2 = JSON.parse(valor);
                        //CREAMOS LAS OPTION DEL COMBO(CODIGO HTML)
                        var opt = document.createElement('option');
                        //GUARDAMOS EL ID EN EL VALUE DE CADA OPCION DE CADA VUELTA
                        opt.value = tipoDireccion2.id_tipo_direccion;
                        //GUARDAMOS LA DESCRIPCION DEL TIPO DE ENTIDAD
                        opt.innerHTML = tipoDireccion2.tipo_direccion;
                        //AÑADIMOS UNA NUEVA OPCION
                        select.appendChild(opt);
                    });
                }
            });
        }







    </script>

    <body>
        <div class="container col-xs-12">
            <div class="col-xs-12">
                <!-- con col elegimos el tamaño xs:moviles md:tablets lg:pantallas de ordenador.
                para empujar las columnas usamos offset y el numero de columnas que queremos desplazar. tiene que estar 
                colocado por orden: tamaño de columnas y luego el offset con las que empujamos-->

                <div class="col-xs-12 col-md-offset-2 col-md-8 col-lg-offset-3 col-lg-6">
                    <div class="form-area">  
                        <form role="form" id="formulario">
                            <br style="clear:both">
                            <h3 style="margin-bottom: 25px; text-align: center;">FORMULARIO PARA DAR DE ALTA ENTIDAD</h3>

                        <div class="form-group col-xs-12" align="center">
                            <h4>DATOS DE LA DIRECCION</h4>
                        </div>

                            <div class="form-group">
                                <!-- COMBO PARA CARGAR DE FORMA DINAMICA LOS TIPOS DE DIRECCION QUE EXISTEN -->
                                <div class="form-group col-xs-6">
                                    <label for="comboEntidad"> Distinct code </label>                                                                          
                                        <select class="form-control" id="comboEntidad" name="comboEntidad">

                                        </select>  
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
                            <!--MIRAR COMO COMPLETAR LA TABLA SI ES LA MISMA DIRECCION PARA TODOS LOS TIPOS(fisica, fiscal....) -->
                            <label> ¿La direccion fisica es igual a la fiscal? </label>
                            <!-- Creamos un radio button para preguntar si la direccion fisica es igual a la fiscal y autcompletamos en caso afirmativo -->
                            <div id="direc" class="form_radio_button">
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="direc" id="direc1" value="no" checked>
                                    <label class="form-check-label" for="1">No</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="direc" id="direc2" value="si">
                                    <label class="form-check-label" for="2">Si</label>
                                </div>
                            </div>   
                            <button type="button" id="guardarDireccion" name="guardarDireccion" class="btn btn-primary pull-right">Alta direccion</button>
                            <a href="<c:url value='/MenuController/start.htm'/>" class="btn btn-info" role="button">Menu principal</a> 
                        </form>
                    </div>
                </div>
            </div>
        </div>                  
    </body>
</body>
</html>
