
package Modelo;

public class ClienteCargos {
    private String id_cliente;
    private String id_cargo;
    private String cargo;    
    private String cantidad;
    
    private String nombre_empresa;    
    private String dir_fisica;    
    private String pais;

    public ClienteCargos() {

    }
    
    
    

    public ClienteCargos(String id_cliente, String id_cargo, String cargo, String cantidad, String nombre_empresa, String dir_fisica, String pais) {
        this.id_cliente = id_cliente;
        this.id_cargo = id_cargo;
        this.cargo = cargo;
        this.cantidad = cantidad;
        this.nombre_empresa = nombre_empresa;
        this.dir_fisica = dir_fisica;
        this.pais = pais;
    }    

    
    
    
    public String getId_cliente() {
        return id_cliente;
    }

    public void setId_cliente(String id_cliente) {
        this.id_cliente = id_cliente;
    }

    public String getId_cargo() {
        return id_cargo;
    }

    public void setId_cargo(String id_cargo) {
        this.id_cargo = id_cargo;
    }

    public String getCargo() {
        return cargo;
    }

    public void setCargo(String cargo) {
        this.cargo = cargo;
    }

    public String getCantidad() {
        return cantidad;
    }

    public void setCantidad(String cantidad) {
        this.cantidad = cantidad;
    }

    public String getNombre_empresa() {
        return nombre_empresa;
    }

    public void setNombre_empresa(String nombre_empresa) {
        this.nombre_empresa = nombre_empresa;
    }

    public String getDir_fisica() {
        return dir_fisica;
    }

    public void setDir_fisica(String dir_fisica) {
        this.dir_fisica = dir_fisica;
    }

    public String getPais() {
        return pais;
    }

    public void setPais(String pais) {
        this.pais = pais;
    }
}
