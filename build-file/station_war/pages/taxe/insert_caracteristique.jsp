<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="security_taxe.jsp"%>
<%@ page import="taxe.model.TypeCaracteristique" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="taxe.database.UtilDB" %>
<%@ page import="java.sql.Connection" %>
<!DOCTYPE html>
<html>
<head>
    <title>Ajouter une Caracteristique</title>
    <style>
        .form-container {
            max-width: 500px;
            margin: 20px auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
        }
        input, select {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        button:hover {
            background-color: #45a049;
        }
        .success {
            color: green;
            margin-bottom: 10px;
            padding: 10px;
            background-color: #e8f5e9;
            border: 1px solid #c8e6c9;
            border-radius: 4px;
        }
        .error {
            color: red;
            margin-bottom: 10px;
            padding: 10px;
            background-color: #ffebee;
            border: 1px solid #ffcdd2;
            border-radius: 4px;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Ajouter une nouvelle caracteristique</h2>
        
        <% if (request.getParameter("success") != null) { %>
            <div class="success">Caracteristique ajoutee avec succes!</div>
        <% } %>
        
        <% if (request.getParameter("error") != null) { %>
            <div class="error">Erreur: <%= request.getParameter("error") %></div>
        <% } %>
        
        <form action="taxe/insert_caracteristique_process.jsp" method="POST">
            <div class="form-group">
                <label for="libelle">Libelle:</label>
                <input type="text" id="libelle" name="libelle" required>
            </div>
            
            <div class="form-group">
                <label for="coefficient">Coefficient:</label>
                <input type="number" id="coefficient" name="coefficient" step="0.01" required>
            </div>
            
            <div class="form-group">
                <label for="idtypecaracteristique">Type de caracteristique:</label>
                <select id="idtypecaracteristique" name="idtypecaracteristique" required>
                    <%
                        try (Connection conn = UtilDB.getConnection()) {
                            ArrayList<TypeCaracteristique> types = TypeCaracteristique.getAll(conn);
                            for (TypeCaracteristique type : types) {
                    %>
                        <option value="<%= type.getId() %>"><%= type.getLibelle() %></option>
                    <%
                            }
                        } catch (Exception e) {
                            out.println("Erreur lors du chargement des types: " + e.getMessage());
                        }
                    %>
                </select>
            </div>
            
            <button type="submit">Enregistrer</button>
        </form>
    </div>
</body>
</html>