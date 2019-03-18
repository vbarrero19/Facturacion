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
public class verFacturasController {

    @RequestMapping("/verFacturasController/startActivas.htm")
    public ModelAndView startActivas(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        ModelAndView mv = new ModelAndView("verFacturasActivasView");

        return mv;
    }

    @RequestMapping("/verFacturasController/startArchivadas.htm")
    public ModelAndView startArchivadas(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        ModelAndView mv = new ModelAndView("verFacturasArchivadasView");

        return mv;
    }

    //Mostramos una factura en detalle en la pagina verDetalleFacturaView
    @RequestMapping("/verFacturasController/verDetalleFactura.htm")
    public ModelAndView starVerDetalleFactura(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        ModelAndView mv = new ModelAndView("verDetalleFacturaView");

        return mv;
    }

    @RequestMapping("/verFacturasController/verDetalleFacturaArchivada.htm")
    public ModelAndView starVerDetalleFacturaArchivada(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        ModelAndView mv = new ModelAndView("verDetalleFacturaArchivadaView");

        return mv;
    }

    @RequestMapping("/verFacturasController/addResources.htm")
    @ResponseBody
    public ModelAndView addResources(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {

        return null;
    }

    /*CARGAMOS EL COMBO PARA VER LAS EMPRESAS*/
    @RequestMapping("/verFacturasController/getVerEntidad.htm")
    @ResponseBody
    public String cargarComboVerEntidad(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        /*CREAMOS UN OBJETO DEL TIPO ENTIDAD */
        //Entidades resourceLoad = new Entidades();

        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";

        //Recuperamos parametrode la URL para saber si piden clietes con facturas activas o archivadas
        String estado = hsr.getParameter("estado");
        
        //Creamos un array list de tipo String donde guardamos los resultados de la busqueda
        //y lo enviamos con JSON. EL resultado son objetos de tipoEntidad convertidos en String por el JSON.
        ArrayList<String> arrayTipoEntidad = new ArrayList<>();

        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();
            /*CREAMOS LA CONSULTA PREPARADA Y LO GUARDAMOS EN rs*/
            Statement sentencia = con.createStatement();
            if (estado.equals("activa")) {
                rs = sentencia.executeQuery("select e.id_entidad, e.distinct_code, e.nombre_entidad, e.nombre_contacto from entidad e inner join entidad_tipo_entidad t"
                        + " on e.id_entidad = t.id_entidad inner join tipo_entidad te on t.id_tipo_entidad = te.id_tipo_entidad "
                        + "where upper(te.tipo_entidad) = upper('cliente') and e.id_entidad in (select distinct id_cliente from facturas where archivada = 0)");

            } else if (estado.equals("archivada")){

                rs = sentencia.executeQuery("select e.id_entidad, e.distinct_code, e.nombre_entidad, e.nombre_contacto from entidad e inner join entidad_tipo_entidad t"
                        + " on e.id_entidad = t.id_entidad inner join tipo_entidad te on t.id_tipo_entidad = te.id_tipo_entidad "
                        + "where upper(te.tipo_entidad) = upper('cliente') and e.id_entidad in (select distinct id_cliente from facturas where archivada = 1 and anulada = 0)");
            }

            /*MIENTRAS QUE TENGAMOS REGISTRO, CADA REGISTRO DEL rs LO CONVERTIMOS A STRING CON JSON
            Y LO GUARDAMOS EN EL ARRAY DECLARADO ARRIBA
             */
            while (rs.next()) {
                arrayTipoEntidad.add(new Gson().toJson(new Entidades(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4))));
            }
            /*CONVERTIMOS EL ARRAY DE STRING EN UN STRING Y LO GUARDAMOS EN LA VARIABLE RESP QUE DEVOLVEREMOS AL JSP*/
            resp = new Gson().toJson(arrayTipoEntidad);

        } catch (SQLException ex) {
            resp = "incorrecto SQL -> " + ex; //
            StringWriter errors = new StringWriter();
            ex.printStackTrace(new PrintWriter(errors));

        } catch (Exception ex) {
            resp = "incorrecto -> " + ex; // ex.getMessage();
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

    //Cargamos los datos en los input cuando seleccionamos una opcion del combo
    @RequestMapping("/verFacturasController/getDatosEntidad.htm")
    @ResponseBody
    public String cargarDatosEntidad(@RequestBody Entidades entidades, HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        Entidades resourceLoad = new Entidades();

        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";

        ArrayList<String> arrayTipo = new ArrayList<>();

        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();

            stAux = con.prepareStatement("SELECT id_entidad, distinct_code, nombre_entidad, nombre_contacto FROM entidad WHERE id_entidad = ?");

            stAux.setInt(1, Integer.parseInt(entidades.getId_entidad()));
            rs = stAux.executeQuery();

            while (rs.next()) {
                arrayTipo.add(new Gson().toJson(new Entidades(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4))));
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

//Cargamos los datos en los input cuando seleccionamos el cliente en el combo y mostramos los datos de todas las facturas.
    @RequestMapping("/verFacturasController/getDatosFactura.htm")
    @ResponseBody
    public String cargarDatosFactura(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        Resource resourceLoad = new Resource();

        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";
        /*recogemos el valor del parametro pasado por url desde el jsp, lo recogemos con hsr.getParameter("idCliente")
         */
        int idCliente = Integer.parseInt(hsr.getParameter("idCliente"));

        ArrayList<String> arrayTipo = new ArrayList<>();

        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();

            stAux = con.prepareStatement("SELECT f.id_factura, f.id_cliente, en.distinct_code, f.id_empresa, e.distinct_code, f.total_factura, f.fecha_emision, f.fecha_vencimiento, ef.estado FROM facturas f inner join \n"
                    + "entidad e on f.id_empresa = e.id_entidad inner join tipo_estado_factura ef on f.id_estado = ef.id_estado inner join entidad en on f.id_cliente = en.id_entidad\n"
                    + "WHERE archivada = 0 and id_cliente = ? order by f.fecha_emision");

            stAux.setInt(1, idCliente);
            rs = stAux.executeQuery();

            while (rs.next()) {
                arrayTipo.add(new Gson().toJson(new Resource(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8), rs.getString(9))));
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

    //Cargamos los datos en los input cuando seleccionamos el cliente en el combo y mostramos los datos de todas las facturas.
    @RequestMapping("/verFacturasController/getDatosFacturaArchivadas.htm")
    @ResponseBody
    public String cargarDatosFacturaArchivadas(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        Resource resourceLoad = new Resource();

        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";
        /*recogemos el valor del parametro pasado por url desde el jsp, lo recogemos con hsr.getParameter("idCliente")
         */
        int idCliente = Integer.parseInt(hsr.getParameter("idCliente"));

        ArrayList<String> arrayTipo = new ArrayList<>();

        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();

            stAux = con.prepareStatement("SELECT f.id_factura, f.id_cliente, en.distinct_code, f.id_empresa, e.distinct_code, f.total_factura, f.fecha_emision, f.fecha_vencimiento, ef.estado FROM facturas f inner join \n"
                    + "entidad e on f.id_empresa = e.id_entidad inner join tipo_estado_factura ef on f.id_estado = ef.id_estado inner join entidad en on f.id_cliente = en.id_entidad\n"
                    + "WHERE archivada = 1 and anulada = 0 and id_cliente = ? order by f.fecha_emision");

            stAux.setInt(1, idCliente);
            rs = stAux.executeQuery();

            while (rs.next()) {
                arrayTipo.add(new Gson().toJson(new Resource(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8), rs.getString(9))));
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

    //Se utiliza para cargar los datos de la empresa en la pagina verDetalleFacturaView
    @RequestMapping("/verFacturasController/cargarEmpresa.htm")
    @ResponseBody
    public String cargarEmpresa(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        Resource resourceLoad = new Resource();

        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";

        /*recogemos los valores de los parametros pasados por url desde el jsp, lo recogemos con hsr.getParameter("empresa")   */
        int idEmpresa = Integer.parseInt(hsr.getParameter("empresa"));

        ArrayList<String> arrayTipo = new ArrayList<>();

        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();

            stAux = con.prepareStatement("SELECT id_entidad, nombre_entidad, tratamiento, nombre_contacto, apellido1 FROM entidad WHERE id_entidad = ?");

            stAux.setInt(1, idEmpresa);
            rs = stAux.executeQuery();

            while (rs.next()) {
                arrayTipo.add(new Gson().toJson(new Resource(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5))));
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

    @RequestMapping("/verFacturasController/cargarCliente.htm")
    @ResponseBody
    public String cargarCliente(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        Resource resourceLoad = new Resource();

        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";

        /*recogemos los valores de los parametros pasados por url desde el jsp, lo recogemos con hsr.getParameter("cliente")   */
        int idCliente = Integer.parseInt(hsr.getParameter("cliente"));

        ArrayList<String> arrayTipo = new ArrayList<>();

        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();

            stAux = con.prepareStatement("SELECT id_entidad, nombre_entidad, tratamiento, nombre_contacto, apellido1 FROM entidad WHERE id_entidad = ?");

            stAux.setInt(1, idCliente);
            rs = stAux.executeQuery();

            while (rs.next()) {
                arrayTipo.add(new Gson().toJson(new Resource(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5))));
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

    //Carga los datos de la factura en detalle factura
    @RequestMapping("/verFacturasController/cargarFactura.htm")
    @ResponseBody
    public String cargarFactura(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        Facturas resourceLoad = new Facturas();

        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";

        /*recogemos el valor del parametro pasado por url desde el jsp, lo recogemos con hsr.getParameter("factura") */
        int idFact = Integer.parseInt(hsr.getParameter("factura"));

        ArrayList<String> arrayTipo = new ArrayList<>();

        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();

            stAux = con.prepareStatement("SELECT id_factura, id_cliente, id_empresa, total_factura, fecha_emision, fecha_vencimiento, id_estado, archivada, anulada FROM facturas WHERE id_factura = ?");

            stAux.setInt(1, idFact);
            rs = stAux.executeQuery();

            while (rs.next()) {
                arrayTipo.add(new Gson().toJson(new Facturas(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8), rs.getString(9))));
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

    //Carga los datos de los cargos en detalle factura
    @RequestMapping("/verFacturasController/cargarCargos.htm")
    @ResponseBody
    public String cargarCargos(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        Resource resourceLoad = new Resource();

        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";

        /*recogemos el valor del parametro pasado por url desde el jsp, lo recogemos con hsr.getParameter("factura") */
        int idFact = Integer.parseInt(hsr.getParameter("factura"));

        ArrayList<String> arrayTipo = new ArrayList<>();

        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();

            stAux = con.prepareStatement("SELECT id_cargo, abreviatura, cuenta, importe, cantidad, valor_impuesto, total FROM cargos WHERE id_factura = ?");

            stAux.setInt(1, idFact);
            rs = stAux.executeQuery();

            while (rs.next()) {
                arrayTipo.add(new Gson().toJson(new Resource(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7))));
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

    //Se utiliza para cargar los datos de la empresa en la pagina verDetalleFacturaView
    @RequestMapping("/verFacturasController/archivarFactura.htm")
    @ResponseBody
    public String archivarFactura(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        Resource resourceLoad = new Resource();

        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";

        /*recogemos los valores de los parametros pasados por url desde el jsp, lo recogemos con hsr.getParameter("empresa")   */
        int idFactura = Integer.parseInt(hsr.getParameter("factura"));

        ArrayList<String> arrayTipo = new ArrayList<>();

        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();

            stAux = con.prepareStatement("UPDATE facturas set archivada = 1 WHERE id_factura = ?");

            stAux.setInt(1, idFactura);
            int afectados = stAux.executeUpdate();

            if (afectados == 1) {
                resp = "Factura archivada";
            }

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
    
    //Se utiliza para cargar los datos de la empresa en la pagina verDetalleFacturaView
    @RequestMapping("/verFacturasController/anularFactura.htm")
    @ResponseBody
    public String anularFactura(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        Resource resourceLoad = new Resource();

        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";

        /*recogemos los valores de los parametros pasados por url desde el jsp, lo recogemos con hsr.getParameter("empresa")   */
        int idFactura = Integer.parseInt(hsr.getParameter("factura"));

        ArrayList<String> arrayTipo = new ArrayList<>();

        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();

            stAux = con.prepareStatement("UPDATE facturas set archivada = 1, anulada = 1 WHERE id_factura = ?");                   

            stAux.setInt(1, idFactura);
            int afectados = stAux.executeUpdate();
            
            stAux = con.prepareStatement("update cargos set id_factura = 0 where id_factura = ?");   
            stAux.setInt(1, idFactura);
            int afectados2 = stAux.executeUpdate();

            if (afectados == 1 && afectados2 > 0) {
                resp = "Factura anulada";
            }

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
    
    @RequestMapping("/verFacturasController/getDatosEstado.htm")
    @ResponseBody
    public String getDatosEstado(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        Resource resourceLoad = new Resource();

        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";        

        ArrayList<String> arrayTipo = new ArrayList<>();

        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();
            
            Statement sentencia = con.createStatement();
            rs = sentencia.executeQuery("SELECT id_estado, estado FROM tipo_estado_factura order by id_estado");   
            
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
    
    //Se utiliza para cargar los tipos de estados de las facturas en el modal
    @RequestMapping("/verFacturasController/cambiarEstado.htm")
    @ResponseBody
    public String cambiarEstado(@RequestBody Resource resource, HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        Resource resourceLoad = new Resource();

        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";

        ArrayList<String> arrayTipo = new ArrayList<>();

        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();

            stAux = con.prepareStatement("UPDATE facturas set id_estado = ? WHERE id_factura = ?");

            stAux.setInt(1, Integer.parseInt(resource.getCol2()));            
            stAux.setInt(2, Integer.parseInt(resource.getCol1()));                 
            
            int afectados = stAux.executeUpdate();

            if (afectados == 1) {
                resp = "correcto " + resource.getCol2();
            }

        } catch (SQLException ex) {
            resp = "incorrecto SQL -> " + ex; // ex.getMessage();
            StringWriter errors = new StringWriter();
            ex.printStackTrace(new PrintWriter(errors));
        } catch (Exception ex) {
            resp = "incorrecto" + ex; // ex.getMessage();
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
    
    //Se utiliza para refrescar el estado en verDetalleFactura
    @RequestMapping("/verFacturasController/refrescarEstado.htm")
    @ResponseBody
    public String refrescarEstado(@RequestBody Resource resource, HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        Resource resourceLoad = new Resource();

        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";

        ArrayList<String> arrayTipo = new ArrayList<>();

        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();
            
            
            stAux = con.prepareStatement("select estado from tipo_estado_factura where id_estado = ?");

            stAux.setInt(1, Integer.parseInt(resource.getCol2()));      
            rs = stAux.executeQuery();

            while (rs.next()) {
                arrayTipo.add(new Gson().toJson(new Resource(rs.getString(1))));
            }

            resp = new Gson().toJson(arrayTipo);            

        } catch (SQLException ex) {
            resp = "incorrecto SQL -> " + ex; // ex.getMessage();
            StringWriter errors = new StringWriter();
            ex.printStackTrace(new PrintWriter(errors));
        } catch (Exception ex) {
            resp = "incorrecto" + ex; // ex.getMessage();
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
