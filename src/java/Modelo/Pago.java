package Modelo;

/**
 *
 * @author vbarr
 */

import java.io.Serializable;

public class Pago {
    private String id_metodo_pago;
    private String id_entidad;
    private String numero_cuenta;
    private String titular_cuenta;
    private String nombre_banco;
    private String direccion_banco;
    private String localidad;
    private String pais;
    private String codigo1;
    private String codigo2;
    private String tarjeta_credito;
    private String titular_tarjeta;
    private String tipo_tarjeta;
    private String mes_caducidad;
    private String anio_caducidad;
    private String codigo_csc;
    private String cuenta_paypal;
    private String correo_paypal;
    private String cheque;
    private String por_defecto;
    private String activado;
    
    public Pago(){
    
    }
    
    

    public String getId_metodo_pago() {
        return id_metodo_pago;
    }

    public void setId_metodo_pago(String id_metodo_pago) {
        this.id_metodo_pago = id_metodo_pago;
    }

    public String getId_entidad() {
        return id_entidad;
    }

    public void setId_entidad(String id_entidad) {
        this.id_entidad = id_entidad;
    }

    public String getNumero_cuenta() {
        return numero_cuenta;
    }

    public void setNumero_cuenta(String numero_cuenta) {
        this.numero_cuenta = numero_cuenta;
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

    public String getDireccion_banco() {
        return direccion_banco;
    }

    public void setDireccion_banco(String direccion_banco) {
        this.direccion_banco = direccion_banco;
    }

    public String getLocalidad() {
        return localidad;
    }

    public void setLocalidad(String localidad) {
        this.localidad = localidad;
    }

    public String getPais() {
        return pais;
    }

    public void setPais(String pais) {
        this.pais = pais;
    }

    public String getCodigo1() {
        return codigo1;
    }

    public void setCodigo1(String codigo1) {
        this.codigo1 = codigo1;
    }

    public String getCodigo2() {
        return codigo2;
    }

    public void setCodigo2(String codigo2) {
        this.codigo2 = codigo2;
    }

    public String getTarjeta_credito() {
        return tarjeta_credito;
    }

    public void setTarjeta_credito(String tarjeta_credito) {
        this.tarjeta_credito = tarjeta_credito;
    }

    public String getTitular_tarjeta() {
        return titular_tarjeta;
    }

    public void setTitular_tarjeta(String titular_tarjeta) {
        this.titular_tarjeta = titular_tarjeta;
    }

    public String getTipo_tarjeta() {
        return tipo_tarjeta;
    }

    public void setTipo_tarjeta(String tipo_tarjeta) {
        this.tipo_tarjeta = tipo_tarjeta;
    }

    public String getMes_caducidad() {
        return mes_caducidad;
    }

    public void setMes_caducidad(String mes_caducidad) {
        this.mes_caducidad = mes_caducidad;
    }

    public String getAnio_caducidad() {
        return anio_caducidad;
    }

    public void setAnio_caducidad(String anio_caducidad) {
        this.anio_caducidad = anio_caducidad;
    }

    public String getCodigo_csc() {
        return codigo_csc;
    }

    public void setCodigo_csc(String codigo_csc) {
        this.codigo_csc = codigo_csc;
    }

    public String getCuenta_paypal() {
        return cuenta_paypal;
    }

    public void setCuenta_paypal(String cuenta_paypal) {
        this.cuenta_paypal = cuenta_paypal;
    }

    public String getCorreo_paypal() {
        return correo_paypal;
    }

    public void setCorreo_paypal(String correo_paypal) {
        this.correo_paypal = correo_paypal;
    }

    public String getCheque() {
        return cheque;
    }

    public void setCheque(String cheque) {
        this.cheque = cheque;
    }

    public String getPor_defecto() {
        return por_defecto;
    }

    public void setPor_defecto(String por_defecto) {
        this.por_defecto = por_defecto;
    }

    public String getActivado() {
        return activado;
    }

    public void setActivado(String activado) {
        this.activado = activado;
    }
    
    
    
}
