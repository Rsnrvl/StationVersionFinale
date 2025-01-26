package taxe.model;

import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import taxe.util.DateUtil;

public class HistoriqueCaracteristique extends ClassMAPTable {
    private String id;
    private String idMaison;
    private String idCaracteristique;
    private double coefficient;
    private int mois;
    private int annee;
    
    public HistoriqueCaracteristique() {
        setNomTable("historique_caracteristique");
    }
    
    // Getters and Setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }
    
    public String getIdMaison() { return idMaison; }
    public void setIdMaison(String idMaison) { this.idMaison = idMaison; }
    
    public String getIdCaracteristique() { return idCaracteristique; }
    public void setIdCaracteristique(String idCaracteristique) { this.idCaracteristique = idCaracteristique; }
    
    public double getCoefficient() { return coefficient; }
    public void setCoefficient(double coefficient) { this.coefficient = coefficient; }
    
    public int getMois() { return mois; }
    public void setMois(int mois) { this.mois = mois; }
    
    public int getAnnee() { return annee; }
    public void setAnnee(int annee) { this.annee = annee; }
    
    @Override
    public String getAttributIDName() {
        return "id";
    }
    
    @Override
    public String getTuppleID() {
        return getId();
    }
    
    public void createObject(Connection connection) throws Exception {
        String sql = "INSERT INTO historique_caracteristique (id, idmaison, idcaracteristique, coefficient, mois, annee) " +
                     "VALUES (generate_id('HC', seq_historique_caracteristique.NEXTVAL), ?, ?, ?, ?, ?)";
                     
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, getIdMaison());
            stmt.setString(2, getIdCaracteristique());
            stmt.setDouble(3, getCoefficient());
            stmt.setInt(4, getMois());
            stmt.setInt(5, getAnnee());
            
            stmt.executeUpdate();
        }
    }
    
    public String getMoisTexte() {
        return DateUtil.getMoisTexte(this.mois);
    }
    
    @Override
    public String toString() {
        return String.format("Coefficient: %.2f (%s %d)", coefficient, getMoisTexte(), annee);
    }
    
    public static HistoriqueCaracteristique getForDate(Connection connection, String idMaison, String idCaracteristique, int mois, int annee) throws SQLException {
        String query = "SELECT * FROM historique_caracteristique " +
                      "WHERE idmaison = ? AND idcaracteristique = ? " +
                      "AND mois = ? AND annee = ?";
                      
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, idMaison);
            stmt.setString(2, idCaracteristique);
            stmt.setInt(3, mois);
            stmt.setInt(4, annee);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    HistoriqueCaracteristique historique = new HistoriqueCaracteristique();
                    historique.setId(rs.getString("id"));
                    historique.setIdMaison(rs.getString("idmaison"));
                    historique.setIdCaracteristique(rs.getString("idcaracteristique"));
                    historique.setCoefficient(rs.getDouble("coefficient"));
                    historique.setMois(rs.getInt("mois"));
                    historique.setAnnee(rs.getInt("annee"));
                    return historique;
                }
            }
        }
        return null;
    }
} 