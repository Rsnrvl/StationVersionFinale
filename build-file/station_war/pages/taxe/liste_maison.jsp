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
    <title>Liste des Maisons</title>
    <style>
        .container {
            padding: 20px;
            max-width: 1200px;
            margin: 0 auto;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        
        th {
            background-color: #f5f5f5;
            font-weight: bold;
        }
        
        tr:hover {
            background-color: #f9f9f9;
        }
        
        .status {
            padding: 5px 10px;
            border-radius: 3px;
            font-weight: bold;
        }
        
        .status-paid {
            background-color: #d4edda;
            color: #155724;
        }
        
        .status-partial {
            background-color: #fff3cd;
            color: #856404;
        }
        
        .status-unpaid {
            background-color: #f8d7da;
            color: #721c24;
        }
        
        .summary {
            margin-bottom: 20px;
            padding: 15px;
            background-color: #f8f9fa;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Liste des Maisons</h2>
        
        <%
            int annee = Integer.parseInt(request.getParameter("annee") != null ? 
                       request.getParameter("annee") : String.valueOf(java.time.Year.now().getValue()));
            double totalPaid = 0;
            double totalRemaining = 0;
            int totalMaisons = 0;
            
            try (Connection conn = UtilDB.getConnection()) {
                ArrayList<Maison> maisons = Maison.getAllByCommune(conn, communeTaxe.getId());
                totalMaisons = maisons.size();
        %>
        
        <div class="summary">
            <h3>Résumé pour l'année <%= annee %></h3>
            <table>
                <thead>
                    <tr>
                        <th>Libellé</th>
                        <th>Dimensions</th>
                        <th>Étages</th>
                        <th>Mois Payés</th>
                        <th>Montant Payé</th>
                        <th>Montant Restant</th>
                        <th>État</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (Maison maison : maisons) {
                            EtatTaxe etat = maison.getEtat(conn, annee);
                            totalPaid += etat.getMontantPaye();
                            totalRemaining += etat.getMontantRestant();
                            
                            String statusClass = "";
                            String statusText = "";
                            
                            if (etat.getMoisPayes() == 12) {
                                statusClass = "status-paid";
                                statusText = "Payé";
                            } else if (etat.getMoisPayes() > 0) {
                                statusClass = "status-partial";
                                statusText = "Partiel";
                            } else {
                                statusClass = "status-unpaid";
                                statusText = "Non payé";
                            }
                    %>
                    <tr>
                        <td><%= maison.getLibelle() %></td>
                        <td><%= maison.getLongueur() %>m × <%= maison.getLargeur() %>m</td>
                        <td><%= maison.getEtage() %></td>
                        <td><%= etat.getMoisPayes() %>/12</td>
                        <td><%= String.format("%,.2f", etat.getMontantPaye()) %> Ar</td>
                        <td><%= String.format("%,.2f", etat.getMontantRestant()) %> Ar</td>
                        <td><span class="status <%= statusClass %>"><%= statusText %></span></td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
                <tfoot>
                    <tr>
                        <td colspan="4"><strong>Total</strong></td>
                        <td><strong><%= String.format("%,.2f", totalPaid) %> Ar</strong></td>
                        <td><strong><%= String.format("%,.2f", totalRemaining) %> Ar</strong></td>
                        <td></td>
                    </tr>
                </tfoot>
            </table>
        </div>
        
        <%
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </div>
</body>
</html> 