<%@page import="org.spa.ds.DistrictMaster"%>
<%@page import="java.util.StringTokenizer"%>

<%
    String s = "{success: false}";
    String talukaIDS = request.getParameter("talukaIDS");
    String districtID = request.getParameter("districtID");    

    DistrictMaster dS = new DistrictMaster();
    int successFlag = dS.moveTaluka(Integer.parseInt(talukaIDS),  Integer.parseInt(districtID));
    //System.out.println("successFlag "+successFlag);
    if(successFlag > 0) 
    {   
        s = "{success: true}";
    }

    out.write(s);
%>
