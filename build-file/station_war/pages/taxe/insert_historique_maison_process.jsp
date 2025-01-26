<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="security_taxe.jsp"%>
<%@ page import="taxe.model.HistoriqueMaison" %>
<%@ page import="taxe.database.UtilDB" %>
<%@ page import="java.sql.Connection" %>

<%
    try (Connection conn = UtilDB.getConnection()) {
        String idMaison = request.getParameter("idmaison");
        double surface = Double.parseDouble(request.getParameter("surface"));
        int nbEtages = Integer.parseInt(request.getParameter("nbetages"));
        int mois = Integer.parseInt(request.getParameter("mois"));
        int annee = Integer.parseInt(request.getParameter("annee"));
        
        HistoriqueMaison historiqueMaison = new HistoriqueMaison();
        historiqueMaison.setIdMaison(idMaison);
        historiqueMaison.setSurfaceTotale(surface);
        historiqueMaison.setNbEtages(nbEtages);
        historiqueMaison.setMois(mois);
        historiqueMaison.setAnnee(annee);
        
        historiqueMaison.createObject(conn);
        
        response.sendRedirect("/station/pages/module.jsp?but=taxe/insert_historique_maison.jsp&success=true");
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("/station/pages/module.jsp?but=taxe/insert_historique_maison.jsp&error=" + e.getMessage());
    }
%> 