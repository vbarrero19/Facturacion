
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="jstl" uri="http://java.sun.com/jstl/core_rt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
    <%@ include file="infouser.jsp" %>
    <head> 
        <title>CARGOS VIEW</title> 
    </head>
    <script>
        $(document).ready(function () {
            //al cargar la pagina llamamos a la funcion getCliente() para llenar el combo 
            getCliente();

            var userLang = navigator.language || navigator.userLanguage;

            //Para que al cargar la pagina activemos la primera pestaña de id: home-tab
            $("#home-tab").click();

            //*************************************//
            //ejecutarlo dentro del ready porque se ejecuta cada vez que entramos en la pagina.
            //constructor para el calendario. uno por cada calendario.
            $('#fecha_cargo').datetimepicker({
                format: 'YYYY-MM-DD',
                locale: userLang.valueOf(),
                daysOfWeekDisabled: [0, 6],
                useCurrent: false//Important! See issue #1075
                        //defaultDate: '08:32:33',
                        //                });
            });

            $('#fecha_vencimiento').datetimepicker({
                format: 'YYYY-MM-DD',
                locale: userLang.valueOf(),
                daysOfWeekDisabled: [0, 6],
                useCurrent: false//Important! See issue #1075
                        //defaultDate: '08:32:33',
                        //                });
            });

            $("#submit").click(function () {
                if (window.XMLHttpRequest) //mozilla
                {
                    ajax = new XMLHttpRequest(); //No Internet explorer
                } else
                {
                    ajax = new ActiveXObject("Microsoft.XMLHTTP");
                }

                var myObj = {};
                myObj["id_cargo"] = $("#id_cargo").val().trim();
                myObj["id_items"] = $("#id_items").val().trim();
                myObj["id_factura"] = $("#id_factura").val().trim();
                myObj["id_cliente"] = $("#id_cliente").val().trim();
                myObj["cantidad"] = $("#cantidad").val().trim();
                myObj["impuesto"] = $("#impuesto").val().trim();
                myObj["cargo"] = $("#cargo").val().trim();

                //dentro de fecha cargo tenemos que coger el valor que hay dentro de input.
                myObj["fecha_cargo"] = $("#fecha_cargo input").val().trim();
                myObj["fecha_vencimiento"] = $("#fecha_vencimiento input").val().trim();


                var json = JSON.stringify(myObj);
                $.ajax({
                    type: 'POST',
                    url: '/Facturacion/cargosController/newCustomer.htm',
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

           
            $("#comboClientes").change(function () {
                
                //$("#id_cliente1").val("AAA")                
                
                if (window.XMLHttpRequest) //mozilla
                {
                    ajax = new XMLHttpRequest(); //No Internet explorer
                } else
                {
                    ajax = new ActiveXObject("Microsoft.XMLHTTP");
                }

                var myObj = {};
                
                myObj["id_cliente"] = $("#comboClientes").val().trim();

                var json = JSON.stringify(myObj);
                $.ajax({
                    type: 'POST',
                    url: '/Facturacion/cargosController/getDatosCliente.htm',
                    data: json,
                    datatype: "json",
                    contentType: "application/json",
                    success: function (data) {
                        //alert(data);
                        
                        //Recogemos los datos del combo y los pasamos a objetos TipoImpuesto  
                    var aux = JSON.parse(data);
                    
                    aux.forEach(function (valor, indice) {
                        var aux2 = JSON.parse(valor);
                        //$("#id_cliente1").val("AAA");   
                        $("#id_cliente1").val(aux2.id_cliente);
                        $("#dir_fisica").val(aux2.dir_fisica);
                        $("#pais").val(aux2.pais);
                        
                        //Cada objeto esta en String y lo pasmoa a TipoImpuesto
//                        var aux2 = JSON.parse(valor);
//                        //Creamos las opciones del combo
//                        var opt = document.createElement('option');
//                        //Guardamos el id en el value de cada opcion
//                        opt.value = aux2.id_cliente;
//                        //Guardamos el impuesto en el nombre de cada opcion
//                        //                 opt.innerHTML = aux2.id_impuesto;
//                        opt.innerHTML = aux2.nombre_empresa;
//                        //Añadimos la opcion
//                        select.appendChild(opt);
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





        //Funcion para llenar el combo de cliente. Los datos nos vienen en un ArrayList de objetos TipoImpuesto transformado en String
        //con json. Los datos se obtienen en itemsController/getImpuesto.htm.
        function getCliente() {
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
                url: '/Facturacion/cargosController/getCliente.htm', //Vamos a cargosController/getImpuesto.htm a recoger los datos
                success: function (data) {

                    //Recogemos los datos del combo y los pasamos a objetos TipoImpuesto  
                    var aux = JSON.parse(data);
                    //Identificamos el combo
                    select = document.getElementById('comboClientes');
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
                        opt.value = aux2.id_cliente;
                        //Guardamos el impuesto en el nombre de cada opcion
                        //                 opt.innerHTML = aux2.id_impuesto;
                        opt.innerHTML = aux2.nombre_empresa;
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

                            <!-- CREAMOS EL DISEÑO DE LAS PESTAÑAS DE CARGOS -->
                            <div class="form-group">						
                                <ul class="nav nav-tabs" id="myTab" role="tablist">
                                    <li class="nav-item">
                                        <a class="nav-link active" id="home-tab" data-toggle="tab" href="#home" role="tab" aria-controls="home" aria-selected="true">Cargos</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" id="profile-tab" data-toggle="tab" href="#profile" role="tab" aria-controls="profile" aria-selected="false">Pestaña2</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" id="contact-tab" data-toggle="tab" href="#contact" role="tab" aria-controls="contact" aria-selected="false">Pestaña3 </a>
                                    </li>
                                </ul>
                            </div> 


                            <!-- DENTRO DE CADA PESTAÑA, METEMOS LA INFORMACIÓN DEL CARGO PARA CADA UNA DE ELLAS -->                        
                            <div class="tab-content" id="myTabContent">
                                <!--INFORMACION DE LA PESTAÑA 1 -->
                                <div class="tab-pane fade active" id="home" role="tabpanel" aria-labelledby="home-tab">

                                    <!--Combo para clientes-->
                                    <label for="comboClientes">Nombre de cliente:</label>
                                    <div class="form-group-combo">                                        
                                        <select class="form-control" id="comboClientes" name="comboClientes">
                                        </select>                                                            
                                    </div>

                                    <div class="form-group">
                                        <input type="text" class="form-control" id="id_cliente1" name="id_cliente" placeholder="Identificador cliente" required>
                                    </div>
                                    <div class="form-group">
                                        <input type="text" class="form-control" id="dir_fisica" name="dir_fisica" placeholder="direccion fisica" required>
                                    </div>
                                    <div class="form-group">
                                        <input type="text" class="form-control" id="pais" name="pais" placeholder="Pais" required>
                                    </div>

                                    <div class="form-group">
                                        <input type="text" class="form-control" id="id_cargo" name="id_cargo" placeholder="Identificador cargo" required>
                                    </div>                            
                                    <div class="form-group">
                                        <input type="text" class="form-control" id="id_items" name="id_items" placeholder="Identificador items" required>
                                    </div>
                                    <div class="form-group">
                                        <input type="text" class="form-control" id="id_factura" name="id_factura" placeholder="Identificador factura" required>
                                    </div>

                                    <div class="form-group">
                                        <input type="text" class="form-control" id="cantidad" name="cantidad" placeholder="Cantidad" required>
                                    </div>
                                    <div class="form-group">
                                        <input type="text" class="form-control" id="impuesto" name="impuesto" placeholder="Impuesto" required>
                                    </div>
                                    <div class="form-group">
                                        <textarea class="form-control" type="textarea" id="cargo" name="cargo" placeholder="Cargo" maxlength="140" rows="7"></textarea>
                                        <!--  <span class="help-block"><p id="characterLeft" class="help-block ">You have reached the limit</p></span>                    -->
                                    </div>

                                    <!--ALMACENAMOS LAS FECHAS DE LOS CARGOS -->  
                                    <label class="fechaGeneral">FECHAS DE LOS CARGOS</label>
                                    <!--DENTRO DEL CONTAINER METEMOS LOS DOS DESPLEGABLES DE LAS FECHAS -->
                                    <div class="container2">                                   
                                        <div class="row">
                                            <div class='col-xs-12 col-md-4'>
                                                <label class="fechaCargos"> PAGO </label>
                                                <div class="form-group">
                                                    <div class='input-group date' id='fecha_cargo'>
                                                        <input  data-format="yyyy-MM-dd hh:mm:ss" type='text' class="form-control" />
                                                        <span class="input-group-addon">
                                                            <span class="glyphicon glyphicon-calendar"></span>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                            <script type="text/javascript">
                                                $(function () {
                                                    $('#fecha_cargo').datetimepicker();
                                                });
                                            </script>
                                        </div>
                                        <!--</div>                                     
                                                
                                                <div class="container">   -->
                                        <div class="row">
                                            <div class='col-xs-12 col-md-4'>
                                                <label class="fechaCargos"> VENCIMIENTO </label>
                                                <div class="form-group">
                                                    <div class='input-group date' id='fecha_vencimiento'>
                                                        <input type='text' class="form-control" />
                                                        <span class="input-group-addon">
                                                            <span class="glyphicon glyphicon-calendar"></span>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                            <script type="text/javascript">
                                                $(function () {
                                                    $('#fecha_vencimiento').datetimepicker();
                                                });
                                            </script>
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
