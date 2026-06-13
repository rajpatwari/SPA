<%@page import="org.spa.ds.RootDS"%>
<%@page import="java.util.StringTokenizer"%>
<%@page import="java.util.Vector"%>
<%@page import="java.util.List"%>
<%@page import="flexjson.JSONDeserializer"%>
<%
	RootDS dS = new RootDS();
	String s = "{success: false}";
    if(dS.deleteSchoolFromRoot(Integer.parseInt(request.getParameter("rootDetailsID"))) != 0)
    {
     	s = "{success: true}";
    }
    out.write(s);
%>
