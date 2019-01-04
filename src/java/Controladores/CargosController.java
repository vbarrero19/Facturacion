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
public class CargosController {
    
    @RequestMapping("/cargosController/start.htm")
    public ModelAndView start(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception { 
        ModelAndView mv = new ModelAndView("cargosView");
       
        return mv;
    }  
    
    @RequestMapping("/cargosController/addResources.htm")
    @ResponseBody
    public ModelAndView addResources(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        
        return null;
    }
    
    @RequestMapping("/cargosController/newCustomer.htm")  
    @ResponseBody
    public String saveNewCustomer(@RequestBody Cargos cargo, HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        Cargos resourceLoad = new Cargos();
        
        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";
       
        //ModelAndView mv = new ModelAndView("lessonresources");
        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();
            
            stAux = con.prepareStatement("INSERT INTO cargos (id_cargo,id_items,id_factura,id_cliente,cantidad,impuesto,fecha_cargo,fecha_vencimiento)"
                                        + "VALUES (?,?,?,?,?,?,?,?)");
            
            stAux.setInt(1, Integer.parseInt(cargo.getId_cargo()));  
            stAux.setInt(2, Integer.parseInt(cargo.getId_items()));  
            stAux.setInt(3, Integer.parseInt(cargo.getId_factura()));
            stAux.setInt(4, Integer.parseInt(cargo.getId_cliente()));
            stAux.setDouble(5, cargo.getCantidad());
            stAux.setInt(6, Integer.parseInt(cargo.getImpuesto()));
            stAux.setDate(7, new java.sql.Date(cargo.getFecha_cargo().getTime()));
            stAux.setDate(8, new java.sql.Date(cargo.getFecha_vencimiento().getTime()));            
            
            rs = stAux.executeQuery();
            
            /*Resource rRespuesta = new Resource();
            
            while (rs.next()) {
                rRespuesta.setCol1(rs.getString("Nombre"));
                rRespuesta.setCol2(rs.getString("Apellido"));
                rRespuesta.setCol3(""+rs.getInt("Edad"));
            } */
        } catch (SQLException ex) {
            resp = "Alta correcta"; // ex.getMessage();
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
