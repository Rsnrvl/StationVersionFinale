<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="security_taxe.jsp"%>
<%@ page import="taxe.model.TypeCaracteristique" %>
<%@ page import="taxe.database.UtilDB" %>
<%@ page import="java.sql.Connection" %>

<%
    try (Connection conn = UtilDB.getConnection()) {
        conn.setAutoCommit(true);
        String libelle = request.getParameter("libelle");
        
        TypeCaracteristique type = new TypeCaracteristique();
        type.setLibelle(libelle);
        
        type.createObject(conn);
        System.out.println("TypeCaracteristique inséré avec succès.");
        
        System.out.println("Redirection vers : /station/pages/module.jsp?but=taxe/insert_type_caracteristique.jsp&success=true");
        response.sendRedirect("/station/pages/module.jsp?but=taxe/insert_type_caracteristique.jsp&success=true");
    } catch (Exception e) {
        e.printStackTrace();
        System.out.println("Erreur : " + e.getMessage());
        response.sendRedirect("/station/pages/module.jsp?but=taxe/insert_type_caracteristique.jsp&error=" + e.getMessage());
    }
%> 