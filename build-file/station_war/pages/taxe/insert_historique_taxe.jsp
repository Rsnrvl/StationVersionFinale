<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="security_taxe.jsp"%>
<%@page import="user.UserEJB"%> 
<%@page import="affichage.*"%>
<%@ page import="taxe.model.*" %>

<%
try{
    String titre = "Insert HistoriqueTaxe";
    UserEJB u = (user.UserEJB) session.getValue("u");

    HistoriqueTaxe historiqueTaxe = new HistoriqueTaxe();
    historiqueTaxe.setNomTable("HISTORIQUETAXE");
    PageInsert pi = new PageInsert(historiqueTaxe, request, u); 
    pi.setLien((String) session.getValue("lien")); 

    affichage.Champ[] liste = new affichage.Champ[1];
    Maison maison = new Maison();
    liste[0] = new Liste("idMaison", maison, "libelle", "id"); 
    pi.getFormu().changerEnChamp(liste);

    String classe = "taxe.model.HistoriqueTaxe";
    String nomTable = "HISTORIQUETAXE";   
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1> <%=titre%></h1>
    <% if (request.getParameter("success") != null) { %>
        <div class="success">Historique de taxe ajouté avec succès!</div>
    <% } %>
    
    <% if (request.getParameter("error") != null) { %>
        <div class="error">Erreur: <%= request.getParameter("error") %></div>
    <% } %>
    
    <form action="<%=pi.getLien()%>?but=taxe/insert_historique_taxe_process.jsp" method="post" name="<%= nomTable%>" id="<%= nomTable%>">
    <%
        pi.getFormu().makeHtmlInsertTabIndex();
        out.println(pi.getFormu().getHtmlInsert());
    %>
    <input name="acte" type="hidden" id="nature" value="insert">
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