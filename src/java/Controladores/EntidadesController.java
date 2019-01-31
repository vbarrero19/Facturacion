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
public class EntidadesController {

    /*llamamos al controlador de entidades e iniciamos el start.htm y creamos un nuevo modelo vista que llama a entidadesView.jsp y nos lo muestra
    en caso de que no exista y salte la excepcion*/
    @RequestMapping("/entidadesController/start.htm")
    public ModelAndView start(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        ModelAndView mv = new ModelAndView("entidadesView");

        return mv;
    }

    @RequestMapping("/entidadesController/addResources.htm")
    @ResponseBody
    public ModelAndView addResources(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {

        return null;
    }

    /*GUARDAMOS UNA NUEVA ENTIDAD EN LA BASE DE DATOS*/
    @RequestMapping("/entidadesController/nuevaEntidad.htm")
    @ResponseBody
    public String guardarNuevaEntidad(@RequestBody Entidades entidades, HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        Entidades resourceLoad = new Entidades();

        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";
        /*CODIGO PARA AÑADIR UNA NUEVA ENTIDAD*/
        try {
            /*REALIZAMOS LA CONEXION A LA BASE DE DATOS.*/
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();
            /*REALIZAMOS LA CONSULTA PREPARADA PARA LA NUEVA ENTIDAD*/
//            stAux = con.prepareStatement("INSERT INTO ENTIDAD (distinct_code, nombre_entidad, tratamiento, nombre_contacto, apellido1, apellido2, telefono1, telefono2, fax, mail1, mail2cc)"
//                    + " VALUES (?,?,?,?,?,?,?,?,?,?,?)");
            //stAux = con.prepareStatement("INSERT INTO ENTIDAD (distinct_code, nombre_entidad, id_tipo_entidad, id_dedicacion) VALUES (?,?,?,?)");
            
            
            stAux = con.prepareStatement("INSERT INTO ENTIDAD (distinct_code, nombre_entidad, tratamiento, nombre_contacto, apellido1, apellido2, telefono1, telefono2, fax, mail1, mail2cc)"
                    + " VALUES (?,?,?,?,?,?,?,?,?,?,?)");
            
            /*VAMOS GUARDANDO LOS VALORES EN LA BASE DE DATOS  Y CONVIRTIENDO LOS QUE NO SEAN STRING) */            
            stAux.setString(1,entidades.getDistinct_code());
            stAux.setString(2,entidades.getNombre_entidad());
            //stAux.setInt(3,Integer.parseInt(entidad.getId_entidad()));
            //stAux.setInt(4,Integer.parseInt(entidad.getId_dedicacion()));
            stAux.setString(3,entidades.getTratamiento());
            stAux.setString(4,entidades.getNombre_contacto());
            stAux.setString(5,entidades.getApellido1());
            stAux.setString(6,entidades.getApellido2());
            stAux.setString(7,entidades.getTelefono1());
            stAux.setString(8,entidades.getTelefono2());
            stAux.setString(9,entidades.getFax());
            stAux.setString(10,entidades.getMail1());
            stAux.setString(11,entidades.getMail2cc());
            
            
            /*LO EJECUTAMOS*/
            stAux.executeUpdate();            
            
        } catch (SQLException ex) {
            resp = "Incorrecto"; // ex.getMessage();
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
    
    
    /*CARGAMOS EL COMBO DEL TIPO_ENTIDAD DE LA ENTIDAD(cliente, proveedor...)*/
    @RequestMapping("/entidadesController/getTipoEntidad.htm")  
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
            rs = sentencia.executeQuery("SELECT id_tipo_entidad, tipo_entidad FROM tipo_entidad");
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
    
    
    
    /*CARGAMOS EL COMBO DEL TIPO_DEDICACION DE LA ENTIDAD(facturacion, mantenimiento......)*/
    @RequestMapping("/entidadesController/getTipoDedicacion.htm")  
    @ResponseBody
    /*CREAMOS UNA CLASE QUE NO TIENE REQUEST PORQUE NO ESTAMOS ESPERANDO LOS DATOS DE NINGUNA PETICION*/
    public String cargarComboTipoDedicacion(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        /*CREAMOS UN OBJETO DEL TIPO DEDICACION */
        TipoDedicacion resourceLoad = new TipoDedicacion();
        
        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";
        
        //Creamos un array list de tipo String donde guardamos los resultados de la busqueda
        //y lo enviamos con JSON. EL resultado son objetos de tipoDedicacion convertidos en String por el JSON.
        ArrayList<String> arrayTipoDedicacion = new ArrayList<>();
        
        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();          
            /*CREAMOS LA CONSULTA PREPARADA Y LO GUARDAMOS EN rs*/
            Statement sentencia = con.createStatement();
            rs = sentencia.executeQuery("select id_dedicacion, dedicacion from tipo_dedicacion");
            /*MIENTRAS QUE TENGAMOS REGISTRO, CADA REGISTRO DEL rs LO CONVERTIMOS A STRING CON JSON
            Y LO GUARDAMOS EN EL ARRAY DECLARADO ARRIBA
            */
            while(rs.next()){
                
            arrayTipoDedicacion.add(new Gson().toJson(new TipoDedicacion(rs.getString(1), rs.getString(2))));
            }
            /*CONVERTIMOS EL ARRAY DE STRING EN UN STRING Y LO GUARDAMOS EN LA VARIABLE RESP QUE DEVOLVEREMOS AL JSP*/
            resp = new Gson().toJson(arrayTipoDedicacion);
            
            
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
