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
import java.text.SimpleDateFormat;
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
public class DireccionController {

    /*LLAMAMOS AL CONTROLADOR DE DIRECCION E INICIAMOS EL START.HTM Y CREAMOS UN NUEVO MODELO VISTA QUE LLAMA A DIRECCIONVIEW.JSP Y NOS LO MUESTRA
    EN CASO DE QUE NO EXISTA Y SALTE LA EXCEPCION*/
    @RequestMapping("/direccionController/start.htm")
    public ModelAndView start(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        ModelAndView mv = new ModelAndView("direccionView");

        return mv;
    }

    @RequestMapping("/direccionController/addResources.htm")
    @ResponseBody
    public ModelAndView addResources(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {

        return null;
    }
    
       /**
     * ******** MENU PRINCIPAL PARA VER MODIFICAR DIRECCION HTM **********
     */
    @RequestMapping("/direccionController/startDireccion.htm")
    public ModelAndView starModificarEntidad(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        ModelAndView mv = new ModelAndView("modificarDireccionView");

        return mv;
    }

    //GUARDAMOS UNA NUEVA DIRECCION EN LA BASE DE DATOS.
    @RequestMapping("direccionController/nuevaDireccion.htm")
    @ResponseBody
    public String nuevaDireccion(@RequestBody Direccion direccion, HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        Direccion resourceLoad = new Direccion();

        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "Alta de dirección correcta";
        
        String idEntidad = hsr.getParameter("idEnt");
        
        /*CODIGO PARA AÑADIR UNA NUEVA DIRECCION*/
        try {
            /*REALIZAMOS LA CONEXION A LA BASE DE DATOS.*/
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();

            /*REALIZAMOS LA CONSULTA PREPARADA PARA LA NUEVA DIRECCION*/

            stAux = con.prepareStatement("INSERT INTO DIRECCION (id_tipo_direccion, tipo_via, nombre_via, numero_via, numero_portal, resto_direccion, codigo_postal, localidad, provincia, pais, activado)"
                    + " VALUES (?,?,?,?,?,?,?,?,?,?,?)");

            /*VAMOS GUARDANDO LOS VALORES EN LA BASE DE DATOS  Y CONVIRTIENDO LOS QUE NO SEAN STRING) */
            stAux.setInt(1, Integer.parseInt(direccion.getId_tipo_direccion()));
            stAux.setString(2, direccion.getTipo_via());
            stAux.setString(3, direccion.getNombre_via());
            stAux.setString(4, direccion.getNumero_via());
            stAux.setString(5, direccion.getNumero_portal());
            stAux.setString(6, direccion.getResto_direccion());
            stAux.setString(7, direccion.getCodigo_postal());
            stAux.setString(8, direccion.getLocalidad());
            stAux.setString(9, direccion.getProvincia());
            stAux.setString(10, direccion.getPais());
            stAux.setBoolean(11,true);
            /*LO EJECUTAMOS*/
            stAux.executeUpdate();

            //RECOGEMOS EL MAXIMO DEL NUMERO DE LA DIRECCION 
            Connection con2 = null;
            ResultSet rs2 = null;
            PreparedStatement stAux2 = null;

            con2 = pool_local.getConnection();
            stAux2 = con2.prepareStatement("SELECT max(id_direccion) FROM direccion");

            rs2 = stAux2.executeQuery();
            int maximo = 0;

            while (rs2.next()) {
                maximo = rs2.getInt(1);
            }

            /*GUARDAMOS EN LA TABLA ENTIDAD_DIRECCION LA RELACION ENTRE LA TABLA ENTIDAD(con id_entidad seleccionadod el combo)
           Y LA TABLA DIRECCION, EL ID_DIRECCION(el maximo id_direccion) QUE ESTA INSERTADO) */
            Connection con3 = null;
            ResultSet rs3 = null;
            PreparedStatement stAux3 = null;
            
            //PARA RECOGER EL PARAMETRO QUE RECOGEMOS DEL COMBO EN EL JSP
            //int idEntidad=Integer.parseInt(hsr.getParameter("idEntidad"));
            
            con3 = pool_local.getConnection();
                    
                    
            stAux3 = con3.prepareStatement("INSERT INTO ENTIDAD_DIRECCION (id_entidad, id_direccion) VALUES (?, ?)");
            // stAux2.setInt(1, idEntidad);
            stAux3.setInt(1, Integer.parseInt(idEntidad));
            stAux3.setInt(2, maximo);

            /*LO EJECUTAMOS*/
            stAux3.executeUpdate();

        } catch (SQLException ex) {
            resp = "Incorrecto. Error SQL"; // ex.getMessage();
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

    /*CARGAMOS EL COMBO CON TODAS LAS ENTIDADES DE LA TABLA*/
    @RequestMapping("/direccionController/getVerEntidad.htm")
    @ResponseBody

    public String cargarComboVerEntidad(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        /*CREAMOS UN OBJETO DEL TIPO ENTIDAD */
        //Entidades resourceLoad = new Entidades();

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

            rs = sentencia.executeQuery("select id_entidad, distinct_code, nombre_entidad from entidad");
            /*MIENTRAS QUE TENGAMOS REGISTRO, CADA REGISTRO DEL rs LO CONVERTIMOS A STRING CON JSON
            Y LO GUARDAMOS EN EL ARRAY DECLARADO ARRIBA
             */
            while (rs.next()) {
                arrayTipoEntidad.add(new Gson().toJson(new Entidades(rs.getString(1), rs.getString(2), rs.getString(3))));
            }
            /*CONVERTIMOS EL ARRAY DE STRING EN UN STRING Y LO GUARDAMOS EN LA VARIABLE RESP QUE DEVOLVEREMOS AL JSP*/
            resp = new Gson().toJson(arrayTipoEntidad);

        } catch (SQLException ex) {
            resp = "incorrecto"; //
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

        //Devolvemos la variable resp al JSP
        return resp;
    }

    /*REALIZAMOS LA CONSULTA PARA CUANDO CARGAMOS LOS DATOS EN EL COMBO, NOS MUESTRE SU NOMBRE_ENTIDAD*/
    //Cargamos los datos en los input cuando seleccionamos una opcion del combo    
    @RequestMapping("/direccionController/getDatosEntidad.htm")
    @ResponseBody
    public String cargarDatosEntidad(@RequestBody Resource resource, HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        Resource resourceLoad = new Resource();

        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";

        ArrayList<String> arrayTipo = new ArrayList<>();

        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();

            stAux = con.prepareStatement("SELECT id_entidad, nombre_entidad FROM entidad WHERE id_entidad = ?");

            stAux.setInt(1, Integer.parseInt(resource.getCol1()));
            rs = stAux.executeQuery();

            while (rs.next()) {
                arrayTipo.add(new Gson().toJson(new Resource(rs.getString(1), rs.getString(2))));
            }

            resp = new Gson().toJson(arrayTipo);

        } catch (SQLException ex) {
            resp = "incorrecto"; // ex.getMessage();
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

    /*CARGAMOS EL COMBO PARA VER EL TIPO DE DIRECCION(fisica, fiscal...)*/
    @RequestMapping("/direccionController/getTipoDireccion.htm")
    @ResponseBody

    public String cargarComboTipoDireccion(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        /*CREAMOS UN OBJETO DEL TIPO ENTIDAD */
        TipoDireccion resourceLoad = new TipoDireccion();

        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";

        //Creamos un array list de tipo String donde guardamos los resultados de la busqueda
        //y lo enviamos con JSON. EL resultado son objetos de tipoEntidad convertidos en String por el JSON.
        ArrayList<String> arrayTipoDireccion = new ArrayList<>();

        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();
            /*CREAMOS LA CONSULTA PREPARADA Y LO GUARDAMOS EN rs*/

            Statement sentencia = con.createStatement();
            rs = sentencia.executeQuery("select id_tipo_direccion, tipo_direccion from tipo_direccion");
            /*MIENTRAS QUE TENGAMOS REGISTRO, CADA REGISTRO DEL rs LO CONVERTIMOS A STRING CON JSON
            Y LO GUARDAMOS EN EL ARRAY DECLARADO ARRIBA
             */
            while (rs.next()) {
                arrayTipoDireccion.add(new Gson().toJson(new TipoDireccion(rs.getString(1), rs.getString(2))));
            }
            /*CONVERTIMOS EL ARRAY DE STRING EN UN STRING Y LO GUARDAMOS EN LA VARIABLE RESP QUE DEVOLVEREMOS AL JSP*/
            resp = new Gson().toJson(arrayTipoDireccion);

        } catch (SQLException ex) {
            resp = "incorrecto"; //
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

        //Devolvemos la variable resp al JSP
        return resp;

    }

    
        /**********************************************************************************/
    /*************** PARA VER LAS DIRECCIONES EN VER/MODIFICAR DIRECION ******************/
    /**********************************************************************************/
    
    

}
