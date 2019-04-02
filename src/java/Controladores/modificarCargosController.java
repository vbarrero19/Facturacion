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
public class modificarCargosController {

    /*llamamos al controlador de entidades e iniciamos el start.htm y creamos un nuevo modelo vista que llama a entidadesView.jsp y nos lo muestra
    en caso de que no exista y salte la excepcion*/
    @RequestMapping("/modificarCargosController/start.htm")
    public ModelAndView start(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        ModelAndView mv = new ModelAndView("modificarCargosView");

        return mv; 
    }

    @RequestMapping("/modificarCargosController/addResources.htm")
    @ResponseBody
    public ModelAndView addResources(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {

        return null;
    }

    /*Cargamos datos del cliente*/
    @RequestMapping("/modificarCargosController/getEntidadCliente.htm")
    @ResponseBody
    public String cargarDatosCliente(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {

        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";

        String idCliente = hsr.getParameter("idCli");
        ArrayList<String> arrayTipoEntidad = new ArrayList<>();

        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();

            Statement sentencia = con.createStatement();
            rs = sentencia.executeQuery("select id_entidad, distinct_code, nombre_entidad, nombre_contacto from entidad where id_entidad = '" + idCliente + "'");

            while (rs.next()) {
                arrayTipoEntidad.add(new Gson().toJson(new Resource(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4))));
            }

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

        return resp;

    }

    /*Cargamos datos del cliente*/
    @RequestMapping("/modificarCargosController/getEntidadEmpresa.htm")
    @ResponseBody
    public String cargarDatosEmpresa(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {

        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";

        String idEmpresa = hsr.getParameter("idEmp");
        ArrayList<String> arrayTipoEntidad = new ArrayList<>();

        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();

            Statement sentencia = con.createStatement();
            rs = sentencia.executeQuery("select id_entidad, distinct_code, nombre_entidad, nombre_contacto from entidad where id_entidad = '" + idEmpresa + "'");

            while (rs.next()) {
                arrayTipoEntidad.add(new Gson().toJson(new Resource(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4))));
            }

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

        return resp;

    }

    /*Cargamos datos del cliente*/
    @RequestMapping("/modificarCargosController/getCargo.htm")
    @ResponseBody
    public String cargarDatosCargo(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {

        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";

        String idCargo = hsr.getParameter("idCar");
        ArrayList<String> arrayTipoEntidad = new ArrayList<>();

        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();

            Statement sentencia = con.createStatement();
            rs = sentencia.executeQuery("select c.id_cargo, c.abreviatura, c.descripcion, t.item, c.cuenta, c.importe, c.cantidad, c.impuesto, c.valor_impuesto,"
            + " c.total, c.periodicidad, c.fecha_cargo, c.fecha_vencimiento from cargos c inner join tipo_item t on c.id_tipo_item = t.id_tipo_item where id_cargo = '" + idCargo + "'");

            while (rs.next()) {
                arrayTipoEntidad.add(new Gson().toJson(new Resource(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6),
                                                rs.getString(7), rs.getString(8), rs.getString(9), rs.getString(10), rs.getString(11), rs.getString(12), rs.getString(13))));
            }

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

        return resp;

    }
    
    //Se usa para cargar los datos del combo TipoImpuesto
    @RequestMapping("/modificarCargosController/getTipoImpuesto.htm")
    @ResponseBody
    public String cargarComboTipoImpuesto(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        TipoImpuesto resourceLoad = new TipoImpuesto();

        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";

        ArrayList<String> arrayTipo = new ArrayList<>();

        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();

            Statement sentencia = con.createStatement();
            
            rs = sentencia.executeQuery("SELECT id_tipo_impuesto, impuesto, valor, pais FROM tipo_impuesto ORDER BY id_tipo_impuesto");

            while (rs.next()) {
                arrayTipo.add(new Gson().toJson(new TipoImpuesto(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4))));
            }

            resp = new Gson().toJson(arrayTipo);

        } catch (SQLException ex) {
            resp = "incorrecto SQLException"; 
            StringWriter errors = new StringWriter();
            ex.printStackTrace(new PrintWriter(errors));
        } catch (Exception ex) {
            resp = "incorrecto";
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
    
    //Se usa para modificar cargos
    @RequestMapping("/modificarCargosController/modificarCargo.htm")
    @ResponseBody
    public String modificarCargo(@RequestBody Cargos cargos, HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        Cargos resourceLoad = new Cargos();

        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";

        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();

            int cargo = Integer.parseInt(cargos.getId_cargo());
            String cuenta = cargos.getCuenta();
            Double importe = Double.parseDouble(cargos.getImporte());
            Double cantidad = Double.parseDouble(cargos.getCantidad());
            int impuesto = Integer.parseInt(cargos.getImpuesto());
            Double total = Double.parseDouble(cargos.getTotal());
            
            String test = cargos.getFecha_cargo();
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date parsedDate = dateFormat.parse(test);
            Timestamp timestamp = new java.sql.Timestamp(parsedDate.getTime());

            //stAux.setTimestamp(10, timestamp);

            String test2 = cargos.getFecha_vencimiento();
            SimpleDateFormat dateFormat2 = new SimpleDateFormat("yyyy-MM-dd");
            Date parsedDate2 = dateFormat2.parse(test2);
            Timestamp timestamp2 = new java.sql.Timestamp(parsedDate2.getTime());

            //stAux.setTimestamp(11, timestamp2);
            
            Double valorImpuesto = Double.parseDouble(cargos.getValor_impuesto());            
  
            stAux = con.prepareStatement("UPDATE cargos SET cuenta = '"+cuenta+"', importe = '"+importe+"', cantidad = '"+cantidad+"', impuesto = '"+impuesto+"', total = '"+total+"', fecha_cargo = '"+timestamp+"', fecha_vencimiento ='"+timestamp2+"', valor_impuesto= '"+valorImpuesto +"' where id_cargo = '"+cargo+"'");     

            stAux.executeUpdate();
            
            resp = "Correcto";

        } catch (SQLException ex) {
            resp = "incorrecto SQLException -> " + ex; // ex.getMessage();
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
        return resp;
    }

    //Se usa para llenar el combo cuentas
    @RequestMapping("/modificarCargosController/cargarCuentas.htm")
    @ResponseBody
    public String cargarCuentas(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        Resource resourceLoad = new Resource();

        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";

        ArrayList<String> arrayTipo = new ArrayList<>();

        //int idCliente = Integer.parseInt(hsr.getParameter("idCliente"));
        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();

            stAux = con.prepareStatement("SELECT id_cuenta, cuenta FROM cuentas where estado = 'Si'");

            rs = stAux.executeQuery();

            while (rs.next()) {
                arrayTipo.add(new Gson().toJson(new Resource(rs.getString(1), rs.getString(2))));
            }

            resp = new Gson().toJson(arrayTipo);

        } catch (SQLException ex) {
            resp = "incorrecto SQLException ->" + ex; // ex.getMessage();
            StringWriter errors = new StringWriter();
            ex.printStackTrace(new PrintWriter(errors));
        } catch (Exception ex) {
            resp = "incorrecto ->" + ex; // ex.getMessage();
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
