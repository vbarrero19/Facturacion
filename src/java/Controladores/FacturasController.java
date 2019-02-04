
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

@Controller
public class FacturasController {
    
    @RequestMapping("/facturasController/start.htm")
    public ModelAndView start(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception { 
        ModelAndView mv = new ModelAndView("facturasView");
       
        return mv;
    }  
    
    @RequestMapping("/facturasController/addResources.htm")
    @ResponseBody
    public ModelAndView addResources(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        
        return null;
    } 
    
    
//    @RequestMapping("/facturasController/getFacturas.htm")  
//    @ResponseBody
//    public String saveNewCustomer(@RequestBody ClienteAdeudos clienteAdeudos, HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
//        ClienteAdeudos resourceLoad = new ClienteAdeudos();
//        
//        Connection con = null;
//        ResultSet rs = null;
//        PreparedStatement stAux = null;
//        String resp = "correcto";
//       
//        ArrayList<String> arrayTipo = new ArrayList<>();   
//        
//        try {
//            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
//            con = pool_local.getConnection();  
//            
//            stAux = con.prepareStatement("SELECT c.id_cliente, c.id_adeudo, adeudo, cantidad, nombre_empresa, dir_fisica, pais FROM ADEUDOS c inner join clientes t on c.id_cliente = t.id_cliente and c.ID_CLIENTE = ?");
//            
//            stAux.setInt(1, Integer.parseInt(clienteAdeudos.getId_cliente())); 
//            //Ejecutamos                 
//            rs = stAux.executeQuery();
//            
//            while (rs.next()) {
//                arrayTipo.add(new Gson().toJson(new ClienteAdeudos(rs.getString(1),rs.getString(2),rs.getString(3),rs.getString(4),rs.getString(5),rs.getString(6),rs.getString(7)))); 
//            }
//            
//            resp = new Gson().toJson(arrayTipo);
//            
//        } catch (SQLException ex) {
//            resp = "incorrecto SQLException"; // ex.getMessage();
//            StringWriter errors = new StringWriter();
//            ex.printStackTrace(new PrintWriter(errors)); 
//        }catch (Exception ex) {
//            resp = "incorrecto"; // ex.getMessage();
//            StringWriter errors = new StringWriter();
//            ex.printStackTrace(new PrintWriter(errors)); 
//        } finally {
//            try {
//                if (rs != null) {
//                    rs.close();
//                }
//            } catch (Exception e) {
//            }
//            try {
//                if (stAux != null) {
//                    stAux.close();
//                }
//            } catch (Exception e) {
//            }
//            try {
//                if (con != null) {
//                    con.close();
//                }
//            } catch (Exception e) {
//            }
//        }
//        return resp;
//    }
    
    
    
    
    //Se usa para cargar los datos del combo Clientes. 
    @RequestMapping("/facturasController/getEntidadCliente.htm")  
    @ResponseBody
    public String cargarComboCliente(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        Entidades resourceLoad = new Entidades();

        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";

        ArrayList<String> arrayTipo = new ArrayList<>();

        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();

            Statement sentencia = con.createStatement();
            rs = sentencia.executeQuery("select e.id_entidad, e.distinct_code, e.nombre_entidad, e.nombre_contacto from entidad e inner join entidad_tipo_entidad t on e.id_entidad = t.id_entidad inner join"
                                        + " tipo_entidad te on t.id_tipo_entidad = te.id_tipo_entidad where upper(te.tipo_entidad) = upper('cliente')");
            
            while (rs.next()) { 
                arrayTipo.add(new Gson().toJson(new Entidades(rs.getString(1),rs.getString(2),rs.getString(3),rs.getString(4)))); 
            }

            resp = new Gson().toJson(arrayTipo);

        } catch (SQLException ex) {
            resp = "incorrecto SQLException"; // ex.getMessage();
            StringWriter errors = new StringWriter();
            ex.printStackTrace(new PrintWriter(errors));
        } catch (Exception ex) {
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
    
    
    
    
    
