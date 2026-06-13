<%@page import="org.spa.ds.DispatchDS"%>
<%@page import="java.util.StringTokenizer"%>
<%@page import="java.util.Vector"%>
<%@page import="java.util.List"%>
<%@page import="flexjson.JSONDeserializer"%>
<%
    DispatchDS  dS = new DispatchDS();
    dS.deleteDispatch(Integer.parseInt(request.getParameter("dispatchID")));
    String s = "{success: true}";
    out.write(s);
%>
