package taxe.model;

import bean.ClassMAPTable;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class HistoriqueTaxe extends ClassMAPTable {
    private String id;
    private String idMaison;
    private Date daty;

    public HistoriqueTaxe() {
        setNomTable("historique_taxe");
    }

    // Getters and setters
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

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
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
        String sql = "INSERT INTO historique_taxe (id, idmaison, daty) " +
                     "VALUES (generate_id('HTX', seq_historique_taxe.NEXTVAL), ?, ?)";
                     
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, this.getIdMaison());
            stmt.setDate(2, this.getDaty());
            
            stmt.executeUpdate();
        }
    }

    public int deleteToTable(Connection connection) throws SQLException {
        String query = "DELETE FROM historique_taxe WHERE id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, getId());
            return preparedStatement.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Erreur lors de la suppression : " + e.getMessage());
            throw e;
        }
    }

    public static ArrayList<HistoriqueTaxe> getAll(Connection connection) throws SQLException {
        String query = "SELECT id, idmaison, daty FROM historique_taxe";
        ArrayList<HistoriqueTaxe> historiques = new ArrayList<>();
        try (PreparedStatement preparedStatement = connection.prepareStatement(query);
             ResultSet resultSet = preparedStatement.executeQuery()) {
            while (resultSet.next()) {
                HistoriqueTaxe historique = new HistoriqueTaxe();
                historique.setId(resultSet.getString("id"));
                historique.setIdMaison(resultSet.getString("idmaison"));
                historique.setDaty(resultSet.getDate("daty"));
                historiques.add(historique);
            }
        }
        return historiques;
    }

    public int updateToTable(Connection connection) throws SQLException {
        String query = "UPDATE historique_taxe SET idmaison = ?, daty = ? WHERE id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, getIdMaison());
            preparedStatement.setDate(2, getDaty());
            preparedStatement.setString(3, getId());
            return preparedStatement.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Erreur lors de la mise à jour : " + e.getMessage());
            throw e;            
        }
    }

    public static HistoriqueTaxe getById(Connection connection, String id) throws SQLException {
        String query = "SELECT id, idmaison, daty FROM historique_taxe WHERE id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, id);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    HistoriqueTaxe historique = new HistoriqueTaxe();
                    historique.setId(resultSet.getString("id"));
                    historique.setIdMaison(resultSet.getString("idmaison"));
                    historique.setDaty(resultSet.getDate("daty"));
                    return historique;
                }
            }
        }
        return null;
    }
}