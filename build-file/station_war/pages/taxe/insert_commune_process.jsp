<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="taxe.model.Commune" %>
<%@ page import="taxe.database.UtilDB" %>
<%@ page import="java.sql.Connection" %>

<%
    try (Connection conn = UtilDB.getConnection()) {
        String nom = request.getParameter("nom");
        String mdp = request.getParameter("mdp");
        
        Commune commune = new Commune();
        commune.setNom(nom);
        commune.setMdp(mdp);
        
        commune.createObject(conn);
        
        response.sendRedirect("/station/pages/module.jsp?but=taxe/insert_commune.jsp&success=true");
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("/station/pages/module.jsp?but=taxe/insert_commune.jsp&error=" + e.getMessage());
    }
%> 