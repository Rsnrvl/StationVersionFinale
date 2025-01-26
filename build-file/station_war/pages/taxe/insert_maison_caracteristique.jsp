<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="security_taxe.jsp"%>
<%@page import="affichage.*"%>
<%@page import="user.UserEJB"%>
<%@page import="taxe.model.*"%>

<% 
try {
    UserEJB u = (UserEJB) session.getAttribute("u");
    MaisonCaracteristique mc = new MaisonCaracteristique();
    mc.setNomTable("maisoncaracteristique");
    PageInsert pi = new PageInsert(mc, request, u);

    affichage.Champ[] liste = new affichage.Champ[2];
    Maison maison = new Maison();
    Caracteristique caracteristique = new Caracteristique();
    liste[0] = new Liste("idMaison", maison, "libelle", "id");
    liste[1] = new Liste("idCaracteristique", caracteristique, "libelle", "id");
    pi.getFormu().changerEnChamp(liste);
    
    pi.setLien((String) session.getAttribute("lien"));
%>
<div class="content-wrapper">
    <h1>Nouvel Caracteristique</h1>
    <form action="<%= pi.getLien() %>?but=taxe/insert_arrondissement_process.jsp" method="post">
        <% pi.getFormu().makeHtmlInsertTabIndex(); %>
        <%= pi.getFormu().getHtmlInsert() %>
        <input type="hidden" name="acte" value="insert">
        <input type="hidden" name="classe" value="taxe.model.Arrondissement">
        <input type="hidden" name="nomtable" value="arrondissement">
    </form>
</div>
<% 
} catch (Exception e) {
    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
}
%>