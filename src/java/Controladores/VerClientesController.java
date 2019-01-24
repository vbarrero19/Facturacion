/**
 *
 * @author vbarr
 */
package Controladores;

import Modelo.Clientes;
import Modelo.PoolC3P0_Local;
import Modelo.TipoEmpresa;
import Modelo.TipoFiscal;
import com.google.gson.Gson;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class VerClientesController {

    @RequestMapping("/verClientesController/start.htm")
    public ModelAndView start(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        ModelAndView mv = new ModelAndView("verClientesView");

        return mv;
    }

    @RequestMapping("/verClientesController/addResources.htm")
    @ResponseBody
    public ModelAndView addResources(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {

        return null;
    }

    @RequestMapping("/verClientesController/verCliente.htm")
    @ResponseBody
    public String verCliente(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        Clientes resourceLoad = new Clientes();

        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";

        //CREAMOS UN ARRAY
        ArrayList<String> arrayTipo = new ArrayList<>();

        /*CODIGO PARA VER UN NUEVO CLIENTE*/
        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();

            Statement sentencia = con.createStatement();
            rs = sentencia.executeQuery("SELECT id_cliente, nombre_empresa, nombre_persona, num_ident, dir_fisica , pais, telefono1 FROM clientes");

            while (rs.next()) {
                String test = rs.getString(3);
                arrayTipo.add(new Gson().toJson(new Clientes(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7))));
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

    /**
     * ******* PARA ELIMINAR UN CLIENTE **********
//     */
//    @RequestMapping("/verClientesController/verCliente.htm")
//    @ResponseBody
//    public String eliminarCliente(@RequestBody Clientes cliente, HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
//        Clientes resourceLoad = new Clientes();
//
//        Connection con = null;
//        ResultSet rs = null;
//        PreparedStatement stAux = null;
//        String resp = "correcto";
//
//        String borrar_cliente = "";
//
//        try {
//            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
//            con = pool_local.getConnection();
//
//            stAux = con.prepareStatement("DELTE FROM clientes WHERE id_cliente = ?");      
//            //Asignamos valores
//            //CREAR BOTON UN SUMBIT 
//            
//            stAux.setString(1, cliente.getCliente()); 
//            //Ejecutamos                 
//            stAux.executeUpdate();            
//            
//            
//
//            /**
//             * ************ ****
//             */
//            stAux.setString(1, borrar_cliente);
//
//        } catch (SQLException ex) {
//            resp = "Incorrecto"; // ex.getMessage();
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
//        return resp;
//    }
}
