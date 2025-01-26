<%@ page import="taxe.model.Maison" %>
<%@ page import="taxe.util.EtatTaxe" %>
<%@ page import="bean.CGenUtil" %>
<%@ page import="taxe.database.UtilDB" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="affichage.Carte" %>
<%@ page import="java.util.HashMap" %>

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
                Maison maison = new Maison();
                String query = "select * from " + maison.getNomTable();
                Maison[] maisons = (Maison[])CGenUtil.rechercher(maison, query, conn);
                
                for (Maison m : maisons) {
                    EtatTaxe etat = m.getEtat(conn, annee);
                    totalPaid += etat.getMontantPaye();
                    totalRemaining += etat.getMontantRestant();
                }
        %>
        <p>Total paye: <span class="total-paid"><%= String.format("%,.2f", totalPaid) %> Ar</span></p>
        <p>Reste a payer: <span class="total-remaining"><%= String.format("%,.2f", totalRemaining) %> Ar</span></p>
        <p>Total: <%= String.format("%,.2f", totalPaid + totalRemaining) %> Ar</p>
        <%
            } catch (Exception e) {
                out.println("Erreur lors du calcul des totaux: " + e.getMessage());
            }
        %>
    </div>

    <div id="map"></div>
    
    <!-- Leaflet JS -->
    <script src="https://unpkg.com/leaflet@1.7.1/dist/leaflet.js"></script>
    
    <%
        try (Connection conn = UtilDB.getConnection()) {
            // Get year parameter, default to current year if not specified
            out.println("<script>");
            out.println("console.log('Initializing map for year: " + annee + "');");
            
            // Initialize map
            out.println(
                "var map = L.map('map').setView([-18.8792, 47.5079], 13);" +
                "L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {" +
                "    maxZoom: 19," +
                "    attribution: '© OpenStreetMap contributors'" +
                "}).addTo(map);"
            );
            
            // Get all maisons
            Maison maison = new Maison();
            String query = "select * from " + maison.getNomTable();
            Maison[] maisons = (Maison[])CGenUtil.rechercher(maison, query, conn);
            
            out.println(String.format("console.log('Found %d maisons');", maisons.length));
            
            // Add markers for each maison
            for (Maison m : maisons) {
                double lat = m.getLatitude();
                double lng = m.getLongitude();
                
                // Get tax status for this year
                EtatTaxe etat = m.getEtat(conn, annee);
                
                // Debug each maison's coordinates and tax status
                out.println(String.format(
                    "console.log('Processing maison: %s');" +
                    "console.log('  Coordinates: [%f, %f]');" +
                    "console.log('  Surface: %.2f m2');" +
                    "console.log('  Etages: %d');" +
                    "console.log('  Mois payes: %d');" +
                    "console.log('  Montant paye: %.2f Ar');" +
                    "console.log('  Montant restant: %.2f Ar');",
                    m.getLibelle(),
                    lat, lng,
                    m.getSurface(),
                    m.getEtage(),
                    etat.getMoisPayes(),
                    etat.getMontantPaye(),
                    etat.getMontantRestant()
                ));

                // Only add marker if coordinates are valid
                if (lat != 0 && lng != 0) {
                    String popupContent = String.format(
                        "<b>%s</b><br>" +
                        "Surface: %.2f m2<br>" +
                        "Etages: %d<br>" +
                        "Prix par m2: %.2f Ar<br>" +
                        "Taxe mensuelle: %.2f Ar<br>" +
                        "<hr>" +
                        "<b>Etat des taxes %d:</b><br>" +
                        "Mois payes: %d/12<br>" +
                        "Montant paye: %.2f Ar<br>" +
                        "Montant restant: %.2f Ar",
                        m.getLibelle(),
                        m.getSurface(),
                        m.getEtage(),
                        m.getConfig(),
                        m.getRealTaxe(conn),
                        annee,
                        etat.getMoisPayes(),
                        etat.getMontantPaye(),
                        etat.getMontantRestant()
                    );

                    // Debug output for tax calculation
                    out.println(String.format(
                        "console.log('Tax details for %s:');" +
                        "console.log('  Config (price/m2): %.2f Ar');" +
                        "console.log('  Monthly tax: %.2f Ar');",
                        m.getLibelle(),
                        m.getConfig(),
                        m.getRealTaxe(conn)
                    ));
                    
                    // Choose marker color based on payment status
                    String markerColor = etat.getMoisPayes() == 12 ? "green" : 
                                       etat.getMoisPayes() > 0 ? "orange" : "red";
                    
                    out.println(
                        "try {" +
                        "    console.log('Adding marker for: " + m.getLibelle() + "');" +
                        "    var marker = L.marker([" + lat + ", " + lng + "], {" +
                        "        icon: L.divIcon({" +
                        "            className: 'custom-div-icon'," +
                        "            html: \"<div style='background-color: " + markerColor + "; " +
                        "                    width: 10px; height: 10px; border-radius: 50%;'></div>\"," +
                        "            iconSize: [10, 10]" +
                        "        })" +
                        "    }).addTo(map)" +
                        "        .bindPopup('" + popupContent.replace("'", "\\'") + "');" +
                        "    console.log('Marker added successfully');" +
                        "} catch(e) {" +
                        "    console.error('Error adding marker:', e);" +
                        "}"
                    );
                } else {
                    out.println(String.format(
                        "console.warn('Invalid coordinates for maison: %s')",
                        m.getLibelle()
                    ));
                }
            }
            
            out.println("console.log('Map initialization complete');");
            out.println("</script>");
            
        } catch (Exception e) {
            out.println("<script>");
            out.println("console.error('Error: " + e.getMessage().replace("'", "\\'") + "');");
            out.println("</script>");
            e.printStackTrace();
        }
    %>
</body>
</html> 