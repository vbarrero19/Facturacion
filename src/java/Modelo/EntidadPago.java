package Modelo;

/**
 *
 * @author vbarr
 */
public class EntidadPago {
    private String id_entidad;
    private String nombre_entidad;
    
    private String id_metodo_pago;
    private String titular_cuenta;
    private String nombre_banco;

    public EntidadPago() {
    }

    public EntidadPago(String id_entidad, String nombre_entidad, String id_metodo_pago, String titular_cuenta, String nombre_banco) {
        this.id_entidad = id_entidad;
        this.nombre_entidad = nombre_entidad;
        this.id_metodo_pago = id_metodo_pago;
        this.titular_cuenta = titular_cuenta;
        this.nombre_banco = nombre_banco;
    }

    
    
    public String getId_entidad() {
        return id_entidad;
    }

    public void setId_entidad(String id_entidad) {
        this.id_entidad = id_entidad;
    }

    public String getNombre_entidad() {
        return nombre_entidad;
    }

    public void setNombre_entidad(String nombre_entidad) {
        this.nombre_entidad = nombre_entidad;
    }

    public String getId_metodo_pago() {
        return id_metodo_pago;
    }

    public void setId_metodo_pago(String id_metodo_pago) {
        this.id_metodo_pago = id_metodo_pago;
    }

    public String getTitular_cuenta() {
        return titular_cuenta;
    }

    public void setTitular_cuenta(String titular_cuenta) {
        this.titular_cuenta = titular_cuenta;
    }

    public String getNombre_banco() {
        return nombre_banco;
    }

    public void setNombre_banco(String nombre_banco) {
        this.nombre_banco = nombre_banco;
    }
    
    
    
}
