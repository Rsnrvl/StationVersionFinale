<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@page import="mg.cnaps.compta.OrigineCompte"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    try{
        OrigineCompte a = new OrigineCompte();
        PageInsert pi = new PageInsert(a, request, (user.UserEJB) session.getValue("u"));
        pi.setLien((String) session.getValue("lien"));
        //Modification des affichages
        pi.getFormu().getChamp("val").setLibelle("Nom");
        pi.getFormu().getChamp("desce").setLibelle("Description");
        //Variables de navigation
        String classe = "mg.cnaps.compta.OrigineCompte";
        String butApresPost = "compta/configuration/origine-liste.jsp";
        String nomTable = "compta_origine";
        //Generer les affichages
        pi.preparerDataFormu();
        pi.getFormu().makeHtmlInsertTabIndex();
%>

<div class="content-wrapper">

    <div class="simple-block mt-5">
        <div class="col-12">
            <h1 class="title">Saisie Origine </h1>
        </div>
        <form class="col-12" action="<%= pi.getLien() %>?but=apresTarif.jsp" method="post" name="compte" id="compte" data-parsley-validate>
            <%
                out.println(pi.getFormu().getHtmlInsert());
            %>
            <input name="acte" type="hidden" id="nature" value="insert">
            <input name="bute" type="hidden" id="bute" value="<%= butApresPost %>">
            <input name="classe" type="hidden" id="classe" value="<%= classe %>">
            <input name="nomtable" type="hidden" id="nomtable" value="<%= nomTable %>">
        </form>
    </div>
</div>
<%
    } catch (Exception e) {
        e.printStackTrace();
    } %>

