package ro.serviceauto.serviceauto.model.dto;

public class ServiciuAfisare {
    private String numeServiciu;
    private String descriere;
    private int durata;
    private String numeAtelier;
    private String adresaAtelier;

    // --- GETTERS (Obligatorii pentru JSP) ---
    public String getNumeServiciu() { return numeServiciu; }
    public String getDescriere() { return descriere; }
    public int getDurata() { return durata; }
    public String getNumeAtelier() { return numeAtelier; }
    public String getAdresaAtelier() { return adresaAtelier; }

    // --- SETTERS ---
    public void setNumeServiciu(String numeServiciu) { this.numeServiciu = numeServiciu; }
    public void setDescriere(String descriere) { this.descriere = descriere; }
    public void setDurata(int durata) { this.durata = durata; }
    public void setNumeAtelier(String numeAtelier) { this.numeAtelier = numeAtelier; }
    public void setAdresaAtelier(String adresaAtelier) { this.adresaAtelier = adresaAtelier; }
}