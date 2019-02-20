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
            getTipoItem();

            //Mostramos la fecha actual
            var f = new Date();
            $("#fecha").text((f.getDate() + "/" + (f.getMonth() + 1) + "/" + f.getFullYear()));
            
            var meses = new Array("Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre");

            //Ocultamos los meses de la periodicidad
            $('#meses').hide(); 

            $("#exampleRadios2").on("click", function () {
                $('#meses').show(); //muestro mediante id
                //$('.target').show(); //muestro mediante clase
            });
            $("#exampleRadios1").on("click", function () {
                $('#meses').hide(); //oculto mediante id
                //$('.target').hide(); //muestro mediante clase
            });


            //tratando de omstrar fechas dinamicamente            
            var mes = f.getMonth();
            var nombreMes = meses[f.getMonth()];
            alert(nombreMes);
            //cargamos de forma dinamica la tabla
            for (var i = mes; i < 12; i++) {
                $('#tbody-tabla-meses').append(" <tr>\n\
                                                                    <td id='id" + (i + 1) + "'> <input type='checkbox' name='chkHos' value ='mes' > </td>              \n\
                                                                    <td>" + meses[i] + "</td>          \n\ \n\
                                                                </tr>");
            }

            //Evento .click en el boton submit
            $("#guardarItem").click(function () {
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
                myObj["abreviatura"] = $("#abreviatura").val().trim();
                myObj["descripcion"] = $("#descripcion").val().trim();

                //Cogemos el valor del Combo y lo guardamos en id_impuesto.
                myObj["id_tipo_item"] = $("#id_tipo_item").val();
                myObj["cuenta"] = $("#cuenta").val().trim();
                myObj["importe"] = $("#importe").val().trim();

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
        function getTipoItem() {
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
                url: '/Facturacion/itemsController/getTipoItem.htm', //Vamos a itemsController/getTipoItem.htm a recoger los datos
                success: function (data) {

                    //Recogemos los datos del combo y pasamos el String a un Array de objetos tipoItem
                    //Estos objetos estan en formato String
                    var tipoItem = JSON.parse(data);
                    //Identificamos el combo por el ID
                    select = document.getElementById('id_tipo_item');
                    //Lo vamos cargando
                    tipoItem.forEach(function (valor, indice) {
                        //Cada objeto esta en String y lo pasmoa a TipoItem
                        var tipoItem2 = JSON.parse(valor);
                        //Creamos las opciones del combo
                        var opt = document.createElement('option');
                        //Guardamos el id en el value de cada opcion
                        opt.value = tipoItem2.id_tipo_item;
                        //Guardamos la descripcion de item en el nombre de cada opcion                        //                 
                        opt.innerHTML = tipoItem2.item;
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
                <div class="col-md-8">
                    <div class="form-area">  
                        <form role="form">

                            <br style="clear:both">
                            <h3 style="margin-bottom: 25px; text-align: center;">Formulario para ITEMS</h3>

                            <div class="col-md-7"> 

                                <div class="form-group">
                                    <label for="abreviatura">Abreviatura:</label>
                                    <input type="text" class="form-control" id="abreviatura" name="abreviatura" required>
                                </div>                            
                                <div class="form-group">
                                    <label for="descripcion:">Descripcion:</label>
                                    <input type="text" class="form-control" id="descripcion" name="descripcion" required>
                                </div>                                    

                                <div class="form-group-combo">
                                    <label for="tipo_item">Tipo de Item:</label>                                        
                                    <!--Combo para tipos de items-->
                                    <select class="form-control" id="id_tipo_item" name="id_tipo_item">
                                    </select>                                                                    
                                </div>

                                <div class="form-group">
                                    <label for="cuenta">Cuenta:</label>
                                    <input type="text" class="form-control" id="cuenta" name="cuenta" required>
                                </div>

                                <div class="form-group">
                                    <label for="importe">Importe:</label>
                                    <input type="text" class="form-control" id="importe" name="importe" required>
                                </div>

                                <!--Radio button para tipo de periodicidad-->                                     
                                <div class="form_radio_button">

                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="exampleRadios" id="exampleRadios1" value="puntual" checked>
                                        <label class="form-check-label" for="2">Puntual</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="exampleRadios" id="exampleRadios2" value="periodico">
                                        <label class="form-check-label" for="1">Periódico</label>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-5"> 
                                <div id="meses">
                                    <div class="form-group">
                                        <label for="fecha">Incluir periodicidad: </label>
                                        <label id="fecha" name="fecha"></label>
                                    </div>
                                    <div class="form-group">
                                        <table class="table table-striped">                                    

                                            <thead class="thead-dark">                                            
                                                <tr>
                                                    <th scope="col">#</th>
                                                    <th scope="col">Mes</th>

                                                </tr>                                            
                                            </thead>

                                            <tbody id="tbody-tabla-meses">

                                            </tbody>
                                        </table>
                                    </div>
                                </div>


                            </div>

                            <br style="clear:both">
                            <a href="<c:url value='/MenuController/start.htm'/>" class="btn btn-info" role="button">Menu principal</a>                             
                            <button type="button" id="guardarItem" name="guardarItem" class="btn btn-primary pull-right">Guardar</button>

                        </form>
                    </div>
                </div>
            </div>
        </div>                  
    </body>
</html>
