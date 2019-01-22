
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
//        $(document).ready(function () {
//            var userLang = navigator.language || navigator.userLanguage;
//
//            $("#btnCliente").click(function () {
//
//                if (window.XMLHttpRequest) //mozilla
//                {
//                    ajax = new XMLHttpRequest(); //No Internet explorer
//                } else
//                {
//                    ajax = new ActiveXObject("Microsoft.XMLHTTP");
//                }
//
////                var myObj = {};
////
////                myObj["id_cliente"] = $("id_cliente").val().trim();
////
////                var json = JSON.stringify(myObj);
//
//                $.ajax({
//                    type: 'POST',
//                    url: '/Facturacion/verClientesController/verCliente.htm',
//                    data: json,
//                    datatype: "json",
//                    contentType: "application/json",
//                    success: function (data) {
//                        var aux = JSON.parse(data);
//
//                        //Vaciamos la tabla cada vez que entramos para que no se dupliquen los datos
//                        $('#tableContainer tbody').empty();
//                        aux.forEach(function (valor, indice) {
//                            //Cada objeto esta en String y lo pasmoa a Cliente
//                            var cliente = JSON.parse(valor);
//
//                            //cargamos de forma dinamica la tabla
//                            $('#tableContainer tbody').append(" <tr>\n\
//                                                                //   <th scope=\"row\">" + (indice + 1) + "</th>              \n\
//                                                                    <td>" + (indice + 1) + "</td>              \n\
//                                                                    <td>" + cliente.nombre_empresa + "</td>                       \n\
//                                                                    <td>" + cliente.num_ident + "</td>                        \n\
//                                                                    <td>" + cliente.pais + "</td>                       \n\ \n\
//                                                                </tr>");
//                        });
//                    },
//                    error: function (xhr, ajaxOptions, thrownError) {
//                        console.log(xhr.status);
//                        console.log(xhr.responseText);
//                        console.log(thrownError);
//                    }
//                });
//            })
//        });


 /* ACABAR Y MIRAR PORQ NO COGE DATOS http://www.actualidadjquery.es/2010/10/20/cargando-contenido-dinamico-con-la-funcion-ajax-de-jquery/ */ 
$(document).ready(function(){  
  
    $('#btnCliente').click(function() {  
        $.ajax({  
            url: 'contenido.html',  
            success: function(data) {  
                $('#div_dinamico').html(data);  
            }  
        });  
    });  
  
    $('#boton_cargar_anim').click(function() {  
        $.ajax({  
            url: 'contenido_anim.html',  
            success: function(data) {  
                $('#div_dinamico_anim').html(data);  
                $('#div_dinamico_anim div').slideDown(1000);  
            }  
        });  
    });  
  
});  

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
                                                <th scope="col">Id fiscal</th> 
                                                <th scope="col">País</th> 
                                            </tr>
                                        </thead>
                                        <tbody>
<!--                                            <tr>
                                                <td>Sam Smith</td>
                                                <td>Depósito</td>
                                                <td>$3,000.00</td>
                                                <td>$3,000.00</td>
                                            </tr>-->
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
