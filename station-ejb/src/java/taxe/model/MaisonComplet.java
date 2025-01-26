package taxe.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.chrono.ThaiBuddhistChronology;
import java.util.function.Supplier;
import java.util.ArrayList;
import taxe.util.DateUtil;
import taxe.util.EtatTaxe;

public class MaisonComplet extends Maison {
    private double surfaceTotale;
    private int nbEtages;
    private double prixUnitaire;
    private int mois;
    private int annee;
    private ArrayList<HistoriqueCaracteristique> caracteristiques;
    
    // Getters supplémentaires
    public double getSurfaceTotale() { return surfaceTotale; }
    public int getNbEtages() { return nbEtages; }
    public double getPrixUnitaire() { return prixUnitaire; }
    public int getMois() { return mois; }
    public int getAnnee() { return annee; }
    public ArrayList<HistoriqueCaracteristique> getCaracteristiques() { return caracteristiques; }
    
    // Méthode pour charger les informations historiques
    public static MaisonComplet getMaisonWithHistory(Connection connection, String idMaison, int mois, int annee) throws SQLException {
        HistoriquePU historiquePU = null;
        double pu = 0;
        try {
            String queryMaison = "SELECT m.*, hm.surface_totale, hm.nbetages, m.idcommune " +
                               "FROM maison m " +
                               "LEFT JOIN historique_maison hm ON m.id = hm.idmaison " +
                               "WHERE m.id = ?"+
                               "AND hm.mois = ? AND hm.annee = ? ";
            try (PreparedStatement stmt = connection.prepareStatement(queryMaison)) {
                
                stmt.setString(1, idMaison);
                stmt.setInt(2, mois);
                stmt.setInt(3, annee);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    String idCommune = rs.getString("idcommune");
                    historiquePU = HistoriquePU.getPUForDateComplet(connection, idCommune, mois, annee);
                    pu = historiquePU.getPu();
                    
                    MaisonComplet maisonComplet = new MaisonComplet();
                    maisonComplet.setId(rs.getString("id"));
                    maisonComplet.setLibelle(rs.getString("libelle"));
                    maisonComplet.setLongueur(rs.getDouble("longueur"));
                    maisonComplet.setLargeur(rs.getDouble("largeur"));
                    maisonComplet.setEtage(rs.getInt("etage"));
                    maisonComplet.setLongitude(rs.getDouble("longitude"));
                    maisonComplet.setLatitude(rs.getDouble("latitude"));
                    maisonComplet.setIdProprietaire(rs.getString("idproprietaire"));
                    maisonComplet.setIdCommune(idCommune);
                    
                    maisonComplet.surfaceTotale = rs.getDouble("surface_totale");
                    maisonComplet.nbEtages = rs.getInt("nbetages");
                    maisonComplet.prixUnitaire = pu;
                    maisonComplet.mois = mois;
                    maisonComplet.annee = annee;
                    
                    // Charger les caractéristiques historiques
                    maisonComplet.caracteristiques = getCaracteristiquesForDate(connection, idMaison, mois, annee);
                    
                    return maisonComplet;
                }
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la récupération : " + e.getMessage());
            throw e;
        }
        return null;
    }
    
    // Méthode pour récupérer les caractéristiques historiques
    private static ArrayList<HistoriqueCaracteristique> getCaracteristiquesForDate(Connection connection, String idMaison, int mois, int annee) throws SQLException {
        ArrayList<HistoriqueCaracteristique> caracteristiques = new ArrayList<>();
        
        String query = "SELECT hc.*, c.libelle as caracteristique_libelle " +
                      "FROM historique_caracteristique hc " +
                      "JOIN caracteristique c ON hc.idcaracteristique = c.id " +
                      "WHERE hc.idmaison = ? AND hc.mois = ? AND hc.annee = ?";
                      
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, idMaison);
            stmt.setInt(2, mois);
            stmt.setInt(3, annee);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    HistoriqueCaracteristique historique = new HistoriqueCaracteristique();
                    historique.setId(rs.getString("id"));
                    historique.setIdMaison(rs.getString("idmaison"));
                    historique.setIdCaracteristique(rs.getString("idcaracteristique"));
                    historique.setCoefficient(rs.getDouble("coefficient"));
                    historique.setMois(rs.getInt("mois"));
                    historique.setAnnee(rs.getInt("annee"));
                    caracteristiques.add(historique);
                }
            }
        }
        return caracteristiques;
    }
    public double produitCoefficient() {
        double somme = 1;
        for (HistoriqueCaracteristique caract : caracteristiques) {
            somme *= caract.getCoefficient();
        }
        return somme;
    }
    // Méthode pour calculer la taxe
    public double calculerTaxe() {
        if (surfaceTotale > 0 && prixUnitaire > 0) {
            double taxeBase = surfaceTotale * prixUnitaire;
            
            // Appliquer les coefficients des caractéristiques
            if (caracteristiques != null && !caracteristiques.isEmpty()) {
                double coefficientTotal = 1.0;
                for (HistoriqueCaracteristique caract : caracteristiques) {
                    coefficientTotal *= caract.getCoefficient();
                }
                return taxeBase * coefficientTotal;
            }
            return taxeBase;
        }
        return 0.0;
    }
    
    // Méthode pour formater l'affichage
    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(String.format("%s - Surface: %.2f m² - PU: %.2f Ar/m² (%s %d)", 
            getLibelle(), surfaceTotale, prixUnitaire, DateUtil.getMoisTexte(mois), annee));
        
        if (caracteristiques != null && !caracteristiques.isEmpty()) {
            sb.append("\nCaractéristiques :");
            for (HistoriqueCaracteristique caract : caracteristiques) {
                sb.append(String.format("\n  - Coefficient: %.2f", caract.getCoefficient()));
            }
        }
        
        return sb.toString();
    }
    
    // Méthode pour obtenir la dernière taxe mensuelle
    private double getDerniereTaxeMensuelle(Connection connection) throws SQLException {
        HistoriquePU dernierPU = HistoriquePU.getLastPUComplet(connection, this.getIdCommune());
        if (dernierPU == null) return 0.0;
        
        String query = "SELECT * FROM (" +
                      "  SELECT surface_totale, nbetages FROM historique_maison " +
                      "  WHERE idmaison = ? " +
                      "  ORDER BY annee DESC, mois DESC" +
                      ") WHERE ROWNUM = 1";
                      
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, this.getId());
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                double surface = rs.getDouble("surface_totale");
                int nbEtages = rs.getInt("nbetages");
                return surface * dernierPU.getPu() * nbEtages;
            }
        }
        return 0.0;
    }

    // Méthode pour obtenir la taxe mensuelle pour un mois spécifique
    private double getTaxeMensuelle(Connection connection, int mois, int annee) throws SQLException {
        try {
            // Charger une instance complète de MaisonComplet pour le mois donné
            MaisonComplet maisonMois = MaisonComplet.getMaisonWithHistory(connection, this.getId(), mois, annee);
            if (maisonMois != null) {
                return maisonMois.calculerTaxe();
            }
            return 0.0;
        } catch (SQLException e) {
            System.err.println("Erreur lors du calcul de la taxe mensuelle : " + e.getMessage());
            throw e;
        }
    }

    @Override
    public EtatTaxe getEtat(Connection connection, int annee) throws SQLException {
        String query = "SELECT COUNT(*) as mois_payes " +
                      "FROM historique_taxe " +
                      "WHERE idmaison = ? " +
                      "AND EXTRACT(YEAR FROM daty) = ?";

        int moisPayes = 0;
        double montantPaye = 0.0;
        double montantRestant = 0.0;

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, getId());
            stmt.setInt(2, annee);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    moisPayes = rs.getInt("mois_payes");
                }
            }
        }

        // Calculer le montant payé
        for (int mois = 1; mois <= moisPayes; mois++) {
            montantPaye += getTaxeMensuelle(connection, mois, annee);
        }

        // Calculer le montant restant
        int moisRestants = 12 - moisPayes;
        for (int mois = moisPayes + 1; mois <= 12; mois++) {
            montantRestant += getTaxeMensuelle(connection, mois, annee);
        }

        return new EtatTaxe(montantPaye, montantRestant, moisPayes, moisRestants);
    }
} 