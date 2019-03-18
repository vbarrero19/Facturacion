
package Modelo;

/**
 *
 * @author vbarr
 */

import java.io.Serializable;

public class Facturas {
    public String id_factura;
    public String id_cliente;
    public String id_empresa;
    public String total_factura;
    public String fecha_emision;
    public String fecha_vencimiento;
    public String id_estado;
    public String archivada;
    public String anulada;
    
    public Facturas() {
    }

    public Facturas(String id_factura, String id_cliente, String id_empresa, String total_factura, String fecha_emision, String fecha_vencimiento, String id_estado, String archivada, String anulada) {
        this.id_factura = id_factura;
        this.id_cliente = id_cliente;
        this.id_empresa = id_empresa;
        this.total_factura = total_factura;
        this.fecha_emision = fecha_emision;
        this.fecha_vencimiento = fecha_vencimiento;
        this.id_estado = id_estado;
        this.archivada = archivada;
        this.anulada = anulada;
    }

    public String getId_factura() {
        return id_factura;
    }

    public void setId_factura(String id_factura) {
        this.id_factura = id_factura;
    }

    public String getId_cliente() {
        return id_cliente;
    }

    public void setId_cliente(String id_cliente) {
        this.id_cliente = id_cliente;
    }

    public String getId_empresa() {
        return id_empresa;
    }

    public void setId_empresa(String id_empresa) {
        this.id_empresa = id_empresa;
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

    public String getArchivada() {
        return archivada;
    }

    public void setArchivada(String archivada) {
        this.archivada = archivada;
    }

    public String getAnulada() {
        return anulada;
    }

    public void setAnulada(String anulada) {
        this.anulada = anulada;
    }
    
    
       
}






