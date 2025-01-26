<%@page import="java.util.Locale"%>
<%@page import="java.util.ResourceBundle"%>
<%@page import="bean.CGenUtil"%>
<%@page import="utilitaire.Utilitaire"%>

<%@ page import="java.io.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Login Impôts</title>
</head>
<body>
    <div class="form-container">
        <h2>Connexion Impôts</h2>
        <div class="row">
            <div class="login-box loginBody" >
              
              <div class="login-box-body">
                <div class="login-logo">
                    <a href="index.jsp">
                        <img style="width: 148px; height: 148px;" src="${pageContext.request.contextPath}/assets/img/logo_sisal-rmbg.png"/>
                    </a>
                </div>
            <p class="login-box-msg" style=" font-weight: bold; font-size: 20px;">Identification</p>
            
            <% if (request.getParameter("error") != null) { %>
                <div class="error">Erreur: <%= request.getParameter("error") %></div>
            <% } %>
            
            <% if (request.getParameter("success") != null) { %>
                <div class="success"><%= request.getParameter("success") %></div>
            <% } %>
            
            <form action="taxe/login_process.jsp" method="POST">
                <div class="input-group" style="margin-bottom: 10px;">
                    <span class="input-group-addon"><i class="fa fa-user"></i></span>
                    <input type="text" name="nom" class="form-control" placeholder="Utilisateur" autofocus="autofocus"/>
                </div>
                <div class="input-group" style="margin-bottom: 10px;">
                    <span class="input-group-addon"><i class="fa fa-lock"></i></span>
                    <input type="password" name="mdp" class="form-control" placeholder="Mot de passe" />
                </div>
                <div class="row">
                    <div class="col-xs-7">
                        <p style="font-weight: bold;"></p>
                    </div>
                    <div class="col-xs-5">
                        <button type="submit" class="btn btn-success btn-block btn-flat">Se connecter</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
    
          </div><!-- /.login-box -->
    
          <!-- jQuery 2.1.4 -->
          <script src="${pageContext.request.contextPath}/plugins/jQuery/jQuery-2.1.4.min.js" type="text/javascript"></script>
          <!-- Bootstrap 3.3.2 JS -->
          <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
          <!-- iCheck -->
          <script src="${pageContext.request.contextPath}/plugins/iCheck/icheck.min.js" type="text/javascript"></script>
          <script>
            $(function () {
              $('input').iCheck({
                checkboxClass: 'icheckbox_square-blue',
                radioClass: 'iradio_square-blue',
                increaseArea: '20%' // optional
              });
            });
          </script>
    </div>
</body>
</html> 