package taxe.model;

import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import taxe.util.DateUtil;

public class HistoriqueMaison extends ClassMAPTable {
    private String id;
    private String idMaison;
    private double surfaceTotale;
    private int nbEtages;
    private int mois;
    private int annee;
    
    public HistoriqueMaison() {
        setNomTable("historique_maison");
    }
    
    // Getters and Setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }
    
    public String getIdMaison() { return idMaison; }
    public void setIdMaison(String idMaison) { this.idMaison = idMaison; }
    
    public double getSurfaceTotale() { return surfaceTotale; }
    public void setSurfaceTotale(double surfaceTotale) { this.surfaceTotale = surfaceTotale; }
    
    public int getNbEtages() { return nbEtages; }
    public void setNbEtages(int nbEtages) { this.nbEtages = nbEtages; }
    
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
        String sql = "INSERT INTO historique_maison (id, idmaison, surface_totale, nbetages, mois, annee) " +
                     "VALUES (generate_id('HM', seq_historique_maison.NEXTVAL), ?, ?, ?, ?, ?)";
                     
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, getIdMaison());
            stmt.setDouble(2, getSurfaceTotale());
            stmt.setInt(3, getNbEtages());
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
        return String.format("Surface: %.2f m² - %d étages (%s %d)", 
                           surfaceTotale, nbEtages, getMoisTexte(), annee);
    }
} 