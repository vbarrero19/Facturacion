
package Modelo;

/**
 *
 * @author vbarr
 */
public class EntidadesDireccion {
    private String id_entidad;
    private String nombre_entidad;
    
    private String id_direccion;
    private String nombre_direccion;
    private String nombre_vida;
    private String localidad;
    
    
    public EntidadesDireccion(){
    
    }

    public EntidadesDireccion(String id_entidad, String nombre_entidad, String id_direccion, String nombre_direccion, String nombre_vida, String localidad) {
        this.id_entidad = id_entidad;
        this.nombre_entidad = nombre_entidad;
        this.id_direccion = id_direccion;
        this.nombre_direccion = nombre_direccion;
        this.nombre_vida = nombre_vida;
        this.localidad = localidad;
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

    public String getId_direccion() {
        return id_direccion;
    }

    public void setId_direccion(String id_direccion) {
        this.id_direccion = id_direccion;
    }

    public String getNombre_direccion() {
        return nombre_direccion;
    }

    public void setNombre_direccion(String nombre_direccion) {
        this.nombre_direccion = nombre_direccion;
    }

    public String getNombre_vida() {
        return nombre_vida;
    }

    public void setNombre_vida(String nombre_vida) {
        this.nombre_vida = nombre_vida;
    }

    public String getLocalidad() {
        return localidad;
    }

    public void setLocalidad(String localidad) {
        this.localidad = localidad;
    }



    
    
}



