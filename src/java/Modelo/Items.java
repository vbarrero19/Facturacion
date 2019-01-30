
package Modelo;

import java.io.Serializable;

public class Items  { 
    private String id_item; //Es serial y no l
    private String abreviatura;
    private String descripcion;
    private String id_tipo_item;
    private String cuenta;
    private String importe;
    private String periodo;

    public Items() {
    }

    public Items(String abreviatura, String descripcion, String id_tipo_item, String cuenta, String importe, String periodo) {        
        this.abreviatura = abreviatura;
        this.descripcion = descripcion;
        this.id_tipo_item = id_tipo_item;
        this.cuenta = cuenta;
        this.importe = importe;
        this.periodo = periodo;
    }

    public String getId_item() {
        return id_item;
    }

    public void setId_item(String id_item) {
        this.id_item = id_item;
    }

    public String getAbreviatura() {
        return abreviatura;
    }

    public void setAbreviatura(String abreviatura) {
        this.abreviatura = abreviatura;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getId_tipo_item() {
        return id_tipo_item;
    }

    public void setId_tipo_item(String id_tipo_item) {
        this.id_tipo_item = id_tipo_item;
    }

    public String getCuenta() {
        return cuenta;
    }

    public void setCuenta(String cuenta) {
        this.cuenta = cuenta;
    }

    public String getImporte() {
        return importe;
    }

    public void setImporte(String importe) {
        this.importe = importe;
    }

    public String getPeriodo() {
        return periodo;
    }

    public void setPeriodo(String periodo) {
        this.periodo = periodo;
    }

    
}