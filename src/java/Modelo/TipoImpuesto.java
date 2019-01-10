package Modelo;



public class TipoImpuesto {

    public TipoImpuesto(int id_impuesto, String impuesto) {
        this.id_impuesto = id_impuesto;
        this.impuesto = impuesto;
    } 
    
    private int id_impuesto;
    private String impuesto;

    public int getId_impuesto() {
        return id_impuesto;
    }

    public void setId_impuesto(int id_impuesto) {
        this.id_impuesto = id_impuesto;
    }

    public String getImpuesto() {
        return impuesto;
    }

    public void setImpuesto(String impuesto) {
        this.impuesto = impuesto;
    }    
    
}
