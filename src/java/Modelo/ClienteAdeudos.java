
package Modelo;

public class ClienteAdeudos {
    private String id_cliente;
    private String id_adeudo;
    private String adeudo;    
    private String cantidad;
    
    private String nombre_empresa;    
    private String dir_fisica;    
    private String pais;

    public ClienteAdeudos() {

    }
    
    
    

    public ClienteAdeudos(String id_cliente, String id_adeudo, String adeudo, String cantidad, String nombre_empresa, String dir_fisica, String pais) {
        this.id_cliente = id_cliente;
        this.id_adeudo = id_adeudo;
        this.adeudo = adeudo;
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

    public String getId_adeudo() {
        return id_adeudo;
    }

    public void setId_adeudo(String id_adeudo) {
        this.id_adeudo = id_adeudo;
    }

    public String getAdeudo() {
        return adeudo;
    }

    public void setAdeudo(String adeudo) {
        this.adeudo = adeudo;
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
