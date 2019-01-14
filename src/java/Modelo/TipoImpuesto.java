package Modelo;


public class TipoImpuesto {
    
    private int id_Impuesto;
    private String impuesto;
    
    public TipoImpuesto(){

    }
    public TipoImpuesto(int a,String b){
       this.id_Impuesto = a;
       this.impuesto = b;
   }

    public String getImpuesto() {
        return impuesto;
    }

    public void setImpuesto(String impuesto) {
        this.impuesto = impuesto;
    }
 
    public int getId_Impuesto() {
        return id_Impuesto;
    }

    public void setId_Impuesto(int id_Impuesto) {
        this.id_Impuesto = id_Impuesto;
    }
 
}
