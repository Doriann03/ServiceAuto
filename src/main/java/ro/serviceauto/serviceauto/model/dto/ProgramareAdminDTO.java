package ro.serviceauto.serviceauto.model.dto;

public class ProgramareAdminDTO {
    private int idProgramare;
    private String numeClient;     // Nume + Prenume
    private String telefonClient;
    private String marcaModel;     // Vehicul
    private String nrInmatriculare;
    private String dataProgramare;
    private String status;

    // --- GETTERS si SETTERS Manuali ---
    public int getIdProgramare() { return idProgramare; }
    public void setIdProgramare(int idProgramare) { this.idProgramare = idProgramare; }

    public String getNumeClient() { return numeClient; }
    public void setNumeClient(String numeClient) { this.numeClient = numeClient; }

    public String getTelefonClient() { return telefonClient; }
    public void setTelefonClient(String telefonClient) { this.telefonClient = telefonClient; }

    public String getMarcaModel() { return marcaModel; }
    public void setMarcaModel(String marcaModel) { this.marcaModel = marcaModel; }

    public String getNrInmatriculare() { return nrInmatriculare; }
    public void setNrInmatriculare(String nrInmatriculare) { this.nrInmatriculare = nrInmatriculare; }

    public String getDataProgramare() { return dataProgramare; }
    public void setDataProgramare(String dataProgramare) { this.dataProgramare = dataProgramare; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}