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
public class modificarItemsController {
    //Al cargar presentemos un Model and View con el JSP modificarItemsView es lo que se ve en la pantalla

    @RequestMapping("/modificarItemsController/start.htm")
    public ModelAndView start(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        ModelAndView mv = new ModelAndView("modificarItemsView");

        return mv;
    }

    @RequestMapping("/modificarItemsController/addResources.htm")
    @ResponseBody
    public ModelAndView addResources(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {

        return null;
    }

    /*Cargamos datos del item*/
    @RequestMapping("/modificarItemsController/getItem.htm")
    @ResponseBody
    public String getItem(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {

        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";

        String idItem = hsr.getParameter("idItem");
        ArrayList<String> arrayTipoEntidad = new ArrayList<>();

        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();

            Statement sentencia = con.createStatement();
            rs = sentencia.executeQuery("select id_item, abreviatura, descripcion, id_tipo_item, importe, estado, id_cuenta, costes from items where id_item = '" + idItem + "'");

            while (rs.next()) {
                arrayTipoEntidad.add(new Gson().toJson(new Resource(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6),
                        rs.getString(7), rs.getString(8))));
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
    
    @RequestMapping("/modificarItemsController/getTipoItem.htm")
    @ResponseBody
    public String cargarComboItem(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        TipoItem resourceLoad = new TipoItem();

        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";
        //Creamos un array de String para guardar los resultados de la busqueda y
        //lo enviamos con JSON, Los resultados son objetos TipoItem convertidos en String
        ArrayList<String> arrayTipoItem = new ArrayList<>();

        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();

            Statement sentencia = con.createStatement();
            rs = sentencia.executeQuery("SELECT id_tipo_item, item FROM tipo_item");

            while (rs.next()) {
                //Cada registro del rs lo convertimos a String con JSON y los guardamos en el Array
                arrayTipoItem.add(new Gson().toJson(new TipoItem(rs.getString(1), rs.getString(2))));
            }

            //Convertimos el Array a un String, lo guardamos en la variable resp y lo devolvemos al JSP
            resp = new Gson().toJson(arrayTipoItem);

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

        //Devolvemos la variable resp al JSP
        return resp;

    }

    @RequestMapping("/modificarItemsController/getTipoCuenta.htm")
    @ResponseBody
    public String cargarComboCuenta(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        Resource resourceLoad = new Resource();

        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";
        //Creamos un array de String para guardar los resultados de la busqueda y
        //lo enviamos con JSON, Los resultados son objetos TipoItem convertidos en String
        ArrayList<String> arrayTipoCuenta = new ArrayList<>();

        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();

            Statement sentencia = con.createStatement();
            rs = sentencia.executeQuery("SELECT id_cuenta, cuenta FROM cuentas where estado = 'Si'");

            while (rs.next()) {
                //Cada registro del rs lo convertimos a String con JSON y los guardamos en el Array
                arrayTipoCuenta.add(new Gson().toJson(new Resource(rs.getString(1), rs.getString(2))));
            }

            //Convertimos el Array a un String, lo guardamos en la variable resp y lo devolvemos al JSP
            resp = new Gson().toJson(arrayTipoCuenta);

        } catch (SQLException ex) {
            resp = "incorrecto SQL ->" + ex; // ex.getMessage();
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

        //Devolvemos la variable resp al JSP
        return resp;

    }

    /*Cargamos datos de los costes de un item*/
    @RequestMapping("/modificarItemsController/getCostes.htm")
    @ResponseBody
    public String getCostes(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {

        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";

        String idItem = hsr.getParameter("idItem");
        ArrayList<String> arrayTipoEntidad = new ArrayList<>();

        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();

            Statement sentencia = con.createStatement();
            rs = sentencia.executeQuery("select id_item, id_entidad, cantidad from costes where id_item = '" + idItem + "'");

            while (rs.next()) {
                arrayTipoEntidad.add(new Gson().toJson(new Resource(rs.getString(1), rs.getString(2), rs.getString(3))));
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
    
    //Insertamos un nuevo item
    @RequestMapping("/modificarItemsController/modificarItem.htm")
    @ResponseBody
    public String modificarItem(@RequestBody Items item, HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        
        Items resourceLoad = new Items();

        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        PreparedStatement stAux2 = null;
        String resp = "correcto";

        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();
            
            String coste = item.getCostes();
            
            //Si el item no tiene costes guardamos el importe y en costes ponemos "No"
            if (item.getCostes().equals("No")) {
                stAux = con.prepareStatement("update items set abreviatura=?, descripcion=?, id_tipo_item=?, importe=?, estado=?, id_cuenta=?, costes=? where id_item = ?");

                stAux.setString(1, item.getAbreviatura());
                stAux.setString(2, item.getDescripcion());
                stAux.setInt(3, Integer.parseInt(item.getId_tipo_item()));
                stAux.setDouble(4, Double.parseDouble(item.getImporte()));
                stAux.setInt(5, Integer.parseInt(item.getEstado()));
                stAux.setInt(6, Integer.parseInt(item.getId_cuenta()));
                stAux.setString(7, item.getCostes());
                stAux.setInt(8, Integer.parseInt(item.getId_item()));

                stAux.executeUpdate();

                resp = "Item modificado sin costes";

            }else{//Si el item tiene costes guardamos el importe y en costes ponemos "Si". Ademas guardamos el desglose de los costes
                
                stAux = con.prepareStatement("update items set abreviatura=?, descripcion=?, id_tipo_item=?, importe=?, estado=?, id_cuenta=?, costes=? where id_item = ?");

                stAux.setString(1, item.getAbreviatura());
                stAux.setString(2, item.getDescripcion());
                stAux.setInt(3, Integer.parseInt(item.getId_tipo_item()));
                stAux.setDouble(4, Double.parseDouble(item.getImporte()));
                stAux.setInt(5, Integer.parseInt(item.getEstado()));
                stAux.setInt(6, Integer.parseInt(item.getId_cuenta()));
                stAux.setString(7, "Si");
                stAux.setInt(8, Integer.parseInt(item.getId_item()));

                stAux.executeUpdate();

                resp = "Item modificado ";
                
                //Insertamos el desglose de los costes
                //Primero borramos los costes para ese item
                Statement sentencia = con.createStatement();
                stAux = con.prepareStatement("delete from costes where id_item = ?");
                stAux.setInt(1, Integer.parseInt(item.getId_item()));
                
                stAux.executeUpdate();
                
                
                int numItem = Integer.parseInt(item.getId_item());
                
                //Los volvemos a insertar con las modificaciones
                String cadena = item.getCostes();
                String EntidadCantidad = "";

                String[] costes = cadena.split(",");
                for (int x = 0; x < costes.length; x++) {
                    EntidadCantidad = costes[x];
                    String[] datos = EntidadCantidad.split("-");
                    int entidad = Integer.parseInt(datos[0]);
                    Double cantidad = Double.parseDouble(datos[1]);

                    stAux2 = con.prepareStatement("INSERT INTO costes VALUES (?,?,?)");

                    stAux2.setInt(1, numItem);
                    stAux2.setInt(2, entidad);
                    stAux2.setDouble(3, cantidad);

                    stAux2.executeUpdate();
                }

                resp = resp + "con costes";

            }

        } catch (SQLException ex) {
            resp = "Incorrecto SQLE -> " + ex; // ex.getMessage();
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
    
    
    
    
};
