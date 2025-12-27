package ro.serviceauto.serviceauto.model;

public class Vehicul {
    private int idv;
    private String serieSasiu;
    private String marca;
    private String model;
    private String tip;
    private String motor;
    private String nrInmatriculare;

    // FARA idc sau numeProprietar

    // Getters si Setters
    public int getIdv() { return idv; }
    public void setIdv(int idv) { this.idv = idv; }

    public String getSerieSasiu() { return serieSasiu; }
    public void setSerieSasiu(String serieSasiu) { this.serieSasiu = serieSasiu; }

    public String getMarca() { return marca; }
    public void setMarca(String marca) { this.marca = marca; }

    public String getModel() { return model; }
    public void setModel(String model) { this.model = model; }

    public String getTip() { return tip; }
    public void setTip(String tip) { this.tip = tip; }

    public String getMotor() { return motor; }
    public void setMotor(String motor) { this.motor = motor; }

    public String getNrInmatriculare() { return nrInmatriculare; }
    public void setNrInmatriculare(String nrInmatriculare) { this.nrInmatriculare = nrInmatriculare; }
}