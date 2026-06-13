<%@page import="java.util.StringTokenizer"%>
<%@page import="org.spa.ds.DispatchDS"%>
<%@page import="org.spa.entity.Dispatch"%>
<%@page import="flexjson.JSONSerializer"%>
<%@page import="java.util.List"%>
<%@page import="org.spa.helper.Paging"%>
<%@page import="org.spa.entity.User"%>
<%@page import="org.spa.entity.Page"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%

	String fromDate  = (String)session.getAttribute("fromYear");
	String toDate  = (String)session.getAttribute("toYear");
	int start = Integer.parseInt(request.getParameter("start"));
	int limit = Integer.parseInt(request.getParameter("limit"));
            
	String sql = " SELECT dispatch_id, bilty_no,d.created_on,truck_capacity, freight_per_ton,adv_freight,driver_name,dm.district_id,dm.district_marathi,d.taluka_id,tm.taluka_marathi,agent_name,bilty_date,draft_bilty_num,driver_license,vehicle_number,get_dispatch_total(d.dispatch_id) AS dispatch_loading "
          	   + " FROM dispatch d  "
          	   + " INNER JOIN taluka_master tm ON tm.taluka_id = d.taluka_id "
          	   + " INNER JOIN district_master dm ON dm.district_id = tm.district_id_fk "
          	   + " WHERE STR_TO_DATE(bilty_date,'%d/%m/%Y') BETWEEN STR_TO_DATE('"+fromDate+"','%d/%m/%Y') AND STR_TO_DATE('"+toDate+"','%d/%m/%Y') "
          	   + " GROUP BY dispatch_id DESC ";

	Page paginatedPage = new Page(new DispatchDS().getAllDispatches(start, limit, fromDate, toDate),new Paging().getTotalRowCount(sql));
	String s = new JSONSerializer().exclude("*.class").deepSerialize(paginatedPage);
	
	//s = new JSONSerializer().exclude("*.class").deepSerialize("root",new DispatchDS().getAllDispatches(start, limit, fromDate, toYear));
	out.write(s);

%>