<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="security_taxe.jsp"%>
<%@ page import="taxe.model.Maison" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="taxe.database.UtilDB" %>
<%@ page import="taxe.util.DateUtil" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="taxe.model.Commune" %>
<!DOCTYPE html>
<html>
<head>
    <title>Historique Maison</title>
    <style>
        .form-container {
            max-width: 500px;
            margin: 20px auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        .forms-wrapper {
            display: flex;
            gap: 20px;
            max-width: 1200px;
            margin: 20px auto;
        }
        .form-title {
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #4CAF50;
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
    <div class="forms-wrapper">
        <div class="form-container">
            <h2 class="form-title">Nouvel historique maison</h2>
            
            <% if (request.getParameter("success") != null) { %>
                <div class="success">Historique enregistré avec succès!</div>
            <% } %>
            
            <% if (request.getParameter("error") != null) { %>
                <div class="error">Erreur: <%= request.getParameter("error") %></div>
            <% } %>
            
            <form action="taxe/insert_historique_maison_process.jsp" method="POST">
                <div class="form-group">
                    <label for="idmaison">Maison:</label>
                    <select id="idmaison" name="idmaison" required>
                        <%
                            try (Connection conn = UtilDB.getConnection()) {
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
                    <label for="surface">Surface totale (m²):</label>
                    <input type="number" id="surface" name="surface" step="0.01" required>
                </div>
                
                <div class="form-group">
                    <label for="nbetages">Nombre d'étages:</label>
                    <input type="number" id="nbetages" name="nbetages" min="1" required>
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
        
        <div class="form-container">
            <h2 class="form-title">Générer une facture</h2>
            <form action="taxe/generer_facture.jsp" method="GET">
                <div class="form-group">
                    <label for="idmaison_facture">Maison:</label>
                    <select id="idmaison_facture" name="idmaison" required>
                        <%
                            try (Connection conn = UtilDB.getConnection()) {
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
                    <label for="mois_facture">Mois:</label>
                    <select id="mois_facture" name="mois" required>
                        <%= DateUtil.getOptionsSelectMois(java.time.LocalDate.now().getMonthValue()) %>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="annee_facture">Année:</label>
                    <input type="number" id="annee_facture" name="annee" 
                           value="<%= java.time.Year.now().getValue() %>" required>
                </div>
                
                <button type="submit">Générer facture</button>
            </form>
        </div>
    </div>
</body>
</html> 