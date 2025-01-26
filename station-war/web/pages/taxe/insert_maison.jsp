<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="security_taxe.jsp"%>
<%@ page import="taxe.model.Proprietaire" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="taxe.database.UtilDB" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="taxe.model.Commune" %>

<%@ page import="java.io.*" %>

<div class="content-wrapper">
    <div class="row">
        <div class="col-md-12">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h2>Ajouter une nouvelle maison</h2>
                        <% if (request.getParameter("success") != null) { %>
                            <div style="color: green; margin-bottom: 20px;">Maison ajoutée avec succès!</div>
                        <% } %>
            
                        <% if (request.getParameter("error") != null) { %>
                            <div style="color: red; margin-bottom: 20px;">Erreur: <%= request.getParameter("error") %></div>
                        <% } %>
                    </div>
                    <div class="box-body">
                        <form action="taxe/insert_maison_process.jsp" method="POST">
                            <table style="width: 100%; border-collapse: collapse; margin-bottom: 20px;">
                                <!-- Champ Libellé -->
                                <tr>
                                    <th style="text-align: left; padding: 8px; border: 1px solid #ddd;"><label for="libelle">Libellé</label></th>
                                    <td style="padding: 8px; border: 1px solid #ddd;">
                                        <input name="libelle" type="text" style="width: 100%; padding: 8px;" id="libelle" required>
                                    </td>
                                </tr>
                                <!-- Champ Longueur -->
                                <tr>
                                    <th style="text-align: left; padding: 8px; border: 1px solid #ddd;"><label for="longueur">Longueur</label></th>
                                    <td style="padding: 8px; border: 1px solid #ddd;">
                                        <input name="longueur" type="number" step="0.01" style="width: 100%; padding: 8px;" id="longueur" required>
                                    </td>
                                </tr>
                                <!-- Champ Largeur -->
                                <tr>
                                    <th style="text-align: left; padding: 8px; border: 1px solid #ddd;"><label for="largeur">Largeur</label></th>
                                    <td style="padding: 8px; border: 1px solid #ddd;">
                                        <input name="largeur" type="number" step="0.01" style="width: 100%; padding: 8px;" id="largeur" required>
                                    </td>
                                </tr>
                                <!-- Champ Étages -->
                                <tr>
                                    <th style="text-align: left; padding: 8px; border: 1px solid #ddd;"><label for="etage">Étages</label></th>
                                    <td style="padding: 8px; border: 1px solid #ddd;">
                                        <input name="etage" type="number" style="width: 100%; padding: 8px;" id="etage" required>
                                    </td>
                                </tr>
                                <!-- Champ Longitude -->
                                <tr>
                                    <th style="text-align: left; padding: 8px; border: 1px solid #ddd;"><label for="longitude">Longitude</label></th>
                                    <td style="padding: 8px; border: 1px solid #ddd;">
                                        <input name="longitude" type="text" style="width: 100%; padding: 8px;" id="longitude" value="0" onblur="calculer('longitude')" required>
                                    </td>
                                </tr>
                                <!-- Champ Latitude -->
                                <tr>
                                    <th style="text-align: left; padding: 8px; border: 1px solid #ddd;"><label for="latitude">Latitude</label></th>
                                    <td style="padding: 8px; border: 1px solid #ddd;">
                                        <input name="latitude" type="text" style="width: 100%; padding: 8px;" id="latitude" value="0" onblur="calculer('latitude')" required>
                                    </td>
                                </tr>
                                <!-- Champ ID Propriétaire -->
                                <tr>
                                    <th style="text-align: left; padding: 8px; border: 1px solid #ddd;"><label for="idProprietaire">ID Propriétaire</label></th>
                                    <td style="padding: 8px; border: 1px solid #ddd;">
                                        <select name="idproprietaire" style="width: 100%; padding: 8px;" id="idproprietaire">
                                            <%
                                                try (Connection conn = UtilDB.getConnection()) {
                                                    ArrayList<Proprietaire> proprietaires = Proprietaire.getAll(conn);
                                                    for (Proprietaire prop : proprietaires) {
                                            %>
                                                <option value="<%= prop.getId() %>">
                                                    <%= prop.getNom() %>
                                                </option>
                                            <%
                                                    }
                                                } catch (Exception e) {
                                                    out.println("Erreur lors du chargement des propriétaires: " + e.getMessage());
                                                }
                                            %>
                                        </select>
                                    </td>
                                </tr>
                            </table>

                            <div style="text-align: center;">
                                <button type="submit" style="padding: 10px 20px; background-color: #28a745; color: white; border: none; cursor: pointer;">Enregistrer</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
