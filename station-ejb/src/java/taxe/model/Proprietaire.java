package taxe.model;

import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class Proprietaire extends ClassMAPTable {
    private String id;
    private String nom;
    private String prenom;
    private String cin;
    private String adresse;
    
    public Proprietaire() {
        setNomTable("proprietaire");
    }
    
    // Getters and Setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }
    
    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }
    
    public String getPrenom() { return prenom; }
    public void setPrenom(String prenom) { this.prenom = prenom; }
    
    public String getCin() { return cin; }
    public void setCin(String cin) { this.cin = cin; }
    
    public String getAdresse() { return adresse; }
    public void setAdresse(String adresse) { this.adresse = adresse; }
    
    @Override
    public String getAttributIDName() {
        return "id";
    }

    @Override
    public String getTuppleID() {
        return getId();
    }
    
    public void createObject(Connection connection) throws Exception {
        String sql = "INSERT INTO proprietaire (id, nom, prenom, cin, adresse) " +
                     "VALUES (generate_id('PRO', seq_proprietaire.NEXTVAL), ?, ?, ?, ?)";
                     
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, getNom());
            stmt.setString(2, getPrenom());
            stmt.setString(3, getCin());
            stmt.setString(4, getAdresse());
            
            stmt.executeUpdate();
        }
    }
    
    public static ArrayList<Proprietaire> getAll(Connection connection) throws SQLException {
        String query = "SELECT * FROM proprietaire ORDER BY nom, prenom";
        ArrayList<Proprietaire> proprietaires = new ArrayList<>();
        
        try (PreparedStatement stmt = connection.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Proprietaire prop = new Proprietaire();
                prop.setId(rs.getString("id"));
                prop.setNom(rs.getString("nom"));
                prop.setPrenom(rs.getString("prenom"));
                prop.setCin(rs.getString("cin"));
                prop.setAdresse(rs.getString("adresse"));
                proprietaires.add(prop);
            }
        }
        return proprietaires;
    }

    public static Proprietaire getById(Connection connection, String id) throws SQLException {
        String query = "SELECT * FROM proprietaire WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Proprietaire prop = new Proprietaire();
                    prop.setId(rs.getString("id"));
                    prop.setNom(rs.getString("nom"));
                    prop.setPrenom(rs.getString("prenom"));
                    prop.setCin(rs.getString("cin"));
                    prop.setAdresse(rs.getString("adresse"));
                    return prop;
                }
            }
        }
        return null; // Si aucun propriétaire n'est trouvé
    }   
} 