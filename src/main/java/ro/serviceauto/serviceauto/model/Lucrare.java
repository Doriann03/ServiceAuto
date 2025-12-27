package ro.serviceauto.serviceauto.model;
import lombok.Data;

@Data
public class Lucrare {
    private int idl;
    private int idp; // Foreign Key catre Programare
    private int ida; // Foreign Key catre Atelier
    private double pret;
    private String dataInitiala;
    private String dataFinala;
    private String descriere;
}