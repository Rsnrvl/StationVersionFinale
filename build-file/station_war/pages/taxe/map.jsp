<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="security_taxe.jsp"%>
<%@ page import="taxe.model.Maison" %>
<%@ page import="taxe.util.EtatTaxe" %>
<%@ page import="taxe.database.UtilDB" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="affichage.Carte" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="org.json.simple.JSONObject" %>


<!DOCTYPE html>
<html>
<head>
    <title>Carte des Maisons</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <!-- Leaflet CSS -->
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.7.1/dist/leaflet.css" />
    
    <style>
        #map {
            height: 600px;
            width: 100%;
        }
        .legend {
            background: white;
            padding: 10px;
            border-radius: 3px;
            box-shadow: 0 1px 2px rgba(0,0,0,0.1);
        }
        .legend h4 {
            margin: 0 0 10px;
            color: #777;
        }
        .legend i {
            width: 18px;
            height: 18px;
            float: left;
            margin-right: 8px;
            opacity: 0.7;
        }
        .summary-box {
            position: absolute;
            top: 10px;
            right: 10px;
            background: white;
            padding: 15px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
            z-index: 1000;
        }
        .total-paid {
            color: green;
            font-weight: bold;
        }
        .total-remaining {
            color: red;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div id="map"></div>
    <%
        double totalPaid = 0;
        double totalRemaining = 0;
        int annee = Integer.parseInt(request.getParameter("annee") != null ? 
                   request.getParameter("annee") : String.valueOf(java.time.Year.now().getValue()));
    %>
    
    <div class="summary-box">
        <h3>Resume des taxes <%= annee %></h3>
        <%
            try (Connection conn = UtilDB.getConnection()) {                
                String idArrondissement = request.getParameter("idarrondissement");                
                ArrayList<Maison> maisons;
                if (idArrondissement == null || idArrondissement.isEmpty()) {
                    maisons = Maison.getAllByCommune(conn, communeTaxe.getId());
                }
                else {                                        
                    maisons = Maison.getAllByArrondissement(conn, idArrondissement);
                }
                
                for (Maison maison : maisons) {
                    EtatTaxe etat = maison.getEtat(conn, annee);
                    totalPaid += etat.getMontantPaye();
                    totalRemaining += etat.getMontantRestant();
                }
        %>
        <div>
            <p>Total payé: <span class="total-paid"><%= String.format("%,.2f", totalPaid) %> Ar</span></p>
            <p>Total restant: <span class="total-remaining"><%= String.format("%,.2f", totalRemaining) %> Ar</span></p>
        </div>
        
        <script>
            var map = L.map('map').setView([-18.8792, 47.5079], 12);
            
            L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                attribution: '© OpenStreetMap contributors'
            }).addTo(map);
            
            // Ajouter les maisons sur la carte
            <%
                for (Maison maison : maisons) {
                    EtatTaxe etat = maison.getEtat(conn, annee);
                    String color = etat.getMoisPayes() == 12 ? "green" : 
                                 etat.getMoisPayes() > 0 ? "orange" : "red";
            %>
                var marker = L.marker([
                    <%= maison.getLatitude() %>, 
                    <%= maison.getLongitude() %>
                ], {
                    icon: L.divIcon({
                        className: 'custom-div-icon',
                        html: "<div style='background-color:<%= color %>;' class='marker-pin'></div>",
                        iconSize: [30, 42],
                        iconAnchor: [15, 42]
                    })
                }).addTo(map);
                
                marker.bindPopup(
                    "<b><%= maison.getLibelle() %></b><br>" +
                    "Dimensions: <%= maison.getLongueur() %>m × <%= maison.getLargeur() %>m<br>" +
                    "Étages: <%= maison.getEtage() %><br>" +
                    "Mois payés: <%= etat.getMoisPayes() %>/12<br>" +
                    "Montant payé: <%= String.format("%,.2f", etat.getMontantPaye()) %> Ar<br>" +
                    "Montant restant: <%= String.format("%,.2f", etat.getMontantRestant()) %> Ar"
                );
            <%
                }
            %>
            
            // Centrer la carte sur la première maison si elle existe
            <% if (!maisons.isEmpty()) { %>
                map.setView([
                    <%= maisons.get(0).getLatitude() %>,
                    <%= maisons.get(0).getLongitude() %>
                ], 12);
            <% } %>
            
        </script>
        <%
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </div>

    <!-- Leaflet JS -->
    <script src="https://unpkg.com/leaflet@1.7.1/dist/leaflet.js"></script>
</body>
</html> 