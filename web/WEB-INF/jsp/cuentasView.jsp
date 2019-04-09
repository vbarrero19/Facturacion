<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="jstl" uri="http://java.sun.com/jstl/core_rt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
    <%@ include file="infouser.jsp" %> 
    <head> 
        <title>Cuentas VIEW</title>       </head>
    <style>
        .container{
            width: 1600px;
        }

        #tableContainer11,#tableContainer33{
            overflow:scroll;
            overflow-x: hidden;
            height:500px;    
            margin-bottom: 25px;
        }

        .azul{
            background-color: lightblue;
            margin-bottom: 25px;
        } 

    </style>
    <script>
        $(document).ready(function () {

            var numeroColumnas = 0;

            //Al cargar la pagina llamamos a la funcion getCuentas(), getEmpresas para llenar las tablas
            getCuentas();
            getEmpresas();
            //Cargamos los detalles de las cuentas de una empresa al inicio
            getCartaSinValor();

            $(".miBotonAnadirCuentaEmpresa").click(function () {

                var idEmpresa = $('#idEmpresaAnadirCuentaHidden').val();
                //alert(idEmpresa);

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
                    url: '/Facturacion/cuentasController/getCargarCuentaEmpresa.htm?empresa=' + idEmpresa,
                    success: function (data) {

                        $('#anadirCuentaEmpresaCombo').empty();

                        //Recogemos los datos del combo y los pasamos a objetos TipoImpuesto  
                        var aux = JSON.parse(data);
                        //Identificamos el combo
                        select = document.getElementById('anadirCuentaEmpresaCombo');
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
                            opt.value = aux2.id_entidad;
                            //Guardamos el impuesto en el nombre de cada opcion
                            opt.innerHTML = aux2.distinct_code;
                            //opt.data(nombre, aux2.distinct_code);
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

                /*Una vez guardados los datos en los campos ocultos, mostramos el modal con los datos*/
                $("#myModalAnadirCuentaEmpresa").modal();

            });

        });


        function getCuentas() {
            if (window.XMLHttpRequest) //mozilla
            {
                ajax = new XMLHttpRequest(); //No Internet explorer
            } else
            {
                ajax = new ActiveXObject("Microsoft.XMLHTTP");
            }


            $.ajax({
                type: 'POST',
                url: '/Facturacion/cuentasController/getCuenta.htm',
                success: function (data) {

                    var aux = JSON.parse(data);
                    $('#tableContainer1 tbody').empty();

                    //Vamos cargando la tabla
                    aux.forEach(function (valor, indice) {
                        //var id = cargo.id_cargo;
                        //Cada objeto esta en String 
                        var cuenta = JSON.parse(valor);

                        $('#tableContainer1 tbody').append(" <tr>\n\
                            <td id='id" + (indice + 1) + "'>" + (indice + 1) + "</td>     \n\
                            <td id='id" + indice + "'>" + cuenta.id_cuenta + "</td>         \n\
                            <td>" + cuenta.cuenta + "</td>         \n\
                            <td class='hidden' id='descrip" + (indice + 1) + "'>" + cuenta.cuenta + "</td>         \n\
                            <td>" + cuenta.estado + "</td>         \n\
                            <td><button type='button' class='btn miBotonModificarCuenta btn-warning btn-sm'  data-idCuenta='" + cuenta.id_cuenta +
                                "' data-cuenta='" + cuenta.cuenta + "' data-idIndice='" + indice + "'><span class='glyphicon glyphicon-edit'></span>&nbsp;&nbsp;Modificar&nbsp;</button></td>\n\
                            <td><button type='button' class='btn miBotonEliminarCuenta btn-danger btn-sm'  data-idCuenta='" + cuenta.id_cuenta +
                                "' data-cuenta='" + cuenta.cuenta + "' data-idIndice='" + indice + "'><span class='glyphicon glyphicon-remove'></span>&nbsp;&nbsp; Archivar </button></td>\n\
                        </tr>");
                    });

                    /*Creamos las funciones que al hacer click en los botones de la tabla nos muestren los modales, identificamos el boton con el nombre miBoton...*/
                    $(document).ready(function () {

                        $(".miBotonActivarCuenta").click(function () {

                            /*Guardamos los valores que recogemos de los parametros declarados en el boton(arriba) y lo recogemos con .val($this...) 
                             * en los campos ocultos que nos hemos declarado en el html para que al pinchar en el boton no se pierdan los datos.*/
                            $("#idActivarCuentaHide").val($(this).attr("data-idCuenta"));

                            //$("#denominacionActivarCuenta").val($("#idModifCuentaTipoHide").val());

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
                                url: '/Facturacion/cuentasController/getCuentasDesactivadas.htm',
                                success: function (data) {

                                    $('#activarCuentaCombo').empty();

                                    //Recogemos los datos del combo y los pasamos a objetos TipoImpuesto  
                                    var aux = JSON.parse(data);
                                    //Identificamos el combo
                                    select = document.getElementById('activarCuentaCombo');
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
                                        opt.value = aux2.id_cuenta;
                                        //Guardamos el impuesto en el nombre de cada opcion
                                        //                 opt.innerHTML = aux2.id_impuesto;
                                        opt.innerHTML = aux2.cuenta;
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

                            /*Una vez guardados los datos en los campos ocultos, mostramos el modal con los datos*/
                            $("#myModalActivarCuenta").modal();
                        })
                                ;

                        $(".miBotonModificarCuenta").click(function () {

                            /*Guardamos los valores que recogemos de los parametros declarados en el boton(arriba) y lo recogemos con .val($this...) 
                             * en los campos ocultos que nos hemos declarado en el html para que al pinchar en el boton no se pierdan los datos.*/
                            $("#idModifCuentaHide").val($(this).attr("data-idCuenta"));
                            $("#idModifCuentaTipoHide").val($(this).attr("data-cuenta"));
                            $("#idModifCuentaFilaHide").val($(this).attr("data-idIndice"));

                            $("#denominacionModificar").val($("#idModifCuentaTipoHide").val());

                            /*Una vez guardados los datos en los campos ocultos, mostramos el modal con los datos*/
                            $("#myModalModificarCuenta").modal();
                        })
                                ;

                        $(".miBotonAnadirCuenta").click(function () {

                            /*Guardamos los valores que recogemos de los parametros declarados en el boton(arriba) y lo recogemos con .val($this...) 
                             * en los campos ocultos que nos hemos declarado en el html para que al pinchar en el boton no se pierdan los datos.*/
                            $("#idAnadirCuentaHide").val($(this).attr("data-idCuenta"));

                            /*Una vez guardados los datos en los campos ocultos, mostramos el modal con los datos*/
                            $("#myModalAnadirCuenta").modal();

                        })
                                ;

                        $(".miBotonEliminarCuenta").click(function () {

                            /*Guardamos los valores que recogemos de los parametros declarados en el boton(arriba) y lo recogemos con .val($this...) 
                             * en los campos ocultos que nos hemos declarado en el html para que al pinchar en el boton no se pierdan los datos.*/
                            $("#idElimCuentaHide").val($(this).attr("data-idCuenta"));
                            $("#idElimCuentaTipoHide").val($(this).attr("data-cuenta"));
                            $("#idElimCuentaFilaHide").val($(this).attr("data-idIndice"));

                            $("#eliminarCuenta").text("Desea eliminar la cuenta: " + $("#idElimCuentaTipoHide").val());

                            /*Una vez guardados los datos en los campos ocultos, mostramos el modal con los datos*/
                            $("#myModalEliminarCuenta").modal();
                        })
                                ;

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

        function getEmpresas() {

            if (window.XMLHttpRequest) //mozilla
            {
                ajax = new XMLHttpRequest(); //No Internet explorer
            } else
            {
                ajax = new ActiveXObject("Microsoft.XMLHTTP");
            }

            $.ajax({
                type: 'POST',
                url: '/Facturacion/cuentasController/getEmpresa.htm',
                success: function (data) {

                    var aux = JSON.parse(data);
                    $('#tableContainer2 tbody').empty();

                    //Vamos cargando la tabla
                    aux.forEach(function (valor, indice) {

                        //Cada objeto esta en String 
                        var cuenta = JSON.parse(valor);



                        $('#tableContainer2 tbody').append(" <tr>\n\
                            <td id='id" + (indice + 1) + "'>" + (indice + 1) + "</td>     \n\
                            <td id='id" + indice + "'>" + cuenta.id_cuenta + "</td>         \n\
                            <td>" + cuenta.nombre + "</td>         \n\
                            <td class='hidden' id='descrip" + (indice + 1) + "'>" + cuenta.nombre + "</td>         \n\
                            <td>" + cuenta.estado + "</td>         \n\\n\
                            <td><button type='button' class='btn btn-info miBotonDetallesEmpresa btn-warning btn-sm'  data-idCuenta='" + cuenta.id_cuenta +
                                "' data-cuenta='" + cuenta.nombre + "' data-idIndice='" + indice + "'><span class='glyphicon glyphicon-eye-open'></span>&nbsp;&nbsp; &nbsp;Detalles&nbsp;</button></td>\n\
                            <td><button type='button' class='btn btn-info miBotonEliminarEmpresa btn-danger btn-sm'  data-idCuenta='" + cuenta.id_cuenta +
                                "' data-cuenta='" + cuenta.nombre + "' data-idIndice='" + indice + "'><span class='glyphicon glyphicon-remove'></span>&nbsp;&nbsp; Archivar </button></td>\n\
                        </tr>");
                    });



                    /*Creamos las funciones que al hacer click en los botones de la tabla nos muestren los modales, identificamos el boton con el nombre miBoton...*/
                    $(document).ready(function () {

                        $(".miBotonActivarEmpresa").click(function () {

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
                                url: '/Facturacion/cuentasController/getEmpresasDesactivadas.htm',
                                success: function (data) {

                                    $('#activarEmpresaCombo').empty();

                                    //Recogemos los datos del combo y los pasamos a objetos TipoImpuesto  
                                    var aux = JSON.parse(data);
                                    //Identificamos el combo
                                    select = document.getElementById('activarEmpresaCombo');
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
                                        opt.value = aux2.id_cuenta;
                                        //Guardamos el impuesto en el nombre de cada opcion
                                        //                 opt.innerHTML = aux2.id_impuesto;
                                        opt.innerHTML = aux2.cuenta;
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

                            /*Una vez guardados los datos en los campos ocultos, mostramos el modal con los datos*/
                            $("#myModalActivarEmpresa").modal();
                        })
                                ;

                        $(".miBotonDetallesEmpresa").click(function () {

                            var idEmpresa = $(this).attr("data-idCuenta");
                            //alert(idEmpresa);
                            getCarta(idEmpresa);

                        })
                                ;

                        $(".miBotonAnadirEmpresa").click(function () {

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
                                url: '/Facturacion/cuentasController/getEmpresasDisponibles.htm',
                                success: function (data) {


                                    $('#anadirEmpresaCombo').empty();

                                    //Recogemos los datos del combo y los pasamos a objetos TipoImpuesto  
                                    var aux = JSON.parse(data);
                                    //Identificamos el combo
                                    select = document.getElementById('anadirEmpresaCombo');
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
                                        opt.value = aux2.id_entidad;
                                        //Guardamos el impuesto en el nombre de cada opcion
                                        opt.innerHTML = aux2.distinct_code;
                                        //opt.data(nombre, aux2.distinct_code);
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

                            /*Una vez guardados los datos en los campos ocultos, mostramos el modal con los datos*/
                            $("#myModalAnadirEmpresa").modal();

                        })
                                ;

                        $(".miBotonEliminarEmpresa").click(function () {

                            /*Guardamos los valores que recogemos de los parametros declarados en el boton(arriba) y lo recogemos con .val($this...) 
                             * en los campos ocultos que nos hemos declarado en el html para que al pinchar en el boton no se pierdan los datos.*/
                            $("#idElimEmpresaHide").val($(this).attr("data-idCuenta"));
                            $("#idElimEmpresaTipoHide").val($(this).attr("data-cuenta"));
                            $("#idElimEmpresaFilaHide").val($(this).attr("data-idIndice"));

                            $("#eliminarEmpresa").text("Desea archivar la empresa " + $("#idElimEmpresaTipoHide").val());

                            /*Una vez guardados los datos en los campos ocultos, mostramos el modal con los datos*/
                            $("#myModalEliminarEmpresa").modal();
                        })
                                ;

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

        //Al pulsar en detalle empresa mostramos las cuentas de una empresa
        function getCarta(idEmpresa) {

            //Guardamos en un campo oculto el id de la empresa que se muestra en pantalla
            //alert("getCarta" + idEmpresa);
            $('#idEmpresaAnadirCuentaHidden').val(idEmpresa);

            if (window.XMLHttpRequest) //mozilla
            {
                ajax = new XMLHttpRequest(); //No Internet explorer
            } else
            {
                ajax = new ActiveXObject("Microsoft.XMLHTTP");
            }

            $.ajax({
                type: 'GET',
                url: '/Facturacion/cuentasController/getDatosCarta.htm?empresa=' + idEmpresa,
                success: function (data) {

                    var aux = JSON.parse(data);
                    $('#tableContainer3 tbody').empty();

                    //Vamos cargando la tabla
                    aux.forEach(function (valor, indice) {
                        //var id = cargo.id_cargo;
                        //Cada objeto esta en String 
                        var cuenta = JSON.parse(valor);



                        //Guardamos en un campo oculto el id de la empresa que se muestra en pantalla
/////////                        $('#idEmpresaAnadirCuentaHidden').val(cuenta.col3);




                        $('#tableContainer3 tbody').append(" <tr>\n\
                            <td id='id" + (indice + 1) + "'>" + (indice + 1) + "</td>     \n\
                            <td id='id" + indice + "'>" + cuenta.col1 + "</td>         \n\
                            <td>" + cuenta.col2 + "</td>         \n\
                            <td class='hidden' id='descrip" + (indice + 1) + "'>" + cuenta.col3 + "</td>         \n\
                            <td>" + cuenta.col5 + "</td>         \n\\n\
                            <td><button type='button' class='btn miBotonModificarDetalle btn-warning btn-sm'  data-idCuenta='" + cuenta.col1 + "' data-cuenta='" + cuenta.col2 +
                                "' data-idEmpresa='" + cuenta.col3 + "' data-denominacion='" + cuenta.col5 + "'><span class='glyphicon glyphicon-edit'></span>&nbsp;&nbsp;Modificar&nbsp;</button></td>\n\
                        </tr>");
                        //Mostramos en el thead el nombre de la empresa
                        $('#nomEmp').text(cuenta.col4);
                    });

                    $(document).ready(function () {

                        $(".miBotonModificarDetalle").click(function () {

                            /*Guardamos los valores que recogemos de los parametros declarados en el boton(arriba) y lo recogemos con .val($this...) 
                             * en los campos ocultos que nos hemos declarado en el html para que al pinchar en el boton no se pierdan los datos.*/
                            $("#idModifDetalleIdCuentaHide").val($(this).attr("data-idCuenta"));
                            $("#idModifDetalleCuentaHide").val($(this).attr("data-cuenta"));
                            $("#idModifDetalleIdEmpresaHide").val($(this).attr("data-idEmpresa"));
                            $("#idModifDetalleDenominacionHide").val($(this).attr("data-denominacion"));

                            $("#denominacionCuenta").text($("#idModifDetalleCuentaHide").val().trim());
                            $("#denominacionDetalle").val($("#idModifDetalleDenominacionHide").val().trim());

                            /*Una vez guardados los datos en los campos ocultos, mostramos el modal con los datos*/
                            $("#myModalModificarDetalle").modal();
                        });



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

        //Funcion para cargar una empresa al inicio. Carga la empresa con menor id.
        function getCartaSinValor() {

            if (window.XMLHttpRequest) //mozilla
            {
                ajax = new XMLHttpRequest(); //No Internet explorer
            } else
            {
                ajax = new ActiveXObject("Microsoft.XMLHTTP");
            }

            $.ajax({
                type: 'GET',
                url: '/Facturacion/cuentasController/getCartaSinValor.htm',
                success: function (data) {

                    var aux = JSON.parse(data);
                    $('#tableContainer3 tbody').empty();

                    //Vamos cargando la tabla
                    aux.forEach(function (valor, indice) {
                        //var id = cargo.id_cargo;
                        //Cada objeto esta en String 
                        var cuenta = JSON.parse(valor);

                        //Guardamos en un campo oculto el id de la empresa que se muestra en pantalla
                        $('#idEmpresaAnadirCuentaHidden').val(cuenta.col3);

                        $('#tableContainer3 tbody').append(" <tr>\n\
                            <td id='id" + (indice + 1) + "'>" + (indice + 1) + "</td>     \n\
                            <td id='id" + indice + "'>" + cuenta.col1 + "</td>         \n\
                            <td>" + cuenta.col2 + "</td>         \n\
                            <td class='hidden' id='descrip" + (indice + 1) + "'>" + cuenta.col3 + "</td>         \n\
                            <td>" + cuenta.col5 + "</td>         \n\\n\
                            <td><button type='button' class='btn miBotonModificarDetalle btn-warning btn-sm'  data-idCuenta='" + cuenta.col1 + "' data-cuenta='" + cuenta.col2 +
                                "' data-idEmpresa='" + cuenta.col3 + "' data-denominacion='" + cuenta.col5 + "'><span class='glyphicon glyphicon-edit'></span>&nbsp;&nbsp;Modificar&nbsp;</button></td>\n\
                        </tr>");
                        //Mostramos en el thead el nombre de la empresa
                        $('#nomEmp').text(cuenta.col4);
                    });



                    $(document).ready(function () {

                        $(".miBotonModificarDetalle").click(function () {

                            /*Guardamos los valores que recogemos de los parametros declarados en el boton(arriba) y lo recogemos con .val($this...) 
                             * en los campos ocultos que nos hemos declarado en el html para que al pinchar en el boton no se pierdan los datos.*/
                            $("#idModifDetalleIdCuentaHide").val($(this).attr("data-idCuenta"));
                            $("#idModifDetalleCuentaHide").val($(this).attr("data-cuenta"));
                            $("#idModifDetalleIdEmpresaHide").val($(this).attr("data-idEmpresa"));
                            $("#idModifDetalleDenominacionHide").val($(this).attr("data-denominacion"));

                            $("#denominacionCuenta").text($("#idModifDetalleCuentaHide").val().trim());
                            $("#denominacionDetalle").val($("#idModifDetalleDenominacionHide").val().trim());

                            /*Una vez guardados los datos en los campos ocultos, mostramos el modal con los datos*/
                            $("#myModalModificarDetalle").modal();
                        });

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

        function archivarCuenta() {
            if (window.XMLHttpRequest) //mozilla
            {
                ajax = new XMLHttpRequest(); //No Internet explorer
            } else
            {
                ajax = new ActiveXObject("Microsoft.XMLHTTP");
            }

            var myObj = {};

            myObj["col1"] = $("#idElimCuentaHide").val().trim();

            var json = JSON.stringify(myObj);
            $.ajax({
                //Usamos GET ya que recibimos.
                type: 'POST',
                url: '/Facturacion/CuentasController/archivarCuenta.htm',
                data: json,
                datatype: "json",
                contentType: "application/json",
                success: function (data) {

                    getCuentas();
                    var idEmpresaNew = $("#idEmpresaAnadirCuentaHidden").val();
                    getCarta(idEmpresaNew);

                },
                error: function (xhr, ajaxOptions, thrownError) {
                    console.log(xhr.status);
                    console.log(xhr.responseText);
                    console.log(thrownError);
                }
            });
        }
        ;

        function anadirCuenta() {
            if (window.XMLHttpRequest) //mozilla
            {
                ajax = new XMLHttpRequest(); //No Internet explorer
            } else
            {
                ajax = new ActiveXObject("Microsoft.XMLHTTP");
            }

            var myObj = {};

            myObj["col1"] = $("#denominacionAnadir").val().trim();

            var json = JSON.stringify(myObj);
            $.ajax({
                //Usamos GET ya que recibimos.
                type: 'POST',
                url: '/Facturacion/CuentasController/anadirCuenta.htm',
                data: json,
                datatype: "json",
                contentType: "application/json",
                success: function (data) {
                    getCuentas();

                },
                error: function (xhr, ajaxOptions, thrownError) {
                    console.log(xhr.status);
                    console.log(xhr.responseText);
                    console.log(thrownError);
                }
            });
        }
        ;

        function modificarCuenta() {
            if (window.XMLHttpRequest) //mozilla
            {
                ajax = new XMLHttpRequest(); //No Internet explorer
            } else
            {
                ajax = new ActiveXObject("Microsoft.XMLHTTP");
            }

            var myObj = {};

            myObj["col1"] = $("#denominacionModificar").val().trim();
            myObj["col2"] = $("#idModifCuentaHide").val().trim();

            var json = JSON.stringify(myObj);
            $.ajax({
                //Usamos GET ya que recibimos.
                type: 'POST',
                url: '/Facturacion/CuentasController/modificarCuenta.htm',
                data: json,
                datatype: "json",
                contentType: "application/json",
                success: function (data) {
                    //alert($("#nomEmp").text());
                    getCuentas();

                    var idEmpresaNew = $("#idEmpresaAnadirCuentaHidden").val();
                    getCarta(idEmpresaNew);

                },
                error: function (xhr, ajaxOptions, thrownError) {
                    console.log(xhr.status);
                    console.log(xhr.responseText);
                    console.log(thrownError);
                }
            });
        }
        ;

        function activarCuenta() {
            if (window.XMLHttpRequest) //mozilla
            {
                ajax = new XMLHttpRequest(); //No Internet explorer
            } else
            {
                ajax = new ActiveXObject("Microsoft.XMLHTTP");
            }

            var myObj = {};

            myObj["col1"] = $("#activarCuentaCombo").val();
            //myObj["col2"] = $("#idModifCuentaHide").val().trim();

            var json = JSON.stringify(myObj);
            $.ajax({
                //Usamos GET ya que recibimos.
                type: 'POST',
                url: '/Facturacion/CuentasController/activarCuenta.htm',
                data: json,
                datatype: "json",
                contentType: "application/json",
                success: function (data) {
                    //alert(data);
                    getCuentas();

                    var idEmpresaNew = $("#idEmpresaAnadirCuentaHidden").val();
                    getCarta(idEmpresaNew);
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    console.log(xhr.status);
                    console.log(xhr.responseText);
                    console.log(thrownError);
                },
//                complete: function (xhr, status) {
//                    alert('Cuenta activada con exito');
//                }
            });
        }
        ;

        function archivarEmpresa() {
            if (window.XMLHttpRequest) //mozilla
            {
                ajax = new XMLHttpRequest(); //No Internet explorer
            } else
            {
                ajax = new ActiveXObject("Microsoft.XMLHTTP");
            }

            var myObj = {};

            myObj["col1"] = $("#idElimEmpresaHide").val().trim();

            var json = JSON.stringify(myObj);
            $.ajax({
                //Usamos GET ya que recibimos.
                type: 'POST',
                url: '/Facturacion/CuentasController/archivarEmpresa.htm',
                data: json,
                datatype: "json",
                contentType: "application/json",
                success: function (data) {
                    getEmpresas();
//                    $("#tbody-tabla-empresas").children().eq($("#idElimEmpresaFilaHide").val()).hide();
//                    alert("Empresa Archivada Correctamente");

                    var empArc = $("#idElimEmpresaHide").val().trim();
                    var empAct = $("#idEmpresaAnadirCuentaHidden").val().trim();

                    if (empArc == empAct) {
                        getCartaSinValor();
                    } else {
                        getCarta(empAct);
                    }
                    ;

                    //getCartaSinValor();


                },
                error: function (xhr, ajaxOptions, thrownError) {
                    console.log(xhr.status);
                    console.log(xhr.responseText);
                    console.log(thrownError);
                }
            });
        }
        ;

        function activarEmpresa() {
            if (window.XMLHttpRequest) //mozilla
            {
                ajax = new XMLHttpRequest(); //No Internet explorer
            } else
            {
                ajax = new ActiveXObject("Microsoft.XMLHTTP");
            }

            var myObj = {};

            myObj["col1"] = $("#activarEmpresaCombo").val();
            //myObj["col2"] = $("#idModifCuentaHide").val().trim();

            var json = JSON.stringify(myObj);
            $.ajax({
                //Usamos GET ya que recibimos.
                type: 'POST',
                url: '/Facturacion/CuentasController/activarEmpresa.htm',
                data: json,
                datatype: "json",
                contentType: "application/json",
                success: function (data) {
                    //alert(data);
                    getEmpresas();

                    var idEmpresaNew = $("#activarEmpresaCombo").val();
                    getCarta(idEmpresaNew);

                },
                error: function (xhr, ajaxOptions, thrownError) {
                    console.log(xhr.status);
                    console.log(xhr.responseText);
                    console.log(thrownError);
                }
            });
        }
        ;

        function anadirEmpresa() {
            if (window.XMLHttpRequest) //mozilla
            {
                ajax = new XMLHttpRequest(); //No Internet explorer
            } else
            {
                ajax = new ActiveXObject("Microsoft.XMLHTTP");
            }

            var myObj = {};

            myObj["col1"] = $("#anadirEmpresaCombo").val();
            myObj["col2"] = $("#anadirEmpresaCombo option:selected").text();

            //$('select[name="lineas"] option:selected').text());

            // alert($('#anadirEmpresaCombo option:selected').text());

            var json = JSON.stringify(myObj);
            $.ajax({
                type: 'POST',
                url: '/Facturacion/CuentasController/anadirEmpresa.htm',
                data: json,
                datatype: "json",
                contentType: "application/json",
                success: function (data) {
                    //alert(data);
                    getEmpresas();

                },
                error: function (xhr, ajaxOptions, thrownError) {
                    console.log(xhr.status);
                    console.log(xhr.responseText);
                    console.log(thrownError);
                }
            });
        }
        ;

        function modificarDetalle() {
            if (window.XMLHttpRequest) //mozilla
            {
                ajax = new XMLHttpRequest(); //No Internet explorer
            } else
            {
                ajax = new ActiveXObject("Microsoft.XMLHTTP");
            }

            idEmpresa = $("#idModifDetalleIdEmpresaHide").val().trim();
            var myObj = {};

            myObj["col1"] = $("#idModifDetalleIdCuentaHide").val().trim();
            myObj["col2"] = $("#idModifDetalleIdEmpresaHide").val().trim();
            myObj["col3"] = $("#denominacionDetalle").val().trim();

            var json = JSON.stringify(myObj);
            $.ajax({
                //Usamos GET ya que recibimos.
                type: 'POST',
                url: '/Facturacion/CuentasController/modificarDetalle.htm',
                data: json,
                datatype: "json",
                contentType: "application/json",
                success: function (data) {
                    //alert(data);
                    getCarta(idEmpresa);

                },
                error: function (xhr, ajaxOptions, thrownError) {
                    console.log(xhr.status);
                    console.log(xhr.responseText);
                    console.log(thrownError);
                }
            });
        }
        ;

        //Para añadir una cuenta a una empresa
        function anadirCuentaEmpresa() {

            var idEmpresa = $("#idEmpresaAnadirCuentaHidden").val();

            //alert(idEmpresa);

            if (window.XMLHttpRequest) //mozilla
            {
                ajax = new XMLHttpRequest(); //No Internet explorer
            } else
            {
                ajax = new ActiveXObject("Microsoft.XMLHTTP");
            }

            var myObj = {};

            myObj["col1"] = $("#anadirCuentaEmpresaCombo").val();
            myObj["col2"] = $("#idEmpresaAnadirCuentaHidden").val();
            myObj["col3"] = $("#myDenominacionCuentaEmpresa").val();

            var json = JSON.stringify(myObj);
            $.ajax({
                type: 'POST',
                url: '/Facturacion/CuentasController/anadirCuentaEmpresa.htm',
                data: json,
                datatype: "json",
                contentType: "application/json",
                success: function (data) {

                    getCarta(idEmpresa);

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
                <div class="col-md-12">

                    <!--<form role="form">-->
                    <br style="clear:both">

                    <h3 style="margin-bottom: 25px; text-align: center;">CARTA DE CUENTAS</h3>  

                    <div class="col-xs-6">
                        <div id="tableContainer11"> <!--Para el scroll-->
                            <table class="table table-striped"  id="tableContainer1">                                    

                                <thead class="thead-dark">
                                    <tr>
                                        <th scope="col" colspan="4" style="text-align:center;"><h4>Denominación cuentas <label>General</label></h4></th>        
                                    </tr>    
                                    <tr>
                                        <th scope="col">#</th>
                                        <th scope="col">ID CUENTA</th>
                                        <th scope="col">DENOMINACIÓN</th>
                                        <th scope="col">ACTIVA</th>
                                        <th><button type="button" class='btn miBotonAnadirCuenta btn-sample btn-sm' data-dismiss="modal">
                                                <span class='glyphicon glyphicon-plus'></span>&nbsp;&nbsp;&nbsp;  Añadir &nbsp;&nbsp;&nbsp; </button></th>
                                        <th><button type="button" class='btn miBotonActivarCuenta btn-info btn-sm' data-dismiss="modal">
                                                <span class='glyphicon glyphicon-check'></span>&nbsp;&nbsp;&nbsp;Activar &nbsp;</button></th>

                                    </tr>                                            
                                </thead>

                                <tbody id="tbody-tabla-cuentas">

                                </tbody>
                            </table>
                        </div>
                        <div id="tableContainer22"> <!--Para el scroll-->
                            <table class="table table-striped"  id="tableContainer2">                                    

                                <thead class="thead-dark">
                                    <tr>
                                        <th scope="col" colspan="4" style="text-align:center;"><h4>Detalle empresas</h4></th>        
                                    </tr>    
                                    <tr>
                                        <th scope="col">#</th>
                                        <th scope="col">ID EMPRESA</th>
                                        <th scope="col">DISTINCT CODE</th>                                    
                                        <th scope="col">ACTIVA</th>
                                        <th><button type="button" class='btn miBotonAnadirEmpresa btn-success btn-sm' data-dismiss="modal">
                                                <span class='glyphicon glyphicon-plus'></span>&nbsp;&nbsp;&nbsp;&nbsp;  Añadir &nbsp;&nbsp; </button></th>
                                        <th><button type="button" class='btn miBotonActivarEmpresa btn-info btn-sm' data-dismiss="modal">
                                                <span class='glyphicon glyphicon-check'></span>&nbsp;&nbsp;&nbsp;Activar &nbsp;</button></th>
                                    </tr>                                            
                                </thead>

                                <tbody id="tbody-tabla-empresas">

                                </tbody>
                            </table>
                        </div>
                    </div>       

                    <div class="col-xs-6">
                        <div id="tableContainer33"> <!--Para el scroll-->
                            <table class="table table-striped"  id="tableContainer3">
                                <thead id="thead-tabla-carta">
                                    <tr>
                                        <th scope="col" colspan="4" style="text-align:center;"><h4>Detalle Cuentas Empresa <label id="nomEmp" name="nomEmp"></label></h4></th>
                                    </tr>    
                                    <tr>
                                        <th scope="col">#</th>
                                        <th scope="col">Id Cuenta</th>
                                        <th scope="col">General</th>  
                                        <th scope="col">Empresa</th>
                                        <th><button type="button" class='btn miBotonAnadirCuentaEmpresa btn-success btn-sm' data-dismiss="modal">
                                                <span class='glyphicon glyphicon-plus'></span>&nbsp;&nbsp;&nbsp;  Añadir &nbsp;&nbsp;&nbsp; </button></th>
                                    </tr>

                                </thead>
                                <!--class="hidden"-->
                                <input class="hidden" id="idEmpresaAnadirCuentaHidden"/>

                                <tbody id="tbody-tabla-carta">

                                </tbody>
                            </table>
                        </div>
                    </div>

                    <br style="clear:both">

                    <a href="/Facturacion/MenuController/start.htm" class="btn btn-info" role="button">Menu principal</a>                     
                    <button type="button" id="submit" name="submit" class="btn btn-primary">Submit</button>


                    <!-- ventana emergente Modificar Cuenta-->
                    <div class="modal fade" id="myModalModificarCuenta" role="dialog">
                        <!-- Declaramos los campos ocultos para en la funcion de ajax podamos guardar los datos -->
                        <input class="hidden" id="idModifCuentaHide"/>
                        <input class="hidden" id="idModifCuentaTipoHide"/>
                        <input class="hidden" id="idModifCuentaFilaHide"/>

                        <div class="modal-dialog">

                            <!-- Modal content-->
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                    <h4 class="modal-title">Modificar Cuenta</h4>
                                </div>
                                <div class="modal-body">
                                    <p id="modificarCuenta"></p>  
                                    <div class="form-area">  
                                        <div class="row"> 
                                            <div class="form-group col-xs-3">
                                                <label for="denominacionModificar">Denominación:</label>
                                            </div>
                                            <div class="form-group col-xs-5">
                                                <input type="text" class="form-control" id="denominacionModificar" name="denominacionModificar">
                                            </div> 
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <!-- Llamamos a la funcion eliminarEntidad al pusar en si, al pulsar en no, no hacemos nada y volvemos a la pagina donde mostramos la lista-->
                                    <button type="button" class="btn btn-info btn-sm" data-dismiss="modal" onclick="modificarCuenta()">Modificar</button>
                                    <button type="button" class="btn btn-warning btn-sm" data-dismiss="modal">Cancelar</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- ventana emergente Añadir Cuenta-->
                    <div class="modal fade" id="myModalAnadirCuenta" role="dialog">
                        <!-- Declaramos los campos ocultos para en la funcion de ajax podamos guardar los datos -->
                        <input class="hidden" id="idAnadirCuentaHide"/>
                        <!--                        <input  id="TextoCuentaHide"/>-->

                        <div class="modal-dialog">

                            <!-- Modal content-->
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                    <h4 class="modal-title">Añadir Cuenta</h4>
                                </div>
                                <div class="modal-body">
                                    <p id="anadirCuenta"></p>  
                                    <div class="form-area">  
                                        <div class="row"> 
                                            <div class="form-group col-xs-3">
                                                <label for="denominacionAnadir">Denominación:</label>
                                            </div>
                                            <div class="form-group col-xs-5">
                                                <input type="text" class="form-control" id="denominacionAnadir" name="denominacionAnadir">
                                            </div> 
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <!-- Llamamos a la funcion eliminarEntidad al pusar en si, al pulsar en no, no hacemos nada y volvemos a la pagina donde mostramos la lista-->
                                    <button type="button" class="btn btn-info btn-sm" data-dismiss="modal" onclick="anadirCuenta()">Añadir</button>
                                    <button type="button" class="btn btn-warning btn-sm" data-dismiss="modal">Cancelar</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- ventana emergente Archivar Cuenta-->
                    <div class="modal fade" id="myModalEliminarCuenta" role="dialog">
                        <!-- Declaramos los campos ocultos para en la funcion de ajax podamos guardar los datos -->
                        <input class="hidden" id="idElimCuentaHide"/>
                        <input class="hidden" id="idElimCuentaTipoHide"/>
                        <input class="hidden" id="idElimCuentaFilaHide"/>

                        <div class="modal-dialog">

                            <!-- Modal content-->
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                    <h4 class="modal-title">Archivar Cuenta</h4>
                                </div>
                                <div class="modal-body">
                                    <p id="eliminarCuenta"></p>                            
                                </div>
                                <div class="modal-footer">
                                    <!-- Llamamos a la funcion eliminarEntidad al pusar en si, al pulsar en no, no hacemos nada y volvemos a la pagina donde mostramos la lista-->
                                    <button type="button" class="btn btn-danger btn-sm" data-dismiss="modal" onclick="archivarCuenta()">Archivar</button>
                                    <button type="button" class="btn btn-info btn-sm" data-dismiss="modal">Cancelar</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- ventana emergente Activar Cuenta-->
                    <div class="modal fade" id="myModalActivarCuenta" role="dialog">
                        <!-- Declaramos los campos ocultos para en la funcion de ajax podamos guardar los datos -->
                        <input class="hidden" id="idActivarCuentaHide"/>                        

                        <div class="modal-dialog">

                            <!-- Modal content-->
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                    <h4 class="modal-title">Activar Cuenta</h4>
                                </div>
                                <div class="modal-body">
                                    <p id="activarCuenta"></p>  
                                    <div class="form-area">  
                                        <div class="row"> 
                                            <div class="form-group col-xs-3">
                                                <label for="activarCuentaCombo">Denominación:</label>
                                            </div>
                                            <div class="form-group col-xs-5">
                                                <select class="form-control" id="activarCuentaCombo" name="activarCuentaCombo">
                                                </select>  
                                            </div> 
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">                                    
                                    <button type="button" class="btn btn-info btn-sm" data-dismiss="modal" onclick="activarCuenta()">Activar</button>
                                    <button type="button" class="btn btn-warning btn-sm" data-dismiss="modal">Cancelar</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- ventana emergente Archivar Empresa-->
                    <div class="modal fade" id="myModalEliminarEmpresa" role="dialog">
                        <!-- Declaramos los campos ocultos para en la funcion de ajax podamos guardar los datos -->
                        <input class="hidden" id="idElimEmpresaHide"/>
                        <input class="hidden" id="idElimEmpresaTipoHide"/>
                        <input class="hidden" id="idElimEmpresaFilaHide"/>

                        <div class="modal-dialog">

                            <!-- Modal content-->
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                    <h4 class="modal-title">Archivar Empresa</h4>
                                </div>
                                <div class="modal-body">
                                    <p id="eliminarEmpresa"></p>                            
                                </div>
                                <div class="modal-footer">
                                    <!-- Llamamos a la funcion eliminarEntidad al pusar en si, al pulsar en no, no hacemos nada y volvemos a la pagina donde mostramos la lista-->
                                    <button type="button" class="btn btn-danger btn-sm" data-dismiss="modal" onclick="archivarEmpresa()">Archivar</button>
                                    <button type="button" class="btn btn-info btn-sm" data-dismiss="modal">Cancelar</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- ventana emergente Activar Empresa-->
                    <div class="modal fade" id="myModalActivarEmpresa" role="dialog">
                        <!-- Declaramos los campos ocultos para en la funcion de ajax podamos guardar los datos -->
                        <input class="hidden" id="idActivarEmpresaHide"/>                        

                        <div class="modal-dialog">

                            <!-- Modal content-->
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                    <h4 class="modal-title">Activar Empresa</h4>
                                </div>
                                <div class="modal-body">
                                    <p id="activarEmpresa"></p>  
                                    <div class="form-area">  
                                        <div class="row"> 
                                            <div class="form-group col-xs-3">
                                                <label for="activarEmpresaCombo">Distinct Code:</label>
                                            </div>
                                            <div class="form-group col-xs-5">
                                                <select class="form-control" id="activarEmpresaCombo" name="activarEmpresaCombo">
                                                </select>  
                                            </div> 
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">                                    
                                    <button type="button" class="btn btn-info btn-sm" data-dismiss="modal" onclick="activarEmpresa()">Activar</button>
                                    <button type="button" class="btn btn-warning btn-sm" data-dismiss="modal">Cancelar</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- ventana emergente Añadir Empresa-->
                    <div class="modal fade" id="myModalAnadirEmpresa" role="dialog">
                        <!-- Declaramos los campos ocultos para en la funcion de ajax podamos guardar los datos -->
                        <input class="hidden" id="idAnadirEmpresaHide"/>                        

                        <div class="modal-dialog">

                            <!-- Modal content-->
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                    <h4 class="modal-title">Añadir Empresa</h4>
                                </div>
                                <div class="modal-body">
                                    <p id="anadirEmpresa"></p>  
                                    <div class="form-area">  
                                        <div class="row"> 
                                            <div class="form-group col-xs-3">
                                                <label for="anadirEmpresaCombo">Distinct Code:</label>
                                            </div>
                                            <div class="form-group col-xs-5">
                                                <select class="form-control" id="anadirEmpresaCombo" name="anadirEmpresaCombo">
                                                </select>  
                                            </div> 
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">                                    
                                    <button type="button" class="btn btn-info btn-sm" data-dismiss="modal" onclick="anadirEmpresa()">Añadir</button>
                                    <button type="button" class="btn btn-warning btn-sm" data-dismiss="modal">Cancelar</button>
                                </div>
                            </div>
                        </div>
                    </div>                   

                    <!-- ventana emergente Modificar Detalle Cuenta Empresa-->
                    <div class="modal fade" id="myModalModificarDetalle" role="dialog">
                        <!-- Declaramos los campos ocultos para en la funcion de ajax podamos guardar los datos -->
                        <input id="idModifDetalleIdCuentaHide"/>
                        <input id="idModifDetalleCuentaHide"/>
                        <input id="idModifDetalleIdEmpresaHide"/>
                        <input id="idModifDetalleDenominacionHide"/>

                        <div class="modal-dialog">

                            <!-- Modal content-->
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                    <h4 class="modal-title">Modificar Detalle</h4>
                                </div>
                                <div class="modal-body">                                    
                                    <div class="form-area">  
                                        <div class="row"> 
                                            <div class="form-group col-xs-3">
                                                <label for="denominacionCuenta">General:</label>
                                            </div>
                                            <div class="form-group col-xs-5">
                                                <label id="denominacionCuenta" name="denominacionCuenta"></label>
                                            </div> 
                                        </div>
                                        <div class="row"> 
                                            <div class="form-group col-xs-3">
                                                <label for="denominacionDetalle">Denominación:</label>
                                            </div>
                                            <div class="form-group col-xs-5">
                                                <input type="text" class="form-control" id="denominacionDetalle" name="denominacionDetalle">
                                            </div> 
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <!-- Llamamos a la funcion eliminarEntidad al pusar en si, al pulsar en no, no hacemos nada y volvemos a la pagina donde mostramos la lista-->
                                    <button type="button" class="btn btn-info btn-sm" data-dismiss="modal" onclick="modificarDetalle()">Modificar</button>
                                    <button type="button" class="btn btn-warning btn-sm" data-dismiss="modal">Cancelar</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- ventana emergente Añadir Cuenta a Empresa-->
                    <div class="modal fade" id="myModalAnadirCuentaEmpresa" role="dialog">
                        <!-- Declaramos los campos ocultos para en la funcion de ajax podamos guardar los datos -->
                        <input class="hidden" id="myModalAnadirCuentaEmpresaHidden"/>                        

                        <div class="modal-dialog">

                            <!-- Modal content-->
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                    <h4 class="modal-title">Añadir Cuenta</h4>
                                </div>
                                <div class="modal-body">
                                    <p id="anadirCuentaEmpresa"></p>  
                                    <div class="form-area">  
                                        <div class="row"> 
                                            <div class="form-group col-xs-3">
                                                <label for="anadirCuentaEmpresaCombo">Cuenta:</label>
                                            </div>
                                            <div class="form-group col-xs-5">
                                                <select class="form-control" id="anadirCuentaEmpresaCombo" name="anadirCuentaEmpresaCombo">
                                                </select>  
                                            </div> 
                                        </div>
                                        <div class="row"> 
                                            <div class="form-group col-xs-3">
                                                <label for="myDenominacionCuentaEmpresa">Denominacion:</label>
                                            </div>
                                            <div class="form-group col-xs-5">                                                
                                                <input type="text" class="form-control" id="myDenominacionCuentaEmpresa" name="myDenominacionCuentaEmpresa">
                                            </div> 
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">                                    
                                    <button type="button" class="btn btn-info btn-sm" data-dismiss="modal" onclick="anadirCuentaEmpresa()">Añadir</button>
                                    <button type="button" class="btn btn-warning btn-sm" data-dismiss="modal">Cancelar</button>
                                </div>
                            </div>
                        </div>
                    </div>                   


                </div>
            </div>
        </div>
    </body> 
</html>
