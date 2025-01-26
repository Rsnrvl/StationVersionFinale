package taxe.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import bean.ClassMAPTable;

public class Caracteristique extends ClassMAPTable {
    private String id;
    private double coefficient;
    private String libelle;
    private String idTypeCaracteristique;

    // Constructors
    public Caracteristique() {
        setNomTable("caracteristique");
    }
    
    // Getters and Setters
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public double getCoefficient() {
        return coefficient;
    }

    public void setCoefficient(double coefficient) {
        this.coefficient = coefficient;
    }

    public String getLibelle() {
        return libelle;
    }

    public void setLibelle(String libelle) {
        this.libelle = libelle;
    }

    public String getIdTypeCaracteristique() {
        return idTypeCaracteristique;
    }

    public void setIdTypeCaracteristique(String idTypeCaracteristique) {
        this.idTypeCaracteristique = idTypeCaracteristique;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    @Override
    public String getTuppleID() {
        return getId();
    }

    public void createObject(Connection connection) throws Exception {
        String sql = "INSERT INTO caracteristique (id, coefficient, libelle, idtypecaracteristique) " +
                     "VALUES (generate_id('CAR', seq_caracteristique.NEXTVAL), ?, ?, ?)";
                     
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setDouble(1, this.getCoefficient());
            stmt.setString(2, this.getLibelle());
            stmt.setString(3, this.getIdTypeCaracteristique());
            
            stmt.executeUpdate();
        }
    }

    public int deleteToTable(Connection connection) throws SQLException {
        String query = "DELETE FROM caracteristique WHERE id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, getId());
            return preparedStatement.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Erreur lors de la suppression : " + e.getMessage());
            throw e;
        }
    }

    public static ArrayList<Caracteristique> getAll(Connection connection) throws SQLException {
        String query = "SELECT id, coefficient, libelle, idtypecaracteristique FROM caracteristique";
        ArrayList<Caracteristique> caracteristiques = new ArrayList<>();
        try (PreparedStatement preparedStatement = connection.prepareStatement(query);
             ResultSet resultSet = preparedStatement.executeQuery()) {
            while (resultSet.next()) {
                Caracteristique caracteristique = new Caracteristique();
                caracteristique.setId(resultSet.getString("id"));
                caracteristique.setCoefficient(resultSet.getDouble("coefficient"));
                caracteristique.setLibelle(resultSet.getString("libelle"));
                caracteristique.setIdTypeCaracteristique(resultSet.getString("idtypecaracteristique"));
                caracteristiques.add(caracteristique);
            }
        }
        return caracteristiques;
    }

    public int updateToTable(Connection connection) throws SQLException {
        String query = "UPDATE caracteristique SET coefficient = ?, libelle = ?, idtypecaracteristique = ? WHERE id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setDouble(1, getCoefficient());
            preparedStatement.setString(2, getLibelle());
            preparedStatement.setString(3, getIdTypeCaracteristique());
            preparedStatement.setString(4, getId());
            return preparedStatement.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Erreur lors de la mise à jour : " + e.getMessage());
            throw e;
        }
    }

    public static Caracteristique getById(Connection connection, String id) throws SQLException {
        String query = "SELECT id, coefficient, libelle, idtypecaracteristique FROM caracteristique WHERE id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, id);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    Caracteristique caracteristique = new Caracteristique();
                    caracteristique.setId(resultSet.getString("id"));
                    caracteristique.setCoefficient(resultSet.getDouble("coefficient"));
                    caracteristique.setLibelle(resultSet.getString("libelle"));
                    caracteristique.setIdTypeCaracteristique(resultSet.getString("idtypecaracteristique"));
                    return caracteristique;
                }
            }
        }
        return null;
    }
}