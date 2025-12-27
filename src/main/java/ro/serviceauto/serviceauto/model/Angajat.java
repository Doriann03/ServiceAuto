package ro.serviceauto.serviceauto.model;

public class Angajat {
    private int idAngajat;
    private String nume;
    private String prenume;
    private String functie;
    private int ida; // ID Atelier (Foreign Key)

    // Camp ajutator pentru afisare (nu exista fizic in tabela Angajat, vine din JOIN)
    private String numeAtelier;

    // Getters si Setters
    public int getIdAngajat() { return idAngajat; }
    public void setIdAngajat(int idAngajat) { this.idAngajat = idAngajat; }

    public String getNume() { return nume; }
    public void setNume(String nume) { this.nume = nume; }

    public String getPrenume() { return prenume; }
    public void setPrenume(String prenume) { this.prenume = prenume; }

    public String getFunctie() { return functie; }
    public void setFunctie(String functie) { this.functie = functie; }

    public int getIda() { return ida; }
    public void setIda(int ida) { this.ida = ida; }

    public String getNumeAtelier() { return numeAtelier; }
    public void setNumeAtelier(String numeAtelier) { this.numeAtelier = numeAtelier; }
}