<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%-- <%@page import="org.spa.entity.RawMaterial"%> --%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="flexjson.JSONSerializer"%>
<%-- <%@page import="org.spa.ds.RawMaterialDS"%> --%>
<%
    String s = null;
   // String years = request.getParameter("id");
    String fromDate  = (String)session.getAttribute("fromYear");
    String toDate  = (String)session.getAttribute("toYear");
    //s = new JSONSerializer().exclude("*.class").deepSerialize("root",new RawMaterialDS().getAllRawMaterialReceive(fromDate,toDate));
    out.write(s);
%>

