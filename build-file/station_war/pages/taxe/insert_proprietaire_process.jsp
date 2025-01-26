<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="security_taxe.jsp"%>
<%@ page import="taxe.model.Proprietaire" %>
<%@ page import="taxe.database.UtilDB" %>
<%@ page import="java.sql.Connection" %>

<%
    try (Connection conn = UtilDB.getConnection()) {
        String nom = request.getParameter("nom");
        String prenom = request.getParameter("prenom");
        String cin = request.getParameter("cin");
        String adresse = request.getParameter("adresse");
        
        Proprietaire proprietaire = new Proprietaire();
        proprietaire.setNom(nom);
        proprietaire.setPrenom(prenom);
        proprietaire.setCin(cin);
        proprietaire.setAdresse(adresse);
        
        proprietaire.createObject(conn);
        
        response.sendRedirect("/station/pages/module.jsp?but=taxe/insert_proprietaire.jsp&success=true");
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("/station/pages/module.jsp?but=taxe/insert_proprietaire.jsp&error=" + e.getMessage());
    }
%> 