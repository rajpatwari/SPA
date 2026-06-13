<%-- 
    Document   : update-taluka-order
    Created on : Jan 30, 2013, 4:24:01 PM
    Author     : anita
--%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="org.spa.connect.dbConnection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="org.spa.entity.TalukaOrder"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="flexjson.JSONSerializer"%>
<%@page import="org.spa.ds.TalukaOrderDS"%>
<%

    dbConnection dbCon = null;
    Connection con = null;
    ResultSet resultSet = null;
    PreparedStatement ps = null;

    String st = "{success: false}";
    String districtOrderId = request.getParameter("editDistrictOrderID").trim();
    String talukaOrderNo = request.getParameter("govOrderNumber").trim();
    String talukaID = request.getParameter("editTalukaID").trim();
    String talukaOrderDate = request.getParameter("govOrderDate").trim();
    String fromMonth = request.getParameter("fromMonth").trim();
    String fromYear = request.getParameter("fromYear").trim();
    String toMonth = request.getParameter("toMonth").trim();
    String toYear = request.getParameter("toYear").trim();
    String orderType = request.getParameter("orderType").trim();
    int counter = 0;

    if(Integer.parseInt(fromYear) < Integer.parseInt(toYear))
    {
        counter =1;
    }
    else if(Integer.parseInt(fromYear) == Integer.parseInt(toYear))
    {
        if(Integer.parseInt(fromMonth) <= Integer.parseInt(toMonth))
           counter =1;
    }
    else
    {
        counter =0;
    }
    
    if(counter == 1)
    {
        String talukaOrderID = request.getParameter("editTalukaOrderID").trim();

        //System.out.println("talukaOrderID"+talukaOrderID);

        TalukaOrder tOrder = new TalukaOrder();
        tOrder.settOrderDistrictId(Integer.parseInt(districtOrderId));
        tOrder.setTalukaOrderGovNum(talukaOrderNo);
        tOrder.setTalukaId(Integer.parseInt(talukaID));
        tOrder.settOrderDate(talukaOrderDate);
        tOrder.setFromMonth(fromMonth);
        tOrder.setFromYear(fromYear);
        tOrder.setToMonth(toMonth);
        tOrder.setToYear(toYear);
        tOrder.setTalukaOrderId(Integer.parseInt(talukaOrderID));
        tOrder.setOrderType(Integer.parseInt(orderType));
        TalukaOrderDS ds = new TalukaOrderDS();
        int tOrderID = 0;
        if(Integer.parseInt(talukaOrderID) == 0)
        {
            tOrderID = ds.addTalukaOrder(tOrder);
        }
        else
        {
            tOrderID = ds.updateTalukaOrder(tOrder);
        }
        if(tOrderID != 0)
        {
            st = "{success: true}";
        }
    }
out.write(st);%>
