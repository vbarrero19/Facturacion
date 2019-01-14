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
 * @author David
 */
@Controller
public class TipoFiscalController {
    
    //Mostramos la vista. Viene del jsp menuView, Creamos un ModelAndView("tipoFiscalView")**
    @RequestMapping("/tipoFiscalController/start.htm")
    public ModelAndView start(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception { 
        ModelAndView mv = new ModelAndView("tipoFiscalView");
       
        return mv;
    }  
    
    @RequestMapping("/tipoFiscalController/addResources.htm")
    @ResponseBody
    public ModelAndView addResources(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        
        return null;
    }
    
    //Codigo para añadir una nueva Empresa. Viene pulsar submit en el formulario
    @RequestMapping("/tipoFiscalController/newCustomer.htm")  
    @ResponseBody
    public String saveNewCustomer(@RequestBody TipoFiscal tipoFis, HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
     //   TipoImpuesto resourceLoad = new TipoImpuesto();
        
        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";       
        
        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();
        
            //Creamos la consulta preparada
            stAux = con.prepareStatement("INSERT INTO tipo_fiscal (fiscal) VALUES (?)");      
            //Asignamos valores
            stAux.setString(1, tipoFis.getFiscal());
            
            //Ejecutamos                 
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
