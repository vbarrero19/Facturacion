<%-- 
    Document   : menu
    Created on : 04-ene-2019, 9:23:26
    Author     : Javier
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="jstl" uri="http://java.sun.com/jstl/core_rt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
    <%@ include file="infouser.jsp" %>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Menu principal</title><script>
//    $(document).ready(function () {
//        $('logoutmodal').hide();
//    });
            function logout() {
                document.location.href = "<c:url value="/cerrarLogin.htm"/>";
            }

        </script>

    </head>

    <body> 
        <style>
            .navUsuario{
                background-color: #020202;
                color: white;
            }
        </style>
        <header> 
            <div class="navUsuario" id="infousuario">   
                <!--BUSCAR EN EL CSS PARA METER EL STYLE. -->
                <div class="row" style="height: 75px;display: flex;">
                    <div class="col-xs-10" id="childrensNav">
                        <!--BUSCAR EN EL CSS PARA METER EL STYLE. -->
                        <div class="row" style="display: flex;/*! flex-direction: unset; */justify-content: space-between;align-items:  center;height: 100%;">
                            <!-- Menu desplegable de clientes donde aparecen las opciones a realizar -->
                            <div class="divName ">
                                <!--<a href="<c:url value='/clientesController/start.htm'/>" class="btn btn-info" role="button">Clientes</a>  -->
                                <div class="dropdown">
                                    <button class="btn btn-info" type="button" data-toggle="dropdown">Clientes
                                        <span class="caret"></span></button>
                                    <ul class="dropdown-menu">
                                        <li><a href="<c:url value='/clientesController/start.htm'/>">Alta cliente</a></li>
                                        <!--meter href la direccion del controlador que realiza las acciones -->
                                        <li><a href="#">Ver cliente</a></li>
                                        <li><a href="#">Modificar cliente</a></li>
                                        <li><a href="#">Baja cliente</a></li>
                                    </ul>
                                </div>
                                
                                <!-- Fin del menu de clientes -->
                            </div> 
                            <div class="divName">
                                <a href="<c:url value='/cargosController/start.htm'/>" class="btn btn-info" role="button">Cargos</a>
                            </div> 
                            <div class="divName ">
                                <a href="<c:url value='/itemsController/start.htm'/>" class="btn btn-info" role="button">Items</a>
                            </div>
                            <div class="divName ">
                                <a href="<c:url value='/tipoImpuestoController/start.htm'/>" class="btn btn-info" role="button">Tipo Impuesto</a>
                            </div>

                            <div class="divName">
                                <a href="<c:url value='/tipoEmpresaController/start.htm'/>" class="btn btn-info" role="button">Tipo Empresa</a>
                            </div>

                            <div class="divName">
                                <a href="<c:url value='/tipoFiscalController/start.htm'/>" class="btn btn-info" role="button">Identificacion fiscal</a>
                            </div>

                            <div class="divName ">
                                <a href="<c:url value='/facturasController/start.htm'/>" class="btn btn-info" role="button">Facturas</a>
                            </div>
                        </div>
                    </div>
                    <!--BUSCAR EN EL CSS PARA METER EL STYLE. -->
                    <div class="logOut col-xs-2" style="margin-top: 10px;">
                        <a onclick="$('#logoutmodal').modal('show');" role="button" aria-haspopup="true" aria-expanded="false"><img class="imgUser" src="<c:url value="/recursos/img/iconos/logoBamboo_IconLogout.svg"/>"></a>
                    </div>
                </div>
            </div>    
        </header>



        <div id="logoutmodal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header modal-header-delete">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Are you sure you want to logout?</h4>
                    </div>
                    <div class="modal-footer text-center">
                        <button id="buttonDelete" type="button" class="btn btn-danger" data-dismiss="modal" onclick="logout()">Yes</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">No</button>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
