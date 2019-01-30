
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
public class ItemsController {
    
    //Al cargar presentemos un Model and View con el JSP
    @RequestMapping("/itemsController/start.htm")
    public ModelAndView start(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception { 
        ModelAndView mv = new ModelAndView("itemsView"); 
            
                    
        return mv;
    }  
    
    //AddResources
    @RequestMapping("/itemsController/addResources.htm")
    @ResponseBody
    public ModelAndView addResources(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        
        return null;
    }
    
    //Insertamos un nuevo item
    @RequestMapping("/itemsController/newItems.htm")  
    @ResponseBody
    public String saveNewItem(@RequestBody Items item, HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        Items resourceLoad = new Items();
        
        Connection con = null; 
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";       
        
        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();          
            
            stAux = con.prepareStatement("INSERT INTO items (abreviatura, descripcion, id_tipo_item, cuenta, importe, periodo) VALUES (?,?,?,?,?,?)");
            //stAux = con.prepareStatement("INSERT INTO items (abreviatura, descripcion, id_tipo_item, cuenta, importe, periodo) VALUES (?,?,?,'fff',25,'Puntual')");
            
            stAux.setString(1, item.getAbreviatura());  
            stAux.setString(2, item.getDescripcion());  
            stAux.setInt(3, Integer.parseInt(item.getId_tipo_item())); 
            stAux.setString(4, item.getCuenta());
            stAux.setDouble(5, Double.parseDouble(item.getImporte()));              
            stAux.setString(6, item.getPeriodo());    
            
            stAux.executeUpdate();            
            
            resp = "Correcto";
            
        } catch (SQLException ex) {
             resp = "Incorrecto SQLException"; // ex.getMessage();
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
    
    @RequestMapping("/itemsController/getTipoItem.htm")  
    @ResponseBody
    public String cargarComboItem(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        TipoItem resourceLoad = new TipoItem();
        
        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";
        
        ArrayList<String> arrayTipoItem = new ArrayList<>();   
        
        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();          
            
            Statement sentencia = con.createStatement();
            rs = sentencia.executeQuery("SELECT id_tipo_item, item FROM tipo_item");
           
            while (rs.next()) {
                arrayTipoItem.add(new Gson().toJson(new TipoItem(rs.getString(1),rs.getString(2)))); 
            }
            
            resp = new Gson().toJson(arrayTipoItem);
            
            
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
