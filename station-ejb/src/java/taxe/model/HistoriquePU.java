package taxe.model;

import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import taxe.util.DateUtil;

public class HistoriquePU extends ClassMAPTable {
    private String id;
    private String idCommune;
    private double pu;
    private int mois;
    private int annee;
    
    public HistoriquePU() {
        setNomTable("historique_pu");
    }
    
    // Getters and Setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }
    
    public String getIdCommune() { return idCommune; }
    public void setIdCommune(String idCommune) { this.idCommune = idCommune; }
    
    public double getPu() { return pu; }
    public void setPu(double pu) { this.pu = pu; }
    
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
        String sql = "INSERT INTO historique_pu (id, idcommune, pu, mois, annee) " +
                     "VALUES (generate_id('PU', seq_historique_pu.NEXTVAL), ?, ?, ?, ?)";
                     
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, getIdCommune());
            stmt.setDouble(2, getPu());
            stmt.setInt(3, getMois());
            stmt.setInt(4, getAnnee());
            
            stmt.executeUpdate();
        }
    }
    
    public static double getPUForDate(Connection connection, String idCommune, int mois, int annee) throws SQLException {
        String query = "SELECT pu FROM historique_pu WHERE idcommune = ? AND mois = ? AND annee = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, idCommune);
            stmt.setInt(2, mois);
            stmt.setInt(3, annee);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getDouble("pu");
                }
            }
        }
        throw new SQLException("Aucun prix unitaire défini pour cette période");
    }
    
    public static double getLastPU(Connection connection, String idCommune) throws SQLException {
        String query = "SELECT pu FROM (" +
                      "  SELECT pu FROM historique_pu " +
                      "  WHERE idcommune = ? " +
                      "  ORDER BY annee DESC, mois DESC" +
                      ") WHERE ROWNUM = 1";
                      
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, idCommune);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getDouble("pu");
                }
            }
        }
        return 0.0; // Valeur par défaut si aucun PU n'est trouvé
    }
    
    public static HistoriquePU getPUForDateComplet(Connection connection, String idCommune, int mois, int annee) throws SQLException {
        String query = "SELECT * FROM historique_pu WHERE idcommune = ? AND mois = ? AND annee = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, idCommune);
            stmt.setInt(2, mois);
            stmt.setInt(3, annee);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    HistoriquePU historiquePU = new HistoriquePU();
                    historiquePU.setId(rs.getString("id"));
                    historiquePU.setIdCommune(rs.getString("idcommune"));
                    historiquePU.setPu(rs.getDouble("pu"));
                    historiquePU.setMois(rs.getInt("mois"));
                    historiquePU.setAnnee(rs.getInt("annee"));
                    return historiquePU;
                }
            }
        }
        return null; // Retourne null si aucun PU n'est trouvé pour cette date
    }
    
    public static HistoriquePU getLastPUComplet(Connection connection, String idCommune) throws SQLException {
        String query = "SELECT * FROM (" +
                      "  SELECT * FROM historique_pu " +
                      "  WHERE idcommune = ? " +
                      "  ORDER BY annee DESC, mois DESC" +
                      ") WHERE ROWNUM = 1";
                      
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, idCommune);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    HistoriquePU historiquePU = new HistoriquePU();
                    historiquePU.setId(rs.getString("id"));
                    historiquePU.setIdCommune(rs.getString("idcommune"));
                    historiquePU.setPu(rs.getDouble("pu"));
                    historiquePU.setMois(rs.getInt("mois"));
                    historiquePU.setAnnee(rs.getInt("annee"));
                    return historiquePU;
                }
            }
        }
        return null; // Retourne null si aucun PU n'est trouvé
    }
    
    // Méthode utilitaire pour formater le mois en texte
    public String getMoisTexte() {
        return DateUtil.getMoisTexte(this.mois);
    }
    
    @Override
    public String toString() {
        return String.format("PU: %.2f Ar/m² (%s %d)", pu, getMoisTexte(), annee);
    }
} 