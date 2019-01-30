
package Modelo;

import java.io.Serializable;

public class TipoItem {
    
    private String id_tipo_item;
    private String item;

    public TipoItem() {
    }

    public TipoItem(String id_tipo_item, String item) {
        this.id_tipo_item = id_tipo_item;
        this.item = item;
    }

    public String getId_tipo_item() {
        return id_tipo_item;
    }

    public void setId_tipo_item(String id_tipo_item) {
        this.id_tipo_item = id_tipo_item;
    }

    public String getItem() {
        return item;
    }

    public void setItem(String item) {
        this.item = item;
    }
    
    
}
