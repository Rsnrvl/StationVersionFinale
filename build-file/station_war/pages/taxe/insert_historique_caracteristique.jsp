<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="security_taxe.jsp"%>
<%@ page import="taxe.model.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="taxe.database.UtilDB" %>
<%@ page import="taxe.util.DateUtil" %>
<%@ page import="java.sql.Connection" %>
<!DOCTYPE html>
<html>
<head>
    <title>Historique Caractéristique</title>
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
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Nouvel historique caractéristique</h2>
        
        <% if (request.getParameter("success") != null) { %>
            <div class="success">Historique enregistré avec succès!</div>
        <% } %>
        
        <% if (request.getParameter("error") != null) { %>
            <div class="error">Erreur: <%= request.getParameter("error") %></div>
        <% } %>
        
        <form action="taxe/insert_historique_caracteristique_process.jsp" method="POST">
            <div class="form-group">
                <label for="idmaison">Maison:</label>
                <select id="idmaison" name="idmaison" required>
                    <%
                        try (Connection conn = UtilDB.getConnection()) {
                            Commune communeTaxe = (Commune) session.getAttribute("commune_taxe");
                            ArrayList<Maison> maisons = Maison.getAllByCommune(conn, communeTaxe.getId());
                            for (Maison maison : maisons) {
                    %>
                        <option value="<%= maison.getId() %>">
                            <%= maison.getLibelle() %>
                        </option>
                    <%
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    %>
                </select>
            </div>
            
            <div class="form-group">
                <label for="idcaracteristique">Caractéristique:</label>
                <select id="idcaracteristique" name="idcaracteristique" required>
                    <%
                        try (Connection conn = UtilDB.getConnection()) {
                            ArrayList<Caracteristique> caracteristiques = Caracteristique.getAll(conn);
                            for (Caracteristique caract : caracteristiques) {
                    %>
                        <option value="<%= caract.getId() %>">
                            <%= caract.getLibelle() %>
                        </option>
                    <%
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    %>
                </select>
            </div>
            
            <div class="form-group">
                <label for="coefficient">Coefficient:</label>
                <input type="number" id="coefficient" name="coefficient" step="0.01" required>
            </div>
            
            <div class="form-group">
                <label for="mois">Mois:</label>
                <select id="mois" name="mois" required>
                    <%= DateUtil.getOptionsSelectMois(java.time.LocalDate.now().getMonthValue()) %>
                </select>
            </div>
            
            <div class="form-group">
                <label for="annee">Année:</label>
                <input type="number" id="annee" name="annee" value="<%= java.time.Year.now().getValue() %>" required>
            </div>
            
            <button type="submit">Enregistrer</button>
        </form>
    </div>
</body>
</html> 