package Modelo;

public class TipoEmpresa {
    
    private int id_empresa;
    private String empresa;

    
     public TipoEmpresa(){

    }
    
    public TipoEmpresa(int a,String b){
       this.id_empresa = a;
       this.empresa = b;
   }    
    
    public int getId_empresa() {
        return id_empresa;
    }

    public void setId_empresa(int id_empresa) {
        this.id_empresa = id_empresa;
    }

    public String getEmpresa() {
        return empresa;
    }

    public void setEmpresa(String empresa) {
        this.empresa = empresa;
    }

}
