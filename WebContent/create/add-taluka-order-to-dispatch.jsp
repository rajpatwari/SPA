<%@page import="org.spa.query.DispatchDSQuery"%>
<%@page import="org.spa.entity.DispatchTalukaOrder"%>
<%@page import="org.spa.entity.TalukaOrder"%>
<%@page import="org.spa.ds.DispatchDS"%>
<%@page import="org.spa.entity.Section"%>
<%@page import="org.spa.entity.Taluka"%>
<%@page import="org.spa.entity.District"%>
<%@page import="java.util.Vector"%>
<%@page import="java.util.List"%>
<%@page import="flexjson.JSONDeserializer"%>
<%
	DispatchDS dS = new DispatchDS();
	DispatchTalukaOrder dto = new DispatchTalukaOrder();
	String s = "{success: false}";
	dto.setDispatchID(Integer.parseInt(request.getParameter("dispatchID")));
	dto.setBeatID(Integer.parseInt(request.getParameter("beatID")));	
	dto.setTalukaOrderID(Integer.parseInt(request.getParameter("orderID")));
	if(dS.dubDispatchOrder(dto) == 0)
	{
		dS.createDispatchOrder(dto);
		s = "{success: true}";
	}
    out.write(s);
%>
