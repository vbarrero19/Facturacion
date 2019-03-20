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
public class verPagoController {

    /*LLAMAMOS AL CONTROLADOR DE VER PAGO E INICIAMOS EL START.HTM Y CREAMOS UN NUEVO MODELO VISTA QUE LLAMA A verdireccionView.JSP Y NOS LO MUESTRA
    EN CASO DE QUE NO EXISTA Y SALTE LA EXCEPCION*/
    @RequestMapping("/verPagoController/start.htm")
    public ModelAndView start(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        ModelAndView mv = new ModelAndView("verPagoView");

        return mv;
    }
    
    /******** MENU PRINCIPAL PARA VER MODIFICAR PAGO HTM *********/
     @RequestMapping("/verPagoController/startPago.htm")
    public ModelAndView starModificarEntidad(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        ModelAndView mv = new ModelAndView("modificarPagoView");

        return mv;
    }

    /* MUESTRA LA LISTA DE TODAS LOS METODOS DE PAGO CON LOS BOTONES ELIMINAR/MODIFICAR*/
    @RequestMapping("/verPagoController/verPago.htm")
    @ResponseBody
    public String verPago(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        EntidadPago resourceLoad = new EntidadPago();

        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";

        //CREAMOS UN ARRAY
        ArrayList<String> arrayTipo = new ArrayList<>();

        /*CODIGO PARA VER UN METODO DE PAGO*/
        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();

            Statement sentencia = con.createStatement();
            rs = sentencia.executeQuery("select e.id_entidad, e.nombre_entidad, m.id_metodo_pago, m.titular_cuenta, m.nombre_banco from entidad e inner join metodo_pago m \n"
                    + "on e.id_entidad = m.id_entidad WHERE m.activado = 'TRUE' order by e.nombre_entidad");

            while (rs.next()) {
                arrayTipo.add(new Gson().toJson(new EntidadPago(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5))));
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
    
    
    
    
    /* CREAMOS CONSULTA PARA MOSTRAR LOS DATOS DE LOS METODOS DE PAGO EN MODIFICAR METODO DE PAGO. ES LA VENTANA CON TODOS LOS CAMPOS COMPLETADOS */
    @RequestMapping("/verPagoController/modificarPago.htm")
    @ResponseBody
    /*CREAMOS UNA CLASE QUE NO TIENE REQUEST PORQUE NO ESTAMOS ESPERANDO LOS DATOS DE NINGUNA PETICION*/
    public String verModificarPago(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        /*CREAMOS UN OBJETO DEL TIPO ENTIDAD */
        EntidadPago resourceLoad = new EntidadPago();

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
        
            stAux = con.prepareStatement("SELECT e.distinct_code, e.nombre_entidad, p.numero_cuenta, p.titular_cuenta, p.nombre_banco, p.direccion_banco, p.localidad, p.pais, p.codigo1, p.codigo2,"
                    + "p.tarjeta_credito, p.titular_tarjeta, p.mes_caducidad, p.anio_caducidad, p.codigo_csc, p.cuenta_paypal, p.correo_paypal, p.cheque"
                    + " FROM entidad e inner join metodo_pago p on e.id_entidad = p.id_entidad where e.id_entidad = ?  ");
            
            stAux.setInt(1, idEnt);
            rs = stAux.executeQuery();
            
            /*MIENTRAS QUE TENGAMOS REGISTRO, CADA REGISTRO DEL rs LO CONVERTIMOS A STRING CON JSON
            Y LO GUARDAMOS EN EL ARRAY DECLARADO ARRIBA
             */
            while (rs.next()) {

                arrayEntidad.add(new Gson().toJson(new EntidadPago(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8),
                rs.getString(9), rs.getString(10), rs.getString(11), rs.getString(12), rs.getString(13), rs.getString(14), rs.getString(15), rs.getString(16),rs.getString(17),rs.getString(18))));
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
