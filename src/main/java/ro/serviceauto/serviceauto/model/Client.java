package ro.serviceauto.serviceauto.model;

import lombok.Data;

@Data
public class Client {
    private int idc;
    private String nume;
    private String prenume;
    private String telefon;
    private String email;
    private String username;
    private String password;
    private String tipUtilizator; // 'Admin' sau 'Client'
}