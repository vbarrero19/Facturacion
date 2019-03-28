
package Modelo;

public class CuentasEmpresas {
    
    private String id_cuenta; 
    private String nombre;
    private String estado;

    public CuentasEmpresas() {
    }

    public CuentasEmpresas(String id_cuenta, String nombre, String estado) {
        this.id_cuenta = id_cuenta;
        this.nombre = nombre;
        this.estado = estado;
    }

    public String getId_cuenta() {
        return id_cuenta;
    }

    public void setId_cuenta(String id_cuenta) {
        this.id_cuenta = id_cuenta;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    
}
