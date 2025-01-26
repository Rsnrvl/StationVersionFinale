<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="security_taxe.jsp"%>
<%@ page import="taxe.model.Maison" %>
<%@ page import="taxe.util.EtatTaxe" %>
<%@ page import="taxe.database.UtilDB" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html>
<head>
    <title>Carte des Maisons</title>
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css"/>
    <style>
        .container {
            display: flex;
            flex-direction: row-reverse;
            height: calc(100vh - 60px); /* Hauteur totale moins la hauteur du header */
            position: relative;
            margin-top: 20px;
        }
        #map {
            flex: 1;
            height: 100%;
            position: relative;
            z-index: 1;
        }
        .sidebar {
            width: 300px;
            padding: 20px;
            background: #f8f9fa;
            overflow-y: auto;
            position: relative;
            z-index: 2;
            box-shadow: -2px 0 5px rgba(0,0,0,0.1);
        }
        .info-box {
            background: white;
            padding: 15px;
            margin-bottom: 15px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .total-paid {
            color: #28a745;
            font-weight: bold;
        }
        .total-remaining {
            color: #dc3545;
            font-weight: bold;
        }
        .legend {
            padding: 10px;
            background: white;
            margin-top: 10px;
            border-radius: 5px;
            position: absolute;
            bottom: 30px;
            left: 30px;
            z-index: 1000;
            min-width: 200px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
        }
        .legend-item {
            margin: 5px 0;
            display: flex;
            align-items: center;
        }
        .legend-color {
            display: inline-block;
            width: 20px;
            height: 20px;
            margin-right: 8px;
            border-radius: 50%;
        }
        .leaflet-popup-content {
            min-width: 200px;
            padding: 5px;
        }
        .leaflet-popup-content strong {
            display: block;
            margin-bottom: 5px;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <div class="container">
        <aside class="sidebar">
            <div class="info-box">
                <h3>Résumé des taxes</h3>
                <%
                    double dernierPU=0;
                    try (Connection conn = UtilDB.getConnection()){
                        double dernierPU=HistoriquePU.getLastPU(conn,commune_taxe.getId());
                    }
                    int annee = Integer.parseInt(request.getParameter("annee") != null ? 
                               request.getParameter("annee") : String.valueOf(java.time.Year.now().getValue()));
                    double totalPaid = 0;
                    double totalRemaining = 0;
                %>
                <p>Année: <%= annee %></p>
                <p>Commune: <%= communeTaxe.getNom() %></p>
            </div>
        </aside>

        <div id="map">
            <div class="legend">
                <h4>Légende</h4>
                <div class="legend-item">
                    <span class="legend-color" style="background: #28a745;"></span>
                    Payé (12 mois)
                </div>
                <div class="legend-item">
                    <span class="legend-color" style="background: #ffc107;"></span>
                    Partiellement payé
                </div>
                <div class="legend-item">
                    <span class="legend-color" style="background: #dc3545;"></span>
                    Non payé
                </div>
            </div>
        </div>
    </div>

    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
    <script>
        // Initialisation de la carte
        var map = L.map('map').setView([-18.8792, 47.5079], 12);
        
        // Ajout du fond de carte OpenStreetMap
        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            attribution: '© OpenStreetMap contributors'
        }).addTo(map);

        <%
            try (Connection conn = UtilDB.getConnection()) {
                ArrayList<Maison> maisons = Maison.getAllByCommune(conn, communeTaxe.getId());
                
                for (Maison maison : maisons) {
                    EtatTaxe etat = maison.getEtat(conn, annee);
                    totalPaid += etat.getMontantPaye();
                    totalRemaining += etat.getMontantRestant();
                    
                    String color = etat.getMoisPayes() == 12 ? "#28a745" : 
                                 etat.getMoisPayes() > 0 ? "#ffc107" : "#dc3545";
        %>
            // Création du marqueur pour chaque maison
            var marker = L.circleMarker([<%= maison.getLatitude() %>, <%= maison.getLongitude() %>], {
                radius: 8,
                fillColor: '<%= color %>',
                color: '#fff',
                weight: 1,
                opacity: 1,
                fillOpacity: 0.8
            }).addTo(map);

            // Ajout du popup avec les informations
            marker.bindPopup(`
                <strong><%= maison.getLibelle() %></strong><br>
                Dimensions: <%= maison.getLongueur() %>m × <%= maison.getLargeur() %>m<br>
                Étages: <%= maison.getEtage() %><br>
                Mois payés: <%= etat.getMoisPayes() %>/12<br>
                Montant payé: <%= String.format("%,.2f", etat.getMontantPaye()) %> Ar<br>
                Montant restant: <%= String.format("%,.2f", etat.getMontantRestant()) %> Ar
            `);
        <%
                }
                
                // Si des maisons existent, centrer la carte sur la première
                if (!maisons.isEmpty()) {
        %>
                map.setView([<%= maisons.get(0).getLatitude() %>, <%= maisons.get(0).getLongitude() %>], 12);
        <%
                }
        %>
                // Mise à jour des totaux dans la sidebar
                document.querySelector('.info-box').innerHTML += `
                    <p>Total payé: <span class="total-paid"><%= String.format("%,.2f", totalPaid) %> Ar</span></p>
                    <p>Total restant: <span class="total-remaining"><%= String.format("%,.2f", totalRemaining) %> Ar</span></p>
                `;
        <%
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </script>
</body>
</html> 