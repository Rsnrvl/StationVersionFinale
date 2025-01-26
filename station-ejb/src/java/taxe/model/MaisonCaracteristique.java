package taxe.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import bean.ClassMAPTable;

public class MaisonCaracteristique extends ClassMAPTable {
    private String id;
    private String idMaison;
    private String idCaracteristique;
    
    // Constructors
    public MaisonCaracteristique() {
        setNomTable("maison_caracteristique");
    }
    
    // Getters and Setters
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdMaison() {
        return idMaison;
    }

    public void setIdMaison(String idMaison) {
        this.idMaison = idMaison;
    }

    public String getIdCaracteristique() {
        return idCaracteristique;
    }

    public void setIdCaracteristique(String idCaracteristique) {
        this.idCaracteristique = idCaracteristique;
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
        String sql = "INSERT INTO maison_caracteristique (id, idmaison, idcaracteristique) " +
                     "VALUES (generate_id('MCA', seq_maison_caracteristique.NEXTVAL), ?, ?)";
                     
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, this.getIdMaison());
            stmt.setString(2, this.getIdCaracteristique());
            
            stmt.executeUpdate();
        }
    }

    public int deleteToTable(Connection connection) throws SQLException {
        String query = "DELETE FROM maison_caracteristique WHERE id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, getId());
            return preparedStatement.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Erreur lors de la suppression : " + e.getMessage());
            throw e;
        }
    }

    public static ArrayList<MaisonCaracteristique> getAll(Connection connection) throws SQLException {
        String query = "SELECT id, idmaison, idcaracteristique FROM maison_caracteristique";
        ArrayList<MaisonCaracteristique> maisonCaracteristiques = new ArrayList<>();
        try (PreparedStatement preparedStatement = connection.prepareStatement(query);
             ResultSet resultSet = preparedStatement.executeQuery()) {
            while (resultSet.next()) {
                MaisonCaracteristique maisonCaracteristique = new MaisonCaracteristique();
                maisonCaracteristique.setId(resultSet.getString("id"));
                maisonCaracteristique.setIdMaison(resultSet.getString("idmaison"));
                maisonCaracteristique.setIdCaracteristique(resultSet.getString("idcaracteristique"));
                maisonCaracteristiques.add(maisonCaracteristique);
            }
        }
        return maisonCaracteristiques;
    }

    public int updateToTable(Connection connection) throws SQLException {
        String query = "UPDATE maison_caracteristique SET idmaison = ?, idcaracteristique = ? WHERE id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, getIdMaison());
            preparedStatement.setString(2, getIdCaracteristique());
            preparedStatement.setString(3, getId());
            return preparedStatement.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Erreur lors de la mise à jour : " + e.getMessage());
            throw e;
        }
    }

    public static MaisonCaracteristique getById(Connection connection, String id) throws SQLException {
        String query = "SELECT id, idmaison, idcaracteristique FROM maison_caracteristique WHERE id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, id);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    MaisonCaracteristique maisonCaracteristique = new MaisonCaracteristique();
                    maisonCaracteristique.setId(resultSet.getString("id"));
                    maisonCaracteristique.setIdMaison(resultSet.getString("idmaison"));
                    maisonCaracteristique.setIdCaracteristique(resultSet.getString("idcaracteristique"));
                    return maisonCaracteristique;
                }
            }
        }
        return null;
    }
}