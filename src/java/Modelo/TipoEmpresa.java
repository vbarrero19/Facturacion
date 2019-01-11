package Modelo;

public class TipoEmpresa {
    
    private int id_ident;
    private String desc_tipo;

    public TipoEmpresa(int id_ident, String desc_tipo) {
        this.id_ident = id_ident;
        this.desc_tipo = desc_tipo;
    }
 
    public int getId_ident() {
        return id_ident;
    }

    public void setId_ident(int id_ident) {
        this.id_ident = id_ident;
    }

    public String getDescr_tipo() {
        return desc_tipo;
    }

    public void setDescr_tipo(String desc_tipo) {
        this.desc_tipo = desc_tipo;
    }

    
    
}
