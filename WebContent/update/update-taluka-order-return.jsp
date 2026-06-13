<%-- 
    Document   : update-taluka-order-details
    Created on : Feb 1, 2013, 12:56:02 PM
    Author     : anita
--%>

<%@page import="org.spa.ds.TalukaOrderDS"%>
<%@page import="java.util.List"%>
<%@page import="org.spa.entity.SectionWiseItemSum"%>
<%@page import="org.spa.helper.TalukaOrderDetailDSHelper"%>

<%
    String s = "{success: false}";
    String tOrderDetails = request.getParameter("postdata");
    String talukaorderID = request.getParameter("talukaorderID");
    String sectionID = request.getParameter("sectionID");   
    TalukaOrderDetailDSHelper h = new TalukaOrderDetailDSHelper();
    TalukaOrderDS dS = new TalukaOrderDS();
    List<SectionWiseItemSum> details = h.convert(tOrderDetails, Integer.parseInt(talukaorderID), Integer.parseInt(sectionID));
    int i;
    for (SectionWiseItemSum orderDetail : details) 
    {
        if (orderDetail.getTalukaOrderDetailsId() == 0)
        {
            i = dS.createReturnDetail(orderDetail, Integer.parseInt(sectionID));
            s = "{success: true}";          
        }
        else
        {
            i = dS.updateReturnDetail(orderDetail, Integer.parseInt(sectionID));
            s = "{success: true}";
        }
    }
    
    out.write(s);
%>
