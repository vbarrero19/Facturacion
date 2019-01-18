
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
            getFiscal();
            getEmpresa();


            //Al cambiar la opcion del radio direc(igual direccion fisica y fiscal)
            //activamos la funcion que repite el texto en los dos campos de texto
            $('input[name=direc]').change(function () {//          

                if ($("#direc2").is(':checked')) {
                    //CUANDO ACTIVAMOS EL BOTON DEL SI
                    $("#dir_fisica").keyup(function () {
                        document.getElementById('dir_fiscal').value = this.value;
                    });
                    //DESHABILITAMOS EL CAJON2 DE LA DIRECCION FISCAL
                    $("#dir_fiscal").prop('disabled', true);

                } else {
                    // CUANDO CLICKAMOS EN EL BOTON DEL NO
                    $("#dir_fiscal").prop('disabled', false);
                    $('#dir_fiscal').val('');
                }
            })


            // LA FUNCION QUE AL HACER CLICK, NOS EJECUTA TODO.
            $("#submit").click(function () {

                if (window.XMLHttpRequest) //mozilla
                {
                    ajax = new XMLHttpRequest(); //No Internet explorer
                } else
                {
                    ajax = new ActiveXObject("Microsoft.XMLHTTP");
                }

                var myObj = {};
                //id cliente 
                myObj["id_cliente"] = $("#id_cliente").val().trim();
                //nombre empresa
                myObj["nombre_empresa"] = $("#nombre_empresa").val().trim();
                //tratamiento persona
                myObj["tratamiento"] = $(".form-check input:checked").val();
                //nombre de la persona  
                myObj["nombre_persona"] = $("#nombre_persona").val().trim();
                //inicial del segundo nombre de la persona
                myObj["mi_persona"] = $("#mi_persona").val().trim();
                //Apellido de la persona de contacto
                myObj["apellido_persona"] = $("#apellido_persona").val().trim();
                //Tipo de identificacion fiscal
                myObj["id_fiscal"] = $("#fiscal").val();
                //Numero de identificador de la empresa.
                myObj["num_ident"] = $("#num_ident").val().trim();
                //Direccion fisica
                myObj["dir_fisica"] = $("#dir_fisica").val().trim();
                //Direccion fiscal
                myObj["dir_fiscal"] = $("#dir_fiscal").val().trim();
                //Pais
                myObj["pais"] = $("#pais").val().trim();
                //correo electronico    
                myObj["mail"] = $("#mail").val().trim();
                //Telefono 1
                myObj["telefono1"] = $("#telefono1").val().trim();
                //Telefono 2
                myObj["telefono2"] = $("#telefono2").val().trim();
                //fax
                myObj["fax"] = $("#fax").val().trim();
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
        function getFiscal() {
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
                //Recogemos los datos de clientesController/getFiscal.htm 
                url: '/Facturacion/clientesController/getFiscal.htm',
                success: function (data) {

                    //Recogemos los datos del combo y los pasamos a objetos tipoFiscal  
                    var aux = JSON.parse(data);
                    select = document.getElementById('fiscal');
                    //Carga del combo
                    aux.forEach(function (valor, indice) {
                        //Cada objeto esta en String y lo pasmoa a tipoFiscal
                        var aux2 = JSON.parse(valor);
                        var opt = document.createElement('option');
                        //Guardamos el id en el value de cada opcion
                        opt.value = aux2.id_fiscal;
                        //Guardamos el tipo de identificacion fiscal en el nombre de cada opcion
                        opt.innerHTML = aux2.fiscal;
                        //Añadimos la opcion
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


        function getEmpresa() {
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
                //Recogemos los datos de clientesController/getFiscal.htm 
                url: '/Facturacion/clientesController/getEmpresa.htm',
                success: function (data) {

                    //Recogemos los datos del combo y los pasamos a objetos tipoFiscal  
                    var aux = JSON.parse(data);
                    select = document.getElementById('empresa');
                    //Carga del combo
                    aux.forEach(function (valor, indice) {
                        //Cada objeto esta en String y lo pasmoa a tipoFiscal
                        var aux2 = JSON.parse(valor);
                        var opt = document.createElement('option');
                        //Guardamos el id en el value de cada opcion
                        opt.value = aux2.id_empresa;
                        //Guardamos el tipo de identificacion fiscal en el nombre de cada opcion
                        opt.innerHTML = aux2.empresa;
                        //Añadimos la opcion
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




    </script>
    <body>
        <div class="container">
            <div class="col-xs-12">
                <div class="col-md-5">
                    <div class="form-area">  
                        <form role="form">
                            <br style="clear:both">
                            <h3 style="margin-bottom: 25px; text-align: center;">FORMULARIO PARA CLIENTES</h3>

                            <!--EL ID DE CLIENTE TENEMOS QUE CAMBIARLO Y PONERLO SERIAL EN LA BASE DE DATOS PARA QUE SE AUTOINCREMENTE SOLO -->
                            <div class="form-group">
                                <input type="text" class="form-control" id="id_cliente" name="id_cliente" placeholder="Identificador cliente" required>
                            </div> 

                            <!-- ALMACENAMOS EL NOMBRE DEL CLIENTE -->
                            <div class="form-group">
                                <input type="text" class="form-control" id="nombre_persona" name="nombre_persona" placeholder="Nombre persona" required>
                            </div>

                            <!-- CREAMOS EL DISEÑO DE LAS PESTAÑAS DE CLIENTES -->
                            <div class="form-group">						
                                <ul class="nav nav-tabs" id="myTab" role="tablist">
                                    <li class="nav-item">
                                        <a class="nav-link active" id="home-tab" data-toggle="tab" href="#home" role="tab" aria-controls="home" aria-selected="true">Adress Info</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" id="profile-tab" data-toggle="tab" href="#profile" role="tab" aria-controls="profile" aria-selected="false">Additional Info</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" id="contact-tab" data-toggle="tab" href="#contact" role="tab" aria-controls="contact" aria-selected="false">Payment Info</a>
                                    </li>
                                </ul>
                            </div>  

                            <!-- DENTRO DE CADA PESTAÑA, METEMOS LA INFORMACIÓN DEL CLIENTE PARA CADA UNA DE ELLAS -->                        
                            <div class="tab-content" id="myTabContent">
                                <!--INFORMACION DE LA PESTAÑA 1 -->
                                <div class="tab-pane fade active" id="home" role="tabpanel" aria-labelledby="home-tab">
                                    <div class="form-group">
                                        <input type="text" class="form-control" id="nombre_empresa" name="nombre_empresa" placeholder="Nombre empresa" required>
                                    </div>  

                                    <div id="tratamiento" class="form_radio_button">
                                        <div class="form-check">
                                            <input class="form-check-input inline-block" type="radio" name="tratamiento" id="tratamiento1" value="mr" checked>
                                            <label class="fm-check-label" for="1">Mr</label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" name="tratamiento" id="tratamiento2" value="mrs">
                                            <label class="form-check-label" for="2">Mrs</label>
                                        </div>
                                    </div> 

                                    <div class="form-group">
                                        <input type="text" class="form-control" id="mi_persona" name="mi_persona" placeholder="Inicial" required>
                                    </div>

                                    <div class="form-group">
                                        <input type="text" class="form-control" id="apellido_persona" name="apellido_persona" placeholder="Apellido" required>
                                    </div>

                                    <a href="<c:url value='/MenuController/start.htm'/>" class="btn btn-info" role="button">Menu principal</a>                             
                                    <button type="button" id="submit" name="submit" class="btn btn-primary pull-right">Submit</button>
                                </div>
                                 <!--INFORMACION DE LA PESTAÑA 2 -->
                                 
                                <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab">
                                    
                                    <!--CARGAMOS EL COMBO CON LA INFORMACION DEL TIPO DE IDENTIFICACION FISCAL DE LA EMRPESA -->
                                    <div class="form-group-combo">
                                        <select class="form-control" id="fiscal" name="fiscal">
                                        </select>
                                    <!-- </div>   

                                    <div class="form-group"> -->
                                        <input type="text" class="form-control" id="num_ident" name="num_ident" placeholder="Numero identificador de empresa" required>
                                    </div>

                                    <div class="form-group">
                                        <select class="form-control" id="empresa" name="empresa">
                                        </select>
                                    </div>

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

                                    <div class="form-group">
                                        <input type="text" class="form-control" id="dir_fisica" name="dir_fisica"  placeholder="Dirección física"  required>
                                    </div>

                                    <div class="form-group">
                                        <input type="text" class="form-control" id="dir_fiscal" name="dir_fiscal" placeholder="Dirección fiscal" required>
                                    </div>

                                    <div class="form-group">
                                        <input type="text" class="form-control" id="pais" name="pais" placeholder="País" required>
                                    </div>
                                </div>
                                 <!--INFORMACION DE LA PESTAÑA 3 -->
                                <div class="tab-pane fade" id="contact" role="tabpanel" aria-labelledby="contact-tab">

                                    <div class="form-group">
                                        <input type="email" class="form-control" id="mail" name="mail" placeholder="E-mail" required>
                                    </div>

                                    <div class="form-group">
                                        <input type="text" class="form-control" id="telefono1" name="telefono1" placeholder="Teléfono" required>
                                    </div>

                                    <div class="form-group">
                                        <input type="text" class="form-control" id="telefono2" name="telefono2" placeholder="Teléfono2" required>
                                    </div>
                                    <div class="form-group">
                                        <input type="text" class="form-control" id="fax" name="fax" placeholder="FAX" required>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>                  
    </body>
</html>
