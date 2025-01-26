<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="security_taxe.jsp"%>
<%@ page import="taxe.model.HistoriqueTaxe" %>
<%@ page import="taxe.database.UtilDB" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Date" %>

<%
    try (Connection conn = UtilDB.getConnection()) {
        String idMaison = request.getParameter("idmaison");
        Date daty = Date.valueOf(request.getParameter("daty"));
        
        HistoriqueTaxe historique = new HistoriqueTaxe();
        historique.setIdMaison(idMaison);
        historique.setDaty(daty);
        
        historique.createObject(conn);
        
        response.sendRedirect("/station/pages/module.jsp?but=taxe/insert_historique_taxe.jsp&success=true");
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("/station/pages/module.jsp?but=taxe/insert_historique_taxe.jsp&error=" + e.getMessage());
    }
%> 