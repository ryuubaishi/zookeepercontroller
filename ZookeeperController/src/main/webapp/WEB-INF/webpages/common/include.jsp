<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
    //String basepath = pageContext.getServletContext().getContextPath();
    String basepath = request.getContextPath();
    String webbasepath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ basepath + "/";
%>

<script type="text/javascript"
        src="<%=basepath%>/javascript/jquery-1.4.2.js">
</script>


