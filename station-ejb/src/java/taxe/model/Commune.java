package taxe.model;

import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class Commune extends ClassMAPTable {
    private String id;
    private String nom;
    private String mdp;
    
    public Commune() {
        setNomTable("commune");
    }
    
    // Getters and Setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }
    
    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }
    
    public String getMdp() { return mdp; }
    public void setMdp(String mdp) { this.mdp = mdp; }
    
    @Override
    public String getAttributIDName() {
        return "id";
    }
    
    @Override
    public String getTuppleID() {
        return getId();
    }
    
    public void createObject(Connection connection) throws Exception {
        String sql = "INSERT INTO commune (id, nom, mdp) " +
                     "VALUES (generate_id('COM', seq_commune.NEXTVAL), ?, ?)";
                     
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, getNom());
            stmt.setString(2, getMdp());
            
            stmt.executeUpdate();
        }
    }
    
    public static Commune authentifier(Connection connection, String nom, String mdp) throws SQLException {
        String query = "SELECT * FROM commune WHERE nom = ? AND mdp = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, nom);
            stmt.setString(2, mdp);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Commune commune = new Commune();
                    commune.setId(rs.getString("id"));
                    commune.setNom(rs.getString("nom"));
                    commune.setMdp(rs.getString("mdp"));
                    return commune;
                }
            }
        }
        return null;
    }
    public static Commune getById(Connection connection, String id) throws SQLException {
        String query = "SELECT * FROM commune WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Commune commune = new Commune();
                commune.setId(rs.getString("id"));
                commune.setNom(rs.getString("nom"));
                commune.setMdp(rs.getString("mdp"));
                return commune;
            }
        }
        return null;
    }
    public static Commune getByNom(Connection connection, String nom) throws SQLException {
        String query = "SELECT * FROM commune WHERE nom = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, nom);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Commune commune = new Commune();
                    commune.setId(rs.getString("id"));
                    commune.setNom(rs.getString("nom"));
                    commune.setMdp(rs.getString("mdp"));
                    return commune;
            }
        }
        return null;
    }
    public static ArrayList<Commune> getAll(Connection connection) throws SQLException {
        String query = "SELECT * FROM commune ORDER BY nom";
        ArrayList<Commune> communes = new ArrayList<>();
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Commune commune = new Commune();
                commune.setId(rs.getString("id"));
                commune.setNom(rs.getString("nom"));
                commune.setMdp(rs.getString("mdp"));
                communes.add(commune);
            }
        }   
        return communes;
    }

} 