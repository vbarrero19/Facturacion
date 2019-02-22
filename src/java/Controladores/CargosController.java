
package Controladores;

import Modelo.*;
import com.google.gson.Gson;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.sql.Connection;
import java.util.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class CargosController {

    @RequestMapping("/cargosController/start.htm")
    public ModelAndView start(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        ModelAndView mv = new ModelAndView("cargosView");

        return mv;
    }

    @RequestMapping("/cargosController/addResources.htm")
    @ResponseBody
    public ModelAndView addResources(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {

        return null;
    }

    @RequestMapping("/cargosController/nuevoCargo.htm")
    @ResponseBody
    public String nuevoCargo(@RequestBody Cargos cargos, HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        Cargos resourceLoad = new Cargos();

        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";

        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();

            stAux = con.prepareStatement("INSERT INTO cargos (id_item, abreviatura, descripcion, id_tipo_item, cuenta, importe, cantidad, "
                    + "  impuesto, total, fecha_cargo, fecha_vencimiento, estado, id_factura, id_cliente, id_empresa, valor_impuesto)"
                    + " VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");            
  
            
            
            stAux.setInt(1, Integer.parseInt(cargos.getId_item()));
            stAux.setString(2, cargos.getAbreviatura());
            stAux.setString(3, cargos.getDescripcion());
            stAux.setInt(4, 1); //Integer.parseInt(cargos.getId_tipo_item())); //Hacer una select para saber el id del tipo???
            stAux.setString(5, cargos.getCuenta());
            stAux.setDouble(6, Double.parseDouble(cargos.getImporte()));
            stAux.setDouble(7, Double.parseDouble(cargos.getCantidad()));
            stAux.setInt(8, Integer.parseInt(cargos.getImpuesto()));
            stAux.setInt(9, Integer.parseInt(cargos.getTotal()));
            

            String test = cargos.getFecha_cargo();
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date parsedDate = dateFormat.parse(test);
            Timestamp timestamp = new java.sql.Timestamp(parsedDate.getTime());

            stAux.setTimestamp(10, timestamp);

            String test2 = cargos.getFecha_vencimiento();
            SimpleDateFormat dateFormat2 = new SimpleDateFormat("yyyy-MM-dd");
            Date parsedDate2 = dateFormat2.parse(test2);
            Timestamp timestamp2 = new java.sql.Timestamp(parsedDate2.getTime());

            stAux.setTimestamp(11, timestamp2);
            
            stAux.setBoolean(12, true);            
            stAux.setInt(13, 0);
            
            stAux.setInt(14, Integer.parseInt(cargos.getId_cliente()));
            stAux.setInt(15, Integer.parseInt(cargos.getId_empresa()));
            
            stAux.setDouble(16, Double.parseDouble(cargos.getValor_impuesto()));
            

            stAux.executeUpdate();
            
            resp = "Correcto";

        } catch (SQLException ex) {
            resp = "incorrecto SQLException"; // ex.getMessage();
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

    //Se usa para cargar los datos del combo Clientes
    @RequestMapping("/cargosController/getEntidadCliente.htm")
    @ResponseBody
    public String cargarComboCliente(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        Entidades resourceLoad = new Entidades();

        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";

        ArrayList<String> arrayTipo = new ArrayList<>();

        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();

            Statement sentencia = con.createStatement();
            rs = sentencia.executeQuery("select e.id_entidad, e.distinct_code, e.nombre_entidad, e.nombre_contacto from entidad e inner join entidad_tipo_entidad t on e.id_entidad = t.id_entidad inner join"
                                        + " tipo_entidad te on t.id_tipo_entidad = te.id_tipo_entidad where upper(te.tipo_entidad) = upper('cliente')");
            
            while (rs.next()) { 
                arrayTipo.add(new Gson().toJson(new Entidades(rs.getString(1),rs.getString(2),rs.getString(3),rs.getString(4)))); 
            }

            resp = new Gson().toJson(arrayTipo);

        } catch (SQLException ex) {
            resp = "incorrecto SQLException"; // ex.getMessage();
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
    
    //Se usa al selleccionar algo en el combo Clientes
    @RequestMapping("/cargosController/getDatosEntidadCliente.htm")
    @ResponseBody
    public String cargarDatosCliente(@RequestBody Entidades entidades, HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
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

    //Se usa para cargar los datos del combo Empresas
    @RequestMapping("/cargosController/getEntidadEmpresa.htm")
    @ResponseBody
    public String cargarComboEmpresa(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        Entidades resourceLoad = new Entidades();

        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";

        ArrayList<String> arrayTipo = new ArrayList<>();

        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();

            Statement sentencia = con.createStatement();
            rs = sentencia.executeQuery("select e.id_entidad, e.distinct_code, e.nombre_entidad, e.nombre_contacto from entidad e inner join entidad_tipo_entidad t on e.id_entidad = t.id_entidad inner join"
                                        + " tipo_entidad te on t.id_tipo_entidad = te.id_tipo_entidad where upper(te.tipo_entidad) = upper('empresa')");

            while (rs.next()) {
                arrayTipo.add(new Gson().toJson(new Entidades(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4))));
            }

            resp = new Gson().toJson(arrayTipo);

        } catch (SQLException ex) {
            resp = "incorrecto SQLException"; // ex.getMessage();
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
    
    //Se usa al seleccionar algo en el combo Clientes
    @RequestMapping("/cargosController/getDatosEntidadEmpresa.htm")
    @ResponseBody
    public String cargarDatosEmpresa(@RequestBody Entidades entidades, HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
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
            resp = "incorrecto SQLException"; // ex.getMessage();
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
        
     //Se usa para cargar los datos del combo items
    @RequestMapping("/cargosController/getItem.htm")
    @ResponseBody
    public String cargarComboItem(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        Items resourceLoad = new Items();

        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";

        ArrayList<String> arrayTipo = new ArrayList<>();

        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();

            Statement sentencia = con.createStatement();
            //Podemos llevar solo los dos primeros campos
            rs = sentencia.executeQuery("SELECT id_item, abreviatura, descripcion, id_tipo_item, cuenta, importe, periodo FROM items ORDER BY abreviatura");

            while (rs.next()) {
                arrayTipo.add(new Gson().toJson(new Items(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7))));
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
    
    //Se usa al seleccionar algo en el combo Clientes
    @RequestMapping("/cargosController/getDatosItem.htm")
    @ResponseBody
    public String cargarDatosItem(@RequestBody Items items, HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        Items resourceLoad = new Items();

        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";

        ArrayList<String> arrayTipo = new ArrayList<>();

        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();
            
            stAux = con.prepareStatement("SELECT i.id_item, i.abreviatura, i.descripcion, t.item, i.cuenta, i.importe, i.periodo FROM items i\n" +
                                         "inner join tipo_item t on i.id_tipo_item = t.id_tipo_item WHERE id_item =  ?");
            
            stAux.setInt(1, Integer.parseInt(items.getId_item()));
            rs = stAux.executeQuery();

            while (rs.next()) {
                arrayTipo.add(new Gson().toJson(new Items(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4),rs.getString(5), rs.getString(6), rs.getString(7))));
            }

            resp = new Gson().toJson(arrayTipo);

        } catch (SQLException ex) {
            resp = "incorrecto SQLException"; // ex.getMessage();
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
    @RequestMapping("/cargosController/getTipoImpuesto.htm")
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
            
            rs = sentencia.executeQuery("SELECT id_tipo_impuesto, impuesto, valor, pais FROM tipo_impuesto ORDER BY impuesto");

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
    
    
}
