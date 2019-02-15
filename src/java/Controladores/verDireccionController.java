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
        EntidadesDireccion resourceLoad = new EntidadesDireccion();

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
            rs = sentencia.executeQuery("select ed.id_entidad, ed.id_direccion, e.nombre_entidad, d.nombre_via, d.localidad"
                    + "from entidad_direccion ed inner join entidad e on e.id_entidad = ed.id_entidad"
                    + "inner join direccion d on d.id_direccion = ed.id_direccion;");

            while (rs.next()) {
                arrayTipo.add(new Gson().toJson(new EntidadesDireccion(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5))));
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

}
