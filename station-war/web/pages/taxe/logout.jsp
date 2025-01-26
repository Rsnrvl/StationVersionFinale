<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    session.removeAttribute("commune_taxe");
    session.removeAttribute("pu_defaut");
%>
<script>
    window.location.href = "${pageContext.request.contextPath}/pages/module.jsp?but=taxe/login.jsp";
</script>