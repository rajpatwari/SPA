<%-- 
    Document   : add-vendor-master
    Created on : Jan 28, 2013, 4:49:22 PM
    Author     : admin
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="org.spa.entity.Supplier"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="flexjson.JSONSerializer"%>
<%@page import="org.spa.ds.SupplierMaster"%>
<%
    String st = "{success: false}";
    String sName = request.getParameter("sName").trim();
    String sAddress = request.getParameter("sAddress").trim();
    String sContact = request.getParameter("sContact").trim();
    String sTIN = request.getParameter("sTIN").trim();
    String sCST = request.getParameter("sCST").trim();
    Supplier supplier = new Supplier();
    supplier.setSupplierName(sName);
    supplier.setSupplierAddress(sAddress);
    supplier.setContactNum(sContact);
    supplier.setTin(sTIN);
    supplier.setCst(sCST);
    SupplierMaster ds = new SupplierMaster();
    int dups = ds.getSupplierDups(supplier);
    if(dups == 0)
    {
        ds.addSupplierMaster(supplier);
        st = "{success: true}";
    }
    else
    {
    }
    out.write(st);
%>
