/**
 *
 * @author vbarr
 */

package Controladores;

import Modelo.Clientes;
import Modelo.PoolC3P0_Local;
import Modelo.TipoEmpresa;
import Modelo.TipoFiscal;
import com.google.gson.Gson;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class VerClientesController { 
    
    @RequestMapping("/verClientesController/start.htm")
    public ModelAndView start(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception { 
        ModelAndView mv = new ModelAndView("verClientesView");
       
        return mv;
    }  
    
    @RequestMapping("/verClientesController/addResources.htm")
    @ResponseBody
    public ModelAndView addResources(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        
        return null;
    }
    
    @RequestMapping("/verClientesController/verCliente.htm")  
    @ResponseBody
    public String saveNewCustomer(@RequestBody Clientes clientes, HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        Clientes resourceLoad = new Clientes();
        
        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";
       
        //CREAMOS UN ARRAY
        ArrayList<String> arrayTipo = new ArrayList<>(); 
        
       /*CODIGO PARA AÑADIR UN NUEVO CLIENTE*/ 
        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();
            /*REALIZAMOS LA CONSULTA PREPARADA PARA EL NUEVO CLIENTE*/
            stAux = con.prepareStatement("SELECT id_cliente, nombre_empresa, num_ident, pais FROM clientes");
            
            /*VAMOS ASIGNANDO LOS VALORES*/
            stAux.setInt(1, Integer.parseInt(clientes.getId_cliente()));
            //EJECUTAMOS LA CONSULTA Y LO GUARDAMOS EN LA VARIABLE RS          
            rs = stAux.executeQuery();
            
            
            while (rs.next()) {
                arrayTipo.add(new Gson().toJson(new Clientes(rs.getString(1),rs.getString(2),rs.getString(3),rs.getString(4)))); 
            }            
            resp = new Gson().toJson(arrayTipo);
            
            
            
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
    

