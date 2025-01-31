<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="taxe.model.Commune" %>
<%@ page import="taxe.model.HistoriquePU" %>
<%@ page import="taxe.database.UtilDB" %>
<%@ page import="java.sql.Connection" %>

<%
    try (Connection conn = UtilDB.getConnection()) {
        String nom = request.getParameter("nom");
        String mdp = request.getParameter("mdp");
        
        Commune commune = Commune.authentifier(conn, nom, mdp);
        
        if (commune != null) {
            session.setAttribute("commune_taxe", commune);
            
            response.sendRedirect("/station/pages/module.jsp?but=taxe/insert_maison.jsp");
        } else {
            response.sendRedirect("/station/pages/module.jsp?but=taxe/login.jsp&error=Identifiants incorrects");
        }
        
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("/station/pages/module.jsp?but=taxe/login.jsp&error=" + e.getMessage());
    }
%> 