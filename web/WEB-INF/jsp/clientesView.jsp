
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
            getTipoEmpresa();
            
            $("#submit").click(function () {
                if (window.XMLHttpRequest) //mozilla
                {
                    ajax = new XMLHttpRequest(); //No Internet explorer
                } else
                {
                    ajax = new ActiveXObject("Microsoft.XMLHTTP");
                }

                var myObj = {};
                //id cliente autoincrement
                myObj["id_cliente"] = $("#id_cliente").val().trim();
                //nombre de la empresa
                myObj["nombreEmpresa"] = $("#nombreEmpresa").val().trim();
                //identificador persona(mr/mrs)
                ////////*****//////
                
                //nombre persona de contacto
                myObj["nombrePersona"] = $("#nombrePersona").val().trim();
                //identificador empresa (cif, nit...)
                myObj["id_ident"] = $("#id_ident").val();
                //Numero identificador de la empresa
                
                //tipo de empresa (cliente, proveedor, nosotros)
                myObj["id_tipo"] = $("#desc_tipo").val().trim();
                //Direccion de la empresa
                myObj["direccion"] = $("#direccion").val().trim();
                //telefono de la empresa
                myObj["telefono"] = $("#telefono").val().trim();
                //mail de la empresa
                myObj["mail"] = $("#mail").val().trim();

                var json = JSON.stringify(myObj);
                $.ajax({
                    type: 'POST',
                    url: '/Facturacion/clientesController/newCustomer.htm',
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
            })
        });
        
        
         function getTipoEmpresa() {
            if (window.XMLHttpRequest) //mozilla
            {
                ajax = new XMLHttpRequest(); //No Internet explorer
            } else
            {
                ajax = new ActiveXObject("Microsoft.XMLHTTP");
            }

            $.ajax({
                type: 'GET',
                url: '/Facturacion/clientesController/getTipoEmpresa.htm',
                success: function (data) {
                    //alert(data);
                    var aux = JSON.parse(data);

                    select = document.getElementById('desc_tipo');

                    aux.forEach(function (valor, indice) {
                        var aux2 = JSON.parse(valor);
                        alert(aux2);
                        var opt = document.createElement('option');
                        opt.value = aux2.id_tipo;
                        opt.innerHTML = aux2.desc_tipo;
                        select.appendChild(opt);
                        
                        
                    });

                }
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
                <div class="col-md-5">
                    <div class="form-area">  
                        <form role="form">
                            <br style="clear:both">
                            <h3 style="margin-bottom: 25px; text-align: center;">Formulario para CLIENTES</h3>
                            <div class="form-group">
                                <input type="text" class="form-control" id="id_cliente" name="id_cliente" placeholder="Identificador cliente" required>
                            </div> 
                            <div class="form-group">
                                <input type="text" class="form-control" id="nombreEmpresa" name="nombreEmpresa" placeholder="Nombre empresa" required>
                            </div>
                            <!--FALTA CREAR TODO EN JAVA Y JSP -->
                            <div class="form-group">
                                <div class="radio">
                                    <label>
                                        <input type="radio" name="opciones" id="opciones_1" value="opcion_1" checked>
                                        Mr
                                    </label>
                                    <label>
                                        <input type="radio" name="opciones" id="opciones_2" value="opcion_2">
                                        Mrs
                                    </label>
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <input type="text" class="form-control" id="nombrePersona" name="nombrePersona" placeholder="Nombre persona" required>
                            </div>
                            
                            <!--FALTA CREAR TODO EN JAVA Y JSP -->
                            <div class="form-group">
                                <select class="form-control" id="tipo_ident">
                                    <option></option>
                                    <option>CIF</option>
                                    <option>NIT</option>
                                    <option>IDENT3</option>
                                </select>
                            </div>
                            
                            <!-- *********** -->
                            
                            <div class="form-group">
                                <input type="text" class="form-control" id="id_ident" name="id_ident" placeholder="Identificador empresa(CIF)" required>
                            </div>
                            
                            <!--FALTA RECOGER LOS DATOS AL CREAR EL OBJETO DESDE EL STRING  -->
                            <div class="form-group">
                                <select class="form-control" id="id_tipo" name="id_tipo">
                                </select>
                            </div>
                            
                            <!-- *********** -->
                            <div class="form-group">
                                <input type="text" class="form-control" id="direccion" name="direccion" placeholder="Dirección" required>
                            </div>
                            <div class="form-group">
                                <input type="text" class="form-control" id="telefono" name="telefono" placeholder="Teléfono" required>
                            </div>
                            <div class="form-group">
                                <input type="text" class="form-control" id="mail" name="mail" placeholder="E-mail" required>
                            </div>

                            <a href="<c:url value='/MenuController/start.htm'/>" class="btn btn-info" role="button">Menu principal</a>                             
                            <button type="button" id="submit" name="submit" class="btn btn-primary pull-right">Submit Form</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>                  
    </body>
</html>
