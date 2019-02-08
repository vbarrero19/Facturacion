
package Controladores;

/**
 *
 * @author vbarr
 */

import Modelo.*;
import com.google.gson.Gson;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


public class DireccionController {
    
     @RequestMapping("/entidadesController/start.htm")
    public ModelAndView start(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        ModelAndView mv = new ModelAndView("entidadesView");

        return mv;
    }
    
    
        /*CARGAMOS EL COMBO DEL TIPO_DIRECCION DE LA ENTIDAD(fisica, fiscal,facturacion...)*/
    @RequestMapping("/entidadesController/getTipoDireccion.htm")  
    @ResponseBody
    /*CREAMOS UNA CLASE QUE NO TIENE REQUEST PORQUE NO ESTAMOS ESPERANDO LOS DATOS DE NINGUNA PETICION*/
    public String cargarComboTipoEntidad(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        /*CREAMOS UN OBJETO DEL TIPO ENTIDAD */
        TipoEntidad resourceLoad = new TipoEntidad();
        
        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";
        
        //Creamos un array list de tipo String donde guardamos los resultados de la busqueda
        //y lo enviamos con JSON. EL resultado son objetos de tipoEntidad convertidos en String por el JSON.
        ArrayList<String> arrayTipoEntidad = new ArrayList<>();
        
        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();          
            /*CREAMOS LA CONSULTA PREPARADA Y LO GUARDAMOS EN rs*/
            Statement sentencia = con.createStatement();
            rs = sentencia.executeQuery("select id_tipo_direccion, tipo_direccion from tipo_direccion");
            /*MIENTRAS QUE TENGAMOS REGISTRO, CADA REGISTRO DEL rs LO CONVERTIMOS A STRING CON JSON
            Y LO GUARDAMOS EN EL ARRAY DECLARADO ARRIBA
            */
            while(rs.next()){
                
            arrayTipoEntidad.add(new Gson().toJson(new TipoEntidad(rs.getString(1), rs.getString(2))));
            }
            /*CONVERTIMOS EL ARRAY DE STRING EN UN STRING Y LO GUARDAMOS EN LA VARIABLE RESP QUE DEVOLVEREMOS AL JSP*/
            resp = new Gson().toJson(arrayTipoEntidad);
            
            
        } catch (SQLException ex) {
            resp = "incorrecto"; //
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
        
        //Devolvemos la variable resp al JSP
        return resp;  
        
    }
}
