<%@page import="java.util.ArrayList"%>
<%@page import="org.spa.entity.SectionWiseItemSum"%>
<%@page import="java.util.Vector"%>
<%@page import="org.spa.ds.DistrictMaster"%>
<%@page import="org.spa.entity.TalukaOrder"%>
<%@page import="java.util.List"%>
<%@page import="org.spa.ds.TalukaOrderDS"%>
<%@page import="org.spa.entity.Section"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    int talukaID = Integer.parseInt(request.getParameter("selTalukaID"));
    int selectedTalukaOrderID = Integer.parseInt(request.getParameter("selectedTalukaOrderID"));
    int toCopyTalukaOrderID = Integer.parseInt(request.getParameter("toCopyTalukaOrderID"));
    int i = 0;
    String msg  = "{success:false}";
    Vector<Section> sectionDetails = new DistrictMaster().getAllSections(talukaID);
    TalukaOrderDS DS = new TalukaOrderDS();
    ArrayList<SectionWiseItemSum> orderDetails = new TalukaOrderDS().getAllTalukaOrderDetailsForCopy(toCopyTalukaOrderID);

    for(SectionWiseItemSum  s : orderDetails) 
    {
        s.setTalukaOrderId(selectedTalukaOrderID);
        i = DS.createOrderDetail(s, s.getSchoolID());
    }
    if(i != 0) 
    {
        msg = "{success:true}";
    }
    out.println(msg);
%>