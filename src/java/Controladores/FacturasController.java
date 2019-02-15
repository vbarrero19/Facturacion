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
import java.util.Iterator;
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
public class FacturasController {

    ArrayList<String> arrayCargos = new ArrayList<String>();
    String cadena = "";
    String cadenaNew = "";

    @RequestMapping("/facturasController/start.htm")
    public ModelAndView start(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        ModelAndView mv = new ModelAndView("facturasView");

        return mv;
    }

    @RequestMapping("/facturasController/addResources.htm")
    @ResponseBody
    public ModelAndView addResources(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {

        return null;
    }

    @RequestMapping("/facturasController/nuevaFactura.htm")
    @ResponseBody
    public String nuevaFactura(@RequestBody Facturas facturas, HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        Facturas resourceLoad = new Facturas();

        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";

        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();

            //Insertamos una nueva factura
            stAux = con.prepareStatement("INSERT INTO facturas (id_cliente, id_empresa, total_factura, fecha_emision, fecha_vencimiento)"
                    + " VALUES (?,?,?,?,?)");

            stAux.setInt(1, Integer.parseInt(facturas.getId_cliente()));
            stAux.setInt(2, Integer.parseInt(facturas.getId_empresa()));
            stAux.setDouble(3, Double.parseDouble(facturas.getTotal_factura()));

            String test = facturas.getFecha_emision();
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date parsedDate = dateFormat.parse(test);
            Timestamp timestamp = new java.sql.Timestamp(parsedDate.getTime());

            stAux.setTimestamp(4, timestamp);

            String test2 = facturas.getFecha_vencimiento();
            SimpleDateFormat dateFormat2 = new SimpleDateFormat("yyyy-MM-dd");
            Date parsedDate2 = dateFormat2.parse(test2);
            Timestamp timestamp2 = new java.sql.Timestamp(parsedDate2.getTime());

            stAux.setTimestamp(5, timestamp2);

            stAux.executeUpdate();

            //Insertamos el numero de factura en los cargos seleccionados
            //Recuperamos el maximo valor del campo factura
            Statement sentencia = con.createStatement();
            rs = sentencia.executeQuery("select max(id_factura) from facturas");
            rs.next();
            int numFac = rs.getInt(1);

            Statement sentencia2 = con.createStatement();
            int afectados = sentencia2.executeUpdate("update cargos set id_factura =" + numFac + " where id_cargo in (" + cadenaNew + ")");

            resp = "Factura generada";

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

    //Se usa para recoger todos los cargos de un cliente
    @RequestMapping("/facturasController/getFacturas.htm")
    @ResponseBody
    public String getFacturas(@RequestBody Resource resource, HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        Resource resourceLoad = new Resource();

        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";

        ArrayList<String> arrayTipo = new ArrayList<>();
        arrayCargos.clear();
        cadena = "";
        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();

            stAux = con.prepareStatement("SELECT c.id_cargo, c.abreviatura, c.cuenta, c.importe, c.cantidad, c.impuesto, c.total, e.id_entidad, e.distinct_code, e.nombre_entidad, "
                    + "e.nombre_contacto FROM cargos c inner join entidad e on c.id_cliente = e.id_entidad and e.id_entidad = ? and id_factura = 0 order by id_cargo");

            stAux.setInt(1, Integer.parseInt(resource.getCol1()));
            //Ejecutamos                 
            rs = stAux.executeQuery();

            while (rs.next()) {
                arrayTipo.add(new Gson().toJson(new Resource(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7),
                        rs.getString(8), rs.getString(9), rs.getString(10), rs.getString(11))));

                arrayCargos.add(rs.getString(1));
            }

            //Si el cliente tiene cargos los pasamos a la cadenaNew
            if (arrayCargos.size() != 0) {
                cadena = "";

                //Pasamos el array a una cadena de texto para usarla en la query
                for (int i = 0; i < arrayCargos.size(); i++) {  //Al ser usado en un select mas adelante debemos concatenar tambien comillas simples     
                    cadena = cadena + arrayCargos.get(i) + ","; //Añadimos una coma para separar los valores
                }

                //Le quitamos la ultima coma a la cadena de los id_Cargo
                cadenaNew = cadena.substring(0, cadena.length() - 1);
            }
            //Controlamos si el cliente tiene cargos o no. Si no tiene el arrayTipo tiene una longitud = 0
            if (arrayTipo.size() > 0) {
                resp = new Gson().toJson(arrayTipo);
            } else {
                resp = "vacio";
            }

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

    //Cargamos los cargos en la tabla quitanfdo el cargo seleccionado por el cliente
    @RequestMapping("/facturasController/refrescarCargos.htm")
    @ResponseBody
    public String refrescarCargos(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        Resource resourceLoad = new Resource();

        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";

        /*recogemos los valores de los parametros pasados por url desde el jsp */
        String cargo = hsr.getParameter("cargo");

        //Borramos la primera ocurrencia del id_cargo en el ArrayList
        arrayCargos.remove(cargo);

        cadena = "";
        //Pasamos el array a una cadena de texto para usarla en la query
        for (int i = 0; i < arrayCargos.size(); i++) {  //Al ser usado en un select mas adelante debemos concatenar tambien comillas simples     
            cadena = cadena + arrayCargos.get(i) + ","; //Añadimos una coma para separar los valores
        }

        //Le quitamos la ultima coma a la cadena de los id_Cargo
        cadenaNew = cadena.substring(0, cadena.length() - 1);

        ArrayList<String> arrayTipo = new ArrayList<>();

        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();

            Statement sentencia = con.createStatement();
            rs = sentencia.executeQuery("SELECT c.id_cargo, c.abreviatura, c.cuenta, c.importe, c.cantidad, c.impuesto, c.total, e.id_entidad, e.distinct_code, e.nombre_entidad, e.nombre_contacto \n"
                    + "FROM cargos c inner join entidad e on c.id_cliente = e.id_entidad and c.id_cargo in(" + cadenaNew + ") order by id_cargo");

            while (rs.next()) {
                arrayTipo.add(new Gson().toJson(new Resource(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7),
                        rs.getString(8), rs.getString(9), rs.getString(10), rs.getString(11))));
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

    //Se usa para cargar los datos del combo Clientes. 
    @RequestMapping("/facturasController/getEntidadCliente.htm")
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

//        /**
//         * SOLO PARA VER QUE ES GLOBAL, BORRAR LUEGO*********************
//         */
//        Iterator<String> nombreIterator = arrayCargos.iterator();
//        while (nombreIterator.hasNext()) {
//            String elemento = nombreIterator.next();
//            System.out.print(elemento + " / ");
//        }
//        /**
//         * ***************************
//         */
        return resp;

    }

    //Se usa para cargar los datos del combo Empresas
    @RequestMapping("/facturasController/getEntidadEmpresa.htm")
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

    //Se usa al seleccionar algo en el combo Empresa
    @RequestMapping("/facturasController/getDatosEntidadEmpresa.htm")
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

}
