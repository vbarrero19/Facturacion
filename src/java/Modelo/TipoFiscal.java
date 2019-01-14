package Modelo;

/**
 *
 * @author vbarr
 */
public class TipoFiscal {
    private int id_fiscal;
    private String nombre_id;
    
    public TipoFiscal(){
    
    }

    public TipoFiscal(int id_fiscal, String nombre_id) {
        this.id_fiscal = id_fiscal;
        this.nombre_id = nombre_id;
    }

    public int getId_fiscal() {
        return id_fiscal;
    }

    public void setId_fiscal(int id_fiscal) {
        this.id_fiscal = id_fiscal;
    }

    public String getNombre_id() {
        return nombre_id;
    }

    public void setNombre_id(String nombre_id) {
        this.nombre_id = nombre_id;
    }
     
}
