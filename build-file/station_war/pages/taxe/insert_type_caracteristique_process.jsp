<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="security_taxe.jsp"%>
<%@ page import="taxe.model.TypeCaracteristique" %>
<%@ page import="taxe.database.UtilDB" %>
<%@ page import="java.sql.Connection" %>

<%
    try (Connection conn = UtilDB.getConnection()) {
        String libelle = request.getParameter("libelle");
        
        TypeCaracteristique type = new TypeCaracteristique();
        type.setLibelle(libelle);
        
        type.createObject(conn);
        
        response.sendRedirect("/station/pages/module.jsp?but=taxe/insert_type_caracteristique.jsp&success=true");
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("/station/pages/module.jsp?but=taxe/insert_type_caracteristique.jsp&error=" + e.getMessage());
    }
%> 