<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="security_taxe.jsp"%>
<%@ page import="taxe.model.MaisonCaracteristique" %>
<%@ page import="taxe.database.UtilDB" %>
<%@ page import="java.sql.Connection" %>

<%
    try (Connection conn = UtilDB.getConnection()) {
        String idMaison = request.getParameter("idmaison");
        String idCaracteristique = request.getParameter("idcaracteristique");
        
        MaisonCaracteristique mc = new MaisonCaracteristique();
        mc.setIdMaison(idMaison);
        mc.setIdCaracteristique(idCaracteristique);
        
        mc.createObject(conn);
        
        response.sendRedirect("/station/pages/module.jsp?but=taxe/insert_maison_caracteristique.jsp&success=true");
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("/station/pages/module.jsp?but=taxe/insert_maison_caracteristique.jsp&error=" + e.getMessage());
    }
%> 