package ro.serviceauto.serviceauto.model.dto;

public class LucrareAdminDTO {
    private int idLucrare;
    private String numeClient;
    private String masina; // Marca + Model + Nr
    private String numeMecanic;
    private String dataInitiala; // Cand a inceput lucrarea
    private String descriere;
    private double pret; // Va fi 0 la inceput
    private String status;

    // --- Getters si Setters ---
    public int getIdLucrare() { return idLucrare; }
    public void setIdLucrare(int idLucrare) { this.idLucrare = idLucrare; }

    public String getNumeClient() { return numeClient; }
    public void setNumeClient(String numeClient) { this.numeClient = numeClient; }

    public String getMasina() { return masina; }
    public void setMasina(String masina) { this.masina = masina; }

    public String getNumeMecanic() { return numeMecanic; }
    public void setNumeMecanic(String numeMecanic) { this.numeMecanic = numeMecanic; }

    public String getDataInitiala() { return dataInitiala; }
    public void setDataInitiala(String dataInitiala) { this.dataInitiala = dataInitiala; }

    public String getDescriere() { return descriere; }
    public void setDescriere(String descriere) { this.descriere = descriere; }

    public double getPret() { return pret; }
    public void setPret(double pret) { this.pret = pret; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}