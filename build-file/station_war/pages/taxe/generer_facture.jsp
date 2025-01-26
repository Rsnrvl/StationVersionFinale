<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="security_taxe.jsp"%>
<%@ page import="taxe.model.*" %>
<%@ page import="taxe.util.EtatTaxe" %>
<%@ page import="taxe.util.DateUtil" %>
<%@ page import="taxe.database.UtilDB" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.time.LocalDate" %>

<!DOCTYPE html>
<html>
<head>
    <title>Facture</title>
    <style>
        .facture-container {
            max-width: 800px;
            margin: 40px auto;
            padding: 30px;
            border: 1px solid #ddd;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .facture-header {
            text-align: center;
            margin-bottom: 30px;
        }
        .facture-details {
            margin: 20px 0;
        }
        .section {
            margin: 20px 0;
            padding: 15px;
            background: #f8f9fa;
            border-radius: 5px;
        }
        .section-title {
            font-weight: bold;
            margin-bottom: 10px;
            color: #2c3e50;
        }
        .montant {
            font-size: 1.2em;
            font-weight: bold;
            color: #2c3e50;
        }
        .print-btn {
            display: block;
            margin: 20px auto;
            padding: 10px 20px;
            background: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .print-btn:hover {
            background: #45a049;
        }
    </style>
</head>
<body>
    <%
        String idMaison = request.getParameter("idmaison");
        int mois = Integer.parseInt(request.getParameter("mois"));
        int annee = Integer.parseInt(request.getParameter("annee"));
        
        try (Connection conn = UtilDB.getConnection()) {
            MaisonComplet maisonComplet = MaisonComplet.getMaisonWithHistory(conn, idMaison,mois, annee);
            Proprietaire proprietaire = maisonComplet.getProprietaire(conn);
            EtatTaxe etat = maisonComplet.getEtat(conn, annee);
            double montantTaxe = maisonComplet.calculerTaxe();
    %>
    <div class="facture-container">
        <div class="facture-header">
            <h1>Facture Taxe Foncière</h1>
            <p>Période : <%= DateUtil.getMoisTexte(mois) %> <%= annee %></p>
        </div>
        
        <div class="section">
            <div class="section-title">Propriétaire</div>
            <p>Nom : <%= proprietaire.getNom() %></p>
            <p>Prénom : <%= proprietaire.getPrenom() %></p>
            <p>CIN : <%= proprietaire.getCin() %></p>
            <p>Adresse : <%= proprietaire.getAdresse() %></p>
        </div>
        
        <div class="section">
            <div class="section-title">Détails de la maison</div>
            <p>Référence : <%= maisonComplet.getLibelle() %></p>
            <p>Surface : <%= maisonComplet.getSurfaceTotale() %> m²</p>
            <p>Dimensions : <%= maisonComplet.getLongueur() %>m × <%= maisonComplet.getLargeur() %>m</p>
            <p>Nombre d'étages : <%= maisonComplet.getNbEtages() %></p>
        </div>
        
        <div class="section">
            <div class="section-title">Calcul de la taxe</div>
            <p>Prix unitaire : <%= String.format("%,.2f", maisonComplet.getPrixUnitaire()) %> Ar/m²</p>
            <p>Surface totale : <%= String.format("%,.2f", maisonComplet.getSurfaceTotale()) %> m²</p>
            <p>Coefficient total : <%= String.format("%.2f", maisonComplet.produitCoefficient()) %></p>
            <p class="montant">Montant total : <%= String.format("%,.2f", montantTaxe) %> Ar</p>
        </div>
        
        
        <button class="print-btn" onclick="window.print()">Imprimer</button>
    </div>
    <%
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>
</body>
</html> 