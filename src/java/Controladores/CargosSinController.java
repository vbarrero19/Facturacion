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
public class CargosSinController {

    @RequestMapping("/cargosSinController/start.htm")
    public ModelAndView start(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        ModelAndView mv = new ModelAndView("cargosSinView");

        return mv;
    }

    @RequestMapping("/cargosSinController/addResources.htm")
    @ResponseBody
    public ModelAndView addResources(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {

        return null;
    }

//    @RequestMapping("/cargosController/nuevoCargo.htm")
//    @ResponseBody
//    public String nuevoCargo(@RequestBody Cargos cargos, HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
//        Cargos resourceLoad = new Cargos();
//
//        Connection con = null;
//        ResultSet rs = null;
//        ResultSet rs2 = null;
//        ResultSet rs3 = null;
//        PreparedStatement stAux = null;
//        PreparedStatement stAux2 = null;
//
//        String resp = "correcto";
//
//        try {
//            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
//            con = pool_local.getConnection();
//
//            String periodicidad = cargos.getPeriodicidad();
//
//            //Comprobamos si tiene periodicidad o no
//            if (periodicidad.equals("1")) { //Sin periodicidad
//
//                stAux = con.prepareStatement("INSERT INTO cargos (id_item, abreviatura, descripcion, id_tipo_item, cuenta, importe, cantidad, "
//                        + "  impuesto, total, fecha_cargo, fecha_vencimiento, estado, id_factura, id_cliente, id_empresa, valor_impuesto, periodicidad, costes)"
//                        + " VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
//
//                stAux.setInt(1, Integer.parseInt(cargos.getId_item()));
//                stAux.setString(2, cargos.getAbreviatura());
//                stAux.setString(3, cargos.getDescripcion());
//                stAux.setInt(4, Integer.parseInt(cargos.getId_tipo_item()));
//                stAux.setInt(5, Integer.parseInt(cargos.getCuenta()));
//
//                //Quitamos decimales al importe
//                Double importe = Double.parseDouble(cargos.getImporte());
//                Double importeDecimales = Math.round(importe * 100d) / 100d;
//                stAux.setDouble(6, importeDecimales);
//
//                //Quitamos decimales a la cantidad
//                Double cantidad = Double.parseDouble(cargos.getCantidad());
//                Double cantidadDecimales = Math.round(cantidad * 100d) / 100d;
//                stAux.setDouble(7, cantidadDecimales);
//
//                stAux.setInt(8, Integer.parseInt(cargos.getImpuesto()));
//
//                //Quitamos decimales al total
//                Double total = Double.parseDouble(cargos.getTotal());
//                Double totalDecimales = Math.round(total * 100d) / 100d;
//                stAux.setDouble(9, totalDecimales);
//
//                String test = cargos.getFecha_cargo();
//                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
//                Date parsedDate = dateFormat.parse(test);
//                Timestamp timestamp = new java.sql.Timestamp(parsedDate.getTime());
//
//                stAux.setTimestamp(10, timestamp);
//
//                String test2 = cargos.getFecha_vencimiento();
//                SimpleDateFormat dateFormat2 = new SimpleDateFormat("yyyy-MM-dd");
//                Date parsedDate2 = dateFormat2.parse(test2);
//                Timestamp timestamp2 = new java.sql.Timestamp(parsedDate2.getTime());
//
//                stAux.setTimestamp(11, timestamp2);
//
//                stAux.setBoolean(12, true);
//                stAux.setInt(13, 0);
//
//                stAux.setInt(14, Integer.parseInt(cargos.getId_cliente()));
//                stAux.setInt(15, Integer.parseInt(cargos.getId_empresa()));
//
//                //Quitamos decimales al valor_impuesto
//                Double valor = Double.parseDouble(cargos.getValor_impuesto());
//                Double valorDecimales = Math.round(valor * 100d) / 100d;
//                stAux.setDouble(16, valorDecimales);
//
//                stAux.setInt(17, Integer.parseInt(cargos.getPeriodicidad()));
//                stAux.setString(18, cargos.getCostes());
//
//                int afect = stAux.executeUpdate();
//
//                resp = "Cargo sin periodicidad";
//
//                //Codigo para insertar costes
//                if (cargos.getCostes().equalsIgnoreCase("Si")) {
//                    //Insertamos el desglose de los costes
//                    Statement sentencia = con.createStatement();
//                    rs = sentencia.executeQuery("select max(id_cargo) from cargos");
//                    rs.next();
//                    int numCargo = rs.getInt(1);
//
//                    String idItem = cargos.getId_item();
//
//                    Statement sentencia2 = con.createStatement();
//                    rs2 = sentencia2.executeQuery("select id_item, id_entidad, cantidad from costes where id_item = '" + idItem + "'");
//
//                    while (rs2.next()) {
//
//                        int idEntidad = rs2.getInt(2);
//                        //Para insertar la cantidad adecuada multiplicamos el coste por la cantidad de items que se van a cargar                        
//                        int idCantidad = rs2.getInt(3);
//                        double cantidadTotal = cantidadDecimales * idCantidad;
//
//                        stAux2 = con.prepareStatement("INSERT INTO cargos_costes (id_cargo,id_entidad,cantidad) VALUES (?,?,?)");
//
//                        stAux2.setInt(1, numCargo);
//                        stAux2.setInt(2, idEntidad);
//                        stAux2.setDouble(3, cantidadTotal);
//
//                        stAux2.executeUpdate();
//
//                    }
//
//                    resp = resp + " y con costes";
//                }
//
//            } else { //Con periodicidad
//
//                String cadena = cargos.getFecha_cargo();
//                String cadenaNew = cadena.substring(0, cadena.length() - 1);
//                String[] parts = cadenaNew.split(",");
//
//                for (int x = 0; x < parts.length; x++) {
//
//                    stAux = con.prepareStatement("INSERT INTO cargos (id_item, abreviatura, descripcion, id_tipo_item, cuenta, importe, cantidad, "
//                            + "  impuesto, total, fecha_cargo, fecha_vencimiento, estado, id_factura, id_cliente, id_empresa, valor_impuesto, periodicidad, costes)"
//                            + " VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
//
//                    stAux.setInt(1, Integer.parseInt(cargos.getId_item()));
//                    stAux.setString(2, cargos.getAbreviatura());
//                    stAux.setString(3, cargos.getDescripcion());
//                    stAux.setInt(4, Integer.parseInt(cargos.getId_tipo_item()));
//                    stAux.setInt(5, Integer.parseInt(cargos.getCuenta()));
//
//                    //Quitamos decimales al importe
//                    Double importe = Double.parseDouble(cargos.getImporte());
//                    Double importeDecimales = Math.round(importe * 100d) / 100d;
//                    stAux.setDouble(6, importeDecimales);
//
//                    //Quitamos decimales a la cantidad
//                    Double cantidad = Double.parseDouble(cargos.getCantidad());
//                    Double cantidadDecimales = Math.round(cantidad * 100d) / 100d;
//                    stAux.setDouble(7, cantidadDecimales);
//
//                    stAux.setInt(8, Integer.parseInt(cargos.getImpuesto()));
//
//                    //Quitamos decimales al total
//                    Double total = Double.parseDouble(cargos.getTotal());
//                    Double totalDecimales = Math.round(total * 100d) / 100d;
//                    stAux.setDouble(9, totalDecimales);
//
//                    // CODIGO PARA LAS FECHAS 
//                    String numeroMes = parts[x];
//                    Formatter obj = new Formatter();
//                    String valorMes = String.valueOf(obj.format("%02d", Integer.parseInt(numeroMes)));
//
//                    //Fecha actual desglosada:
//                    Calendar fecha = Calendar.getInstance();
//                    int ano = fecha.get(Calendar.YEAR);
//                    //int mes = fecha.get(Calendar.MONTH) + 1;
//                    int dia = fecha.get(Calendar.DAY_OF_MONTH);
//
//                    //String primerDia = String.valueOf(obj.format("%02d", dia));                    
//                    String fechaCargo = ano + "-" + valorMes + "-01";// + primerDia;
//
//                    //Ultimo dia de mes
//                    fecha.set(ano, (Integer.parseInt(valorMes) - 1), 1);
//                    int ultimoDiaMes = fecha.getActualMaximum(Calendar.DAY_OF_MONTH);
//                    String fechaVencimiento = ano + "-" + valorMes + "-" + ultimoDiaMes;
//
//                    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
//                    Date parsedDate = dateFormat.parse(fechaCargo);
//                    Timestamp timestamp = new java.sql.Timestamp(parsedDate.getTime());
//
//                    stAux.setTimestamp(10, timestamp);
//
//                    //String test2 = cargos.getFecha_vencimiento();
//                    SimpleDateFormat dateFormat2 = new SimpleDateFormat("yyyy-MM-dd");
//                    Date parsedDate2 = dateFormat2.parse(fechaVencimiento);
//                    Timestamp timestamp2 = new java.sql.Timestamp(parsedDate2.getTime());
//
//                    stAux.setTimestamp(11, timestamp2);
//
//                    // FIN CODIGO PARA LAS FECHAS 
//                    stAux.setBoolean(12, true);
//                    stAux.setInt(13, 0);
//
//                    stAux.setInt(14, Integer.parseInt(cargos.getId_cliente()));
//                    stAux.setInt(15, Integer.parseInt(cargos.getId_empresa()));
//
//                    //Quitamos decimales al valor_impuesto
//                    Double valor = Double.parseDouble(cargos.getValor_impuesto());
//                    Double valorDecimales = Math.round(valor * 100d) / 100d;
//                    stAux.setDouble(16, valorDecimales);
//
//                    stAux.setInt(17, Integer.parseInt(cargos.getPeriodicidad()));
//
//                    stAux.setString(18, cargos.getCostes());
//
//                    stAux.executeUpdate();
//
//                    //Codigo para insertar costes
//                    if (cargos.getCostes().equalsIgnoreCase("Si")) {
//                        //Insertamos el desglose de los costes
//                        Statement sentencia = con.createStatement();
//                        rs = sentencia.executeQuery("select max(id_cargo) from cargos");
//                        rs.next();
//                        int numCargo = rs.getInt(1);
//
//                        String idItem = cargos.getId_item();
//
//                        Statement sentencia2 = con.createStatement();
//                        rs2 = sentencia2.executeQuery("select id_item, id_entidad, cantidad from costes where id_item = '" + idItem + "'");
//
//                        while (rs2.next()) {
//
//                            int idEntidad = rs2.getInt(2);
//
//                            //Para insertar la cantidad adecuada multiplicamos el coste por la cantidad de items que se van a cargar                        
//                            int idCantidad = rs2.getInt(3);
//                            double cantidadTotal = cantidadDecimales * idCantidad;
//
//                            stAux2 = con.prepareStatement("INSERT INTO cargos_costes (id_cargo,id_entidad,cantidad) VALUES (?,?,?)");
//
//                            stAux2.setInt(1, numCargo);
//                            stAux2.setInt(2, idEntidad);
//                            stAux2.setDouble(3, cantidadTotal);
//
//                            stAux2.executeUpdate();
//                        }
//                        resp = "Cargo con costes";
//                    }
//                }
//                resp = resp + " y con periodicidad";
//            }
//
//        } catch (SQLException ex) {
//            resp = "incorrecto SQLException -> " + ex; // ex.getMessage();
//            StringWriter errors = new StringWriter();
//            ex.printStackTrace(new PrintWriter(errors));
//        } catch (Exception ex) {
//            resp = "incorrecto -> " + ex; // ex.getMessage();
//            StringWriter errors = new StringWriter();
//            ex.printStackTrace(new PrintWriter(errors));
//        } finally {
//            try {
//                if (rs != null) {
//                    rs.close();
//                }
//            } catch (Exception e) {
//            }
//            try {
//                if (stAux != null) {
//                    stAux.close();
//                }
//            } catch (Exception e) {
//            }
//            try {
//                if (con != null) {
//                    con.close();
//                }
//            } catch (Exception e) {
//            }
//        }
//        return resp;
//    }

    //Se usa para cargar los datos del combo Clientes
    @RequestMapping("/cargosSinController/getEntidadCliente.htm")
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
    @RequestMapping("/cargosSinController/getDatosEntidadCliente.htm")
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


    //Se usa para cargar el combo tipoItem
    @RequestMapping("/cargosSinController/cargarTipoItem.htm")
    @ResponseBody
    public String cargarTipoItem(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        Resource resourceLoad = new Resource();

        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";

        ArrayList<String> arrayTipo = new ArrayList<>();
        
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

    //Se usa para llenar el combo cuentas
    @RequestMapping("/cargosSinController/cargarCuentas.htm")
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

    //Se usa para cargar los datos del combo TipoImpuesto
    @RequestMapping("/cargosSinController/getTipoImpuesto.htm")
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
    
        //Se usa para cargar los datos del combo Empresas
    @RequestMapping("/cargosSinController/getEntidadEmpresa.htm")
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




}
