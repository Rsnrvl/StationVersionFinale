package taxe.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import bean.ClassMAPTable;

public class TypeCaracteristique extends ClassMAPTable{
    private String id;
    private String libelle;

    // Getters and Setters
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

    // Constructors
    public TypeCaracteristique() {
        setNomTable("typecaracteristique");
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
        String sql = "INSERT INTO typecaracteristique (id, libelle) " +
                     "VALUES (generate_id('TYP', seq_typecaracteristique.NEXTVAL), ?)";
                     
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, this.getLibelle());
            
            stmt.executeUpdate();
        }
    }

    public int deleteToTable(Connection connection) throws SQLException {
        String query = "DELETE FROM typecaracteristique WHERE id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, getId());
            return preparedStatement.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Erreur lors de la suppression : " + e.getMessage());
            throw e;
        }
    }

    public static ArrayList<TypeCaracteristique> getAll(Connection connection) throws SQLException {
        String query = "SELECT id, libelle FROM typecaracteristique";
        ArrayList<TypeCaracteristique> types = new ArrayList<>();
        try (PreparedStatement preparedStatement = connection.prepareStatement(query);
             ResultSet resultSet = preparedStatement.executeQuery()) {
            while (resultSet.next()) {
                TypeCaracteristique type = new TypeCaracteristique();
                type.setId(resultSet.getString("id"));
                type.setLibelle(resultSet.getString("libelle"));
                types.add(type);
            }
        }
        return types;
    }

    public int updateToTable(Connection connection) throws SQLException {
        String query = "UPDATE typecaracteristique SET libelle = ? WHERE id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, getLibelle());
            preparedStatement.setString(2, getId());
            return preparedStatement.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Erreur lors de la mise à jour : " + e.getMessage());
            throw e;
        }
    }

    public static TypeCaracteristique getById(Connection connection, String id) throws SQLException {
        String query = "SELECT id, libelle FROM typecaracteristique WHERE id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, id);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    TypeCaracteristique type = new TypeCaracteristique();
                    type.setId(resultSet.getString("id"));
                    type.setLibelle(resultSet.getString("libelle"));
                    return type;
                }
            }
        }
        return null;
    }
}
