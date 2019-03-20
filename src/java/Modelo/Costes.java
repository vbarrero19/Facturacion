
package Modelo;

public class Costes {
    
    private String id_item; 
    private String id_entidad;
    private String cantidad;

    public Costes() {
    }

    public Costes(String id_item, String id_entidad, String cantidad) {
        this.id_item = id_item;
        this.id_entidad = id_entidad;
        this.cantidad = cantidad;
    }

    public String getId_item() {
        return id_item;
    }

    public void setId_item(String id_item) {
        this.id_item = id_item;
    }

    public String getId_entidad() {
        return id_entidad;
    }

    public void setId_entidad(String id_entidad) {
        this.id_entidad = id_entidad;
    }

    public String getCantidad() {
        return cantidad;
    }

    public void setCantidad(String cantidad) {
        this.cantidad = cantidad;
    }
    
    
}
