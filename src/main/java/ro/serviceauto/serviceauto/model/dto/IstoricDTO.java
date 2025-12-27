package ro.serviceauto.serviceauto.model.dto;

public class IstoricDTO {
    private int idProgramare;
    private String dataProgramare;
    private String status;

    // Date despre masina (din JOIN)
    private String marcaModel;
    private String nrInmatriculare;

    // --- Getters si Setters manuali ---
    public int getIdProgramare() { return idProgramare; }
    public void setIdProgramare(int idProgramare) { this.idProgramare = idProgramare; }

    public String getDataProgramare() { return dataProgramare; }
    public void setDataProgramare(String dataProgramare) { this.dataProgramare = dataProgramare; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getMarcaModel() { return marcaModel; }
    public void setMarcaModel(String marcaModel) { this.marcaModel = marcaModel; }

    public String getNrInmatriculare() { return nrInmatriculare; }
    public void setNrInmatriculare(String nrInmatriculare) { this.nrInmatriculare = nrInmatriculare; }
}