<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="jstl" uri="http://java.sun.com/jstl/core_rt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
    <%@ include file="infouser.jsp" %> 
    <head> 
        <title>ITEMS VIEW</title>  
    </head>
    <script>
        $(document).ready(function () {
            //al cargar la pagina llamamos a la funcion getImpuesto() para llenar el combo 
            getImpuesto();
            
            $("#home-tab").click();

            //Evento .click en el boton submit
            $("#submit").click(function () {
                if (window.XMLHttpRequest) //mozilla
                {
                    ajax = new XMLHttpRequest(); //No Internet explorer
                } else
                {
                    ajax = new ActiveXObject("Microsoft.XMLHTTP");
                }

                //Variable para guardar los valores del formulario
                var myObj = {};

                //Cargamos el contenido de los campos del formulario
                myObj["id_item"] = $("#id_item").val().trim();
                myObj["abreviatura"] = $("#abreviatura").val().trim();
                myObj["nombre"] = $("#nombre").val().trim();
                myObj["precio"] = $("#precio").val().trim();
                //Cogemos el valor del Combo y lo guardamos en id_impuesto.
                myObj["id_impuesto"] = $("#impuesto").val();
                //Cogemos el valor del radio seleccionado y lo guardamos en periodo
                myObj["periodo"] = $(".form-check input:checked").val();

                //Convertimos la variable myObj a String
                var json = JSON.stringify(myObj);

                $.ajax({
                    type: 'POST',
                    url: '/Facturacion/itemsController/newItems.htm', //Vamos a newCustomer de itemsController
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

        //Funcion para llenar el combo de impuestos. Los datos nos vienen en un ArrayList de objetos TipoImpuesto transformado en String
        //con json. Los datos se obtienen en itemsController/getImpuesto.htm.
        function getImpuesto() {
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
                url: '/Facturacion/itemsController/getImpuesto.htm', //Vamos a itemsController/getImpuesto.htm a recoger los datos
                success: function (data) {

                    //Recogemos los datos del combo y los pasamos a objetos TipoImpuesto  
                    var aux = JSON.parse(data);
                    //Identificamos el combo
                    select = document.getElementById('impuesto');
                    //Lo vamos cargando
                    aux.forEach(function (valor, indice) {
                        //Cada objeto esta en String y lo pasmoa a TipoImpuesto
                        var aux2 = JSON.parse(valor);
                        //Creamos las opciones del combo
                        var opt = document.createElement('option');
                        //Guardamos el id en el value de cada opcion
                        opt.value = aux2.id_Impuesto;
                        //Guardamos el impuesto en el nombre de cada opcion
                        //                 opt.innerHTML = aux2.id_impuesto;
                        opt.innerHTML = aux2.impuesto;
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
                            <h3 style="margin-bottom: 25px; text-align: center;">Formulario para ITEMS</h3>
                            <!--CARGAMOS LAS PESTAÑAS DE LA PARTE DE ARRIBA -->
                            <div class="form-group">						
                                <ul class="nav nav-tabs" id="myTab" role="tablist">
                                    <li class="nav-item">
                                        <a class="nav-link active" id="home-tab" data-toggle="tab" href="#home" role="tab" aria-controls="home" aria-selected="true">Items</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" id="profile-tab" data-toggle="tab" href="#profile" role="tab" aria-controls="profile" aria-selected="false">Pestaña2</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" id="contact-tab" data-toggle="tab" href="#contact" role="tab" aria-controls="contact" aria-selected="false">Pestaña3 </a>
                                    </li>
                                </ul>
                            </div>

                            <!-- DENTRO DE CADA PESTAÑA, METEMOS LA INFORMACIÓN DEL CLIENTE PARA CADA UNA DE ELLAS -->                        
                            <div class="tab-content" id="myTabContent">
                                <!--INFORMACION DE LA PESTAÑA 1 -->
                                <div class="tab-pane fade active" id="home" role="tabpanel" aria-labelledby="home-tab">
                                    <div class="form-group">
                                        <input type="text" class="form-control" id="id_item" name="id_item" placeholder="Identificador" required>
                                    </div>                            
                                    <div class="form-group">
                                        <input type="text" class="form-control" id="abreviatura" name="abreviatura" placeholder="Abreviatura" required>
                                    </div>
                                    <div class="form-group">
                                        <input type="text" class="form-control" id="nombre" name="nombre" placeholder="Nombre" required>
                                    </div>

                                    <div class="form-group-combo">
                                        <!--Combo para tipo de impuestos-->
                                        <select class="form-control" id="impuesto" name="impuesto">
                                        </select>
                                        <input type="text" class="form-control" id="precio" name="precio" placeholder="Precio" required>                               
                                    </div>

                                    <!--Radio button para tipo de periodicidad--> 
                                    <div class="form_radio_button">
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" name="exampleRadios" id="exampleRadios1" value="periodico" checked>
                                            <label class="form-check-label" for="1">Periodico</label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" name="exampleRadios" id="exampleRadios2" value="puntual">
                                            <label class="form-check-label" for="2">Puntual</label>
                                        </div>
                                    </div>
                                    <a href="<c:url value='/MenuController/start.htm'/>" class="btn btn-info" role="button">Menu principal</a>                             
                                    <button type="button" id="submit" name="submit" class="btn btn-primary pull-right">Submit</button>
                                </div>
                                <!--INFORMACION DE LA PESTAÑA 2 -->
                                <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab">                                 
                                    <!--AQUI METEMOS LA INFORMACION DE LA PESTAÑA 2 -->
                                    <label>INFORMACION DE LA PESTAÑA 2 </label>
                                </div>

                                <!--INFORMACION DE LA PESTAÑA 3 -->
                                <div class="tab-pane fade" id="contact" role="tabpanel" aria-labelledby="contact-tab">
                                    <!-- AQUI METEMOS LA INFORMACION DE LA PESTAÑA 3 -->
                                    <label>INFORMACION DE LA PESTAÑA 3</label>
                                </div>                               
                            </div> 
                        </form>
                    </div>
                </div>
            </div>
        </div>                  
    </body>
</html>
