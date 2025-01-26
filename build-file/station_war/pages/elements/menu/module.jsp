<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@page import="java.util.Locale"%>
<%@page import="java.util.ResourceBundle"%>
<%@page import="javax.ejb.ConcurrentAccessTimeoutException"%>
<%@page import="menu.MenuDynamique"%>
<%@page import="java.util.ArrayList"%>
<%@page import="utilisateur.UserMenu"%>
<%@page import="bean.CGenUtil"%>
<%@page import="mg.cnaps.utilisateur.CNAPSUser"%>
<%@page import="user.UserEJB"%>

    
<%
     HttpSession sess = request.getSession();
  String lang = "fr"; 
  if(sess.getAttribute("lang")!=null){
      lang = String.valueOf(sess.getAttribute("lang"));
  }
  ResourceBundle RB = ResourceBundle.getBundle("text", new Locale(lang));
  
    try{

    if(request.getParameter("currentMenu")!=null && request.getParameter("currentMenu")!=""){
        session.setAttribute("currentMenu", request.getParameter("currentMenu"));
    }
    String  currentMenu =(String) request.getSession().getAttribute("currentMenu");  
    UserEJB u = (UserEJB) session.getAttribute("u");
    CNAPSUser cnapsUser = u.getCnapsUser();
    ArrayList<ArrayList<MenuDynamique>> arbre =null;
    if(session.getAttribute("MENU")==null){
        arbre = MenuDynamique.getElementMenu(request, u.getUser(), cnapsUser);
        session.setAttribute("MENU", arbre);
    }else{
        arbre = (ArrayList<ArrayList<MenuDynamique>>) session.getAttribute("MENU");
    }
    MenuDynamique[] tabMenu = null;
    if(request.getServletContext().getAttribute("tabMenu")!=null){
        tabMenu=(MenuDynamique[])request.getServletContext().getAttribute("tabMenu");
    }
 %>
 <aside class="main-sidebar">
    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">
        <!-- sidebar menu: : style can be found in sidebar.less -->
        <ul class="sidebar-menu" id="menuslider">
            <li class="header">Menu</li>
            <%=MenuDynamique.renderMenu(arbre,currentMenu,tabMenu,RB) %>              
            
            <!-- Section Impôts -->
            <li class="treeview">
                <%
                    if (session.getAttribute("commune_taxe") == null) {
                %>
                    <a href="${pageContext.request.contextPath}/pages/module.jsp?but=taxe/login.jsp">
                        <i class="fa fa-money"></i>
                        <span>Impôts</span>
                    </a>
                <%
                    } else {
                        taxe.model.Commune commune = (taxe.model.Commune) session.getAttribute("commune_taxe");
                %>
                    <a href="#">
                        <i class="fa fa-money"></i>
                        <span>Impôts - <%= commune.getNom() %></span>
                        <i class="fa fa-angle-left pull-right"></i>
                    </a>
                    <ul class="treeview-menu">
                        <li><a href="${pageContext.request.contextPath}/pages/module.jsp?but=taxe/insert_maison.jsp">
                            <i class="fa fa-home"></i> Maison</a></li>
                        <li><a href="${pageContext.request.contextPath}/pages/module.jsp?but=taxe/insert_pu.jsp">
                            <i class="fa fa-money"></i>Editer PU</a></li>
                        <li><a href="${pageContext.request.contextPath}/pages/module.jsp?but=taxe/insert_proprietaire.jsp">
                            <i class="fa fa-user"></i> Propriétaire</a></li>
                        <li><a href="${pageContext.request.contextPath}/pages/module.jsp?but=taxe/insert_arrondissement.jsp">
                        <i class="fa fa-map-marker"></i> Arrondissement</a></li>
                        <li><a href="${pageContext.request.contextPath}/pages/module.jsp?but=taxe/insert_type_caracteristique.jsp">
                            <i class="fa fa-list"></i> Type Caractéristique</a></li>
                        <li><a href="${pageContext.request.contextPath}/pages/module.jsp?but=taxe/insert_caracteristique.jsp">
                            <i class="fa fa-tags"></i> Caractéristique</a></li>
                        <li><a href="${pageContext.request.contextPath}/pages/module.jsp?but=taxe/insert_maison_caracteristique.jsp">
                            <i class="fa fa-link"></i> Maison Caractéristique</a></li>
                        <li><a href="${pageContext.request.contextPath}/pages/module.jsp?but=taxe/insert_historique_taxe.jsp">
                            <i class="fa fa-file-text"></i> Taxe</a></li>
                        <li><a href="${pageContext.request.contextPath}/pages/module.jsp?but=taxe/insert_arrondissement.jsp">
                            <i class="fa fa-map-marker"></i> Arrondissement</a></li>
                        <li><a href="${pageContext.request.contextPath}/pages/module.jsp?but=taxe/parametreForm.jsp">
                            <i class="fa fa-search"></i> Voir Taxe</a></li>
                        <li><a href="${pageContext.request.contextPath}/pages/module.jsp?but=taxe/insert_historique_maison.jsp">
                            <i class="fa fa-search"></i> Historique Maison</a></li>
                        <li><a href="${pageContext.request.contextPath}/pages/module.jsp?but=taxe/insert_historique_caracteristique.jsp">
                            <i class="fa fa-search"></i> Historique Caracteristique</a></li>
                        <li class="divider"></li>
                        <li><a href="${pageContext.request.contextPath}/pages/module.jsp?but=taxe/logout.jsp">
                            <i class="fa fa-sign-out"></i> Déconnexion</a></li>
                    </ul>
                <%
                    }
                %>
            </li>
        </ul>
    </section>
    <!-- /.sidebar -->
</aside>
  <% }
  catch(ConcurrentAccessTimeoutException e){
        out.println("<script language='JavaScript'> document.location.replace('/cnaps-war/');</script>");
    }
  %>