<%@page import="org.spa.ds.DistrictMaster"%>
<%@page import="java.util.StringTokenizer"%>

<%
    String s = "{success: false}";
    String sectionID = request.getParameter("sectionID");
    String talukaID = request.getParameter("talukaID");
    
    DistrictMaster dS = new DistrictMaster();
    int successFlag = dS.moveSection(Integer.parseInt(sectionID),  Integer.parseInt(talukaID));
    if(successFlag == 1) 
    {
         s = "{success: true}";
    }
    out.write(s);
%>
