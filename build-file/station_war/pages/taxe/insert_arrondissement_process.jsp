<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="security_taxe.jsp"%>
<%@ page import="taxe.model.Arrondissement" %>
<%@ page import="taxe.database.UtilDB" %>
<%@ page import="java.sql.Connection" %>

<%
    try (Connection conn = UtilDB.getConnection()) {
        // Get form parameters
        int numero = Integer.parseInt(request.getParameter("numero"));
        String nom = request.getParameter("nom");
        String commune = request.getParameter("commune");
        
        // Create and set Arrondissement object
        Arrondissement arrondissement = new Arrondissement();
        arrondissement.setNumero(numero);
        arrondissement.setNom(nom);
        arrondissement.setCommune(commune);
        
        // Save to database
        arrondissement.createObject(conn);
        
        // Redirect with success message
        response.sendRedirect("/station/pages/module.jsp?but=taxe/insert_arrondissement.jsp&success=true");
        
    } catch (Exception e) {
        // Redirect with error message
        e.printStackTrace();
        response.sendRedirect("/station/pages/module.jsp?but=taxe/insert_arrondissement.jsp&error=" + e.getMessage());
    }
%> 