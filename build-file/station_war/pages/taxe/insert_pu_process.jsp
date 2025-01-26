<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="security_taxe.jsp"%>
<%@ page import="taxe.model.HistoriquePU" %>
<%@ page import="taxe.model.Commune" %>
<%@ page import="taxe.database.UtilDB" %>
<%@ page import="java.sql.Connection" %>

<%
    try (Connection conn = UtilDB.getConnection()) {
        double pu = Double.parseDouble(request.getParameter("pu"));
        int mois = Integer.parseInt(request.getParameter("mois"));
        int annee = Integer.parseInt(request.getParameter("annee"));
        
        HistoriquePU historiquePU = new HistoriquePU();
        historiquePU.setIdCommune(communeTaxe.getId());
        historiquePU.setPu(pu);
        historiquePU.setMois(mois);
        historiquePU.setAnnee(annee);
        
        historiquePU.createObject(conn);
        
        response.sendRedirect("/station/pages/module.jsp?but=taxe/insert_pu.jsp&success=true");
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("/station/pages/module.jsp?but=taxe/insert_pu.jsp&error=" + e.getMessage());
    }
%> 