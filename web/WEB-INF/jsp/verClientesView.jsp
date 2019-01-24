
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
                url: '/Facturacion/verClientesController/verCliente.htm', //Vamos a facturasController/getCliente.htm a recoger los datos
                success: function (data) {

                    //Recogemos los datos del combo y los pasamos a objetos TipoImpuesto  
                    var aux = JSON.parse(data);
 
                    //Vamos cargando la tabla
                    aux.forEach(function (valor, indice) {
                        //Cada objeto esta en String y lo pasmoa a 
                        var cliente = JSON.parse(valor);                        
                        
                        $('#tableContainer tbody').append(" <tr>\n\
                                                                <th scope=\"row\">" + (indice + 1) + "</th>     \n\
                                                                    <td>" + cliente.id_cliente + "</td>         \n\
                                                                    <td>" + cliente.nombre_empresa + "</td>     \n\
                                                                    <td>" + cliente.nombre_persona + "</td>     \n\
                                                                    <td>" + cliente.num_ident + "</td>          \n\
                                                                    <td>" + cliente.dir_fisica + "</td>         \n\
                                                                    <td>" + cliente.pais + "</td>               \n\
                                                                    <td>" + cliente.telefono1 + "</td>          \n\
                                                                    <td class='botones'>" + " <button value='actualizar' tittle='actualizar' id='btnedit' class='btn btn-primary btn-edit'><i class='fas fa-edit'></i></i></button> " 
                                                                    + "<button value='eliminar' tittle='eliminar' class='btn btn-danger btn-delete'><i class='fas fa-window-close'></i></button>"    
                                                                    + "</td>          \n\\n\
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
        
//        $("#btnedit").click(function(){
//            Alert("Hola!");
//        }


/*https://uh-tis.blogspot.com/2017/02/curso-de-java-como-hago-el-boton-eliminar.html
 * 
 * https://www.lawebdelprogramador.com/foros/Netbeans/1200965-boton-eliminar.html*/

    </script>

    
    <body>
        <div class="container">
            <div class="col-xs-12">                               
                <div class="col-xs-12 col-md-offset-2 col-md-8 col-lg-offset-1 col-lg-6">
                    <div class="form-area">  
                        <form role="form">
                            <br style="clear:both">
                            <h3 style="margin-bottom: 25px; text-align: center;">FORMULARIO PARA CLIENTES</h3>
                            <div>

                                
                                <!--https://es.stackoverflow.com/questions/64319/boton-dinamico-jquery-en-una-tabla-->
                                

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
                                                <th scope="col">Acciones</th>  
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



