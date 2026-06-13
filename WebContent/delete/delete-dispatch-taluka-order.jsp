<%@page import="org.spa.ds.DispatchDS"%>
<%@page import="java.util.StringTokenizer"%>
<%@page import="java.util.Vector"%>
<%@page import="java.util.List"%>
<%@page import="flexjson.JSONDeserializer"%>
<%
    int result  = new DispatchDS().deleteDispatchDetails(Integer.parseInt(request.getParameter("dispatchDetailsID")));   
    String s = "{success: true}";
    out.write(s);
%>
