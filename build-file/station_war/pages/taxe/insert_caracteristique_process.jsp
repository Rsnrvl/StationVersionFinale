<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="security_taxe.jsp"%>
<%@ page import="taxe.model.Caracteristique" %>
<%@ page import="taxe.database.UtilDB" %>
<%@ page import="java.sql.Connection" %>

<%
    try (Connection conn = UtilDB.getConnection()) {
        String libelle = request.getParameter("libelle");
        double coefficient = Double.parseDouble(request.getParameter("coefficient"));
        String idTypeCaracteristique = request.getParameter("idtypecaracteristique");
        
        Caracteristique carac = new Caracteristique();
        carac.setLibelle(libelle);
        carac.setCoefficient(coefficient);
        carac.setIdTypeCaracteristique(idTypeCaracteristique);
        
        carac.createObject(conn);
        
        response.sendRedirect("/station/pages/module.jsp?but=taxe/insert_caracteristique.jsp&success=true");
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("/station/pages/module.jsp?but=taxe/insert_caracteristique.jsp&error=" + e.getMessage());
    }
%> 