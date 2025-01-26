<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="security_taxe.jsp"%>
<%@page import="affichage.PageInsert"%> 
<%@page import="user.UserEJB"%> 
<%@page import="bean.TypeObjet"%> 
<%@page import="taxe.model.*"%> 

%
try {
    String titre = "insert Arrondissement";
    String autreparsley = "data-parsley-range='[8, 40]' required";
    UserEJB u = (user.UserEJB) session.getValue("u");
    
    Arrondissement arr = new Arrondissement();
    arr.setNomTable("arrondissement");
    PageInsert pi = new PageInsert(arr, request, u); 
    //pi.getFormu().getChamp("val").setLibelle("rubrique");
    pi.setLien((String) session.getValue("lien")); 

    String butApresPost = "magasin/magasin-fiche.jsp";
    String classe = "taxe.model.Arrondissement";
    String nomTable = "Arrondissement";   
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1> <%= titre %></h1>
    
    <form action="<%=pi.getLien()%>?but=hetra/maison/caracteristique-liste.jsp" method="post" name="<%= nomTable%>" id="<%= nomTable%>">
    <%
        pi.getFormu().makeHtmlInsertTabIndex();
        out.println(pi.getFormu().getHtmlInsert());
    %>
    <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="<%= butApresPost %>">
    <input name="classe" type="hidden" id="classe" value="<%= classe %>">
    <input name="nomtable" type="hidden" id="nomtable" value="<%= nomTable %>">
    </form>
</div>

<%
} catch (Exception e) {
    e.printStackTrace();
%>
<script language="JavaScript"> alert('<%=e.getMessage()%>');
    history.back();</script>

<% }%>

<!-- <!DOCTYPE html>
<html>
<head>
    <title>Ajouter un Arrondissement</title>
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
        .points-container {
            margin-top: 20px;
            border-top: 1px solid #ddd;
            padding-top: 15px;
        }
        .point-group {
            display: flex;
            gap: 10px;
            margin-bottom: 10px;
        }
        .point-group input {
            width: 45%;
        }
        #addPoint {
            background-color: #008CBA;
            margin-bottom: 20px;
        }
        #addPoint:hover {
            background-color: #007399;
        }
        .success {
            color: green;
            margin-bottom: 10px;
        }
        .error {
            color: red;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Ajouter un Arrondissement</h2>
        
        <% if (request.getParameter("success") != null) { %>
            <div class="success">Arrondissement ajouté avec succès!</div>
        <% } %>
        
        <% if (request.getParameter("error") != null) { %>
            <div class="error">Erreur: <%= request.getParameter("error") %></div>
        <% } %>
        
        <form action="taxe/insert_arrondissement_process.jsp" method="POST">
            <div class="form-group">
                <label for="numero">Numéro:</label>
                <input type="number" id="numero" name="numero" required min="1">
            </div>
            
            <div class="form-group">
                <label for="nom">Nom:</label>
                <input type="text" id="nom" name="nom" required>
            </div>
            
            <div class="form-group">
                <label for="commune">Commune:</label>
                <input type="text" id="commune" name="commune" required>
            </div>                        
            
            <button type="submit">Enregistrer</button>
        </form>
    </div>
</body>
</html>  -->