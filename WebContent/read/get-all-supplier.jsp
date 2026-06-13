<%-- 
    Document   : get-all-suppliers
    Created on : Jan 28, 2013, 4:31:03 PM
    Author     : anita
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="org.spa.entity.Supplier"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="flexjson.JSONSerializer"%>
<%@page import="org.spa.ds.SupplierMaster"%>
<%
    String s = null;
    s = new JSONSerializer().exclude("*.class").deepSerialize("root",new SupplierMaster().getAllSupplier());
    out.write(s);
%>
