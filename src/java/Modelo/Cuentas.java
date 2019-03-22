
package Modelo;

public class Cuentas {
    
    private String id_cuenta; 
    private String cuenta;
    private String estado;

    public Cuentas() {
    }

    public Cuentas(String id_cuenta, String cuenta, String estado) {
        this.id_cuenta = id_cuenta;
        this.cuenta = cuenta;
        this.estado = estado;
    }

    public String getId_cuenta() {
        return id_cuenta;
    }

    public void setId_cuenta(String id_cuenta) {
        this.id_cuenta = id_cuenta;
    }

    public String getCuenta() {
        return cuenta;
    }

    public void setCuenta(String cuenta) {
        this.cuenta = cuenta;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }
    
    
    
}
