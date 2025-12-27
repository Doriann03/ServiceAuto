package ro.serviceauto.serviceauto.model;

public class IstoricClient {
    private int id;
    private int idc;
    private String numeClient;
    private String actiune;
    private String dataOra;

    // Getters si Setters standard
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getIdc() { return idc; }
    public void setIdc(int idc) { this.idc = idc; }
    public String getNumeClient() { return numeClient; }
    public void setNumeClient(String numeClient) { this.numeClient = numeClient; }
    public String getActiune() { return actiune; }
    public void setActiune(String actiune) { this.actiune = actiune; }
    public String getDataOra() { return dataOra; }
    public void setDataOra(String dataOra) { this.dataOra = dataOra; }
}