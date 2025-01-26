<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="security_taxe.jsp"%>
<%@ page import="taxe.model.MaisonComplet" %>
<%@ page import="taxe.database.UtilDB" %>
<%@ page import="java.sql.Connection" %>

<%
    String idMaison = request.getParameter("idmaison");
    int mois = Integer.parseInt(request.getParameter("mois"));
    int annee = Integer.parseInt(request.getParameter("annee"));
    
    try (Connection conn = UtilDB.getConnection()) {
        MaisonComplet maisonComplet = MaisonComplet.getById(conn, idMaison);
        
        // Définir le type de contenu comme PDF
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "inline; filename=facture.pdf");
        
        // Générer et envoyer le PDF
        maisonComplet.generateFacture(conn, mois, annee, response.getOutputStream());
        
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("module.jsp?but=taxe/insert_historique_maison.jsp&error=" + e.getMessage());
    }
%> 