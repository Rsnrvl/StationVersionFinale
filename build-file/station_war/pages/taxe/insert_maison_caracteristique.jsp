<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="security_taxe.jsp"%>
<%@ page import="taxe.model.Maison" %>
<%@ page import="taxe.model.Caracteristique" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="taxe.database.UtilDB" %>
<%@ page import="java.sql.Connection" %>
<!DOCTYPE html>
<html>
<head>
    <title>Associer une Caractéristique à une Maison</title>
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
        select {
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
        <h2>Associer une caracteristique a une maison</h2>
        <form action="taxe/insert_maison_caracteristique_process.jsp" method="POST">
            <div class="form-group">
                <label for="idmaison">Maison:</label>
                <select id="idmaison" name="idmaison" required>
                    <%
                        try (Connection conn = UtilDB.getConnection()) {
                            ArrayList<Maison> maisons = Maison.getAll(conn);
                            for (Maison maison : maisons) {
                    %>
                        <option value="<%= maison.getId() %>"><%= maison.getLibelle() %></option>
                    <%
                            }
                        } catch (Exception e) {
                            out.println("Erreur lors du chargement des maisons: " + e.getMessage());
                        }
                    %>
                </select>
            </div>
            
            <div class="form-group">
                <label for="idcaracteristique">Caracteristique:</label>
                <select id="idcaracteristique" name="idcaracteristique" required>
                    <%
                        try (Connection conn = UtilDB.getConnection()) {
                            ArrayList<Caracteristique> caracteristiques = Caracteristique.getAll(conn);
                            for (Caracteristique carac : caracteristiques) {
                    %>
                        <option value="<%= carac.getId() %>"><%= carac.getLibelle() %></option>
                    <%
                            }
                        } catch (Exception e) {
                            out.println("Erreur lors du chargement des caracteristiques: " + e.getMessage());
                        }
                    %>
                </select>
            </div>
            
            <button type="submit">Associer</button>
        </form>
    </div>
</body>
</html>