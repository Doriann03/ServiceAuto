package ro.serviceauto.serviceauto.model;
import lombok.Data;

@Data
public class Programare {
    private int idp;
    private int idc; // Foreign Key catre Client
    private int idv; // Foreign Key catre Vehicul
    private String dataProg; // Format datetime (yyyy-MM-dd HH:mm:ss)
    private String status;   // 'Programat', 'In lucru', 'Finalizat', 'Anulat'
}