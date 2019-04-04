
package Modelo;

public class Cargos {
    
    private String id_cargo; 
    private String id_item; 
    private String abreviatura;
    private String descripcion;
    private String id_tipo_item;
    private String cuenta;
    private String importe;
    private String cantidad;
    private String impuesto; 
    private String total; 
    private String fecha_cargo; 
    private String fecha_vencimiento; 
    private String estado; 
    private String id_factura; 
    private String id_cliente; 
    private String id_empresa; 
    private String valor_impuesto;
    private String periodicidad;
    private String costes;

    public Cargos() {
    }

    public Cargos(String id_cliente, String id_empresa) {
        this.id_cliente = id_cliente;
        this.id_empresa = id_empresa;
    }

    public Cargos(String id_cargo, String id_item, String abreviatura, String descripcion, String id_tipo_item, String cuenta, String importe, String cantidad, String impuesto, String total, String fecha_cargo, String fecha_vencimiento, String estado, String id_factura, String id_cliente, String id_empresa, String valor_impuesto, String periodicidad, String costes) {
        this.id_cargo = id_cargo;
        this.id_item = id_item;
        this.abreviatura = abreviatura;
        this.descripcion = descripcion;
        this.id_tipo_item = id_tipo_item;
        this.cuenta = cuenta;
        this.importe = importe;
        this.cantidad = cantidad;
        this.impuesto = impuesto;
        this.total = total;
        this.fecha_cargo = fecha_cargo;
        this.fecha_vencimiento = fecha_vencimiento;
        this.estado = estado;
        this.id_factura = id_factura;
        this.id_cliente = id_cliente;
        this.id_empresa = id_empresa;
        this.valor_impuesto = valor_impuesto;
        this.periodicidad = periodicidad;
        this.costes = costes;
    }
  

    public Cargos(String id_cargo) {
        this.id_cargo = id_cargo;
    }
    
    
    public String getId_cargo() {
        return id_cargo;
    }

    public void setId_cargo(String id_cargo) {
        this.id_cargo = id_cargo;
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

    public String getCantidad() {
        return cantidad;
    }

    public void setCantidad(String cantidad) {
        this.cantidad = cantidad;
    }

    public String getImpuesto() {
        return impuesto;
    }

    public void setImpuesto(String impuesto) {
        this.impuesto = impuesto;
    }

    public String getTotal() {
        return total;
    }

    public void setTotal(String total) {
        this.total = total;
    }

    public String getFecha_cargo() {
        return fecha_cargo;
    }

    public void setFecha_cargo(String fecha_cargo) {
        this.fecha_cargo = fecha_cargo;
    }

    public String getFecha_vencimiento() {
        return fecha_vencimiento;
    }

    public void setFecha_vencimiento(String fecha_vencimiento) {
        this.fecha_vencimiento = fecha_vencimiento;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
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

    public String getValor_impuesto() {
        return valor_impuesto;
    }

    public void setValor_impuesto(String valor_impuesto) {
        this.valor_impuesto = valor_impuesto;
    }

    public String getPeriodicidad() {
        return periodicidad;
    }

    public void setPeriodicidad(String periodicidad) {
        this.periodicidad = periodicidad;
    }

    public String getCostes() {
        return costes;
    }

    public void setCostes(String costes) {
        this.costes = costes;
    }
    
    
    
}
