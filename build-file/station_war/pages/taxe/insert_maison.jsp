<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="security_taxe.jsp"%>
<%@ page import="taxe.model.Proprietaire" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="taxe.database.UtilDB" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="taxe.model.Commune" %>
<!DOCTYPE html>
<html>
<head>
    <title>Ajouter une Maison</title>
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
        input[type="text"],
        input[type="number"] {
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
        <h2>Ajouter une nouvelle maison</h2>
        
        <% if (request.getParameter("success") != null) { %>
            <div class="success">Maison ajoutée avec succès!</div>
        <% } %>
        
        <% if (request.getParameter("error") != null) { %>
            <div class="error">Erreur: <%= request.getParameter("error") %></div>
        <% } %>
        
        
        <form action="taxe/insert_maison_process.jsp" method="POST">
            <input type="hidden" name="idcommune" value="<%= communeTaxe.getId() %>">
            
            <div class="form-group">
                <label for="libelle">Libellé:</label>
                <input type="text" id="libelle" name="libelle" required>
            </div>
            
            <div class="form-group">
                <label for="longueur">Longueur (m):</label>
                <input type="number" id="longueur" name="longueur" step="0.01" required>
            </div>
            
            <div class="form-group">
                <label for="largeur">Largeur (m):</label>
                <input type="number" id="largeur" name="largeur" step="0.01" required>
            </div>
            
            <div class="form-group">
                <label for="etage">Nombre d'etages:</label>
                <input type="number" id="etage" name="etage" min="1" required>
            </div>
            
            <div class="form-group">
                <label for="config">Prix par m2:</label>
                <input type="number" id="config" name="config" step="0.01" required>
            </div>
            
            <div class="form-group">
                <label for="longitude">Longitude:</label>
                <input type="number" id="longitude" name="longitude" step="0.000001" required>
            </div>
            
            <div class="form-group">
                <label for="latitude">Latitude:</label>
                <input type="number" id="latitude" name="latitude" step="0.000001" required>
            </div>
            
            <div class="form-group">
                <label for="idproprietaire">Propriétaire:</label>
                <select id="idproprietaire" name="idproprietaire" required>
                    <%
                        try (Connection conn = UtilDB.getConnection()) {
                            ArrayList<Proprietaire> proprietaires = Proprietaire.getAll(conn);
                            for (Proprietaire prop : proprietaires) {
                    %>
                        <option value="<%= prop.getId() %>">
                            <%= prop.getNom() %>
                        </option>
                    <%
                            }
                        } catch (Exception e) {
                            out.println("Erreur lors du chargement des propriétaires: " + e.getMessage());
                        }
                    %>
                </select>
            </div>
            
            <button type="submit">Enregistrer</button>
        </form>
    </div>
</body>
</html>