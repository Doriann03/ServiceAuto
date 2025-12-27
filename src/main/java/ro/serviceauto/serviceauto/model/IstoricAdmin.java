package ro.serviceauto.serviceauto.model;

public class IstoricAdmin {
    private int id;
    private int idAdmin;
    private String numeAdmin;
    private String actiune; // Aici vom scrie ex: "UPDATE Vehicul ID 5"
    private String dataOra;

    // Getters si Setters standard
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getIdAdmin() { return idAdmin; }
    public void setIdAdmin(int idAdmin) { this.idAdmin = idAdmin; }
    public String getNumeAdmin() { return numeAdmin; }
    public void setNumeAdmin(String numeAdmin) { this.numeAdmin = numeAdmin; }
    public String getActiune() { return actiune; }
    public void setActiune(String actiune) { this.actiune = actiune; }
    public String getDataOra() { return dataOra; }
    public void setDataOra(String dataOra) { this.dataOra = dataOra; }
}