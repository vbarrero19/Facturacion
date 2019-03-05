package Controladores;

import Modelo.*;
import com.google.gson.Gson;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class verItemsController {

    /*llamamos al controlador de entidades e iniciamos el start.htm y creamos un nuevo modelo vista que llama a entidadesView.jsp y nos lo muestra
    en caso de que no exista y salte la excepcion*/
    @RequestMapping("/verItemsController/start.htm")
    public ModelAndView start(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        ModelAndView mv = new ModelAndView("verItemsView");

        return mv;
    }
    
//    @RequestMapping("/verCargosController/startCargo.htm")
//    public ModelAndView starModificarCargo(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
//        ModelAndView mv = new ModelAndView("modificarCargoView");
//
//        return mv;
//    }

    @RequestMapping("/verItemsController/addResources.htm")
    @ResponseBody
    public ModelAndView addResources(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {

        return null;
    }
    
    
    /*MUESTRA LA LISTA DE TODoS los items CON SUS BOTONES ELIMINAR/MODIFICAR */
    @RequestMapping("/verItemsController/verItems.htm")
    @ResponseBody
    public String verItems(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        Entidades resourceLoad = new Entidades();

        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";

        //CREAMOS UN ARRAY
        ArrayList<String> arrayTipo = new ArrayList<>();

        /*CODIGO PARA VER los items*/
        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();

            Statement sentencia = con.createStatement();
            rs = sentencia.executeQuery("select i.id_item, i.abreviatura, i.descripcion, t.item, i.cuenta, i.importe, i.estado from items i inner join tipo_item t on i.id_tipo_item = t.id_tipo_item order by abreviatura");

            while (rs.next()) {
                arrayTipo.add(new Gson().toJson(new Items(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7))));
            }
            resp = new Gson().toJson(arrayTipo);   
            
        } catch (SQLException ex) {
            resp = "Incorrecto"; // ex.getMessage();
            StringWriter errors = new StringWriter();
            ex.printStackTrace(new PrintWriter(errors));
        } catch (Exception ex) {
            resp = "incorrecto"; // ex.getMessage();
            StringWriter errors = new StringWriter();
            ex.printStackTrace(new PrintWriter(errors));
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
            } catch (Exception e) {
            }
            try {
                if (stAux != null) {
                    stAux.close();
                }
            } catch (Exception e) {
            }
            try {
                if (con != null) {
                    con.close();
                }
            } catch (Exception e) {
            }
        }

        return resp;
    }
    
//
//    /*CARGAMOS EL COMBO PARA VER LAS EMPRESAS*/
//    @RequestMapping("/verCargosController/getVerEntidad.htm")
//    @ResponseBody
//    public String cargarComboVerEntidad(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
//        /*CREAMOS UN OBJETO DEL TIPO ENTIDAD */
//        //Entidades resourceLoad = new Entidades();
//
//        Connection con = null;
//        ResultSet rs = null;
//        PreparedStatement stAux = null;
//        String resp = "correcto";
//
//        //Creamos un array list de tipo String donde guardamos los resultados de la busqueda
//        //y lo enviamos con JSON. EL resultado son objetos de tipoEntidad convertidos en String por el JSON.
//        ArrayList<String> arrayTipoEntidad = new ArrayList<>();
//
//        try {
//            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
//            con = pool_local.getConnection();
//            /*CREAMOS LA CONSULTA PREPARADA Y LO GUARDAMOS EN rs*/
//            Statement sentencia = con.createStatement();
//            rs = sentencia.executeQuery("select e.id_entidad, e.distinct_code, e.nombre_entidad, e.nombre_contacto from entidad e inner join entidad_tipo_entidad t on e.id_entidad = t.id_entidad inner join"
//                    + " tipo_entidad te on t.id_tipo_entidad = te.id_tipo_entidad where upper(te.tipo_entidad) = upper('cliente')");
//            /*MIENTRAS QUE TENGAMOS REGISTRO, CADA REGISTRO DEL rs LO CONVERTIMOS A STRING CON JSON
//            Y LO GUARDAMOS EN EL ARRAY DECLARADO ARRIBA
//             */
//            while (rs.next()) {
//                arrayTipoEntidad.add(new Gson().toJson(new Entidades(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4))));
//            }
//            /*CONVERTIMOS EL ARRAY DE STRING EN UN STRING Y LO GUARDAMOS EN LA VARIABLE RESP QUE DEVOLVEREMOS AL JSP*/
//            resp = new Gson().toJson(arrayTipoEntidad);
//
//        } catch (SQLException ex) {
//            resp = "incorrecto"; //
//            StringWriter errors = new StringWriter();
//            ex.printStackTrace(new PrintWriter(errors));
//
//        } catch (Exception ex) {
//            resp = "incorrecto"; // ex.getMessage();
//            StringWriter errors = new StringWriter();
//            ex.printStackTrace(new PrintWriter(errors));
//        } finally {
//            try {
//                if (rs != null) {
//                    rs.close();
//                }
//            } catch (Exception e) {
//            }
//            try {
//                if (stAux != null) {
//                    stAux.close();
//                }
//            } catch (Exception e) {
//            }
//            try {
//                if (con != null) {
//                    con.close();
//                }
//            } catch (Exception e) {
//            }
//        }
//
//        //Devolvemos la variable resp al JSP
//        return resp;
//
//    }
//
//    //Cargamos los datos en los input cuando seleccionamos una opcion del combo
//    @RequestMapping("/verCargosController/getDatosEntidad.htm")
//    @ResponseBody
//    public String cargarDatosEntidad(@RequestBody Entidades entidades, HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
//        Entidades resourceLoad = new Entidades();
//
//        Connection con = null;
//        ResultSet rs = null;
//        PreparedStatement stAux = null;
//        String resp = "correcto";
//
//        ArrayList<String> arrayTipo = new ArrayList<>();
//
//        try {
//            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
//            con = pool_local.getConnection();
//
//            stAux = con.prepareStatement("SELECT id_entidad, distinct_code, nombre_entidad, nombre_contacto FROM entidad WHERE id_entidad = ?");
//
//            stAux.setInt(1, Integer.parseInt(entidades.getId_entidad()));
//            rs = stAux.executeQuery();
//
//            while (rs.next()) {
//                arrayTipo.add(new Gson().toJson(new Entidades(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4))));
//            }
//
//            resp = new Gson().toJson(arrayTipo);
//
//        } catch (SQLException ex) {
//            resp = "incorrecto"; // ex.getMessage();
//            StringWriter errors = new StringWriter();
//            ex.printStackTrace(new PrintWriter(errors));
//        } catch (Exception ex) {
//            resp = "incorrecto"; // ex.getMessage();
//            StringWriter errors = new StringWriter();
//            ex.printStackTrace(new PrintWriter(errors));
//        } finally {
//            try {
//                if (rs != null) {
//                    rs.close();
//                }
//            } catch (Exception e) {
//            }
//            try {
//                if (stAux != null) {
//                    stAux.close();
//                }
//            } catch (Exception e) {
//            }
//            try {
//                if (con != null) {
//                    con.close();
//                }
//            } catch (Exception e) {
//            }
//        }
//        return resp;
//
//    }
//
////Cargamos los datos en los input cuando seleccionamos el cliente en el combo y mostramos los datos de todos los cargos.
//    @RequestMapping("/verCargosController/getDatosCargos.htm")
//    @ResponseBody
////    public String cargarDatosFactura(@RequestBody Facturas facturas, HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
//    public String cargarDatosCargos(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
//        Cargos resourceLoad = new Cargos();
//
//        Connection con = null;
//        ResultSet rs = null;
//        PreparedStatement stAux = null;
//        String resp = "correcto";
//        /*recogemos el valor del parametro pasado por url desde el jsp, lo recogemos con 
//        hsr.getParameter("idCliente")
//         */
//        int idCliente = Integer.parseInt(hsr.getParameter("idCliente"));
//
//        ArrayList<String> arrayTipo = new ArrayList<>();
//
//        try {
//            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
//            con = pool_local.getConnection();
//
//            stAux = con.prepareStatement("SELECT c.id_cargo, c.id_item, c.abreviatura, c.descripcion, t.item, c.cuenta, c.importe, c.cantidad, c.impuesto,\n"
//                    + "c.total, c.fecha_cargo, c.fecha_vencimiento, c.estado, c.id_factura, c.id_cliente, id_empresa, valor_impuesto FROM cargos c inner join \n"
//                    + "tipo_item t on c.id_tipo_item = t.id_tipo_item WHERE c.id_factura = 0 and id_cliente =  ?");
//
//            stAux.setInt(1, idCliente);
//            rs = stAux.executeQuery();
//
//            while (rs.next()) {
//                arrayTipo.add(new Gson().toJson(new Cargos(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8), rs.getString(9), rs.getString(10), rs.getString(11), rs.getString(12), rs.getString(13), rs.getString(14), rs.getString(15), rs.getString(16), rs.getString(17))));
//            }
//
//            resp = new Gson().toJson(arrayTipo);
//
//        } catch (SQLException ex) {
//            resp = "incorrecto"; // ex.getMessage();
//            StringWriter errors = new StringWriter();
//            ex.printStackTrace(new PrintWriter(errors));
//        } catch (Exception ex) {
//            resp = "incorrecto"; // ex.getMessage();
//            StringWriter errors = new StringWriter();
//            ex.printStackTrace(new PrintWriter(errors));
//        } finally {
//            try {
//                if (rs != null) {
//                    rs.close();
//                }
//            } catch (Exception e) {
//            }
//            try {
//                if (stAux != null) {
//                    stAux.close();
//                }
//            } catch (Exception e) {
//            }
//            try {
//                if (con != null) {
//                    con.close();
//                }
//            } catch (Exception e) {
//            }
//        }
//        return resp;
//
//    }
//
//    @RequestMapping("/verCargosController/eliminarCargo.htm")
//    @ResponseBody
//    public String eliminarPago(@RequestBody Resource resource, HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
//        Resource resourceLoad = new Resource();
//
//        Connection con = null;
//        ResultSet rs = null;
//        PreparedStatement stAux = null;
//        String resp = "correcto";
//
//        try {
//            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
//            con = pool_local.getConnection();
//
//            stAux = con.prepareStatement("delete from cargos where id_cargo = ?");
//
//            stAux.setInt(1, Integer.parseInt(resource.getCol1()));
//
//            stAux.executeUpdate();
//
//        } catch (SQLException ex) {
//            resp = "incorrecto sql"; // ex.getMessage();
//            StringWriter errors = new StringWriter();
//            ex.printStackTrace(new PrintWriter(errors));
//        } catch (Exception ex) {
//            resp = "incorrecto"; // ex.getMessage();
//            StringWriter errors = new StringWriter();
//            ex.printStackTrace(new PrintWriter(errors));
//        } finally {
//            try {
//                if (rs != null) {
//                    rs.close();
//                }
//            } catch (Exception e) {
//            }
//            try {
//                if (stAux != null) {
//                    stAux.close();
//                }
//            } catch (Exception e) {
//            }
//            try {
//                if (con != null) {
//                    con.close();
//                }
//            } catch (Exception e) {
//            }
//        }
//        return resp;
//    }
//


}


    