
package Modelo;

/**
 *
 * @author vbarr
 */
public class EntidadDireccion {
    private String id_entidad;
    private String distinct_code;
    private String nombre_entidad;
    
    private String id_direccion;
    private String tipo_via;
    private String nombre_via;
    private String numero_via;
    private String numero_portal;
    private String resto_direccion;
    private String codigo_postal;
    private String localidad;
    private String provincia;
    private String pais;
    
    
    public EntidadDireccion(){
    
    }
    //CONSTRUCTOR PARA CARGAR LA LISTA DE DIRECCIONES EN MODIFICAR DIRECCION
    public EntidadDireccion(String id_entidad, String nombre_entidad, String id_direccion, String nombre_via, String localidad) {
        this.id_entidad = id_entidad;
        this.nombre_entidad = nombre_entidad;
        
        this.id_direccion = id_direccion;
        this.nombre_via = nombre_via;
        this.localidad = localidad;
    }

    //CONSTRUCTOR PARA MODIFICAR LA DIRECCION DE ENTIDADES.

    public EntidadDireccion(String distinct_code, String nombre_entidad, String id_direccion, String tipo_via, String nombre_via, String numero_via, String numero_portal, String resto_direccion, String codigo_postal, String localidad, String provincia, String pais) {
        this.distinct_code = distinct_code;
        this.nombre_entidad = nombre_entidad;
        this.id_direccion = id_direccion;
        this.tipo_via = tipo_via;
        this.nombre_via = nombre_via;
        this.numero_via = numero_via;
        this.numero_portal = numero_portal;
        this.resto_direccion = resto_direccion;
        this.codigo_postal = codigo_postal;
        this.localidad = localidad;
        this.provincia = provincia;
        this.pais = pais;
    }
    
    
    

    public String getId_entidad() {
        return id_entidad;
    }

    public void setId_entidad(String id_entidad) {
        this.id_entidad = id_entidad;
    }

    public String getDistinct_code() {
        return distinct_code;
    }

    public void setDistinct_code(String distinct_code) {
        this.distinct_code = distinct_code;
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

    public String getTipo_via() {
        return tipo_via;
    }

    public void setTipo_via(String tipo_via) {
        this.tipo_via = tipo_via;
    }

    public String getNombre_via() {
        return nombre_via;
    }

    public void setNombre_via(String nombre_via) {
        this.nombre_via = nombre_via;
    }

    public String getNumero_via() {
        return numero_via;
    }

    public void setNumero_via(String numero_via) {
        this.numero_via = numero_via;
    }

    public String getNumero_portal() {
        return numero_portal;
    }

    public void setNumero_portal(String numero_portal) {
        this.numero_portal = numero_portal;
    }

    public String getResto_direccion() {
        return resto_direccion;
    }

    public void setResto_direccion(String resto_direccion) {
        this.resto_direccion = resto_direccion;
    }

    public String getCodigo_postal() {
        return codigo_postal;
    }

    public void setCodigo_postal(String codigo_postal) {
        this.codigo_postal = codigo_postal;
    }

    public String getLocalidad() {
        return localidad;
    }

    public void setLocalidad(String localidad) {
        this.localidad = localidad;
    }

    public String getProvincia() {
        return provincia;
    }

    public void setProvincia(String provincia) {
        this.provincia = provincia;
    }

    public String getPais() {
        return pais;
    }

    public void setPais(String pais) {
        this.pais = pais;
    }
    
    
    
    
    
    

    
    
}



