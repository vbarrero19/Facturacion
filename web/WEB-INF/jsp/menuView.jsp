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

                <div class="row">
                    <div class="col-xs-10" id="childrensNav">
<!--                        <div class="row">-->
                            <div class="divName col-xs-1">
                                <a href="<c:url value='/clientesController/start.htm'/>" class="btn btn-info" role="button">Clientes</a>
                            </div> 
                            <div class="divName col-xs-1">
                                <a href="<c:url value='/cargosController/start.htm'/>" class="btn btn-info" role="button">Cargos</a>
                            </div> 
                            <div class="divName col-xs-1">
                                <a href="<c:url value='/itemsController/start.htm'/>" class="btn btn-info" role="button">Items</a>
                            </div>
                            <div class="divName col-xs-2">
                                <a href="<c:url value='/tipoImpuestoController/start.htm'/>" class="btn btn-info" role="button">Tipo Impuesto</a>
                            </div>

                            <div class="divName col-xs-2">
                                <a href="<c:url value='/tipoEmpresaController/start.htm'/>" class="btn btn-info" role="button">Tipo Empresa</a>
                            </div>
                            
                            <div class="divName col-xs-2">
                                <a href="<c:url value='/tipoFiscalController/start.htm'/>" class="btn btn-info" role="button">Identificacion fiscal</a>
                            </div>

                            <div class="divName col-xs-1">
                                <a href="<c:url value='/facturasController/start.htm'/>" class="btn btn-info" role="button">Facturas</a>
                            </div>  
<!--                        </div>-->
                    </div>

                    <div class="divName col-xs-2">
                        <div class="row">

                        </div>
                    </div>
                    <div class="logOut col-xs-2">
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
