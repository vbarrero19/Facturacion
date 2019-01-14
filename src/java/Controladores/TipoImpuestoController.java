/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
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
public class TipoImpuestoController {
    
    //Mostramos la vista. Viene del jsp menuView. Creamos un ModelAndView("tipoImpuestoView")
    @RequestMapping("/tipoImpuestoController/start.htm")
    public ModelAndView start(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception { 
        ModelAndView mv = new ModelAndView("tipoImpuestoView");
       
        return mv;
    }  
    
    @RequestMapping("/tipoImpuestoController/addResources.htm")
    @ResponseBody
    public ModelAndView addResources(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        
        return null;
    }
    
    //Codigo para añadir un nuevo Impuesto. Viene pulsar submit en el formulario
    @RequestMapping("/tipoImpuestoController/newCustomer.htm")  
    @ResponseBody
    public String saveNewCustomer(@RequestBody TipoImpuesto tipoImp, HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
     //   TipoImpuesto resourceLoad = new TipoImpuesto();
        
        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";       
        
        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();
       
            //Creamos la consulta preparada
            stAux = con.prepareStatement("INSERT INTO tipo_impuesto (impuesto) VALUES (?)");      
            //Asignamos valores
            stAux.setString(1, tipoImp.getImpuesto()); 
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
