package ro.serviceauto.serviceauto.model;

public class MaterialePiese {
    private int idMat;
    private String denumire;
    private int cantitate;
    private double pretUnitar; // Pret per bucata/litru
    private int ids; // FK catre Serviciu

    // Camp ajutator pentru afisare (JOIN)
    private String numeServiciu;

    // Getters si Setters
    public int getIdMat() { return idMat; }
    public void setIdMat(int idMat) { this.idMat = idMat; }

    public String getDenumire() { return denumire; }
    public void setDenumire(String denumire) { this.denumire = denumire; }

    public int getCantitate() { return cantitate; }
    public void setCantitate(int cantitate) { this.cantitate = cantitate; }

    public double getPretUnitar() { return pretUnitar; }
    public void setPretUnitar(double pretUnitar) { this.pretUnitar = pretUnitar; }

    public int getIds() { return ids; }
    public void setIds(int ids) { this.ids = ids; }

    public String getNumeServiciu() { return numeServiciu; }
    public void setNumeServiciu(String numeServiciu) { this.numeServiciu = numeServiciu; }
}