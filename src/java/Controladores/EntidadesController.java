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

@Controller
public class EntidadesController {

    /*LLAMAMOS AL CONTROLADOR DE ENTIDADES E INICIAMOS EL START.HTM Y CREAMOS UN NUEVO MODELO VISTA QUE LLAMA A ENTIDADESVIEW.JSP Y NOS LO MUESTRA
    EN CASO DE QUE NO EXISTA Y SALTE LA EXCEPCION*/
    @RequestMapping("/entidadesController/start.htm")
    public ModelAndView start(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        ModelAndView mv = new ModelAndView("entidadesView");

        return mv;
    }

   
    
     /*  * *******************************************************************************************************
     * ******************** FUNCIONES PARA LA INFORMACION DE LA ENTIDAD DE  ENTIDADESVIEW ****************************** 
     * ******************************************************************************************************* */
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
        String resp = "Alta de entidad correcta";
        /*CODIGO PARA AÑADIR UNA NUEVA ENTIDAD*/
        try {
            /*REALIZAMOS LA CONEXION A LA BASE DE DATOS.*/
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();
            /*REALIZAMOS LA CONSULTA PREPARADA PARA LA NUEVA ENTIDAD*/

            
            stAux = con.prepareStatement("INSERT INTO ENTIDAD (distinct_code, nombre_entidad, tratamiento, nombre_contacto, apellido1, apellido2, telefono1, telefono2, fax, mail1, mail2cc, fecha_alta, fecha_baja, activado)"
                    + " VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
           
            /*VAMOS GUARDANDO LOS VALORES EN LA BASE DE DATOS  Y CONVIRTIENDO LOS QUE NO SEAN STRING) */            
            stAux.setString(1,entidades.getDistinct_code());
            stAux.setString(2,entidades.getNombre_entidad());
            stAux.setString(3,entidades.getTratamiento());
            stAux.setString(4,entidades.getNombre_contacto());
            stAux.setString(5,entidades.getApellido1());
            stAux.setString(6,entidades.getApellido2());
            stAux.setString(7,entidades.getTelefono1());
            stAux.setString(8,entidades.getTelefono2());
            stAux.setString(9,entidades.getFax());
            stAux.setString(10,entidades.getMail1());
            stAux.setString(11,entidades.getMail2cc());
            
            String fechaAlta = entidades.getFecha_alta();
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date parsedDate = dateFormat.parse(fechaAlta);
            Timestamp timestamp = new java.sql.Timestamp(parsedDate.getTime());

            stAux.setTimestamp(12, timestamp);
            
            String fechaBaja = entidades.getFecha_alta();
            SimpleDateFormat dateFormat2 = new SimpleDateFormat("yyyy-MM-dd");
            Date parsedDate2 = dateFormat2.parse(fechaBaja);
            Timestamp timestamp2 = new java.sql.Timestamp(parsedDate2.getTime());

            stAux.setTimestamp(13, timestamp2);
            
            String activado = "TRUE";
            stAux.setString(14,activado);
            /*LO EJECUTAMOS*/
            stAux.executeUpdate();            

            /**
             * ************** SELECCIONAMOS EL MAXIMO DEL NUMERO DE ENTIDAD DE LA TABLA ********************
             */
            Connection con3 = null;
            ResultSet rs3 = null;
            PreparedStatement stAux3 = null;

            con3 = pool_local.getConnection();

            stAux3 = con3.prepareStatement("SELECT max(id_entidad) FROM entidad");

            //stAux3.setInt(1, Integer.parseInt(entidades.getId_entidad()));
            rs3 = stAux3.executeQuery();
            int maximo = 0;

            while (rs3.next()) {
                maximo = rs3.getInt(1);
            }

            // GUARDAMOS EN LA TABLA ENTIDAD_TIPO DE ENTIDAD LA RELACION ENTRE LA TABLA ENTIDAD Y LA TABLA TIPO ENTIDAD.
            Connection con2 = null;
            ResultSet rs2 = null;
            PreparedStatement stAux2 = null;

            con2 = pool_local.getConnection();
            /*REALIZAMOS LA CONSULTA PREPARADA PARA LA NUEVA ENTIDAD*/

            stAux2 = con2.prepareStatement("INSERT INTO ENTIDAD_TIPO_ENTIDAD (id_entidad, id_tipo_entidad) VALUES (?,?)");

            /*VAMOS GUARDANDO LOS VALORES EN LA BASE DE DATOS  Y CONVIRTIENDO LOS QUE NO SEAN STRING) */
            stAux2.setInt(1, maximo);
            stAux2.setInt(2, Integer.parseInt(entidades.getId_tipo_entidad()));

            /*LO EJECUTAMOS*/
            stAux2.executeUpdate();

            /**
             * ********* INSERTAMOS EN LA TABLA DOCUMENTO EL ID_TIPO_DOCUMENTO DE LA TABLA TIPO_DOCUMENTO(QUE LO COGEMOS DEL COMBO) Y EL NUMERO DEL DOCUMENTO QUE LO SELECCIONAMOS DEL INPUT ***************
             */
            Connection con5 = null;
            ResultSet rs5 = null;
            PreparedStatement stAux5 = null;

            con5 = pool_local.getConnection();

            stAux5 = con5.prepareStatement("INSERT INTO DOCUMENTO (id_tipo_documento, numero_documento) VALUES (?,?)");

            stAux5.setInt(1, Integer.parseInt(entidades.getId_tipo_documento()));
            stAux5.setString(2, entidades.getNumero_documento());

            stAux5.executeUpdate();

            Connection con6 = null;
            ResultSet rs6 = null;
            PreparedStatement stAux6 = null;

            con6 = pool_local.getConnection();

            stAux6 = con6.prepareStatement("INSERT INTO ENTIDAD_DOCUMENTO (id_entidad, id_documento) VALUES (?,?)");

            stAux6.setInt(1, maximo);
            stAux6.setInt(2, Integer.parseInt(entidades.getId_tipo_documento()));

            stAux6.executeUpdate();

        } catch (SQLException ex) {
            resp = "Incorrecto SQL"; // ex.getMessage();
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
            while (rs.next()) {

                arrayTipoEntidad.add(new Gson().toJson(new TipoEntidad(rs.getString(1), rs.getString(2))));
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
            while (rs.next()) {

                arrayTipoDedicacion.add(new Gson().toJson(new TipoDedicacion(rs.getString(1), rs.getString(2))));
            }
            /*CONVERTIMOS EL ARRAY DE STRING EN UN STRING Y LO GUARDAMOS EN LA VARIABLE RESP QUE DEVOLVEREMOS AL JSP*/
            resp = new Gson().toJson(arrayTipoDedicacion);

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

    /*CARGAMOS EL COMBO DEL TIPO_DOCUMENTO DE LA ENTIDAD(CIF, NIF, PASAPORTE......)*/
    @RequestMapping("/entidadesController/getTipoDocumento.htm")
    @ResponseBody
    /*CREAMOS UNA CLASE QUE NO TIENE REQUEST PORQUE NO ESTAMOS ESPERANDO LOS DATOS DE NINGUNA PETICION*/
    public String cargarComboTipoDocumento(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        /*CREAMOS UN OBJETO DEL TIPO DEDICACION */
        TipoDocumento resourceLoad = new TipoDocumento();

        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";

        //Creamos un array list de tipo String donde guardamos los resultados de la busqueda
        //y lo enviamos con JSON. EL resultado son objetos de tipoDedicacion convertidos en String por el JSON.
        ArrayList<String> arrayTipoDocumento = new ArrayList<>();

        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();
            /*CREAMOS LA CONSULTA PREPARADA Y LO GUARDAMOS EN rs*/
            Statement sentencia = con.createStatement();
            rs = sentencia.executeQuery("select id_tipo_documento, documento from tipo_documento");
            /*MIENTRAS QUE TENGAMOS REGISTRO, CADA REGISTRO DEL rs LO CONVERTIMOS A STRING CON JSON
            Y LO GUARDAMOS EN EL ARRAY DECLARADO ARRIBA
             */
            while (rs.next()) {
                arrayTipoDocumento.add(new Gson().toJson(new TipoDocumento(rs.getString(1), rs.getString(2))));
            }
            /*CONVERTIMOS EL ARRAY DE STRING EN UN STRING Y LO GUARDAMOS EN LA VARIABLE RESP QUE DEVOLVEREMOS AL JSP*/
            resp = new Gson().toJson(arrayTipoDocumento);

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
    /*************** PARA VER LAS ENTIDADES EN VER/MODIFICAR ENTIDAD ******************/
    /**********************************************************************************/
    
    /*CARGAMOS TODOS LOS DATOS DE LA ENTIDAD PARA MOSTRARLOS EN LA PANTALLA DE MODIFICAR ENTIDAD.*/
    @RequestMapping("/entidadesController/getEntidad.htm")
    @ResponseBody
    /*CREAMOS UNA CLASE QUE NO TIENE REQUEST PORQUE NO ESTAMOS ESPERANDO LOS DATOS DE NINGUNA PETICION*/
    public String getEntidad(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
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
            while (rs.next()) {

                arrayTipoEntidad.add(new Gson().toJson(new TipoEntidad(rs.getString(1), rs.getString(2))));
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
    
    
    
}
