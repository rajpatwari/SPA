<%-- 
    Document   : print all challan bills
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
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN http://www.w3.org/TR/html4/loose.dtd">

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
	<%
	String dd = ""; //= st.nextToken("/") ;
	String mm = ""; // st.nextToken("/") ;
	String yy = ""; // st.nextToken("/") ;
	String challanDate = null;
	StringTokenizer st = null;
    SectionWiseItemSum allSum = new SectionWiseItemSum();
    if( orderType == 2 ) { 
        for(SectionWiseItemSum sectionWiseItemSum : sectionOrder ) {
			i = 0;
			challanDate = sectionWiseItemSum.getChallanDate();
			if(challanDate != null) {
			    st = new StringTokenizer(challanDate,"/");
			    dd=st.nextToken("/");
			    mm =st.nextToken("/");
			    yy =st.nextToken("/");
			}
			
			double turDaal = sectionWiseItemSum.getMungdaal()*90;
			double matki = sectionWiseItemSum.getMatki()*86.5;
			double mung = sectionWiseItemSum.getMung()*83;
			double masurdaal = sectionWiseItemSum.getMasuldaal()*80;
			double watana = sectionWiseItemSum.getChvli()*58;
			double tel = sectionWiseItemSum.getTel()*100;
			double meet = sectionWiseItemSum.getMith()*18;
			double kanda = sectionWiseItemSum.getMirchi()*184;
			double halad = sectionWiseItemSum.getHalad()*189;
			double jire = sectionWiseItemSum.getJire()*237;
			double moheri = sectionWiseItemSum.getMohari()*75;
			
			double harbara = sectionWiseItemSum.getHarbara()*75;
			double vatana = sectionWiseItemSum.getVatana()*75;
			double extra1 = sectionWiseItemSum.getExtra1()*75;
			double extra2 = sectionWiseItemSum.getExtra2()*75;
			double extra3 = sectionWiseItemSum.getExtra3()*75;
			double extra4 = sectionWiseItemSum.getExtra4()*75;
			double extra5 = sectionWiseItemSum.getExtra5()*75;
			double extra6 = sectionWiseItemSum.getExtra6()*75;

			double t =  turDaal + matki + mung + masurdaal + watana + tel + meet + kanda + halad + jire + moheri + harbara + vatana + extra1 + extra2 + extra3 + extra4 + extra5 + extra6;

			double tax = (tel + kanda + jire + moheri )* 5 / 105;
			
%>
			<table width="" border=0>
				<tbody>
					<tr>
						<td colspan="7" class="fontsize14 center"><font class="fontsize20Bold" style="font-size:35px"> <b> केंद्रीय भांडार </b></font>
						<br>१८९ एम आइ डी सी अवधान धुळे - ४२४००६<br>TAX INVOICE<br>कॅश क्रेडिट मेमो</td>
					</tr>
					<tr><td colspan="7" class="fontsize14">प्रती</td></tr>
					<tr>
						<td colspan="5" class="fontsize14">अधिखक / गट शिक्षण अधिकारी</td>
						<td width="200" class="right">बिल क्र. : </td>
						<td width="200"><span class="fontMarathiNumber14"><%=sectionWiseItemSum.getBillNumber()%></span></td>
					</tr>
					<tr class="fontsize14">
						<td width="250">पंचायत समिती कार्यालय</td>
						<td width="200" class="right">तालुका : </td>
						<td width="200"><%=talukaOrderHelper.getTalukaName()%></td>
						<td width="200" class="right">जिल्हा : </td>
						<td width="200"><%=talukaOrderHelper.getDistrictName()%></td>
						<td width="200" class="right">बिल दिनांक : </td>
						<td width="200"></td>
					</tr>
					<tr class="fontsize14">
						<td colspan="5"></td>
						<td class="right">चलन क्र. : </td>
						<td><span class="fontMarathiNumber14"><%=sectionWiseItemSum.getChallanNumber()%></span></td>
					</tr>
					<tr class="fontsize14">
						<td>शाळेचे नाव : </td>
						<td colspan="4"><b><%=sectionWiseItemSum.getSchoolMarathi()+""%></b></td>
						<td class="right">चलन दिनांक : </td>
						<td class="fontMarathiNumber10"><span class="fontsize14"><font face="Kiran"><%=dd%></font>/<font face="Kiran"><%=mm%></font>/<font face="Kiran"><%=yy%></font></span></td>
					</tr>
				</tbody>
			</table>
			<table align="center" class="printstyle" width="600" cellspacing="1" cellpadding="1">
				<tbody>
					<tr>
						<th width="">अ. क्र.</th>
						<th width="">HSN</th>
						<th width="">पुरवठा प्रकार</th>
						<th width="">वजन किलो / लिटर</th>
						<th width="">दर किलो / लिटर प्रमाणे</th>
						<th width="">GST रक्कम</th>
						<th width="">एकूण रक्कम</th>
					</tr>
					<tr>
						<th class="fontMarathiNumber"><%=1%></th>
						<th class="fontMarathiNumber">1901</th>
						<th class="fontsize12 center">मुंगदाळ</th>
						<th class="fontMarathiNumber"><%=sectionWiseItemSum.getMungdaal() %></th>
						<th class="fontMarathiNumber" style="text-align:right">90.00</th>
						<th class="fontMarathiNumber"></th>
						<th class="fontMarathiNumber" style="text-align:right"><%=turDaal%></th>
					</tr>
					<tr>
						<th class="fontMarathiNumber"><%=2%></th>
						<th class="fontMarathiNumber">1901</th>
						<th class="fontsize12 center">तुर डाळ</th>
						<th class="fontMarathiNumber"><%=sectionWiseItemSum.getMatki() %></th>
						<th class="fontMarathiNumber" style="text-align:right">86.50</th>
						<th class="fontMarathiNumber"></th>
						<th class="fontMarathiNumber" style="text-align:right"><%=matki %></th>
					</tr>
					<tr>
						<th class="fontMarathiNumber"><%=3%></th>
						<th class="fontMarathiNumber">1901</th>
						<th class="fontsize12 center">मुंग</th>
						<th class="fontMarathiNumber"><%=sectionWiseItemSum.getMung() %></th>
						<th class="fontMarathiNumber" style="text-align:right">83.00</th>
						<th class="fontMarathiNumber"></th>
						<th class="fontMarathiNumber" style="text-align:right"><%=mung %></th>
					</tr>
					<tr>
						<th class="fontMarathiNumber"><%=4%></th>
						<th class="fontMarathiNumber">1901</th>
						<th class="fontsize12 center">मटकी</th>
						<th class="fontMarathiNumber"><%=sectionWiseItemSum.getMasuldaal() %></th>
						<th class="fontMarathiNumber" style="text-align:right">80.00</th>
						<th class="fontMarathiNumber"></th>
						<th class="fontMarathiNumber" style="text-align:right"><%=masurdaal %></th>
					</tr>
					<tr>
						<th class="fontMarathiNumber"><%=5%></th>
						<th class="fontMarathiNumber">1901</th>
						<th class="fontsize12 center">हरभरा</th>
						<th class="fontMarathiNumber"><%=sectionWiseItemSum.getHarbara() %></th>
						<th class="fontMarathiNumber" style="text-align:right">80.00</th>
						<th class="fontMarathiNumber"></th>
						<th class="fontMarathiNumber" style="text-align:right"><%=harbara %></th>
					</tr>
					<tr>
						<th class="fontMarathiNumber"><%=6%></th>
						<th class="fontMarathiNumber">1901</th>
						<th class="fontsize12 center">वटाणा</th>
						<th class="fontMarathiNumber"><%=sectionWiseItemSum.getVatana() %></th>
						<th class="fontMarathiNumber" style="text-align:right">80.00</th>
						<th class="fontMarathiNumber"></th>
						<th class="fontMarathiNumber" style="text-align:right"><%=vatana %></th>
					</tr>
					<tr>
						<th class="fontMarathiNumber"><%=7%></th>
						<th class="fontMarathiNumber">1901</th>
						<th class="fontsize12 center">Extra1</th>
						<th class="fontMarathiNumber"><%=sectionWiseItemSum.getExtra1() %></th>
						<th class="fontMarathiNumber" style="text-align:right">80.00</th>
						<th class="fontMarathiNumber"></th>
						<th class="fontMarathiNumber" style="text-align:right"><%=extra1 %></th>
					</tr>
					<tr>
						<th class="fontMarathiNumber"><%=8%></th>
						<th class="fontMarathiNumber">1901</th>
						<th class="fontsize12 center">Extra2</th>
						<th class="fontMarathiNumber"><%=sectionWiseItemSum.getExtra2() %></th>
						<th class="fontMarathiNumber" style="text-align:right">80.00</th>
						<th class="fontMarathiNumber"></th>
						<th class="fontMarathiNumber" style="text-align:right"><%=extra2 %></th>
					</tr>
					<tr>
						<th class="fontMarathiNumber"><%=9%></th>
						<th class="fontMarathiNumber">1901</th>
						<th class="fontsize12 center">Extra3</th>
						<th class="fontMarathiNumber"><%=sectionWiseItemSum.getExtra3() %></th>
						<th class="fontMarathiNumber" style="text-align:right">80.00</th>
						<th class="fontMarathiNumber"></th>
						<th class="fontMarathiNumber" style="text-align:right"><%=extra3 %></th>
					</tr>
					<tr>
						<th class="fontMarathiNumber"><%=10%></th>
						<th class="fontMarathiNumber">1901</th>
						<th class="fontsize12 center">Extra4</th>
						<th class="fontMarathiNumber"><%=sectionWiseItemSum.getExtra4() %></th>
						<th class="fontMarathiNumber" style="text-align:right">80.00</th>
						<th class="fontMarathiNumber"></th>
						<th class="fontMarathiNumber" style="text-align:right"><%=extra4 %></th>
					</tr>
					<tr>
						<th class="fontMarathiNumber"><%=11%></th>
						<th class="fontMarathiNumber">1901</th>
						<th class="fontsize12 center">Extra5</th>
						<th class="fontMarathiNumber"><%=sectionWiseItemSum.getExtra5() %></th>
						<th class="fontMarathiNumber" style="text-align:right">80.00</th>
						<th class="fontMarathiNumber"></th>
						<th class="fontMarathiNumber" style="text-align:right"><%=extra5 %></th>
					</tr>
					<tr>
						<th class="fontMarathiNumber"><%=12%></th>
						<th class="fontMarathiNumber">1901</th>
						<th class="fontsize12 center">Extra6</th>
						<th class="fontMarathiNumber"><%=sectionWiseItemSum.getExtra6() %></th>
						<th class="fontMarathiNumber" style="text-align:right">80.00</th>
						<th class="fontMarathiNumber"></th>
						<th class="fontMarathiNumber" style="text-align:right"><%=extra6 %></th>
					</tr>
					<tr>
						<th class="fontMarathiNumber"><%=13%></th>
						<th class="fontMarathiNumber">1901</th>
						<th class="fontsize12 center">चवली</th>
						<th class="fontMarathiNumber"><%=sectionWiseItemSum.getChvli() %></th>
						<th class="fontMarathiNumber" style="text-align:right">58.00</th>
						<th class="fontMarathiNumber"></th>
						<th class="fontMarathiNumber" style="text-align:right"><%=watana %></th>
					</tr>
					<tr>
						<th class="fontMarathiNumber"><%=14%></th>
						<th class="fontMarathiNumber">1901</th>
						<th class="fontsize12 center">तेल (सोया अॅगमार्क)</th>
						<th class="fontMarathiNumber"><%=sectionWiseItemSum.getTel() %></th>
						<th class="fontMarathiNumber" style="text-align:right">100.00</th>
						<th class="fontMarathiNumber" style="text-align:right"><%=twoDecimalFormatter.format(tel*5/105)%></th>
						<th class="fontMarathiNumber" style="text-align:right"><%=tel %></th>
					</tr>
					<tr>
						<th class="fontMarathiNumber"><%=15%></th>
						<th class="fontMarathiNumber">1901</th>
						<th class="fontsize12 center">मीठ (आयोडिनयुक्त)</th>
						<th class="fontMarathiNumber"><%=sectionWiseItemSum.getMith() %></th>
						<th class="fontMarathiNumber" style="text-align:right">18.00</th>
						<th class="fontMarathiNumber"></th>
						<th class="fontMarathiNumber" style="text-align:right"><%=meet %></th>
					</tr>						
					<tr>
						<th class="fontMarathiNumber"><%=16%></th>
						<th class="fontMarathiNumber">1901</th>
						<th class="fontsize12 center">कांदा लसूण मसाला</th>
						<th class="fontMarathiNumber"><%=sectionWiseItemSum.getMirchi() %></th>
						<th class="fontMarathiNumber" style="text-align:right">184.00</th>
						<th class="fontMarathiNumber" style="text-align:right"><%=twoDecimalFormatter.format(kanda*5/105)%></th>
						<th class="fontMarathiNumber" style="text-align:right"><%=kanda %></th>
					</tr>
					<tr>
						<th class="fontMarathiNumber"><%=17%></th>
						<th class="fontMarathiNumber">1901</th>
						<th class="fontsize12 center">हळद (अॅगमार्क)</th>
						<th class="fontMarathiNumber"><%=sectionWiseItemSum.getHalad() %></th>
						<th class="fontMarathiNumber" style="text-align:right">189.00</th>
						<th class="fontMarathiNumber"></th>
						<th class="fontMarathiNumber" style="text-align:right"><%=halad %></th>
					</tr>
					<tr>
						<th class="fontMarathiNumber"><%=18%></th>
						<th class="fontMarathiNumber">1901</th>
						<th class="fontsize12 center">जिरे</th>
						<th class="fontMarathiNumber"><%=sectionWiseItemSum.getJire() %></th>
						<th class="fontMarathiNumber" style="text-align:right">237.00</th>
						<th class="fontMarathiNumber" style="text-align:right"><%=twoDecimalFormatter.format(jire*5/105)%></th>
						<th class="fontMarathiNumber" style="text-align:right"><%=jire %></th>
					</tr>
					<tr>
						<th class="fontMarathiNumber"><%=19%></th>
						<th class="fontMarathiNumber">1901</th>
						<th class="fontsize12 center">मोहरी</th>
						<th class="fontMarathiNumber"><%=sectionWiseItemSum.getMohari() %></th>
						<th class="fontMarathiNumber" style="text-align:right">75.00</th>
						<th class="fontMarathiNumber" style="text-align:right"><%=twoDecimalFormatter.format(moheri*5/105)%></th>
						<th class="fontMarathiNumber" style="text-align:right"><%=moheri%></th>
					</tr>
					<tr>
						<th class="fontMarathiNumber" colspan="5">एकूण :-</th>
						<th class="fontMarathiNumber14" style="text-align:right"><%=twoDecimalFormatter.format(tax) %></th>
						<th class="fontMarathiNumber14" style="text-align:right"><%=t %></th>
					</tr>
				</tbody>
			</table>
			<table border="1" class="fontsize10 fontMarathiNumber14 printstyle center">
				<tbody>
					<tr>
						<td width="80%">
							<table border="0" class="fontsize10 fontMarathiNumber14 printstyle center">
								<tbody>
									<tr class="">
										<td colspan="2" class="fontMarathiNumber14"><b>Bill Details</b></td>
										<td colspan="2" class="fontMarathiNumber14"><b>Central Tax(CGST)</b></td>
										<td colspan="2" class="fontMarathiNumber14"><b>State Tax(SGST)</b></td>
										<td colspan="3" class="fontMarathiNumber14"><b>Total Tax</b></td>
									</tr>
									<tr class="left">
										<td colspan="" class="fontMarathiNumber14"><b>Bill Value</b></td>
										<td colspan="" class="right fontMarathiNumber14 fontMarathiNumber26"><b><%=t%></b></td>
										<td colspan="" class="fontMarathiNumber14"><b>Rate</b></td>
										<td colspan="" class="fontMarathiNumber14"><b>Amount</b></td>
										<td colspan="" class="fontMarathiNumber14"><b>Rate</b></td>
										<td colspan="" class="fontMarathiNumber14"><b>Amount</b></td>
										<td colspan="3" class="fontMarathiNumber14"><b>Amount</b></td>
									</tr>
									<tr class="left">
										<td colspan="" class="fontMarathiNumber14"><b>GST @5%</b></td>
										<td colspan="" class="right fontMarathiNumber14 fontMarathiNumber26"><%=(int)Math.round(t * 5/105)%></td>
										<td colspan="" class="fontMarathiNumber14"><b>2.50%</b></td>
										<td colspan="" class="right fontMarathiNumber14 fontMarathiNumber26"><%=twoDecimalFormatter.format(t * 5/105/2)%></td>
										<td colspan="" class="fontMarathiNumber14"><b>2.50%</b></td>
										<td colspan="" class="right fontMarathiNumber14 fontMarathiNumber26"><%=twoDecimalFormatter.format(t * 5/105/2)%></td>
										<td colspan="3" class="right fontMarathiNumber14 fontMarathiNumber26"><%=(int)Math.round(t * 5/105)%></td>
									</tr>
									<tr class="left">
										<td colspan="" class="fontMarathiNumber14"><b>Taxable Value</b></td>
										<td colspan="" class="right fontMarathiNumber14 fontMarathiNumber26"><b><%=(int)Math.round(t - (t * 5/105))%></b></td>
										<td colspan="" class="fontMarathiNumber14"><b>&nbsp;</b></td>
										<td colspan="" class="right fontMarathiNumber14 fontMarathiNumber26"><b><%=twoDecimalFormatter.format(t * 5/105/2)%></b></td>
										<td colspan="" class="fontMarathiNumber14"><b>&nbsp;</b></td>
										<td colspan="" class="right fontMarathiNumber14 fontMarathiNumber26"><b><%=twoDecimalFormatter.format(t * 5/105/2)%></b></td>
										<td colspan="3" class="right fontMarathiNumber14 fontMarathiNumber26"><b><%=(int)Math.round(t)%></b></td>
									</tr>
									<tr class="left">
										<td colspan="7" class="fontsize14" style="border-bottom:0;">“I / We
											hereby certify that my/our registration certificate under the
											GST ACT 2017 IS in force on the date on which the sale of the
											goods specified in this Bill of supply is made by me / us and
											that the transaction of supply covered by this Bill has been
											effected by me / us and it shall be accounted for in the
											turnover of supply while filing of return and the due tax, if
											any, payable on the supply has been paid or shall be paid.”<br/><br/><br/>
										</td>
									</tr>
									<tr class="left">
										<td colspan="5" class="fontsize14" style="border-top:0;border-right:0;">
											Goods Delivered to be Billed on Completion of Supply
										</td>
										<td colspan="2" class="fontsize14 center" style="border-top:0;border-left:0;">देणाऱ्याची सही</td>
									</tr>
								</tbody>
							</table>
						</td>
						<td width="20%" style="text-align: center; vertical-align: bottom">
							<table border="0" class="fontsize10 fontMarathiNumber14 ">
								<tbody>
									<tr>
										<td class="fontsize14 center" style="border:0;">केंद्रीय भांडार, धुळे</td>
									</tr>
									<tr>
										<td class="fontsize14 center" style="border:0;">करिता</td>
									</tr>
								</tbody>
							</table>
						</td>
					</tr>
				</tbody>
			</table>
			<br/><br/>
		<%
        }
    }
%>
</body>
</html>