<!-- Fetching all school based on section selected to display it on grid -->
<%@page import="org.spa.ds.RootDS"%>
<%@page import="flexjson.JSONSerializer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
	int beatID = Integer.parseInt(request.getParameter("beatID").trim());
    String s = new JSONSerializer().exclude("*.class").deepSerialize("root",new RootDS().getAllSchoolNotAddedOnRoot(beatID));
    out.write(s);
%>