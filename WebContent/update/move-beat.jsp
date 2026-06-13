<%@page import="org.spa.ds.DistrictMaster"%>
<%@page import="java.util.StringTokenizer"%>
<%
    String s = "{success: false}";
    String beatId = request.getParameter("beatID");
    String sectionID = request.getParameter("section");
    
    DistrictMaster dS = new DistrictMaster();
    int successFlag = dS.moveBeat(Integer.parseInt(beatId),  Integer.parseInt(sectionID)); 
    if(successFlag == 1) 
    {
        s = "{success: true}";
    }
    out.write(s);
%>
