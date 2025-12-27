package ro.serviceauto.serviceauto.model;

public class Serviciu {
    private int ids;
    private String nume;
    private String descriere;
    private int durataEstimata;
    private int ida; // ID Atelier (FK)

    // Camp extra pentru afisare (vine din JOIN)
    private String numeAtelier;

    // --- Getters si Setters ---
    public int getIds() { return ids; }
    public void setIds(int ids) { this.ids = ids; }

    public String getNume() { return nume; }
    public void setNume(String nume) { this.nume = nume; }

    public String getDescriere() { return descriere; }
    public void setDescriere(String descriere) { this.descriere = descriere; }

    public int getDurataEstimata() { return durataEstimata; }
    public void setDurataEstimata(int durataEstimata) { this.durataEstimata = durataEstimata; }

    public int getIda() { return ida; }
    public void setIda(int ida) { this.ida = ida; }

    public String getNumeAtelier() { return numeAtelier; }
    public void setNumeAtelier(String numeAtelier) { this.numeAtelier = numeAtelier; }
}