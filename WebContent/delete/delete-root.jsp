<%@page import="org.spa.ds.RootDS"%>
<%@page import="java.util.StringTokenizer"%>
<%@page import="java.util.Vector"%>
<%@page import="java.util.List"%>
<%@page import="flexjson.JSONDeserializer"%>
<%
	RootDS dS = new RootDS();
	String s = "{success: false}";
    String master = request.getParameter("master");
    if(dS.deleteRoot(Integer.parseInt(request.getParameter("rootMasterID"))) != 0)
    {
     	s = "{success: true}";
    }
    out.write(s);
%>
