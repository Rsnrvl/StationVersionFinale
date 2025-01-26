<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="security_taxe.jsp"%>
<%@ page import="taxe.model.*" %>
<%@ page import="taxe.util.DateUtil" %>
<%@ page import="taxe.database.UtilDB" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
    <title>Prix Unitaire</title>
    <style>
        .forms-wrapper {
            display: flex;
            gap: 20px;
            max-width: 1200px;
            margin: 20px auto;
            padding: 0 20px;
            justify-content: center;
        }
        .form-container {
            max-width: 500px;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            background: white;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            flex: 1;
        }
        .form-title {
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #4CAF50;
            color: #2c3e50;
            font-size: 1.5em;
        }
        .form-group {
            margin-bottom: 15px;
            width: 100%;
        }
        label {
            display: block;
            margin-bottom: 5px;
            color: #34495e;
            font-weight: 500;
        }
        input, select {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
            margin-top: 5px;
        }
        button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
            font-size: 1em;
            margin-top: 10px;
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
            <h2 class="form-title">Nouveau Prix Unitaire</h2>
            
            <% if (request.getParameter("success") != null) { %>
                <div class="success">Prix unitaire enregistré avec succès!</div>
            <% } %>
            
            <% if (request.getParameter("error") != null) { %>
                <div class="error">Erreur: <%= request.getParameter("error") %></div>
            <% } %>
            
            <form action="taxe/insert_pu_process.jsp" method="POST">
                <div class="form-group">
                    <label for="pu">Prix par m²:</label>
                    <input type="number" id="pu" name="pu" step="0.01" required 
                           value="<%= session.getAttribute("pu_defaut") != null ? session.getAttribute("pu_defaut") : "" %>">
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
            <h2 class="form-title">Générer les factures</h2>
            <form action="taxe/generer_factures_masse.jsp" method="GET">
                <div class="form-group">
                    <label for="mois_factures">Mois:</label>
                    <select id="mois_factures" name="mois" required>
                        <%= DateUtil.getOptionsSelectMois(java.time.LocalDate.now().getMonthValue()) %>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="annee_factures">Année:</label>
                    <input type="number" id="annee_factures" name="annee" 
                           value="<%= java.time.Year.now().getValue() %>" required>
                </div>
                
                <button type="submit">Générer toutes les factures</button>
            </form>
        </div>
    </div>
</body>
</html> 