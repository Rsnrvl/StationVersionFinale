<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="security_taxe.jsp"%>
<%@ page import="taxe.model.Arrondissement" %>
<%@ page import="taxe.database.UtilDB" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html>
<head>
    <title>Parametres de la carte</title>
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
        <h2>Sélectionner les parametres</h2>
        <form action="module.jsp" method="GET">                        
            <div class="form-group">
                <input type="hidden" name="but" value="taxe/map3.jsp">
                <label for="annee">Annee:</label>
                <input type="number" id="annee" name="annee" value="<%= java.time.Year.now().getValue() %>">
            </div>
            
            <div class="form-group">
                <label for="idarrondissement">Arrondissement:</label>
                <select id="idarrondissement" name="idarrondissement">
                    <option value="">Tous</option>
                    <% 
                    try (Connection conn = UtilDB.getConnection()) {
                        ArrayList<Arrondissement> arrondissements = Arrondissement.getAll(conn);
                        for (Arrondissement arr : arrondissements) {
                    %>
                        <option value="<%= arr.getId() %>">
                            <%= arr.getNom() %> (<%= arr.getCommune() %>)
                        </option>
                    <%
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    %>
                </select>
            </div>
            
            <button type="submit">Voir la carte</button>
        </form>
    </div>
</body>
</html> 