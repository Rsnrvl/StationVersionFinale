<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="security_taxe.jsp"%>
<%@ page import="taxe.model.*" %>
<%@ page import="taxe.util.DateUtil" %>
<%@ page import="taxe.database.UtilDB" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html>
<head>
    <title>Factures en masse</title>
    <style>
        .factures-container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
        }
        .facture {
            page-break-after: always;
            margin-bottom: 50px;
        }
        .facture:last-child {
            page-break-after: auto;
        }
        /* Réutiliser les styles de la facture individuelle */
        .facture-container {
            max-width: 800px;
            margin: 40px auto;
            padding: 30px;
            border: 1px solid #ddd;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        /* ... autres styles de facture ... */
    </style>
</head>
<body>
    <div class="factures-container">
        <%
            int mois = Integer.parseInt(request.getParameter("mois"));
            int annee = Integer.parseInt(request.getParameter("annee"));
            
            try (Connection conn = UtilDB.getConnection()) {
                ArrayList<Maison> maisons = Maison.getAllByCommune(conn, communeTaxe.getId());
                
                for (Maison maison : maisons) {
                    MaisonComplet maisonComplet = MaisonComplet.getMaisonWithHistory(conn, maison.getId(), mois, annee);
                    if (maisonComplet != null) {
                        Proprietaire proprietaire = maisonComplet.getProprietaire(conn);
                        double montantTaxe = maisonComplet.calculerTaxe();
        %>
        <div class="facture">
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
            </div>
        </div>
        <%
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </div>
    
    <script>
        // Imprimer automatiquement
        window.onload = function() {
            window.print();
        }
    </script>
</body>
</html> 