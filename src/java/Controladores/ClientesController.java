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


@Controller
public class ClientesController {
    
    @RequestMapping("/clientesController/start.htm")
    public ModelAndView start(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception { 
        ModelAndView mv = new ModelAndView("clientesView");
       
        return mv;
    }  
    
    @RequestMapping("/clientesController/addResources.htm")
    @ResponseBody
    public ModelAndView addResources(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        
        return null;
    }
    
    @RequestMapping("/clientesController/newCustomer.htm")  
    @ResponseBody
    public String saveNewCustomer(@RequestBody Clientes cliente, HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        Clientes resourceLoad = new Clientes();
        
        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";
       
        //ModelAndView mv = new ModelAndView("lessonresources");
        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();
            
            stAux = con.prepareStatement("INSERT INTO clientes (id_cliente, nombre_empresa, tratamiento, nombre_persona, mi_persona, apellido_persona, id_fiscal, num_ident, id_empresa, dir_fisica, dir_fiscal, pais, mail, telefono1, telefono2, fax) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
            
            
            stAux.setInt(1, Integer.parseInt(cliente.getId_cliente()));
            stAux.setString(2, cliente.getNombre_empresa());
            stAux.setString(3,cliente.getTratamiento());
            stAux.setString(4, cliente.getNombre_persona());
            stAux.setString(5,cliente.getMi_persona());
            stAux.setString(6, cliente.getApellido_persona());
            stAux.setInt(7,Integer.parseInt(cliente.getId_fiscal()));
            stAux.setString(8, cliente.getNum_ident());
            stAux.setString(9,cliente.getNum_ident());
            stAux.setString(10, cliente.getDir_fisica());
            stAux.setString(11, cliente.getDir_fiscal());
            stAux.setString(12, cliente.getPais());
            stAux.setString(13, cliente.getMail());
            stAux.setString(14, cliente.getTelefono1());
            stAux.setString(15,cliente.getTelefono2());
            stAux.setString(16,cliente.getFax());
            
            
            stAux.executeUpdate();
            
            
            
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
    
    @RequestMapping("/clientesController/getFiscal.htm")  
    @ResponseBody
    public String cargarCombo(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        Clientes resourceLoad = new Clientes();
        
        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";
        
        ArrayList<String> arrayTipo = new ArrayList<>();   
        
        
        //ModelAndView mv = new ModelAndView("lessonresources");
        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();          
            
            Statement sentencia = con.createStatement();
            rs = sentencia.executeQuery("SELECT ID_FISCAL, FISCAL FROM TIPO_FISCAL");
           
            while (rs.next()) {
                arrayTipo.add(new Gson().toJson(new TipoFiscal(rs.getInt(1),rs.getString(2)))); 
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
    
   
    @RequestMapping("/clientesController/getEmpresa.htm")  
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
            rs = sentencia.executeQuery("SELECT ID_EMPRESA, EMPRESA FROM TIPO_EMPRESA");
           
            while (rs.next()) {
                arrayTipo.add(new Gson().toJson(new TipoEmpresa(rs.getInt(1),rs.getString(2)))); 
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