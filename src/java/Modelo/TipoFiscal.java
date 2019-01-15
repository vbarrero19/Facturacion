package Modelo;

public class TipoFiscal {
    
    private int id_fiscal;
    private String fiscal;

    public TipoFiscal(){

    }
    
    public TipoFiscal(int a,String b){
       this.id_fiscal = a;
       this.fiscal = b;
   }    
    
    public int getId_fiscal() {
        return id_fiscal;
    }

    public void setId_fiscal(int id_fiscal) {
        this.id_fiscal = id_fiscal;
    }

    public String getFiscal() {
        return fiscal;
    }

    public void setFiscal(String fiscal) {
        this.fiscal = fiscal;
    }

}
