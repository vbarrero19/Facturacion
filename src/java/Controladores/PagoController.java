/**
 *
 * @author vbarr
 */
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
public class PagoController {

    /*LLAMAMOS AL CONTROLADOR DE PAGO E INICIAMOS EL START.HTM Y CREAMOS UN NUEVO MODELO VISTA QUE LLAMA A PAGOVIEW.JSP Y NOS LO MUESTRA
    EN CASO DE QUE NO EXISTA Y SALTE LA EXCEPCION*/
    @RequestMapping("/pagoController/start.htm")
    public ModelAndView start(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        ModelAndView mv = new ModelAndView("pagoView");

        return mv;
    }

    @RequestMapping("/pagoController/addResources.htm")
    @ResponseBody
    public ModelAndView addResources(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {

        return null;
    }

     @RequestMapping("/pagoController/startPago.htm")
    public ModelAndView starModificarEntidad(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        ModelAndView mv = new ModelAndView("modificarPagoView");

        return mv;
    }
    
    //GUARDAMOS UNA NUEVA DIRECCION EN LA BASE DE DATOS.
    @RequestMapping("pagoController/nuevoPago.htm")
    @ResponseBody
    public String nuevoPago(@RequestBody Pago pago, HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        Pago resourceLoad = new Pago();

        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";

        //recogemos el valor del idEnt y lo guardamos en la base de datos.
        String idEntidad = hsr.getParameter("idEnt");

        /*CODIGO PARA AÑADIR UN NUEVO METODO DE PAGO*/
        try {
            /*REALIZAMOS LA CONEXION A LA BASE DE DATOS.*/
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();

            /*REALIZAMOS LA CONSULTA PREPARADA PARA EL NUEVO METODO DE PAGO*/
            stAux = con.prepareStatement("INSERT INTO METODO_PAGO (id_entidad, numero_cuenta, codigo1, codigo2, titular_cuenta, tarjeta_credito, mes_caducidad, anio_caducidad, tipo_tarjeta,"
                    + "codigo_csc, titular_tarjeta, cuenta_paypal, correo_paypal, cheque, nombre_banco, direccion_banco, localidad, pais, activado)"+
                    "VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");


            /*VAMOS GUARDANDO LOS VALORES EN LA BASE DE DATOS  Y CONVIRTIENDO LOS QUE NO SEAN STRING) */            
            
            stAux.setInt(1, Integer.parseInt(idEntidad));
            stAux.setString(2, pago.getNumero_cuenta());
            stAux.setString(3, pago.getCodigo1());
            stAux.setString(4, pago.getCodigo2());
            stAux.setString(5, pago.getTitular_cuenta());
            stAux.setString(6, pago.getTarjeta_credito());
            stAux.setString(7, pago.getMes_caducidad());
            stAux.setString(8, pago.getAnio_caducidad());
            stAux.setString(9, pago.getTipo_tarjeta());
            stAux.setString(10, pago.getCodigo_csc());
            stAux.setString(11, pago.getTitular_tarjeta());
            stAux.setString(12, pago.getCuenta_paypal());
            stAux.setString(13, pago.getCorreo_paypal());
            stAux.setString(14, pago.getCheque());
            stAux.setString(15, pago.getNombre_banco());
            stAux.setString(16, pago.getDireccion_banco());
            stAux.setString(17, pago.getLocalidad());
            stAux.setString(18, pago.getPais());
            stAux.setBoolean(19,true);
            

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

    /*CARGAMOS EL COMBO CON TODAS LAS ENTIDADES DE LA TABLA*/
    @RequestMapping("/pagoController/getVerEntidad.htm")
    @ResponseBody

    public String cargarComboVerEntidad(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        /*CREAMOS UN OBJETO DEL TIPO ENTIDAD */
        //Entidades resourceLoad = new Entidades();

        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "Alta metodo de pago correcta";

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
            resp = "incorrecto. Error consulta SQL"; //
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
    @RequestMapping("/pagoController/getDatosEntidad.htm")
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

    
         /**********************************************************************************/
    /*************** PARA ELIMINAR LOS METODOS DE PAGO EN VER/MODIFICAR PAGO ******************/
    /**********************************************************************************/
    
    
    
    /**CUANDO ELIMINAMOS UN METODO DE PAGO DE LA LISTA , ACTUALIZAMOS ACTIVADO Y LO PONEMOS A FALSE. 
     buscar preparestatement update y cambiar los datos de la funcion*/
    
    @RequestMapping("/pagoController/eliminarPago.htm")
    @ResponseBody
    public String eliminarPago(@RequestBody Resource resource, HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        Resource resourceLoad = new Resource();

        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";
     

        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();

            stAux = con.prepareStatement("update metodo_pago SET activado = ? where id_metodo_pago = ?");
            
            stAux.setBoolean(1,false);
            stAux.setInt(2, Integer.parseInt(resource.getCol2()));
            
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

}
