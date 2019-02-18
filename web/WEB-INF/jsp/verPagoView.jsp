<%-- 
    Document   : verDireccionView
    Created on : 15-feb-2019, 13:19:19
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
        <title>MODIFICAR PAGO</title>
    </head>

    <script>
        
        $(document).ready(function () {

            cargarPago();

            var userLang = navigator.language || navigator.userLanguage;

        });
        


function cargarPago() {
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
                url: '/Facturacion/verPagoController/verPago.htm',
                success: function (data) {

                    //Recogemos los datos del combo y los pasamos a objetos TipoImpuesto  
                    var aux = JSON.parse(data);

                    //Vamos cargando la tabla
                    aux.forEach(function (valor, indice) {
                        //Cada objeto esta en String y lo pasmoa a 
                        var EntidadPago = JSON.parse(valor);

                        $('#tableContainer tbody').append(" <tr>\n\
                                                                <th scope=\"row\">" + (indice + 1) + "</th>     \n\
                                                                    <td>" + EntidadPago.nombre_entidad + "</td>         \n\
                                                                    <td>" + EntidadPago.titular_cuenta + "</td>         \n\
                                                                    <td>" + EntidadPago.nombre_banco + "</td>         \n\
                                                                    <td><a href='/Facturacion/pagoController/startPago.htm' class='btn btn-primary'> Modificar </button>\n\
                                                                    <td><button class='btn btn-danger btn-eliminar'> Eliminar </button>\n\</td> \n\\n\
                        < /tr>");
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
            <div class="col-xs-12">                               
                <div class="col-xs-12 col-md-offset-2 col-md-8 col-lg-offset-3 col-lg-6">
                    <div class="form-area">  
                        <form role="form">
                            <br style="clear:both">
                            <h3 style="margin-bottom: 25px; text-align: center;">LISTA DE DIRECCIONES</h3>
                            <div>
                                <div class="col-xs-12" id="tableContainer">
                                    <table class="table table-striped">                                    

                                        <thead class="thead-dark">
                                            <tr>
                                                <th scope="col">#</th>
                                                <th scope="col">Nombre entidad</th>
                                                <th scope="col">Titular cuenta</th>
                                                <th scope="col">Nombre banco</th>
                                            </tr>                                            
                                        </thead>

                                        <tbody id="tbody-tabla-entidades">

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
