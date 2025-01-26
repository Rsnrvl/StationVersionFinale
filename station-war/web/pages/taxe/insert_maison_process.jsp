<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="security_taxe.jsp"%>
<%@ page import="taxe.model.Maison" %>
<%@ page import="taxe.database.UtilDB" %>
<%@ page import="java.sql.Connection" %>

<%
    try (Connection conn = UtilDB.getConnection()) {
        String libelle = request.getParameter("libelle");
        double longueur = Double.parseDouble(request.getParameter("longueur"));
        double largeur = Double.parseDouble(request.getParameter("largeur"));
        int etage = Integer.parseInt(request.getParameter("etage"));
        double prixParMetre = Double.parseDouble(request.getParameter("config"));
        double longitude = Double.parseDouble(request.getParameter("longitude"));
        double latitude = Double.parseDouble(request.getParameter("latitude"));
        String idProprietaire = request.getParameter("idproprietaire");
        String idCommune = request.getParameter("idcommune");
        
        Maison maison = new Maison();
        maison.setLibelle(libelle);
        maison.setLongueur(longueur);
        maison.setLargeur(largeur);
        maison.setEtage(etage);
        maison.setConfig(prixParMetre);
        maison.setLongitude(longitude);
        maison.setLatitude(latitude);
        maison.setIdProprietaire(idProprietaire);
        maison.setIdCommune(idCommune);
        
        maison.createObject(conn);
        
        response.sendRedirect("/station/pages/module.jsp?but=taxe/insert_maison.jsp&success=true");
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("/station/pages/module.jsp?but=taxe/insert_maison.jsp&error=" + e.getMessage());
    }
%> 