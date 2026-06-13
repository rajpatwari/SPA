<%@page import="org.spa.ds.DispatchDS"%>
<%@page import="org.spa.entity.District"%>
<%@page import="java.util.Vector"%>
<%@page import="java.util.List"%>
<%@page import="flexjson.JSONDeserializer"%>
<%
	DispatchDS dS = new DispatchDS();
	String s = "{success:false}";
	int key = dS.createBilty(Integer.parseInt(request.getParameter("dispatchID")));
	if(key != 0)
		s = "{success:true}";
	out.write(s);
%>
