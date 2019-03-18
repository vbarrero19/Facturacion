
package Modelo;

import java.io.Serializable;

public class Items  { 
    private String id_item; 
    private String abreviatura;
    private String descripcion;
    private String id_tipo_item;    
    private String importe;
    private String estado;
    private String id_cuenta;

    public Items() {
    }

    public Items(String id_item, String abreviatura, String descripcion, String id_tipo_item, String importe, String estado, String id_cuenta) {
        this.id_item = id_item;
        this.abreviatura = abreviatura;
        this.descripcion = descripcion;
        this.id_tipo_item = id_tipo_item;
        this.importe = importe;
        this.estado = estado;
        this.id_cuenta = id_cuenta;
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
    
    public String getImporte() {
        return importe;
    }

    public void setImporte(String importe) {
        this.importe = importe;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String getId_cuenta() {
        return id_cuenta;
    }

    public void setId_cuenta(String id_cuenta) {
        this.id_cuenta = id_cuenta;
    }

    
}