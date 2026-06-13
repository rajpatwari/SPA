<%-- 
    Document   : delete-supplier
    Created on : Jan 28, 2013, 5:51:59 PM
    Author     : anita
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="org.spa.entity.Supplier"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="flexjson.JSONSerializer"%>
<%@page import="org.spa.ds.SupplierMaster"%>
<%
    String st = "{success: false}";
    String supplier_id = request.getParameter("supplier_id").trim();
    Supplier supplier = new Supplier();
    supplier.setSupplierID(Integer.parseInt(supplier_id));

    SupplierMaster ds = new SupplierMaster();
    ds.deleteSupplierMaster(supplier);
    st = "{success: true}";

out.write(st);%>
