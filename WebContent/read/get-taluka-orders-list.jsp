<%@page import="org.spa.ds.DistrictMaster"%>
<%@page import="flexjson.JSONSerializer"%>
<%@page import="org.spa.ds.TalukaOrderDS"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String s = null;
    int talukaID = Integer.parseInt(request.getParameter("talukaID"));
    int talukaOrderID = 0;
    int orderType = 0;
    try
    {
    	orderType = Integer.parseInt(request.getParameter("orderType"));
    	talukaOrderID = Integer.parseInt(request.getParameter("talukaOrderID"));
    }
    catch(Exception e)
    {
    	orderType = 0;
    }
    if(orderType != 0)
    {
	    if(request.getParameter("talukaOrderID") != null)
	    {
	        s = new JSONSerializer().exclude("*.class").deepSerialize("root",new TalukaOrderDS().getTalukaOrderList(talukaID,talukaOrderID, orderType));
	    }
	    else
	    {
	        s = new JSONSerializer().exclude("*.class").deepSerialize("root",new TalukaOrderDS().getTalukaOrderListAll(talukaID, orderType));
	    }
    }
    else
    {
    	s = new JSONSerializer().exclude("*.class").deepSerialize("root",new TalukaOrderDS().getTalukaOrderListAll(talukaID, orderType));
    }
    out.write(s);
%>