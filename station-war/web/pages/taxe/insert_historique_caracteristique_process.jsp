<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="security_taxe.jsp"%>
<%@ page import="taxe.model.HistoriqueCaracteristique" %>
<%@ page import="taxe.database.UtilDB" %>
<%@ page import="java.sql.Connection" %>

<%
    try (Connection conn = UtilDB.getConnection()) {
        String idMaison = request.getParameter("idmaison");
        String idCaracteristique = request.getParameter("idcaracteristique");
        double coefficient = Double.parseDouble(request.getParameter("coefficient"));
        int mois = Integer.parseInt(request.getParameter("mois"));
        int annee = Integer.parseInt(request.getParameter("annee"));
        
        HistoriqueCaracteristique historique = new HistoriqueCaracteristique();
        historique.setIdMaison(idMaison);
        historique.setIdCaracteristique(idCaracteristique);
        historique.setCoefficient(coefficient);
        historique.setMois(mois);
        historique.setAnnee(annee);
        
        historique.createObject(conn);
        
        response.sendRedirect("/station/pages/module.jsp?but=taxe/insert_historique_caracteristique.jsp&success=true");
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("/station/pages/module.jsp?but=taxe/insert_historique_caracteristique.jsp&error=" + e.getMessage());
    }
%> 