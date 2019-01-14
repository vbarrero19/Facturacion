
package Controladores;

import Modelo.*;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
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
 * @author vbarr
 */
public class TipoFiscalController {
    
    
    @RequestMapping("/fiscalController/start.htm")
    public ModelAndView start(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception { 
        ModelAndView mv = new ModelAndView("tipoImpuestoView");
       
        return mv;
    }  
    
    @RequestMapping("/fiscalController/addResources.htm")
    @ResponseBody
    public ModelAndView addResources(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        
        return null;
    }
    
    
    @RequestMapping("/fiscalController/newCustomer.htm")  
    @ResponseBody
    public String saveNewCustomer(@RequestBody TipoFiscal tipoFis, HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
     //   TipoImpuesto resourceLoad = new TipoImpuesto();
        
        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";
       
        //ModelAndView mv = new ModelAndView("lessonresources");
        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();
            
            stAux = con.prepareStatement("INSERT INTO tipo_fiscal (id_fiscal, nombre_id) VALUES (?,?)");       
            
            stAux.setInt(1,tipoFis.getId_fiscal());
            stAux.setString(2,tipoFis.getNombre_id());
                          
            stAux.executeUpdate();
            
            resp = "Correcto";
            
        } catch (SQLException ex) {
             resp = "Incorrecto"; // ex.getMessage();
            StringWriter errors = new StringWriter();
            ex.printStackTrace(new PrintWriter(errors)); 
        }catch (Exception ex) {
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
    
}
