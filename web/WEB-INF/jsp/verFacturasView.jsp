<%-- 

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
        <title>VER FACTURAS</title> 
    </head>
    <script>
       $(document).ready(function () {
            //Al cargar la pagina llamamos a las funciones getCliente() y getEmpresa() para llenar los combos
            //getEntidadCliente();
            
            getVerEntidad();

            var userLang = navigator.language || navigator.userLanguage;

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
                myObj["distinct_code"] = $("#comboEntidad").val().trim();                
                myObj["id_entidad"] = $("#id_entidad").val().trim();


                var json = JSON.stringify(myObj);
                $.ajax({
                    type: 'POST',
                    url: '/Facturacion/verFacturasController/nuevoFactura.htm',
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

//            //Muestra datos de la entidadCliente al seleccionar algo en el combo
//            $("#comboEntidad").change(function () {
//
//                //Si la opcion seleccionada es diferente a "Seleccionar" se muestran datos
//                if ($("#comboEntidad").val() != "0") {
//
//                    if (window.XMLHttpRequest) //mozilla
//                    {
//                        ajax = new XMLHttpRequest(); //No Internet explorer
//                    } else
//                    {
//                        ajax = new ActiveXObject("Microsoft.XMLHTTP");
//                    }
//
//                    var myObj = {};
//
//                    myObj["id_entidad"] = $("#comboEntidad").val().trim();
//
//                    var json = JSON.stringify(myObj);
//                    $.ajax({
//                        type: 'POST',
//                        url: '/Facturacion/verFacturasController/getDatosEntidadCliente.htm',
//                        data: json,
//                        datatype: "json",
//                        contentType: "application/json",
//                        success: function (data) {
//                            
//                            var aux = JSON.parse(data);
//
//                            aux.forEach(function (valor, indice) {
//                                //Recogemos cada objeto en String y los pasamos a objetos Tipo cliente con JSON
//                                var aux2 = JSON.parse(valor);
//                                //Mostramos los datos en la cajas de texto
//                                $("#id_entidad").val(aux2.id_entidad);
//                                $("#nombre_entidad").val(aux2.nombre_entidad);
//                                $("#nombre_contacto").val(aux2.nombre_contacto);
//
//                            });
//                        },
//                        error: function (xhr, ajaxOptions, thrownError) {
//                            console.log(xhr.status);
//                            console.log(xhr.responseText);
//                            console.log(thrownError);
//                        }
//                    });
//
//                    //Si se seleciona lo opcion "Seleccionar" se limpian las cajas de texto
//                } else {
//                    $("#id_entidad").val("");
//                    $("#nombre_entidad").val("");
//                    $("#nombre_contacto").val("");
//                }
//
//            });
        });
        
        
        
        
        
            //CREAMOS LA FUNCION PARA CARGAR EL COMBO DE TIPO ENTIDAD.
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
                url: '/Facturacion/verFacturasController/getVerEntidad.htm',
                success: function (data) {
                    //RECOGEMOS LOS DATOS DEL COMBO Y PASAMOS EL STRING A UN ARRAY DE OBJETOS TIPO ENTIDAD
                    var verEntidad = JSON.parse(data);
                    //IDENTIFICAMOS EL COMBO POR EL ID DE LA TABLA TIPO_ENTIDAD
                    select = document.getElementById('comboEntidad');
                    //LO CARGAMOS
                    verEntidad.forEach(function (valor, indice) {
                        //CADA OBJETO TIPO STRING LO PASAMOS A TIPOENTIDAD CON JSON
                        var verEntidad2 = JSON.parse(valor);
                        //CREAMOS LAS OPTION DEL COMBO(CODIGO HTML)
                        var opt = document.createElement('option');
                        //GUARDAMOS EL ID EN EL VALUE DE CADA OPCION DE CADA VUELTA
                        opt.value = verEntidad2.id_entidad;
                        //GUARDAMOS LA DESCRIPCION DEL TIPO DE ENTIDAD
                        opt.innerHTML = verEntidad2.distinct_code;
                        //AÑADIMOS UNA NUEVA OPCION
                        select.appendChild(opt);
                    });
                }
            });
        }
        
    </script>


    <body>
        <div class="container">
            <div class="col-xs-12">
                <div class="col-md-12 col-xs-5">
                    <div class="form-area">  
                        <form role="form">
                            <br style="clear:both">
                            <h3 style="margin-bottom: 25px; text-align: center;">VER FACTURAS ENTIDAD</h3>                           

                            <div class="datos" class="col-xs-12">
                                <!--Combo para entidades-->
                                <div class="form-group col-xs-3">
                                    <label for="comboEntidad"> Entidad </label>
                                    <div class="form-group-combo">                                        
                                        <select class="form-control" id="comboEntidad" name="comboEntidad">

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
                                <br style="clear:both">


                                <button type="button" id="submit" name="submit" class="btn btn-primary pull-right">Submit</button>
                                <a href="<c:url value='/MenuController/start.htm'/>" class="btn btn-info" role="button">Menu principal</a> 
                        </form>

                    </div>                            
                </div>
            </div>
        </div>  
    </div>
</body> 
</html>



