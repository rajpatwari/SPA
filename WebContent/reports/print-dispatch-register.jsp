<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.List"%>
<%@page import="org.spa.ds.DispatchDS"%>
<%@page import="org.spa.entity.Dispatch"%>
<%@page import="java.util.StringTokenizer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Dispatch Register Reports</title>
        <style>
            .fontMarathiNumber {
                font:normal normal 18px Kiran,Verdana;
                text-decoration:none;
            }
            .fontMarathiNumberBold {
                font:normal normal bold 18px Kiran,Verdana;
                text-decoration:none;
            }
            table.printstyle {
                border-width: 2px;
                border-spacing: 0px ;
                border-style: inset;
                border-color: gray;
                border-collapse: collapse;
                background-color: white;
            }
            table.printstyle th {
                border-width: 2px;
                padding: 1px;
                border-style: inset;
                border-color: gray;
                background-color: white;
            }
            table.printstyle td {
                border-width: 1px;
                padding: 1px;
                height: 13px;
                border-style: inset;
                border-color: gray;
                background-color: white;
            }
            .fontsize12 {
                font:normal normal 12px Tahoma;
                text-decoration:none;
            }
            .fontsize12bold {
                font:normal normal bold 12px Tahoma;
                text-decoration:none;
            }
            .fontsize14 {
                font:normal normal 14px Tahoma;
                text-decoration:none;
            }
            .fontsize16 {
                font:normal normal 16px Tahoma;
                text-decoration:none;
            }
            @media print  { .noprint  { display: none; border:0} .noborder  {  border:0} }

            @media screen { .noscreen { display: none; } }

        </style>
    </head>

    <body>
        <center><h3>&nbsp;&nbsp;Dispatch Report&nbsp;&nbsp;<%=request.getParameter("fromChallanDate")%>&nbsp;&nbsp;-&nbsp;&nbsp;<%=request.getParameter("toChallanDate")%></h3></center>
        <table align="center" class="printstyle fontsize12" width="1200" cellspacing="1" cellpadding="1">
            <thead align="center">
            	<tr>
		            <th>SR NO</th>
		            <th>Dispatch No:</th>
		            <th>Bilty No.</th>
		            <th>Bilty Date</th>
		            <th>Taluka</th>
		            <th>District</th>
		            <th>Truck Loading</th>
		            <th>Dispatch Loading</th>
		            <th>Empty Space</th>
		            <th>Freight(&#8377;)<br>/Ton</th>
		            <th>Advance Freight(&#8377;)</th>
		            <th>Driver Name</th>
		            <th>Agent Name</th>
		            <th>Driver License</th>
		            <th>Vehicle No</th>
		     	</tr>
        	</thead>

<%
     String fromDate = request.getParameter("fromChallanDate");
     String toDate = request.getParameter("toChallanDate");
     int start = 0;
     int limit = 0;
     int count = 0;
     String fd, fm, fy, td, tm, ty = "";
     int dispatchID/*, biltyID*/;
     String biltyID;
     String biltyDate, godownName, districtName, talukaName, driverName, agentName, driverLicense, vehicleNo = "";
     double truckLoading, dispatchLoading, freight, advFreight = 0;

     List<Dispatch> dispatchList = new DispatchDS().getAllDispatchesBetweenDate(fromDate, toDate);

     for (Dispatch d : dispatchList) 
     {
         dispatchID = d.getDispatchID();
         biltyID = d.getBiltyNos();
         biltyDate = d.getBiltyDate();
         districtName = d.getDistrictMarathi();
         talukaName = d.getTalukaMarathi();
         driverName = d.getDriverName();
         agentName = d.getAgentName();
         driverLicense = d.getDriverLicense();
         vehicleNo = d.getVehicleNo();
         truckLoading = d.getTruckCapacity();
         dispatchLoading = d.getActualLoading();
         freight = d.getFreightPerTonInRupees();
         advFreight = d.getAdvanceFrieght();

         NumberFormat fourDecimalFormatter = new DecimalFormat("#0.0000");

%>
	        <tbody align="center">
	            <tr>
	            	<td ><%=++count%></td>
			        <td><%=dispatchID%></td>
			        <td><%=biltyID%></td>
			        <td><%=biltyDate%></td>
			        <td width="100"><%=talukaName%></td>
			        <td width="100"><%=districtName%></td>
			        <td><%=truckLoading%></td>
			        <td><%=fourDecimalFormatter.format(dispatchLoading)%></td>
			        <td><% if ((truckLoading < dispatchLoading)) {%>
			            <font color="red"> <%=fourDecimalFormatter.format(truckLoading - dispatchLoading)%></font> <%}%>
			            <% if ((truckLoading > dispatchLoading)) {%>
			            <font color="green"> <%=fourDecimalFormatter.format(truckLoading - dispatchLoading)%></font> <%}%>
			        </td>
			        <td><%=freight%></td>
			        <td><%=advFreight%></td>
			        <td width="100"><%=driverName%></td>
			        <td width="100"><%=agentName%></td>
			        <td><%=driverLicense%></td>
			        <td><%=vehicleNo%></td>
			   	</tr>
	    	</tbody>
<%
	}
%>
		</table>
	</body>
</html>