<%@page import="org.spa.ds.DispatchDS"%>
<%@page import="flexjson.JSONSerializer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String s = new JSONSerializer().exclude("*.class").deepSerialize("root",new DispatchDS().getDispatcheTalukaOrders(Integer.parseInt(request.getParameter("dispatchID")),Integer.parseInt(request.getParameter("biltyNo"))));
    out.write(s);
%>