<%@page import="org.spa.ds.DistrictOrderDS"%>
<%@page import="org.spa.entity.Stock"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.spa.ds.StockDS"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="org.spa.helper.TalukaOrderDetailDSHelper"%>
<%@page import="org.spa.entity.Section"%>
<%@page import="java.util.StringTokenizer"%>
<%@page import="java.sql.ResultSet"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <title>Stock Report</title>
    <head>
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
<%
    String onDate = request.getParameter("onDate");
    String fd, fm, fy, td, tm, ty = "";

    StringTokenizer st2 = new StringTokenizer(onDate, "/- ");
    td = st2.nextToken();
    tm = st2.nextToken();
    ty = st2.nextToken();    
    int i = 0;
%>

    <body>
<%
	Stock allSum = new Stock();
	Stock s = new StockDS().getCurrentStockOnDate(onDate);
	if(s != null)
	{		
%>
  		<center>
  			<h3>Stock रिपोर्ट : - <font face="Kiran"><%=td%></font><span class="fontsize12">/</span><font face="Kiran"><%=tm%></font><span class="fontsize12">/</span><font face="Kiran"><%=ty%></font></h3> 
  		</center>
		<table align="center" class="printstyle fontsize12" width="1200" cellspacing="1" cellpadding="1">
			<thead>
                <tr>
                    <th >मुंगदाळ</th>
					<th >तुर डाळ</th>
                    <th >Extra2</th>
					<th >मुंग</th>
					<th >मटकी</th>
					<th >हरभरा</th>
					<th >वटाणा</th>
					<th >सोया वडी</th>
                    <!--
                    <th >Extra3</th>
                    <th >Extra4</th>
                    <th >Extra5</th>
                    <th >Extra6</th>
                    -->
					<th >चवळी</th>
                    <th >तेल (सोया अॅगमार्क)</th>
                    <th >मीठ (आयोडिनयुक्त)</th>
                    <th >कांदा लसूण मसाला</th>
                    <th >हळद (अॅगमार्क)</th>
                    <th >जिरे</th>
                    <th >मोहरी</th>
                    <th >तांदूळ</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <th class="fontMarathiNumber"><%=s.getMungdaal() %></th>
                    <th class="fontMarathiNumber"><%=s.getMatki() %></th>
                    <th class="fontMarathiNumber"><%=s.getExtra2() %></th>
                    <th class="fontMarathiNumber"><%=s.getMung() %></th>
                    <th class="fontMarathiNumber"><%=s.getMasuldaal() %></th>
                    <th class="fontMarathiNumber"><%=s.getHarbara() %></th>
                    <th class="fontMarathiNumber"><%=s.getVatana() %></th>
                    <th class="fontMarathiNumber"><%=s.getExtra1() %></th>
                    <!--
                    <th class="fontMarathiNumber"><%=s.getExtra3() %></th>
                    <th class="fontMarathiNumber"><%=s.getExtra4() %></th>
                    <th class="fontMarathiNumber"><%=s.getExtra5() %></th>
                    <th class="fontMarathiNumber"><%=s.getExtra6() %></th>
                    -->
                    <th class="fontMarathiNumber"><%=s.getChvli() %></th>
                    <th class="fontMarathiNumber"><%=s.getTel() %></th>
                    <th class="fontMarathiNumber"><%=s.getMith() %></th>
                    <th class="fontMarathiNumber"><%=s.getMirchi() %></th>
                    <th class="fontMarathiNumber"><%=s.getHalad() %></th>
                    <th class="fontMarathiNumber"><%=s.getJire() %></th>
                    <th class="fontMarathiNumber"><%=s.getMohari() %></th>
                    <th class="fontMarathiNumber"><%=s.getTandul() %></th>
                </tr>
        	</tbody>
        </table>
<%   
	}
	else
	{
%>
		<h1>No Records is Avelable Between selected date</h1>
<%
	}
%>
    </body>
</html>