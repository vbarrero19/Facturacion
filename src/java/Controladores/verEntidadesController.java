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
public class verEntidadesController {

    /*LLAMAMOS AL CONTROLADOR DE ENTIDADES E INICIAMOS EL START.HTM Y CREAMOS UN NUEVO MODELO VISTA QUE LLAMA A ENTIDADESVIEW.JSP Y NOS LO MUESTRA
    EN CASO DE QUE NO EXISTA Y SALTE LA EXCEPCION*/
    @RequestMapping("/verEntidadesController/start.htm")
    public ModelAndView start(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        ModelAndView mv = new ModelAndView("verEntidadesView");

        return mv;
    }

    /**
     * ******** MENU PRINCIPAL PARA VER MODIFICAR ENTIDADES HTM **********
     */
    @RequestMapping("/verEntidadesController/startEntidad.htm")
    public ModelAndView starModificarEntidad(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        ModelAndView mv = new ModelAndView("modificarEntidadesView");

        return mv;
    }

    /*MUESTRA LA LISTA DE TODAS LAS ENTIDADES CON SUS BOTONES ELIMINAR/MODIFICAR */
    @RequestMapping("/verEntidadesController/verEntidades.htm")
    @ResponseBody
    public String verEntidades(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        Entidades resourceLoad = new Entidades();

        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";

        //CREAMOS UN ARRAY
        ArrayList<String> arrayTipo = new ArrayList<>();

        /*CODIGO PARA VER UNA ENTIDAD*/
        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();

            Statement sentencia = con.createStatement();
            rs = sentencia.executeQuery("select id_entidad, distinct_code, nombre_entidad, nombre_contacto from entidad where activado = 'TRUE' order by distinct_code");

            while (rs.next()) {
                arrayTipo.add(new Gson().toJson(new Entidades(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4))));
            }
            resp = new Gson().toJson(arrayTipo);
            /**
             * ******CONSULTA QUE RECOGE LOS DNI DE LAS ENTIDADES ACTIVAS**********************
             */

            resp = new Gson().toJson(arrayTipo);

            /**
             * **************************
             */
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

    /* CREAMOS CONSULTA PARA MOSTRAR LOS DATOS DE LA ENTIDAD EN MODIFICAR ENTIDAD */
    @RequestMapping("/verEntidadesController/modificarEntidad.htm")
    @ResponseBody
    /*CREAMOS UNA CLASE QUE NO TIENE REQUEST PORQUE NO ESTAMOS ESPERANDO LOS DATOS DE NINGUNA PETICION*/
    public String verModificarEntidad(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        /*CREAMOS UN OBJETO DEL TIPO ENTIDAD */
        Entidades resourceLoad = new Entidades();

        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";

        int idEnt = Integer.parseInt(hsr.getParameter("entidad"));
        //Creamos un array list de tipo String donde guardamos los resultados de la busqueda
        //y lo enviamos con JSON. EL resultado son objetos de tipoEntidad convertidos en String por el JSON.
        ArrayList<String> arrayEntidad = new ArrayList<>();

        try {

            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();

            stAux = con.prepareStatement("select e.id_entidad, e.distinct_code, e.nombre_entidad, e.nombre_contacto, e.apellido1, e.apellido2, e.telefono1, e.telefono2, e.fax, e.mail1,"
                    + "e.mail2cc, d.numero_documento from entidad e inner join entidad_documento ed on e.id_entidad = ed.id_entidad inner join documento d on ed.id_documento = d.id_documento where e.activado = 'TRUE' and e.id_entidad = ?"
                    + "order by distinct_code");

            stAux.setInt(1, idEnt);
            rs = stAux.executeQuery();

            /*MIENTRAS QUE TENGAMOS REGISTRO, CADA REGISTRO DEL rs LO CONVERTIMOS A STRING CON JSON
            Y LO GUARDAMOS EN EL ARRAY DECLARADO ARRIBA
             */
            while (rs.next()) {

                arrayEntidad.add(new Gson().toJson(new Entidades(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7),
                        rs.getString(8), rs.getString(9), rs.getString(10), rs.getString(11), rs.getString(12))));
            }
            
              resp = new Gson().toJson(arrayEntidad);

/***********
consulta que muestra todos los datos con los combos donde id_entidad = ? 


select e.id_entidad, e.distinct_code, e.nombre_entidad, e.nombre_contacto, e.apellido1, e.apellido2, e.telefono1, e.telefono2, e.fax, e.mail1,
e.mail2cc, d.numero_documento, td.documento, te.tipo_entidad, tde.dedicacion
from entidad e inner join entidad_documento ed on e.id_entidad = ed.id_entidad inner join documento d on ed.id_documento = d.id_documento 
inner join tipo_documento td
on d.id_tipo_documento = td.id_tipo_documento
inner join entidad_tipo_entidad ete
on e.id_entidad = ete.id_entidad
inner join tipo_entidad te
on ete.id_tipo_entidad = te.id_tipo_entidad
inner join tipo_dedicacion tde
on tde.id_dedicacion = e.id_dedicacion
where e.activado = 'TRUE' and e.id_entidad = ?
order by distinct_code

* 
* 
* 
* EN LA CONSULTA SE DUPLICAN DATOS SI METEMOS DOS TIPOS DE DOCUMENTO O DOS TIPOS DE ENTIDAD....ETC

**************/         
            

        } catch (SQLException ex) {
            resp = "incorrecto SQL"; //
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

    /*FUNCION PARA MODIFICAR UNA ENTIDAD RECOGIENDO EL ID_ENTIDAD. AL DARLE AL BOTON ACTUALIZAMOS LOS DATOS
    ********* NO FUNCIONA **********
     */
    @RequestMapping("/verEntidadesController/actualizarEntidad.htm")
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

            stAux = con.prepareStatement("UPDATE entidad set nombre_contacto where id_entidad = ?");

            stAux.setString(1, entidades.getNombre_contacto());


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

}
