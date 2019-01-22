
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="jstl" uri="http://java.sun.com/jstl/core_rt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
    <%@ include file="infouser.jsp" %>
    <head> 
        <title>CLIENTES</title> 
    </head>
    <script>
        $(document).ready(function () {
  
            /* VAMOS COMPLETANDO LA TABLA CON LOS DATOS DE LOS CLIENTES PARA QUE SE VISUALICEN TODOS.  */

            $("#tableContainer").click(function ()(){

            if (window.XMLHttpRequest) //mozilla
            {
                ajax = new XMLHttpRequest(); //No Internet explorer
            } else
            {
                ajax = new ActiveXObject("Microsoft.XMLHTTP");
            }

//            var myObj = {};
//
//            myObj["id_cliente"] = $("#id_cliente").val().trim();

            var json = JSON.stringify(myObj);

            $.ajax({
                type: 'POST',
                url: '/Facturacion/verClientesController/verCliente.htm',
                data: json,
                datatype: "json",
                contentType: "application/json",
                success: function (data) {

                    var aux = JSON.parse(data);
                    alert(data);
                    //Vaciamos la tabla cada vez que entramos para que no se dupliquen los datos
                    $('#tableContainer tbody').empty();
                    //recorremos la tabla.
                    aux.forEach(function (valor, indice) {
                        //Cada objeto esta en String y lo pasmoa a Cliente
                        var clientes = JSON.parse(valor);

                        //cargamos de forma dinamica la tabla
                        $('#tableContainer tbody').append(" <tr>\n\
                                                                    <th scope=\"row\">" + (indice + 1) + "</th>              \n\
                                                                    <td>" + clientes.nombre_empresa + "</td>                       \n\
                                                                    <td>" + clientes.num_ident + "</td>                        \n\
                                                                    <td>" + clientes.pais + "</td>                       \n\ \n\
                                                                </tr>");


                    });
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    console.log(xhr.status);
                    console.log(xhr.responseText);
                    console.log(thrownError);
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

                            <!--EL ID DE CLIENTE TENEMOS QUE CAMBIARLO Y PONERLO SERIAL EN LA BASE DE DATOS PARA QUE SE AUTOINCREMENTE SOLO -->
                            <div class="form-group">
                                <input type="text" class="form-control" id="id_cliente" name="id_cliente" placeholder="Identificador cliente" required>
                            </div> 

                            <!--CREAMOS TABLA DONDE VISUALIZAREMOS LA LISTA DE LOS CLIENTES -->                            

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

                                    </tbody>
                                </table>
                            </div>                            
                            <a href="<c:url value='/MenuController/start.htm'/>" class="btn btn-info" role="button">Menu principal</a> 
                        </form>
                    </div>
                </div>
            </div>
        </div>                  
    </body>
</html>
