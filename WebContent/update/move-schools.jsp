<!-- moving school to another district - taluka- section -->

<%@page import="org.spa.ds.DistrictMaster"%>
<%@page import="java.util.StringTokenizer"%>

<%
    String s = "{success: false}";
    String schoolId = request.getParameter("schoolID");
    String beatID = request.getParameter("beat");    
    DistrictMaster dS = new DistrictMaster();
    int successFlag = dS.moveSchool(Integer.parseInt(schoolId),  Integer.parseInt(beatID));   
    if(successFlag == 1) 
    {
        s = "{success: true}";
    }
    out.write(s);
%>
