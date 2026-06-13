<%-- 
    Document   : get-all-items
    Created on : Jan 24, 2013, 1:30:08 PM
    Author     : anita
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="org.spa.entity.Item"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="flexjson.JSONSerializer"%>
<%@page import="org.spa.ds.ItemDS"%>
<%
    String s = null;
    s = new JSONSerializer().exclude("*.class").deepSerialize("root",new ItemDS().getAllItem());
    //System.out.println("s:"+s);
    out.write(s);
%>
