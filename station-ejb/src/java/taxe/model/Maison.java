package taxe.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import bean.ClassMAPTable;
import bean.ClassGeom;
import org.postgis.PGgeometry;
import org.postgis.Point;
import taxe.util.EtatTaxe;

public class Maison extends ClassGeom {
    private String id;
    private String libelle;
    private double longueur;
    private double largeur; 
    private int etage;
    private double longitude;
    private double latitude;
    private String idProprietaire;
    private String idCommune;

    public Maison() {
        setNomTable("maison");
    }

    // Getters and setters
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getLibelle() {
        return libelle;
    }

    public void setLibelle(String libelle) {
        this.libelle = libelle;
    }

    public double getLongueur() {
        return longueur;
    }

    public void setLongueur(double longueur) {
        this.longueur = longueur;
    }

    public double getLargeur() {
        return largeur;
    }

    public void setLargeur(double largeur) {
        this.largeur = largeur;
    }

    public int getEtage() {
        return etage;
    }

    public void setEtage(int etage) {
        this.etage = etage;
    }

    public double getLongitude() {
        return longitude;
    }

    public void setLongitude(double longitude) {
        this.longitude = longitude;
    }

    public double getLatitude() {
        return latitude;
    }

    public void setLatitude(double latitude) {
        this.latitude = latitude;
    }

    public String getIdProprietaire() {
        return idProprietaire;
    }

    public void setIdProprietaire(String idProprietaire) {
        this.idProprietaire = idProprietaire;
    }

    public String getIdCommune() {
        return idCommune;
    }

    public void setIdCommune(String idCommune) {
        this.idCommune = idCommune;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    @Override
    public String getTuppleID() {
        return getId();
    }

    @Override
    public PGgeometry getGeom() {
        try {
            Point point = new Point(getLongitude(), getLatitude());
            point.setSrid(4326); // WGS84 SRID
            return new PGgeometry(point);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override 
    public void setGeom(PGgeometry geom) {
        if (geom != null && geom.getGeometry() instanceof Point) {
            Point point = (Point) geom.getGeometry();
            setLongitude(point.getX());
            setLatitude(point.getY());
        }
    }

    public void createObject(Connection connection) throws Exception {
        String sql = "INSERT INTO maison (id, libelle, longueur, largeur, etage, longitude, latitude, idproprietaire, idcommune) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
                     
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, this.getId());
            stmt.setString(2, this.getLibelle());
            stmt.setDouble(3, this.getLongueur());
            stmt.setDouble(4, this.getLargeur());
            stmt.setInt(5, this.getEtage());
            stmt.setDouble(6, this.getLongitude());
            stmt.setDouble(7, this.getLatitude());
            stmt.setString(8, this.getIdProprietaire());
            stmt.setString(9, this.getIdCommune());
            
            stmt.executeUpdate();
        }
    }

    public int deleteToTable(Connection connection) throws SQLException {
        String query = "DELETE FROM maison WHERE id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, getId());
            int rowsDeleted = preparedStatement.executeUpdate();
            return rowsDeleted; // Retourne le nombre de lignes supprimées
        } catch (SQLException e) {
            System.err.println("Erreur lors de la suppression : " + e.getMessage());
            throw e;
        }
    }

    public static ArrayList<Maison> getAll(Connection connection) throws SQLException {
        String query = "SELECT id, libelle, longueur, largeur, etage, longitude, latitude, geom FROM maison";
        ArrayList<Maison> maisons = new ArrayList<>();
        try (PreparedStatement preparedStatement = connection.prepareStatement(query);
             ResultSet resultSet = preparedStatement.executeQuery()) {
            while (resultSet.next()) {
                Maison maison = new Maison();
                maison.setId(resultSet.getString("id"));
                maison.setLibelle(resultSet.getString("libelle"));
                maison.setLongueur(resultSet.getDouble("longueur"));
                maison.setLargeur(resultSet.getDouble("largeur"));
                maison.setEtage(resultSet.getInt("etage"));
                maison.setLongitude(resultSet.getDouble("longitude"));
                maison.setLatitude(resultSet.getDouble("latitude"));
                // Set geom using longitude/latitude
                maison.setGeom(new PGgeometry(
                    new Point(maison.getLongitude(), maison.getLatitude())
                ));
                maisons.add(maison);
            }
        }
        return maisons;
    }

    public int updateToTable(Connection connection) throws SQLException {
        String query = "UPDATE maison SET libelle = ?, longueur = ?, largeur = ?, etage = ?, longitude = ?, latitude = ? " +
                       "WHERE id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, getLibelle());
            preparedStatement.setDouble(2, getLongueur());
            preparedStatement.setDouble(3, getLargeur());
            preparedStatement.setInt(4, getEtage());
            preparedStatement.setDouble(5, getLongitude());
            preparedStatement.setDouble(6, getLatitude());
            preparedStatement.setString(7, getId());
    
            int rowsUpdated = preparedStatement.executeUpdate();
            return rowsUpdated; // Retourne le nombre de lignes mises à jour
        } catch (SQLException e) {
            System.err.println("Erreur lors de la mise à jour : " + e.getMessage());
            throw e;
        }
    }

    public static Maison getById(Connection connection, String id) throws SQLException {
        String query = "SELECT id, libelle, longueur, largeur, etage, longitude, latitude FROM maison WHERE id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, id);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    Maison maison = new Maison();
                    maison.setId(resultSet.getString("id"));
                    maison.setLibelle(resultSet.getString("libelle"));
                    maison.setLongueur(resultSet.getDouble("longueur"));
                    maison.setLargeur(resultSet.getDouble("largeur"));
                    maison.setEtage(resultSet.getInt("etage"));
                    maison.setLongitude(resultSet.getDouble("longitude"));
                    maison.setLatitude(resultSet.getDouble("latitude"));
                    return maison;
                }
            }
        }
        return null; // Si aucune maison n'est trouvée
    }

    public double getSurface() {
        return this.longueur * this.largeur;
    }

    public double getSurfaceHabitable() {
        return this.getSurface() * this.etage;
    }

    public double getTaxeBase() {
        return this.getSurfaceHabitable() * 1.0; // Assuming config is 1.0 for simplicity
    }

    public Proprietaire getProprietaire(Connection connection) throws SQLException {
        return Proprietaire.getById(connection, getIdProprietaire());
    }

    public double getRealTaxe(Connection connection) throws SQLException {
        String query = "SELECT c.coefficient " +
                      "FROM maison_caracteristique mc " +
                      "JOIN caracteristique c ON mc.idcaracteristique = c.id " +
                      "WHERE mc.idmaison = ?";

        double coefficientTotal = 1.0; // Start with 1 as we'll multiply coefficients
        
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, getId());
            
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    coefficientTotal *= resultSet.getDouble("coefficient");
                }
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors du calcul de la taxe réelle : " + e.getMessage());
            throw e;
        }

        return getTaxeBase() * coefficientTotal;
    }    

    public EtatTaxe getEtat(Connection connection, int annee) throws SQLException {
        String query = "SELECT COUNT(*) as mois_payes " +
                      "FROM historique_taxe " +
                      "WHERE idmaison = ? " +
                      "AND EXTRACT(YEAR FROM daty) = ?";

        int moisPayes = 0;
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, getId());
            preparedStatement.setInt(2, annee);
            
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    moisPayes = resultSet.getInt("mois_payes");
                }
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors du calcul de l'état des taxes : " + e.getMessage());
            throw e;
        }

        double taxeMensuelle = getRealTaxe(connection);
        int moisRestants = 12 - moisPayes;
        
        double montantPaye = taxeMensuelle * moisPayes;
        double montantRestant = taxeMensuelle * moisRestants;

        return new EtatTaxe(montantPaye, montantRestant, moisPayes, moisRestants);
    }

    public static ArrayList<Maison> getAllByCommune(Connection connection, String idCommune) throws Exception {
        String sql = "SELECT * FROM maison WHERE idcommune = ?";
        ArrayList<Maison> maisons = new ArrayList<>();
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, idCommune);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Maison maison = new Maison();
                    maison.setId(rs.getString("id"));
                    maison.setLibelle(rs.getString("libelle"));
                    maison.setLongueur(rs.getDouble("longueur"));
                    maison.setLargeur(rs.getDouble("largeur"));
                    maison.setEtage(rs.getInt("etage"));
                    maison.setLongitude(rs.getDouble("longitude"));
                    maison.setLatitude(rs.getDouble("latitude"));
                    maison.setIdProprietaire(rs.getString("idproprietaire"));
                    maison.setIdCommune(rs.getString("idcommune"));
                    maisons.add(maison);
                }
            }
        }
        return maisons;
    }
}