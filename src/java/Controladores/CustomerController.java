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
public class CustomerController {
    
    @RequestMapping("/customerController/start.htm")
    public ModelAndView start(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception { 
        ModelAndView mv = new ModelAndView("customerView");
       
        return mv;
    }  
    
    @RequestMapping("/customerController/addResources.htm")
    @ResponseBody
    public ModelAndView addResources(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        
        return null;
    }
    
    @RequestMapping("/customerController/newCustomer.htm")  
    @ResponseBody
    public String saveNewCustomer(@RequestBody Resource r, HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        Resource resourceLoad = new Resource();
        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "incorrecto";
       
        //ModelAndView mv = new ModelAndView("lessonresources");
        /*try {
            /*PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();
            
            stAux = con.prepareStatement("SELECT * FROM customers WHERE id = ?");
            
            stAux.setInt(1, Integer.parseInt(r.getCol1()));  
            rs = stAux.executeQuery();
            
            Resource rRespuesta = new Resource();
            
            while (rs.next()) {
                rRespuesta.setCol1(rs.getString("Nombre"));
                rRespuesta.setCol2(rs.getString("Apellido"));
                rRespuesta.setCol3(""+rs.getInt("Edad"));
            } 
        } catch (SQLException ex) {
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
        }*/
        return resp;
    }
}
