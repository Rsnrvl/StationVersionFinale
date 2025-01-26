<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="taxe.model.Commune" %>

<%
    // Vérifier les deux attributs de session
    Commune communeTaxe = (Commune) session.getAttribute("commune_taxe");
    
    if (communeTaxe == null) {
        response.sendRedirect("/station/pages/module.jsp?but=taxe/login.jsp&error=Veuillez vous connecter");
        return;
    }
%> 