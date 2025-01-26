<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Ajouter une Commune</title>
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
        .back-link {
            display: block;
            text-align: center;
            margin-top: 15px;
            color: #666;
            text-decoration: none;
        }
        .back-link:hover {
            color: #333;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Ajouter une nouvelle commune</h2>
        
        <% if (request.getParameter("error") != null) { %>
            <div class="error">Erreur: <%= request.getParameter("error") %></div>
        <% } %>
        
        <% if (request.getParameter("success") != null) { %>
            <div class="success">Commune ajoutée avec succès!</div>
        <% } %>
        
        <form action="taxe/insert_commune_process.jsp" method="POST">
            <div class="form-group">
                <label for="nom">Nom de la commune:</label>
                <input type="text" id="nom" name="nom" required>
            </div>
            
            <div class="form-group">
                <label for="mdp">Mot de passe:</label>
                <input type="password" id="mdp" name="mdp" required>
            </div>
            
            <div class="form-group">
                <label for="mdp_confirm">Confirmer le mot de passe:</label>
                <input type="password" id="mdp_confirm" name="mdp_confirm" required>
            </div>
            
            <button type="submit">Enregistrer</button>
        </form>
        
        <a href="${pageContext.request.contextPath}/pages/module.jsp?but=taxe/login.jsp" class="back-link">
            Retour à la page de connexion
        </a>
    </div>
</body>
</html> 