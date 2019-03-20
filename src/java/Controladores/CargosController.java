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
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Formatter;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.JOptionPane;
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

            String periodicidad = cargos.getPeriodicidad();
            if (periodicidad.equals("1")) {

                stAux = con.prepareStatement("INSERT INTO cargos (id_item, abreviatura, descripcion, id_tipo_item, cuenta, importe, cantidad, "
                        + "  impuesto, total, fecha_cargo, fecha_vencimiento, estado, id_factura, id_cliente, id_empresa, valor_impuesto, periodicidad)"
                        + " VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");

                stAux.setInt(1, Integer.parseInt(cargos.getId_item()));
                stAux.setString(2, cargos.getAbreviatura());
                stAux.setString(3, cargos.getDescripcion());
                stAux.setInt(4, Integer.parseInt(cargos.getId_tipo_item()));
                stAux.setString(5, cargos.getCuenta());

                //Quitamos decimales al importe
                Double importe = Double.parseDouble(cargos.getImporte());
                Double importeDecimales = Math.round(importe * 100d) / 100d;
                stAux.setDouble(6, importeDecimales);

                //Quitamos decimales a la cantidad
                Double cantidad = Double.parseDouble(cargos.getCantidad());
                Double cantidadDecimales = Math.round(cantidad * 100d) / 100d;
                stAux.setDouble(7, cantidadDecimales);

                stAux.setInt(8, Integer.parseInt(cargos.getImpuesto()));

                //Quitamos decimales al total
                Double total = Double.parseDouble(cargos.getTotal());
                Double totalDecimales = Math.round(total * 100d) / 100d;
                stAux.setDouble(9, totalDecimales);

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

                //Quitamos decimales al valor_impuesto
                Double valor = Double.parseDouble(cargos.getValor_impuesto());
                Double valorDecimales = Math.round(valor * 100d) / 100d;
                stAux.setDouble(16, valorDecimales);

                stAux.setInt(17, Integer.parseInt(cargos.getPeriodicidad()));

                stAux.executeUpdate();

            } else {

                String cadena = cargos.getFecha_cargo();
                String cadenaNew = cadena.substring(0, cadena.length() - 1);
                String[] parts = cadenaNew.split(",");

                for (int x = 0; x < parts.length; x++) {

                    stAux = con.prepareStatement("INSERT INTO cargos (id_item, abreviatura, descripcion, id_tipo_item, cuenta, importe, cantidad, "
                            + "  impuesto, total, fecha_cargo, fecha_vencimiento, estado, id_factura, id_cliente, id_empresa, valor_impuesto, periodicidad)"
                            + " VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");

                    stAux.setInt(1, Integer.parseInt(cargos.getId_item()));
                    stAux.setString(2, cargos.getAbreviatura());
                    stAux.setString(3, cargos.getDescripcion());
                    stAux.setInt(4, Integer.parseInt(cargos.getId_tipo_item()));
                    stAux.setString(5, cargos.getCuenta());

                    //Quitamos decimales al importe
                    Double importe = Double.parseDouble(cargos.getImporte());
                    Double importeDecimales = Math.round(importe * 100d) / 100d;
                    stAux.setDouble(6, importeDecimales);

                    //Quitamos decimales a la cantidad
                    Double cantidad = Double.parseDouble(cargos.getCantidad());
                    Double cantidadDecimales = Math.round(cantidad * 100d) / 100d;
                    stAux.setDouble(7, cantidadDecimales);

                    stAux.setInt(8, Integer.parseInt(cargos.getImpuesto()));

                    //Quitamos decimales al total
                    Double total = Double.parseDouble(cargos.getTotal());
                    Double totalDecimales = Math.round(total * 100d) / 100d;
                    stAux.setDouble(9, totalDecimales);

                    /**
                     * *****CODIGO PARA LAS FECHAS ********
                     */
                    String numeroMes = parts[x];
                    Formatter obj = new Formatter();
                    String valorMes = String.valueOf(obj.format("%02d", Integer.parseInt(numeroMes)));

//                    Date fechaActual = new Date();
//                    DateFormat formatoFecha = new SimpleDateFormat("yyyy-MM-dd");
//                    DateFormat formatoHora = new SimpleDateFormat("HH:mm:ss");

                    //Fecha actual desglosada:
                    Calendar fecha = Calendar.getInstance();
                    int ano = fecha.get(Calendar.YEAR);
                    //int mes = fecha.get(Calendar.MONTH) + 1;
                    int dia = fecha.get(Calendar.DAY_OF_MONTH);

                    
                    //String primerDia = String.valueOf(obj.format("%02d", dia));                    
                    String fechaCargo = ano + "-" + valorMes + "-01";// + primerDia;
                    
                    //Ultimo dia de mes
                    fecha.set(ano, (Integer.parseInt(valorMes) - 1), 1);
                    int ultimoDiaMes = fecha.getActualMaximum(Calendar.DAY_OF_MONTH);
                    String fechaVencimiento = ano + "-" + valorMes + "-" + ultimoDiaMes;
                    
                    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                    Date parsedDate = dateFormat.parse(fechaCargo);
                    Timestamp timestamp = new java.sql.Timestamp(parsedDate.getTime());

                    stAux.setTimestamp(10, timestamp);

                    //String test2 = cargos.getFecha_vencimiento();
                    SimpleDateFormat dateFormat2 = new SimpleDateFormat("yyyy-MM-dd");
                    Date parsedDate2 = dateFormat2.parse(fechaVencimiento);
                    Timestamp timestamp2 = new java.sql.Timestamp(parsedDate2.getTime());

                    stAux.setTimestamp(11, timestamp2);
                    
                    /*
                     * *****FIN CODIGO PARA LAS FECHAS ********
                     */
                    stAux.setBoolean(12, true);
                    stAux.setInt(13, 0);

                    stAux.setInt(14, Integer.parseInt(cargos.getId_cliente()));
                    stAux.setInt(15, Integer.parseInt(cargos.getId_empresa()));

                    //Quitamos decimales al valor_impuesto
                    Double valor = Double.parseDouble(cargos.getValor_impuesto());
                    Double valorDecimales = Math.round(valor * 100d) / 100d;
                    stAux.setDouble(16, valorDecimales);

                    stAux.setInt(17, Integer.parseInt(cargos.getPeriodicidad()));

                    stAux.executeUpdate();

                }

            }

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

    @RequestMapping("/cargosController/nuevoCargo2.htm")
    @ResponseBody
    public String nuevoCargo2(@RequestBody Resource resource, HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        Resource resourceLoad = new Resource();

        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;

        String resp = "correcto";

        try {

            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();

            String dato = resource.getCol1();

            String cadenaNew = dato.substring(0, dato.length() - 1);

            String[] parts = cadenaNew.split(",");

            int cont = 0;

            String cadena = "";

            for (int x = 0; x < parts.length; x++) {

                String numeroMes = parts[x];

                Formatter obj = new Formatter();

                String valorMes = String.valueOf(obj.format("%02d", Integer.parseInt(numeroMes)));

                cont++;

                Date fechaActual = new Date();
                DateFormat formatoFecha = new SimpleDateFormat("yyyy-MM-dd");

                DateFormat formatoHora = new SimpleDateFormat("HH:mm:ss");

                //Fecha actual desglosada:
                Calendar fecha = Calendar.getInstance();
                int ano = fecha.get(Calendar.YEAR);
                //int mes = fecha.get(Calendar.MONTH) + 1;
                int dia = fecha.get(Calendar.DAY_OF_MONTH);

                //Ultimo dia de mes
                fecha.set(2014, (Integer.parseInt(valorMes) - 1), 1);
                int ultimoDiaMes = fecha.getActualMaximum(Calendar.DAY_OF_MONTH);

                String fechaCargo = ano + "-" + valorMes + "-" + ultimoDiaMes;

                stAux = con.prepareStatement("insert into cargos (abreviatura) values('" + fechaCargo + "');");
                stAux.executeUpdate();

            }
            cadena = Integer.toString(cont);

            resp = cadena; //parts[0];

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
            rs = sentencia.executeQuery("SELECT id_item, abreviatura, descripcion, id_tipo_item, importe, estado, id_cuenta, costes FROM items where estado = 0 ORDER BY abreviatura");

            while (rs.next()) {
                arrayTipo.add(new Gson().toJson(new Items(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8))));
            }

            resp = new Gson().toJson(arrayTipo);

        } catch (SQLException ex) {
            resp = "incorrecto SQLException -> " + ex;
            StringWriter errors = new StringWriter();
            ex.printStackTrace(new PrintWriter(errors));
        } catch (Exception ex) {
            resp = "incorrecto -> " + ex;
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

    //Se usa al seleccionar algo en el combo Items
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

            stAux = con.prepareStatement("SELECT i.id_item, i.abreviatura, i.descripcion, i.id_tipo_item, i.importe, i.estado, i.id_cuenta, i.costes FROM items i\n"
                    + "inner join tipo_item t on i.id_tipo_item = t.id_tipo_item WHERE id_item =  ?");

            stAux.setInt(1, Integer.parseInt(items.getId_item()));
            rs = stAux.executeQuery();

            while (rs.next()) {
                arrayTipo.add(new Gson().toJson(new Items(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8))));
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

    //Se usa al seleccionar algo en el combo Items
    @RequestMapping("/cargosController/cargarTipoItem.htm")
    @ResponseBody
    public String cargarTipoItem(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
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

            stAux = con.prepareStatement("SELECT id_tipo_item, item FROM tipo_item");

            rs = stAux.executeQuery();

            while (rs.next()) {
                arrayTipo.add(new Gson().toJson(new Resource(rs.getString(1), rs.getString(2))));
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

}
