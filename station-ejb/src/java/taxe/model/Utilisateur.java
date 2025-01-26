package taxe.model;

import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class Utilisateur extends ClassMAPTable {
    private String id;
    private String nomcommune;
    private String mdp;
    
    public Utilisateur() {
        this.setNomTable("utilisateur");
    }
    
    // Getters et Setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }
    
    public String getNomcommune() { return nomcommune; }
    public void setNomcommune(String nomcommune) { this.nomcommune = nomcommune; }
    
    public String getMdp() { return mdp; }
    public void setMdp(String mdp) { this.mdp = mdp; }
    
    // Méthodes obligatoires de ClassMAPTable
    @Override
    public String getAttributIDName() {
        return "id";
    }

    @Override
    public String getTuppleID() {
        return getId();
    }

    @Override
    public void construirePK(Connection c) throws Exception {
        setId(makePK(c));
    }

    // CRUD Operations
    public void createObject(Connection connection) throws Exception {
        String sql = "INSERT INTO utilisateur (id, nomcommune, mdp) " +
                    "VALUES (generate_id('UTI', seq_utilisateur.NEXTVAL), ?, ?)";
                     
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, this.getNomcommune());
            stmt.setString(2, this.getMdp());
            
            stmt.executeUpdate();
        }
    }

    public int updateToTable(Connection connection) throws Exception {
        String query = "UPDATE utilisateur SET nomcommune = ?, mdp = ? WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, getNomcommune());
            stmt.setString(2, getMdp());
            stmt.setString(3, getId());
    
            return stmt.executeUpdate();
        }
    }

    public int deleteToTable(Connection connection) throws Exception {
        String query = "DELETE FROM utilisateur WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, getId());
            return stmt.executeUpdate();
        }
    }
    
    // Méthode d'authentification
    public static Utilisateur authenticate(Connection conn, String nomcommune, String mdp) throws Exception {
        String query = "SELECT * FROM utilisateur WHERE nomcommune = ? AND mdp = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, nomcommune);
            pstmt.setString(2, mdp);
            
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                Utilisateur user = new Utilisateur();
                user.setId(rs.getString("id"));
                user.setNomcommune(rs.getString("nomcommune"));
                user.setMdp(rs.getString("mdp"));
                return user;
            }
        }
        return null;
    }
    
    // Méthode pour récupérer tous les utilisateurs
    public static ArrayList<Utilisateur> getAll(Connection conn) throws Exception {
        ArrayList<Utilisateur> users = new ArrayList<>();
        String query = "SELECT * FROM utilisateur ORDER BY nomcommune";
        
        try (PreparedStatement pstmt = conn.prepareStatement(query)) {
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Utilisateur user = new Utilisateur();
                user.setId(rs.getString("id"));
                user.setNomcommune(rs.getString("nomcommune"));
                user.setMdp(rs.getString("mdp"));
                users.add(user);
            }
        }
        return users;
    }

    @Override
    public void controler(Connection c) throws Exception {
        if (getNomcommune() == null || getNomcommune().trim().isEmpty()) {
            throw new Exception("Le nom de la commune est obligatoire");
        }
        if (getMdp() == null || getMdp().trim().isEmpty()) {
            throw new Exception("Le mot de passe est obligatoire");
        }
    }

    @Override
    public void controlerUpdate(Connection c) throws Exception {
        controler(c);
        if (getId() == null || getId().trim().isEmpty()) {
            throw new Exception("ID invalide pour la mise à jour");
        }
    }
} 