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
public class ItemsController {
    
    @RequestMapping("/itemsController/start.htm")
    public ModelAndView start(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception { 
        ModelAndView mv = new ModelAndView("itemsView");
       
        return mv;
    }  
    
    @RequestMapping("/itemsController/addResources.htm")
    @ResponseBody
    public ModelAndView addResources(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        
        return null;
    }
    
    @RequestMapping("/itemsController/newCustomer.htm")  
    @ResponseBody
    public String saveNewCustomer(@RequestBody Items item, HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        Items resourceLoad = new Items();
        
        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";
       
        //ModelAndView mv = new ModelAndView("lessonresources");
        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();
            
            stAux = con.prepareStatement("INSERT INTO items (id_item, abreviatura, nombre, precio, id_impuesto) VALUES (?,?,?,?,?)");
            
            stAux.setInt(1, Integer.parseInt(item.getId_item()));  
            stAux.setString(2, item.getAbreviatura()); 
            stAux.setString(3, item.getNombre()); 
            stAux.setDouble(4, Double.parseDouble(item.getPrecio()));  
            stAux.setInt(5, Integer.parseInt(item.getId_impuesto()));            
            stAux.executeUpdate();
            
            /*Resource rRespuesta = new Resource();
            
            while (rs.next()) {
                rRespuesta.setCol1(rs.getString("Nombre"));
                rRespuesta.setCol2(rs.getString("Apellido"));
                rRespuesta.setCol3(""+rs.getInt("Edad"));
            } */
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
