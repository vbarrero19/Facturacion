
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="jstl" uri="http://java.sun.com/jstl/core_rt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
    <%@ include file="infouser.jsp" %>
    <head> 
        <title>VER CLIENTES</title> 
    </head>
    <script>
        $(document).ready(function () {
            var userLang = navigator.language || navigator.userLanguage;

            $("#btnCliente").click(function () {

                if (window.XMLHttpRequest) //mozilla
                {
                    ajax = new XMLHttpRequest(); //No Internet explorer
                } else
                {
                    ajax = new ActiveXObject("Microsoft.XMLHTTP");
                }

                var myObj = {};

                myObj["id_cliente"] = "1";

                var json = JSON.stringify(myObj);

                $.ajax({
                    type: 'POST',
                    url: '/Facturacion/verClientesController/verCliente.htm',
                    data: json,
                    datatype: "json",
                    contentType: "application/json",
                    success: function (data) {
                        var aux = JSON.parse(data);

                        //Vaciamos la tabla cada vez que entramos para que no se dupliquen los datos
                        $('#tableContainer tbody').empty();
                        aux.forEach(function (valor, indice) {
                            //Cada objeto esta en String y lo pasmoa a Cliente
                            var cliente = JSON.parse(valor);

                            //cargamos de forma dinamica la tabla
                            $('#tableContainer tbody').append(" <tr>\n\
                                                                <th scope=\"row\">" + (indice + 1) + "</th>              \n\
                                                                    <td>" + cliente.nombre_empresa + "</td>                       \n\
                                                                    <td>" + cliente.num_ident + "</td>                        \n\
                                                                    \n\<td>" + cliente.dir_fisica + "</td>                       \n\ \n\
                                                                    <td>" + cliente.pais + "</td>                       \n\ \n\
                                                                </tr>");
                        });
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        console.log(xhr.status);
                        console.log(xhr.responseText);
                        console.log(thrownError);
                    }
                });
            })
        });


        /* ACABAR Y MIRAR PORQ NO COGE DATOS http://www.actualidadjquery.es/2010/10/20/cargando-contenido-dinamico-con-la-funcion-ajax-de-jquery/
         * 
         *  https://es.stackoverflow.com/questions/56676/agregar-datos-a-tabla-html-din%C3%A1mica-desde-funci%C3%B3n-success-de-jquery */


    </script>



    <body>
        <div class="container">
            <div class="col-xs-12">                               
                <div class="col-xs-12 col-md-offset-2 col-md-8 col-lg-offset-3 col-lg-6">
                    <div class="form-area">  
                        <form role="form">
                            <br style="clear:both">
                            <h3 style="margin-bottom: 25px; text-align: center;">FORMULARIO PARA CLIENTES</h3>
                            <div>
                                <div class="col-xs-12">
                                    <button type="button" id="btnCliente" name="btnCliente" class="btn btn-primary pull-right">Lista clientes</button>
                                </div>


                                <div class="col-xs-12" id="tableContainer">
                                    <table class="table table-striped">
                                        <thead class="thead-dark">
                                            <tr>
                                                <th scope="col">#</th>
                                                <th scope="col">Nombre</th>
                                                <th scope="col">Num id fiscal</th> 
                                                <th scope="col">Direccion fisica</th> 
                                                <th scope="col">País</th> 
                                            </tr>
                                        </thead>
                                        <tbody>
                                            
                                        </tbody>
                                    </table>
                                </div>    
                                <div>
                                    <a href="<c:url value='/MenuController/start.htm'/>" class="btn btn-info" role="button">Menu principal</a> 
                                </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>                  
    </body>
</html>
