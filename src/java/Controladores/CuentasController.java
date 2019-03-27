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
public class CuentasController {

    //Al cargar presentemos un Model and View con el JSP itemsView es lo que se ve en la pantalla
    @RequestMapping("/cuentasController/start.htm")
    public ModelAndView start(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        ModelAndView mv = new ModelAndView("cuentasView");

        return mv;
    }

    //AddResources
    @RequestMapping("/cuentasController/addResources.htm")
    @ResponseBody
    public ModelAndView addResources(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {

        return null;
    }

    //Se usa para cargar los datos de la tabla cuentas
    @RequestMapping("/cuentasController/getCuenta.htm")
    @ResponseBody
    public String cargarCuentas(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        Cuentas resourceLoad = new Cuentas();

        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";

        ArrayList<String> arrayTipo = new ArrayList<>();

        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();

            Statement sentencia = con.createStatement();

            rs = sentencia.executeQuery("SELECT id_cuenta, cuenta, estado FROM cuentas where estado = 'Si' ORDER BY id_cuenta");

            while (rs.next()) {
                arrayTipo.add(new Gson().toJson(new Cuentas(rs.getString(1), rs.getString(2), rs.getString(3))));
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

    //Se usa para cargar los datos de la tabla empresas
    @RequestMapping("/cuentasController/getEmpresa.htm")
    @ResponseBody
    public String cargarEmpresas(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        Cuentas resourceLoad = new Cuentas();

        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";

        ArrayList<String> arrayTipo = new ArrayList<>();

        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();

            Statement sentencia = con.createStatement();

            rs = sentencia.executeQuery("SELECT id_empresa, nombre, estado FROM cuentas_empresas where estado = 'Si' ORDER BY id_empresa");

            while (rs.next()) {
                arrayTipo.add(new Gson().toJson(new Cuentas(rs.getString(1), rs.getString(2), rs.getString(3))));
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

    //Codigo para archivar cuentas. En estado ponemos un No para indicar que esta desactivada
    @RequestMapping("/CuentasController/archivarCuenta.htm")
    @ResponseBody
    public String archivarCuenta(@RequestBody Resource resource, HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        Resource resourceLoad = new Resource();

        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";

        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();

            stAux = con.prepareStatement("update cuentas SET estado = ? where id_cuenta = ?");

            //Ponemos el estado en No para indicar que esta archivado
            stAux.setString(1, "No");
            stAux.setInt(2, Integer.parseInt(resource.getCol1()));

            stAux.executeUpdate();

        } catch (SQLException ex) {
            resp = "incorrecto SQL -> " + ex; // ex.getMessage();
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
    
    //Codigo para archivar cuentas. En estado ponemos un Si para indicar que esta activada
    @RequestMapping("/CuentasController/activarCuenta.htm")
    @ResponseBody
    public String activarCuenta(@RequestBody Resource resource, HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        Resource resourceLoad = new Resource();

        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";

        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();

            stAux = con.prepareStatement("update cuentas SET estado = ? where id_cuenta = ?");

            //Ponemos el estado en No para indicar que esta archivado
            stAux.setString(1, "Si");
            stAux.setInt(2, Integer.parseInt(resource.getCol1()));

            stAux.executeUpdate();

        } catch (SQLException ex) {
            resp = "incorrecto SQL -> " + ex; // ex.getMessage();
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

    //Codigo para añadir cuentas. En estado ponemos un Si para indicar que esta activada
    @RequestMapping("/CuentasController/anadirCuenta.htm")
    @ResponseBody
    public String anadirCuenta(@RequestBody Resource resource, HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        Resource resourceLoad = new Resource();

        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "Cuenta insertada";

        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();

            stAux = con.prepareStatement("insert into cuentas (cuenta, estado) values (?,?)");

            //Ponemos el estado en Si para indicar que esta activa            
            stAux.setString(1, resource.getCol1());
            stAux.setString(2, "Si");

            stAux.executeUpdate();

        } catch (SQLException ex) {
            resp = "incorrecto SQL -> " + ex;
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

    //Codigo para modificar cuentas. En estado ponemos lo que nos llega del formulario, será un Si ya que esta activada
    @RequestMapping("/CuentasController/modificarCuenta.htm")
    @ResponseBody
    public String modificarCuenta(@RequestBody Resource resource, HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        Resource resourceLoad = new Resource();

        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "Cuenta modificada";

        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();

            stAux = con.prepareStatement("update cuentas SET cuenta = ? where id_cuenta = ?");

            //Ponemos el estado en Si para indicar que esta activa            
            stAux.setString(1, resource.getCol1());
            stAux.setInt(2, Integer.parseInt(resource.getCol2()));

            stAux.executeUpdate();

        } catch (SQLException ex) {
            resp = "incorrecto SQL -> " + ex;
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
            
    //Se usa para cargar los datos del combo de cuentas desactivadas
    @RequestMapping("/cuentasController/getCuentasDesactivadas.htm")
    @ResponseBody
    public String getCuentasDesactivadas(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        Cuentas resourceLoad = new Cuentas();

        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";

        ArrayList<String> arrayTipo = new ArrayList<>();

        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();

            Statement sentencia = con.createStatement();

            rs = sentencia.executeQuery("SELECT id_cuenta, cuenta, estado FROM cuentas where estado = 'No' ORDER BY id_cuenta");

            while (rs.next()) {
                arrayTipo.add(new Gson().toJson(new Cuentas(rs.getString(1), rs.getString(2), rs.getString(3))));
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

    //Codigo para archivar empresas. En estado ponemos un No para indicar que esta desactivado
    @RequestMapping("/CuentasController/archivarEmpresa.htm")
    @ResponseBody
    public String archivarEmpresa(@RequestBody Resource resource, HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        Resource resourceLoad = new Resource();

        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";

        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();

            stAux = con.prepareStatement("update cuentas_empresas SET estado = ? where id_empresa = ?");

            //Ponemos el estado en No para indicar que esta archivado
            stAux.setString(1, "No");
            stAux.setInt(2, Integer.parseInt(resource.getCol1()));

            stAux.executeUpdate();

        } catch (SQLException ex) {
            resp = "incorrecto SQL -> " + ex; // ex.getMessage();
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
    
     //Codigo para activar empresas. En estado ponemos un No para indicar que esta desactivado
    @RequestMapping("/CuentasController/activarEmpresa.htm")
    @ResponseBody
    public String activarEmpresa(@RequestBody Resource resource, HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        Resource resourceLoad = new Resource();

        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";

        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();

            stAux = con.prepareStatement("update cuentas_empresas SET estado = ? where id_empresa = ?");

            //Ponemos el estado en No para indicar que esta archivado
            stAux.setString(1, "Si");
            stAux.setInt(2, Integer.parseInt(resource.getCol1()));

            stAux.executeUpdate();

        } catch (SQLException ex) {
            resp = "incorrecto SQL -> " + ex; // ex.getMessage();
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
    
    //Codigo para añadir cuentas. En estado ponemos un Si para indicar que esta activada
    @RequestMapping("/CuentasController/anadirEmpresa.htm")
    @ResponseBody
    public String anadirEmpresa(@RequestBody Resource resource, HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        Resource resourceLoad = new Resource();

        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "Empresa añadida";

        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();

            stAux = con.prepareStatement("insert into cuentas_empresas (id_empresa, nombre, estado) values (?,?,?)");

            //Ponemos el estado en Si para indicar que esta activa            
            stAux.setInt(1, Integer.parseInt(resource.getCol1()));
            stAux.setString(2, resource.getCol2());
            stAux.setString(3, "Si");

            stAux.executeUpdate();

        } catch (SQLException ex) {
            resp = "incorrecto SQL -> " + ex;
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

    //Se usa para cargar los datos del combo de cuentas desactivadas
    @RequestMapping("/cuentasController/getEmpresasDesactivadas.htm")
    @ResponseBody
    public String getEmpresasDesactivadas(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        Cuentas resourceLoad = new Cuentas();

        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stAux = null;
        String resp = "correcto";

        ArrayList<String> arrayTipo = new ArrayList<>();

        try {
            PoolC3P0_Local pool_local = PoolC3P0_Local.getInstance();
            con = pool_local.getConnection();

            Statement sentencia = con.createStatement();

            rs = sentencia.executeQuery("SELECT id_empresa, nombre, estado FROM cuentas_empresas where estado = 'No' ORDER BY id_empresa");

            while (rs.next()) {
                arrayTipo.add(new Gson().toJson(new Cuentas(rs.getString(1), rs.getString(2), rs.getString(3))));
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
    
    //Se usa para cargar los datos del combo de cuentas desactivadas
    @RequestMapping("/cuentasController/getEmpresasDisponibles.htm")
    @ResponseBody
    public String getEmpresasDisponibles(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
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

            rs = sentencia.executeQuery("select e.id_entidad, e.distinct_code from entidad e inner join entidad_tipo_entidad t on e.id_entidad = t.id_entidad\n" +
                                        " inner join tipo_entidad te on t.id_tipo_entidad = te.id_tipo_entidad where upper(te.tipo_entidad) = upper('empresa')\n" +
                                        "  and e.id_entidad not in (SELECT id_empresa FROM cuentas_empresas)");
            
                         
            while (rs.next()) {
                arrayTipo.add(new Gson().toJson(new Entidades(rs.getString(1), rs.getString(2))));
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
    
}
