<%@page import="org.spa.ds.InwardMaterialDS"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.List"%>
<%@page import="org.spa.ds.DispatchDS"%>
<%@page import="org.spa.entity.InwardMaterialDetails"%>
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
<%
	NumberFormat fourDecimalFormatter = new DecimalFormat("#0.0000");
    String fromDate = request.getParameter("fromRationDate");
    String toDate = request.getParameter("toRationDate");
    int count = 0;
    String td = "", tm = "", ty = "";
     
    List<InwardMaterialDetails> dispatchList = new InwardMaterialDS().getAllInwardMaterialReceive(fromDate, toDate,1, 100000);

    if(dispatchList != null)
    {
%>		
        <center><h3>&nbsp;&nbsp;Dispatch Report&nbsp;&nbsp;<%=request.getParameter("fromChallanDate")%>&nbsp;&nbsp;-&nbsp;&nbsp;<%=request.getParameter("toChallanDate")%></h3></center>
        <table align="center" class="printstyle fontsize12" width="1200" cellspacing="1" cellpadding="1">
            <thead align="center">
            	<tr>
		            <th>SR NO</th>
		            <th>Inward Date </th>
		            <th>Supplier Name</th>
		            <th>Item Name</th>
		            <th>Truck No.</th>
		            <th>Bags</th>
		            <th>Quantity</th>
		     	</tr>
        	</thead>
	        <tbody align="center">		
<%
    	
	    for (InwardMaterialDetails d : dispatchList) 
	    {
	    	StringTokenizer st3 = new StringTokenizer(d.getInwardDate(), "/- ");
		    td = st3.nextToken();
		    tm = st3.nextToken();
		    ty = st3.nextToken();


%>
	            <tr>
	            	<td ><%=++count%></td>
			        <td ><font face="Kiran"><%=td%></font><span class="fontsize12">/</span><font face="Kiran"><%=tm%></font><span class="fontsize12">/</span><font face="Kiran"><%=ty%></font></td>
                    <td><%=d.getSupplierName()%></td>
                    <td><%=d.getItemMarathi()%></td>
			        <td><%=d.getTruckNo()%></td>
			        <td><%=d.getBag()%></td>
			        <td><%=d.getQtyInKG()%></td>
			   	</tr>
<%
	    }
	}
    else
    {
%>			
	    	</tbody>
	    </table>
		<h1>No Data to Display</h1>
<%
    }
%>
	</body>
</html>