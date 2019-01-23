
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
            
            cargarClientes();            
            
            var userLang = navigator.language || navigator.userLanguage;
            
//            
        });

        function cargarClientes() {
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
                url: 'verCliente.htm', //Vamos a facturasController/getCliente.htm a recoger los datos
                success: function (data) {

                    //Recogemos los datos del combo y los pasamos a objetos TipoImpuesto  
                    var aux = JSON.parse(data);
 
                    //Vamos cargando la tabla
                    aux.forEach(function (valor, indice) {
                        //Cada objeto esta en String y lo pasmoa a 
                        var cliente = JSON.parse(valor);                        
                        
                        $('#tableContainer tbody').append(" <tr>\n\
                                                                <th scope=\"row\">" + (indice + 1) + "</th>              \n\
                                                                    <td>" + cliente.id_cliente + "</td>              \n\
                                                                    <td>" + cliente.nombre_empresa + "</td>                  \n\
                                                                    <td>" + cliente.nombre_persona + "</td>              \n\
                                                                    <td>" + cliente.num_ident + "</td>                  \n\
                                                                    <td>" + cliente.dir_fisica + "</td>              \n\
                                                                    <td>" + cliente.pais + "</td>              \n\ \n\
                                                                    <td>" + cliente.telefono1 + "</td>                        \n\ \n\
                                                                </tr>");
        
        
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

                                
                                <div class="col-xs-6 form-group">
                                <label for="comboClientes">Nombre de cliente</label>
                                <div class="form-group-combo">
                                    <!--Combo para clientes-->
                                    <select class="form-control" id="comboClientes" name="comboClientes">
                                    </select>                                                            
                                </div>
                            </div>
                                

                                <div class="col-xs-12" id="tableContainer">
                                    <table class="table table-striped">
                                        <thead class="thead-dark">
                                            <tr>
                                                <th scope="col">#</th>
                                                <th scope="col">id_cliente</th>                                                
                                                <th scope="col">nombre_empresa</th> 
                                                <th scope="col">nombre_persona</th> 
                                                <th scope="col">num_ident</th>
                                                <th scope="col">dir_fisica</th>                                                
                                                <th scope="col">pais</th> 
                                                <th scope="col">telefono1</th>                                                 
                                                
                                                
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



<!--//Identificamos el combo
                    select = document.getElementById('comboItems');
                    //Añadimos la opcion Seleccionar al combo
                    var opt = document.createElement('option');
                    opt.value = 0;
                    opt.innerHTML = "Seleccionar";
                    select.appendChild(opt);

                    //Lo vamos cargando
                    aux.forEach(function (valor, indice) {
                        //Cada objeto esta en String y lo pasmoa a TipoImpuesto
                        var aux2 = JSON.parse(valor);
                        //Creamos las opciones del combo
                        var opt = document.createElement('option');
                        //Guardamos el id en el value de cada opcion
                        opt.value = aux2.id_item;
                        //Guardamos el impuesto en el nombre de cada opcion                        
                        opt.innerHTML = aux2.nombre;
                        //Añadimos la opcion
                        select.appendChild(opt);
                    });-->


