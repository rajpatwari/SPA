<%-- 
    Document   : print all challan transport copy
    Created on : June 17, 2018, 6:30:34 PM
    Author     : Raj
--%>
<%@page import="java.util.StringTokenizer"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="org.spa.helper.TalukaOrderDetailDSHelper"%>
<%@page import="org.spa.entity.*"%>
<%@page import="org.spa.ds.*"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="org.spa.convert.monthYearToMarathi"%>
<%@page import="org.spa.connect.dbConnection"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html lang="mr">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>बीट गोषवारा</title>
<style type="text/css">
<!--
body {
	font-family: Tahoma;
}

img {
	border: 0;
}

#page {
	width: 590px;
	margin: 0 auto;
	padding: 0px;
}

#address {
	height: 181px;
	margin-left: 15px;
}

table {
	width: 100%;
}

td {
	padding: 0px;
}

tr.odd {
	background: #e1ffe1;
}

tr.center {
	text-align: center;
}

td.center {
	text-align: center;
}

td.right {
	text-align: right;
}

tr.right {
	text-align: right;
}

right {
	text-align: right;
}

.fontMarathiNumber {
	font: normal normal 12px/15px Kiran, Tahoma;
	text-decoration: none;
}

.fontMarathiNumber14 {
	font: normal normal bold 16px/20px Kiran, Tahoma;
	text-decoration: none;
	margin: 0px;
	padding: 0px;
}

.fontMarathiNumber10 {
	font: normal normal 10px/30px Kiran, Tahoma;
	text-decoration: none;
}

.fontsize10 {
	font: normal normal 10px Tahoma;
	text-decoration: none;
}

.fontsize12 {
	font: normal normal 12px Tahoma;
	text-decoration: none;
}

.fontsize14 {
	font: normal normal 14px Tahoma;
	text-decoration: none;
}

table.printstyle {
	border-width: 2px;
	border-spacing: 0px;
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
	border-style: inset;
	border-color: gray;
	background-color: white;
}

P.breakhere {
	page-break-before: always;
}
-->
</style>
<%
	NumberFormat twoDecimalFormatter = new DecimalFormat("#0.00");
    NumberFormat zeroDecimalFormatter = new DecimalFormat("#0");

    String talukaOrderID = request.getParameter("talukaOrderID");
    String beatID = request.getParameter("beatID");
    int orderType = Integer.parseInt(request.getParameter("orderType"));
/*
    System.out.println("talukaOrderID " + talukaOrderID);
    System.out.println("beatID " + beatID);
    System.out.println("orderType " + orderType);
*/
    int tOrderID = Integer.parseInt(talukaOrderID);
    int tID = Integer.parseInt(beatID);
    int i = 0;

    TalukaOrderDS DS = new TalukaOrderDS();
    DistrictMaster DM = new DistrictMaster();                    
    TalukaOrderDetailDSHelper dSHelper = new TalukaOrderDetailDSHelper();
                              
    TalukaOrder talukaOrderHelper = dSHelper.talukaOrderDetails(tOrderID);                    
    ArrayList<SectionWiseItemSum> sectionOrder = DS.getAllTalukaOrderDetails(tID,tOrderID);
%>

</head>
<body>
	<table align="center" width="1200" border="1">

		<%

	String dd = ""; //= st.nextToken("/") ;
	String mm = ""; // st.nextToken("/") ;
	String yy = ""; // st.nextToken("/") ;
	String challanDate = null;
	StringTokenizer st = null;
    SectionWiseItemSum allSum = new SectionWiseItemSum();
    if( orderType == 2 )
    { 
        for(SectionWiseItemSum sectionWiseItemSum : sectionOrder )
        {
            for(int k =1; k<=2;k++)
            {
%>
		<tr>
			<%
               for(int j =1; j<=2;j++)
               {
                   i = 0; 
                   challanDate = sectionWiseItemSum.getChallanDate();
                   if(challanDate != null) 
                   {
                       st = new StringTokenizer(challanDate,"/");
                       dd=st.nextToken("/");
                       mm =st.nextToken("/");
                       yy =st.nextToken("/");
                   }

%>
			<td>
				<table width="" border=0>
					<tbody>
						<tr class="center">
							<td colspan="4" class="fontsize14"><b>अग्रवाल ट्रान्सपोर्ट</b></td>
						</tr>
						<tr class="fontsize12 center">
							<td colspan="4">१३ बारापत्थर, धुळे</td>
						</tr>
						<tr class="fontMarathiNumber14">
							<td width="" class="fontMarathiNumber14 noprint">पावती क्र.</td>
							<td width=""><span class="fontMarathiNumber14"><%=sectionWiseItemSum.getChallanNumber()%></span></td>
							<td width="" class="noprint">दिनांक :</td>
							<td width=""><span class="fontsize14"><font
									face="Kiran"><%=dd%></font>/<font face="Kiran"><%=mm%></font>/<font
									face="Kiran"><%=yy%></font></span></td>
						</tr>
						<tr class="fontMarathiNumber14">
							<td class="noprint">माल पाठविणारा :</td>
							<td>केंद्रीय भांडार</td>
							<td class="noprint">मो. नं.:</td>
							<td></td>
						</tr>
						<tr class="fontMarathiNumber14">
							<td class="noprint">माल घेणारा :</td>
							<td><%=sectionWiseItemSum.getSchoolMarathi() %>, ता.<%=talukaOrderHelper.getTalukaName()%>, जि. <%=talukaOrderHelper.getDistrictName()%></td>
							<td class="noprint">ट्रक नं.:</td>
							<td></td>
						</tr>
						<tr>
							<td colspan="" class="fontMarathiNumber14 noprint">स्टेशन :</td>
							<td colspan="3" class="fontMarathiNumber14"><b>ता.<%=talukaOrderHelper.getTalukaName()%>, जि. <%=talukaOrderHelper.getDistrictName()%></b></td>
						</tr>
					</tbody>
				</table>
				<table align="center" class="printstyle" width="600" cellspacing="1" cellpadding="1">
					<tbody>
						<tr>
							<th width="10%">अ. क्र.</th>
							<th width="30%">पुरवठा प्रकार</th>
							<th width="20%">एकूण पुरवठा(किलो)
						</tr>
						<tr>
							<th class="fontMarathiNumber"><%=1%></th>
							<th class="fontsize12 center">तुर डाळ</th>
							<th class="fontMarathiNumber"><%=sectionWiseItemSum.getMungdaal() %></th>
						</tr>
						<tr>
							<th class="fontMarathiNumber"><%=2%></th>
							<th class="fontsize12 center">तुर डाळ</th>
							<th class="fontMarathiNumber"><%=sectionWiseItemSum.getMatki() %></th>
						</tr>
						<tr>
							<th class="fontMarathiNumber"><%=3%></th>
							<th class="fontsize12 center">हरभरा</th>
							<th class="fontMarathiNumber"><%=sectionWiseItemSum.getMung() %></th>
						</tr>
						<tr>
							<th class="fontMarathiNumber"><%=4%></th>
							<th class="fontsize12 center">मटकी</th>
							<th class="fontMarathiNumber"><%=sectionWiseItemSum.getMasuldaal() %></th>
						</tr>
						<tr>
							<th class="fontMarathiNumber"><%=5%></th>
							<th class="fontsize12 center">चवली</th>
							<th class="fontMarathiNumber"><%=sectionWiseItemSum.getChvli() %></th>
						</tr>
						<tr>
							<th class="fontMarathiNumber"><%=6%></th>
							<th class="fontsize12 center">तेल (सोया अॅगमार्क)</th>
							<th class="fontMarathiNumber"><%=sectionWiseItemSum.getTel() %></th>
						</tr>
						<tr>
							<th class="fontMarathiNumber"><%=7%></th>
							<th class="fontsize12 center">मीठ (आयोडिनयुक्त)</th>
							<th class="fontMarathiNumber"><%=sectionWiseItemSum.getMith() %></th>
						</tr>						
						<tr>
							<th class="fontMarathiNumber"><%=8%></th>
							<th class="fontsize12 center">कांदा लसूण मसाला</th>
							<th class="fontMarathiNumber"><%=sectionWiseItemSum.getMirchi() %></th>
						</tr>
						<tr>
							<th class="fontMarathiNumber"><%=9%></th>
							<th class="fontsize12 center">हळद (अॅगमार्क)</th>
							<th class="fontMarathiNumber"><%=sectionWiseItemSum.getHalad() %></th>
						</tr>
						<tr>
							<th class="fontMarathiNumber"><%=10%></th>
							<th class="fontsize12 center">जिरे</th>
							<th class="fontMarathiNumber"><%=sectionWiseItemSum.getJire() %></th>
						</tr>
						<tr>
							<th class="fontMarathiNumber"><%=11%></th>
							<th class="fontsize12 center">मोहरी</th>
							<th class="fontMarathiNumber"><%=sectionWiseItemSum.getMohari() %></th>
						</tr>
					</tbody>
				</table>
				<table border=0>
					<tbody>
						<tr class="">
						    <td class="fontMarathiNumber14" colspan="4">मोटार भाडा<br/><br/></td>
						    <td class="center"><br/><br/></td>
						</tr>
						<tr class="">
						    <td class="" colspan="4">Company Sign.</td>
						    <td class="center">Driver Sign.</td>
						</tr>
					</tbody>
				</table>
			</td>
			<%
        		}
%>
		</tr>
		<%
            }
        }  
    }
%>
	</table>
</body>
</html>