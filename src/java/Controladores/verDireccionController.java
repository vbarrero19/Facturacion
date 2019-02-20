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
public class verDireccionController {

    /*LLAMAMOS AL CONTROLADOR DE DIRECCION E INICIAMOS EL START.HTM Y CREAMOS UN NUEVO MODELO VISTA QUE LLAMA A verdireccionView.JSP Y NOS LO MUESTRA
    EN CASO DE QUE NO EXISTA Y SALTE LA EXCEPCION*/
    @RequestMapping("/verDireccionController/start.htm")
    public ModelAndView start(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        ModelAndView mv = new ModelAndView("verDireccionView");

        return mv;
    }

    @RequestMapping("/verDireccionController/verDireccion.htm")
    @ResponseBody
    public String verDireccion(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        EntidadDireccion resourceLoad = new EntidadDireccion();

        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";

        //CREAMOS UN ARRAY
        ArrayList<String> arrayTipo = new ArrayList<>();

        /*CODIGO PARA VER UNA DIRECCION*/
        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();

            Statement sentencia = con.createStatement();
            rs = sentencia.executeQuery("select ed.id_entidad, e.nombre_entidad, ed.id_direccion, d.nombre_via, d.localidad\n"
                    + "                    from entidad_direccion ed inner join entidad e on e.id_entidad = ed.id_entidad\n"
                    + "                    inner join direccion d on d.id_direccion = ed.id_direccion where d.activado = 'TRUE' order by e.distinct_code ASC");

            while (rs.next()) {
                arrayTipo.add(new Gson().toJson(new EntidadDireccion(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5))));
            }
            resp = new Gson().toJson(arrayTipo);

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
    @RequestMapping("/verDireccionController/modificarDireccion.htm")
    @ResponseBody
    /*CREAMOS UNA CLASE QUE NO TIENE REQUEST PORQUE NO ESTAMOS ESPERANDO LOS DATOS DE NINGUNA PETICION*/
    public String verModificarEntidad(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        /*CREAMOS UN OBJETO DEL TIPO ENTIDAD */
        EntidadDireccion resourceLoad = new EntidadDireccion();

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

            stAux = con.prepareStatement("select e.distinct_code, e.nombre_entidad, d.nombre_via, d.tipo_via, d.nombre_via, d.numero_via, d.numero_portal, d.resto_direccion," 
                    +" d.codigo_postal, d.localidad, d.provincia, d.pais from entidad e inner join entidad_direccion ed on e.id_entidad = ed.id_entidad"
                    + " inner join direccion d on d.id_direccion = ed.id_direccion where e.id_entidad = ?");

            stAux.setInt(1, idEnt);
            rs = stAux.executeQuery();

            /*MIENTRAS QUE TENGAMOS REGISTRO, CADA REGISTRO DEL rs LO CONVERTIMOS A STRING CON JSON
            Y LO GUARDAMOS EN EL ARRAY DECLARADO ARRIBA
             */
            while (rs.next()) {

                arrayEntidad.add(new Gson().toJson(new EntidadDireccion(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8), rs.getString(9), rs.getString(10), rs.getString(11),rs.getString(12))));
            }
            /*CONVERTIMOS EL ARRAY DE STRING EN UN STRING Y LO GUARDAMOS EN LA VARIABLE RESP QUE DEVOLVEREMOS AL JSP*/
            resp = new Gson().toJson(arrayEntidad);

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

}
