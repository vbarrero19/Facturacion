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

/**
 *
 * @author VanessaB
 */
public class ModificarDireccionController {
    @RequestMapping("/modificarDireccionController/start.htm")
    public ModelAndView start(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        ModelAndView mv = new ModelAndView("modificarDireccionView");

        return mv; 
    }

    @RequestMapping("/modificarDireccionController/addResources.htm")
    @ResponseBody
    public ModelAndView addResources(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {

        return null;
    }
    
    
    
   
    @RequestMapping("/modificarDireccionController/modificarDireccion.htm")
    @ResponseBody
    public String modificarCargo(@RequestBody Direccion direccion, HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        Direccion resourceLoad = new Direccion();

        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";

        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();
    
            String tipo_via = direccion.getTipo_via();
            
            String idEntidad = hsr.getParameter("idEnt");            
                   
  
            stAux = con.prepareStatement("UPDATE direccion SET tipo_via  = '"+tipo_via+"' where id_entidad = '"+idEntidad+"'");     

            stAux.executeUpdate();
            
            resp = "Correcto";

        } catch (SQLException ex) {
            resp = "incorrecto SQLException -> " + ex; // ex.getMessage();
            StringWriter errors = new StringWriter();
            ex.printStackTrace(new PrintWriter(errors));
        } catch (Exception ex) {
            resp = "incorrecto -> " + ex; // ex.getMessage();
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

    
}
