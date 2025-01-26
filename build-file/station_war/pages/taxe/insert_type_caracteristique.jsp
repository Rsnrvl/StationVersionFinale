<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="security_taxe.jsp"%>

<%@page import="affichage.PageInsert"%> 
<%@page import="user.UserEJB"%> 
<%@page import="bean.TypeObjet"%> 
<%@page import="taxe.model.TypeCaracteristique"%> 

<%
try{
    String titre = "insert typeCaracteristique";
    String autreparsley = "data-parsley-range='[8, 40]' required";
    UserEJB u = (user.UserEJB) session.getValue("u");

    TypeCaracteristique  typeCaracteristique = new TypeCaracteristique();
    typeCaracteristique.setNomTable("typecaracteristique");
    PageInsert pi = new PageInsert(typeCaracteristique, request, u); 
    pi.setLien((String) session.getValue("lien")); 

    String classe = "taxe.model.TypeCaracteristique";
    String nomTable = "typecaracteristique";   
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1> <%=titre%></h1>
    <% if (request.getParameter("success") != null) { %>
        <div class="success">Propriétaire ajouté avec succès!</div>
    <% } %>
    
    <% if (request.getParameter("error") != null) { %>
        <div class="error">Erreur: <%= request.getParameter("error") %></div>
    <% } %>
    
    <form action="<%=pi.getLien()%>?but=taxe/insert_type_caracteristique_process.jsp" method="post" name="<%= nomTable%>" id="<%= nomTable%>">
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

