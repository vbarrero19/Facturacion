
package Modelo;

/**
 *
 * @author vbarr
 */

import java.io.Serializable;

public class Facturas {
    public String id_factura;
    public String id_emisor;
    public String id_receptor;
    public String total_factura;
    public String fecha_emision;
    public String fecha_vencimiento;
    public String id_estado;

    
    
    public Facturas(){
    
    
    }
    
    
    
    public String getId_factura() {
        return id_factura;
    }

    public void setId_factura(String id_factura) {
        this.id_factura = id_factura;
    }

    public String getId_emisor() {
        return id_emisor;
    }

    public void setId_emisor(String id_emisor) {
        this.id_emisor = id_emisor;
    }

    public String getId_receptor() {
        return id_receptor;
    }

    public void setId_receptor(String id_receptor) {
        this.id_receptor = id_receptor;
    }

    public String getTotal_factura() {
        return total_factura;
    }

    public void setTotal_factura(String total_factura) {
        this.total_factura = total_factura;
    }

    public String getFecha_emision() {
        return fecha_emision;
    }

    public void setFecha_emision(String fecha_emision) {
        this.fecha_emision = fecha_emision;
    }

    public String getFecha_vencimiento() {
        return fecha_vencimiento;
    }

    public void setFecha_vencimiento(String fecha_vencimiento) {
        this.fecha_vencimiento = fecha_vencimiento;
    }

    public String getId_estado() {
        return id_estado;
    }

    public void setId_estado(String id_estado) {
        this.id_estado = id_estado;
    }
   
    
    
    
    
    
    
    
}






