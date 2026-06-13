<%-- 
    Document   : update-supplier-master
    Created on : Jan 28, 2013, 5:42:47 PM
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
    String v_id = request.getParameter("esId").trim();
    String v_name = request.getParameter("esName").trim();
    String v_address = request.getParameter("esAddress").trim();
    String v_Contact = request.getParameter("esContact").trim();
    String v_tin = request.getParameter("esTIN").trim();
    String v_cst = request.getParameter("esCST").trim();
    Supplier supplier = new Supplier();
    supplier.setSupplierID(Integer.parseInt(v_id));
    supplier.setSupplierName(v_name);
    supplier.setSupplierAddress(v_address);
    supplier.setContactNum(v_Contact);
    supplier.setTin(v_tin);
    supplier.setCst(v_cst);
    SupplierMaster ds = new SupplierMaster();
    int dups = ds.getSupplierDups(supplier);
    if(dups == 0)
    {
        ds.updateSupplierMaster(supplier);
        st = "{success: true}";
    }
    else
    {
    }
    out.write(st);
%>
