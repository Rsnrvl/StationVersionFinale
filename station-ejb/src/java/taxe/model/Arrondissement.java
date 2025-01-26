package taxe.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import bean.ClassMAPTable;
import bean.CGenUtil;

public class Arrondissement extends ClassMAPTable {
    private String id;
    private int numero;
    private String nom;
    private String idCommune;

    // Constructor
    public Arrondissement() {
        setNomTable("arrondissement");
    }

    // Getters and Setters
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public int getNumero() {
        return numero;
    }

    public void setNumero(int numero) {
        this.numero = numero;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getCommune() {
        return idCommune;
    }

    public void setCommune(String commune) {
        this.idCommune = commune;
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
        String sql = "INSERT INTO arrondissement (id, numero, nom, commune) " +
                     "VALUES (generate_id('ARR', seq_arrondissement.NEXTVAL), ?, ?, ?)";
                     
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, this.getNumero());
            stmt.setString(2, this.getNom());
            stmt.setString(3, this.getCommune());
            
            stmt.executeUpdate();
        }
    }

    public int deleteToTable(Connection connection) throws SQLException {
        String query = "DELETE FROM arrondissement WHERE id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, getId());
            return preparedStatement.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Erreur lors de la suppression : " + e.getMessage());
            throw e;
        }
    }

    public static ArrayList<Arrondissement> getAll(Connection connection) throws SQLException {
        String query = "SELECT id, numero, nom, commune FROM arrondissement";
        ArrayList<Arrondissement> arrondissements = new ArrayList<>();
        try (PreparedStatement preparedStatement = connection.prepareStatement(query);
             ResultSet resultSet = preparedStatement.executeQuery()) {
            while (resultSet.next()) {
                Arrondissement arrondissement = new Arrondissement();
                arrondissement.setId(resultSet.getString("id"));
                arrondissement.setNumero(resultSet.getInt("numero"));
                arrondissement.setNom(resultSet.getString("nom"));
                arrondissement.setCommune(resultSet.getString("commune"));
                arrondissements.add(arrondissement);
            }
        }
        return arrondissements;
    }

    public int updateToTable(Connection connection) throws SQLException {
        String query = "UPDATE arrondissement SET numero = ?, nom = ?, commune = ? WHERE id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, getNumero());
            preparedStatement.setString(2, getNom());
            preparedStatement.setString(3, getCommune());
            preparedStatement.setString(4, getId());
            return preparedStatement.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Erreur lors de la mise à jour : " + e.getMessage());
            throw e;
        }
    }

    public static Arrondissement getById(Connection connection, String id) throws SQLException {
        String query = "SELECT id, numero, nom, commune FROM arrondissement WHERE id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, id);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    Arrondissement arrondissement = new Arrondissement();
                    arrondissement.setId(resultSet.getString("id"));
                    arrondissement.setNumero(resultSet.getInt("numero"));
                    arrondissement.setNom(resultSet.getString("nom"));
                    arrondissement.setCommune(resultSet.getString("commune"));
                    return arrondissement;
                }
            }
        }
        return null;
    }

    // Additional method to get houses in this arrondissement
    public ArrayList<Maison> getMaisons(Connection connection) throws SQLException {
        try {
            Maison maison = new Maison();
            String query = "SELECT m.* FROM maison m, arrondissement_geom ag " +
                          "WHERE ag.id = '" + this.getId() + "' " +
                          "AND SDO_RELATE(m.geom, ag.geom, 'mask=INSIDE') = 'TRUE'";
                          
            Maison[] results = (Maison[]) CGenUtil.rechercher(maison, query, connection);
            
            ArrayList<Maison> maisons = new ArrayList<>();
            for (Maison m : results) {
                maisons.add(m);
            }
            return maisons;
        } catch (Exception e) {
            throw new SQLException("Error getting maisons in arrondissement: " + e.getMessage());
        }
    }
}