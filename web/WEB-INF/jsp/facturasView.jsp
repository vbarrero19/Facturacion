
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="jstl" uri="http://java.sun.com/jstl/core_rt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
    <%@ include file="infouser.jsp" %>
    <head> 
        <title>FACTURAS GENERAR VIEW</title> 
    </head>
    <script>
        $(document).ready(function () {
            var userLang = navigator.language || navigator.userLanguage;
            //*************************************//
            //ejecutarlo dentro del ready porque se ejecuta cada vez que entramos en la pagina.
            //constructor para el calendario. uno por cada calendario.
//            $('#fecha_cargo').datetimepicker({
//                format: 'YYYY-MM-DD',
//                locale: userLang.valueOf(),
//                daysOfWeekDisabled: [0, 6],
//                useCurrent: false//Important! See issue #1075
//                        //defaultDate: '08:32:33',
//                        //                });
//            });
//            $('#fecha_vencimiento').datetimepicker({
//                format: 'YYYY-MM-DD',
//                locale: userLang.valueOf(),
//                daysOfWeekDisabled: [0, 6],
//                useCurrent: false//Important! See issue #1075
//                        //defaultDate: '08:32:33',
//                        //                });
//            });
            $("#submit").click(function () {

                if (window.XMLHttpRequest) //mozilla
                {
                    ajax = new XMLHttpRequest(); //No Internet explorer
                } else
                {
                    ajax = new ActiveXObject("Microsoft.XMLHTTP");
                }

                var myObj = {};
//              
                myObj["id_cliente"] = $("#id_cliente").val().trim();
               
//              
                var json = JSON.stringify(myObj);

                $.ajax({
                    type: 'POST',
                    url: '/Facturacion/facturasController/getFacturas.htm',
                    data: json,
                    datatype: "json",
                    contentType: "application/json",
                    success: function (data) {

                        var aux = JSON.parse(data);                        

                        //Vaciamos la tabla cada vez que entramos para que no se dupliquen los datos
                        $('#tableContainer tbody').empty();
                        aux.forEach(function (valor, indice) {
                            //Cada objeto esta en String y lo pasmoa a TipoImpuesto
                            var item = JSON.parse(valor);                            
                            
                            $("#nombre_empresa").val(item.nombre_empresa);
                            $("#dir_fisica").val(item.dir_fisica);
                            $("#pais").val(item.pais);
                            
                            //cargamos de forma dinamica la tabla
                            $('#tableContainer tbody').append(" <tr>\n\
                                                                    <th scope=\"row\">" + (indice + 1) + "</th>              \n\
                                                                    <td>" + item.id_cargo + "</td>                       \n\
                                                                    <td>" + item.cargo + "</td>                        \n\
                                                                    <td>" + item.cantidad + "</td>                       \n\ \n\
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
        ;


    </script>
    <body>
        <div class="container">
            <div class="col-xs-12">
                <div class="col-md-5">
                    <div class="form-area">  
                        <form role="form">
                            <br style="clear:both">
                            <h3 style="margin-bottom: 25px; text-align: center;">Formulario para CARGOS</h3>

                            <div class="form-group">
                                <input type="text" class="form-control" id="id_cliente" name="id_cliente" placeholder="Identificador cliente" required>
                            </div>
                            <button type="button" id="submit" name="submit" class="btn btn-primary pull-right">Submit Form</button>


                            <div class="form-group">
                                <input type="text" class="form-control" id="nombre_empresa" name="nombre_empresa" placeholder="Identificador cargo" required>
                            </div>                            
                            <div class="form-group">
                                <input type="text" class="form-control" id="dir_fisica" name="dir_fisica" placeholder="Identificador items" required>
                            </div>
                            <div class="form-group">
                                <input type="text" class="form-control" id="pais" name="pais" placeholder="Identificador factura" required>
                            </div>

                            <div class="col-xs-12" id="tableContainer">
                                <table class="table table-striped">
                                    <thead class="thead-dark">
                                        <tr>
                                            <th scope="col">#</th>
                                            <th scope="col">Id_cargo</th>
                                            <th scope="col">Cargo</th> 
                                            <th scope="col">Cantidad</th> 
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
