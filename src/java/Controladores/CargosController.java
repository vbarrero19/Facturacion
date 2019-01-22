/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controladores;

import Modelo.*;
import com.google.gson.Gson;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.sql.Connection;
import java.util.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
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
            
            
            stAux = con.prepareStatement("INSERT INTO cargos (id_cargo,id_empresa,id_factura,id_cliente,cantidad,impuesto,cargo,fecha_cargo,fecha_vencimiento) VALUES (?,?,?,?,?,?,?,?,?)");
            /**********/
            //Calendar calendar = Calendar.getInstance();
            //java.sql.Timestamp ourJavaTimestampObject = new java.sql.Timestamp(calendar.getTime().getTime());
            /**********/
            stAux.setInt(1, Integer.parseInt(cargo.getId_cargo()));  
            stAux.setInt(2, Integer.parseInt(cargo.getId_empresa()));  
            stAux.setInt(3, Integer.parseInt(cargo.getId_factura()));
            stAux.setInt(4, Integer.parseInt(cargo.getId_cliente()));
            stAux.setDouble(5, cargo.getCantidad());
            stAux.setInt(6, Integer.parseInt(cargo.getImpuesto()));
            stAux.setString(7, cargo.getCargo());            
            
            String test = cargo.getFecha_cargo();
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");            
            Date parsedDate = dateFormat.parse(test);
            Timestamp timestamp = new java.sql.Timestamp(parsedDate.getTime());
                       
            stAux.setTimestamp(8, timestamp);            
            
            String test2 = cargo.getFecha_vencimiento();
            SimpleDateFormat dateFormat2 = new SimpleDateFormat("yyyy-MM-dd");            
            Date parsedDate2 = dateFormat2.parse(test2);
            Timestamp timestamp2 = new java.sql.Timestamp(parsedDate2.getTime());
                       
            stAux.setTimestamp(9, timestamp2);
                        
            stAux.executeUpdate();
            
            /*Resource rRespuesta = new Resource();            
            while (rs.next()) {
                rRespuesta.setCol1(rs.getString("Nombre"));
                rRespuesta.setCol2(rs.getString("Apellido"));
                rRespuesta.setCol3(""+rs.getInt("Edad"));
            } */
            
            resp = "Correcto";
            
        } catch (SQLException ex) {
            resp = "incorrecto SQLException"; // ex.getMessage();
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
    
    @RequestMapping("/cargosController/getCliente.htm")  
    @ResponseBody
    public String cargarComboCliente(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        Clientes resourceLoad = new Clientes();
        
        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";
        
        ArrayList<String> arrayTipo = new ArrayList<>();         
        
        
        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();          
            
            Statement sentencia = con.createStatement();
            rs = sentencia.executeQuery("SELECT id_cliente, nombre_empresa, dir_fisica, pais FROM clientes where id_empresa = '1'");
           
            while (rs.next()) {
                arrayTipo.add(new Gson().toJson(new Clientes(rs.getString(1),rs.getString(2),rs.getString(3),rs.getString(4)))); 
            }
            
            resp = new Gson().toJson(arrayTipo);
            
            
        } catch (SQLException ex) {
             resp = "incorrecto"; // ex.getMessage();
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
    
   
    
    @RequestMapping("/cargosController/getDatosCliente.htm")  
    @ResponseBody
    public String cargarDatosCliente(@RequestBody Clientes clientes, HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        Clientes resourceLoad = new Clientes();
        
        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";
        
        ArrayList<String> arrayTipo = new ArrayList<>();         
        
        
        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();          
            
            //Statement sentencia = con.createStatement();
            stAux = con.prepareStatement("SELECT id_cliente, nombre_empresa, dir_fisica, pais FROM clientes WHERE id_cliente = ?");
            
            stAux.setInt(1, Integer.parseInt(clientes.getId_cliente())); 
            rs = stAux.executeQuery();
            
            
            
            while (rs.next()) {
                arrayTipo.add(new Gson().toJson(new Clientes(rs.getString(1),rs.getString(2),rs.getString(3),rs.getString(4)))); 
            }
            
            resp = new Gson().toJson(arrayTipo);
            
            
        } catch (SQLException ex) {
             resp = "incorrecto"; // ex.getMessage();
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
    
    
    @RequestMapping("/cargosController/getEmpresa.htm")  
    @ResponseBody
    public String cargarComboEmpresa(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        Clientes resourceLoad = new Clientes();
        
        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";
        
        ArrayList<String> arrayTipo = new ArrayList<>();         
        
        
        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();          
            
            Statement sentencia = con.createStatement();
            rs = sentencia.executeQuery("SELECT id_cliente, nombre_empresa, dir_fisica, pais FROM clientes where id_empresa = '2'");
           
            while (rs.next()) {
                arrayTipo.add(new Gson().toJson(new Clientes(rs.getString(1),rs.getString(2),rs.getString(3),rs.getString(4)))); 
            }
            
            resp = new Gson().toJson(arrayTipo);
            
            
        } catch (SQLException ex) {
             resp = "incorrecto"; // ex.getMessage();
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
