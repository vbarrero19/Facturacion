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
public class verItemsController {

    /*llamamos al controlador de entidades e iniciamos el start.htm y creamos un nuevo modelo vista que llama a entidadesView.jsp y nos lo muestra
    en caso de que no exista y salte la excepcion*/
    @RequestMapping("/verItemsController/start.htm")
    public ModelAndView start(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        ModelAndView mv = new ModelAndView("verItemsView");

        return mv;
    }

    @RequestMapping("/verItemsController/addResources.htm")
    @ResponseBody
    public ModelAndView addResources(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {

        return null;
    }

    /*Muestra la lista de los items con sus botones eliminar, modificar, ...  */
    @RequestMapping("/verItemsController/verItems.htm")
    @ResponseBody
    public String verItems(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        Entidades resourceLoad = new Entidades();

        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";

        //Creamos un array
        ArrayList<String> arrayTipo = new ArrayList<>();

        /*Codigo para ver los items*/
        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();

            Statement sentencia = con.createStatement();
            rs = sentencia.executeQuery("select i.id_item, i.abreviatura, i.descripcion, ti.item, i.importe, i.estado, tc.cuenta, i.costes from items i inner join tipo_item ti "
                    + "on i.id_tipo_item = ti.id_tipo_item inner join tipo_cuenta tc on i.id_cuenta = tc.id_cuenta and i.estado = 0 order by abreviatura");

            while (rs.next()) {
                arrayTipo.add(new Gson().toJson(new Items(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8))));
            }
            resp = new Gson().toJson(arrayTipo);

        } catch (SQLException ex) {
            resp = "Incorrecto SQL -> " + ex;
            StringWriter errors = new StringWriter();
            ex.printStackTrace(new PrintWriter(errors));
        } catch (Exception ex) {
            resp = "Incorrecto -> " + ex; // 
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

    //Codigo para archivar items. En estado ponemos un 1 para indicar que esta archivado
    @RequestMapping("/verItemsController/archivarItem.htm")
    @ResponseBody
    public String archivarItem(@RequestBody Resource resource, HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        Resource resourceLoad = new Resource();

        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";

        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();

            stAux = con.prepareStatement("update items SET estado = ? where id_item = ?");

            //Ponemos el estado en 1 para indicar que esta archivado
            stAux.setInt(1, 1);
            stAux.setInt(2, Integer.parseInt(resource.getCol1()));

            stAux.executeUpdate();

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

    /*Muestra la lista de los items con sus botones eliminar, modificar, ...  */
    @RequestMapping("/verItemsController/verCostes.htm")
    @ResponseBody
    public String verCostes(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        Resource resourceLoad = new Resource();

        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";

        /*recogemos los valores de los parametros pasados por url desde el jsp, lo recogemos con hsr.getParameter("empresa")   */
        int idItem = Integer.parseInt(hsr.getParameter("idItem"));

        //Creamos un array
        ArrayList<String> arrayTipo = new ArrayList<>();

        /*Codigo para ver los items*/
        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();

            stAux = con.prepareStatement("select i.abreviatura, e.distinct_code, c.cantidad from costes c inner join items i on c.id_item = i.id_item inner join entidad e"
                    + " on c.id_entidad = e.id_entidad where i.id_item = ?");
            
            stAux.setInt(1, idItem);
            rs = stAux.executeQuery();

            while (rs.next()) {
                arrayTipo.add(new Gson().toJson(new Resource(rs.getString(1), rs.getString(2), rs.getString(3))));
            }
            resp = new Gson().toJson(arrayTipo);

        } catch (SQLException ex) {
            resp = "Incorrecto SQL -> " + ex;
            StringWriter errors = new StringWriter();
            ex.printStackTrace(new PrintWriter(errors));
        } catch (Exception ex) {
            resp = "Incorrecto -> " + ex; // 
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
