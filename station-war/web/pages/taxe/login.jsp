<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login Impôts</title>
    <style>
        .form-container {
            max-width: 400px;
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
        input {
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
            width: 100%;
        }
        button:hover {
            background-color: #45a049;
        }
        .error {
            color: red;
            margin-bottom: 10px;
            padding: 10px;
            background-color: #ffebee;
            border: 1px solid #ffcdd2;
            border-radius: 4px;
        }
        .success {
            color: green;
            margin-bottom: 10px;
            padding: 10px;
            background-color: #e8f5e9;
            border: 1px solid #c8e6c9;
            border-radius: 4px;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Connexion Impôts</h2>
        
        <% if (request.getParameter("error") != null) { %>
            <div class="error">Erreur: <%= request.getParameter("error") %></div>
        <% } %>
        
        <% if (request.getParameter("success") != null) { %>
            <div class="success"><%= request.getParameter("success") %></div>
        <% } %>
        
        <form action="taxe/login_process.jsp" method="POST">
            <div class="form-group">
                <label for="nom">Nom de la commune:</label>
                <input type="text" id="nom" name="nom" required>
            </div>
            
            <div class="form-group">
                <label for="mdp">Mot de passe:</label>
                <input type="password" id="mdp" name="mdp" required>
            </div>
            
            <button type="submit">Se connecter</button>
        </form>
        
        <div style="margin-top: 20px; text-align: center;">
            <a href="${pageContext.request.contextPath}/pages/module.jsp?but=taxe/insert_commune.jsp" 
               style="display: inline-block; padding: 8px 15px; background-color: #008CBA; color: white; 
                      text-decoration: none; border-radius: 4px;">
                Ajouter une nouvelle commune
            </a>
        </div>
    </div>
</body>
</html> 