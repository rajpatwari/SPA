<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="org.spa.entity.*"%>
<%@page import="org.spa.ds.*"%>
<%@page import="org.spa.convert.*"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.StringTokenizer"%>
<%@page import="org.spa.helper.NumberToMarathiWord"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.NumberFormat"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>जिल्हा गोषवारा</title>
        <style>
            .fontMarathiNumber {
                font:normal normal 24px/30px Kiran,Verdana;
                text-decoration:none;
            }
            .fontMarathiNumberBold {
                font:normal normal bold 26px/30px Kiran,Verdana;
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
            tr.odd {
                background:#e1ffe1;
            }
            tr.center {
                text-align: center;
            }
            p.center {
                text-align: center;
            }
            tr.left {
                text-align: left;
            }
            table.center {
                text-align: center;
            }
            td.right {
                text-align: right;
            }
            tr.right {
                text-align: right;
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
            .fontsize12 {
                font:normal normal 12px Tahoma;
                text-decoration:none;
            }
            .fontsize14 {
                font:normal normal 14px Tahoma;
                text-decoration:none;
            }
            .fontsize18 {
                font:normal normal bold 18px Tahoma;
                text-decoration:none;
            }

        </style>
<%   
	NumberFormat tdf = new DecimalFormat("#0.000");
   	String fromDate = session.getAttribute("fromYear").toString().trim();
   	String toDate =  session.getAttribute("toYear").toString().trim();
   	int dist_id = Integer.parseInt(request.getParameter("districtID"));
   	int district_order_id = Integer.parseInt(request.getParameter("orderID"));            
   	List<TalukaOrder> list1 = new TalukaOrderDS().getAllTalukaOrder(district_order_id,fromDate,toDate,dist_id,0,100);
   	try
   	{
   		list1.get(0).getFromMonth();
   		monthYearToMarathi mm = new monthYearToMarathi();
	   	DistrictOrder dod = new  DistrictOrderDS().getDistrictOrderDetails(district_order_id); 
	   	SectionWiseItemSum s2 = null;
	   	SectionWiseItemSum sum = new SectionWiseItemSum();
	   	List<SectionWiseItemSum> list3 = new ArrayList<SectionWiseItemSum>();
	   	
	   	for(TalukaOrder t : list1)
	   	{
		  	ArrayList<SectionWiseItemSum> list2 = new TalukaOrderDS().getAllSectionForOrder(t.getTalukaId(),t.getTalukaOrderId());
		  	s2 = new SectionWiseItemSum();
		  	
			s2.setTalukaID(t.getTalukaId());
			s2.setTalukaMarathi(t.getTalukaName());
		  	for(SectionWiseItemSum s1 : list2)
		  	{
		  		s2.setMungdaal(Double.parseDouble(tdf.format(s2.getMungdaal()+s1.getMungdaal())));
		  		s2.setMatki(Double.parseDouble(tdf.format(s2.getMatki() + s1.getMatki())));
		  		s2.setMung(Double.parseDouble(tdf.format(s2.getMung() + s1.getMung())));
		  		s2.setMasuldaal(Double.parseDouble(tdf.format(s2.getMasuldaal() + s1.getMasuldaal())));
		  		s2.setHarbara(Double.parseDouble(tdf.format(s2.getHarbara() + s1.getHarbara())));
		  		s2.setVatana(Double.parseDouble(tdf.format(s2.getVatana() + s1.getVatana())));
		  		s2.setExtra1(Double.parseDouble(tdf.format(s2.getExtra1() + s1.getExtra1())));
		  		s2.setExtra2(Double.parseDouble(tdf.format(s2.getExtra2() + s1.getExtra2())));
		  		s2.setExtra3(Double.parseDouble(tdf.format(s2.getExtra3() + s1.getExtra3())));
		  		s2.setExtra4(Double.parseDouble(tdf.format(s2.getExtra4() + s1.getExtra4())));
		  		s2.setExtra5(Double.parseDouble(tdf.format(s2.getExtra5() + s1.getExtra5())));
		  		s2.setExtra6(Double.parseDouble(tdf.format(s2.getExtra6() + s1.getExtra6())));
		  		s2.setChvli(Double.parseDouble(tdf.format(s2.getChvli() + s1.getChvli())));
		  		s2.setTel(Double.parseDouble(tdf.format(s2.getTel() + s1.getTel())));
		  		s2.setMith(Double.parseDouble(tdf.format(s2.getMith() + s1.getMith())));
		  		s2.setMirchi(Double.parseDouble(tdf.format(s2.getMirchi() + s1.getMirchi())));
		  		s2.setHalad(Double.parseDouble(tdf.format(s2.getHalad() + s1.getHalad())));
		  		s2.setJire(Double.parseDouble(tdf.format(s2.getJire() + s1.getJire())));
		  		s2.setMohari(Double.parseDouble(tdf.format(s2.getMohari() + s1.getMohari())));
		  		s2.setTandul(Double.parseDouble(tdf.format(s2.getTandul() + s1.getTandul())));  
		  		//System.out.println("Anita Mad-am : " +s1.getJire()+ "\t" +s1.getMohari());
		  		//System.out.println("Anita Mad-am " +s2.getJire()+ "\t" +s2.getMohari());
		  	}
		  	list3.add(s2);
	   }   
%>       
    </head>
    <body>
        <p align="center">शालेय पोषण आहार योजना 
<% 
		if(dod.getStdType()==1)
		{
			out.print("१ ली ते ५ वी");
		}
		else
		{
			out.print("६ वी ते 8 वी");
		} 
%>
   <br/>
            					    धान्यावर साहित्याची मागणी माहे  
            		      <%=list1.get(0).getFromMonth() %>
            		      -
            		      <%=mm.yearString(Integer.parseInt(list1.get(0).getFromYear()))%> 
            		      			    ते 
            		      <%=list1.get(0).getToMonth()%>
            		      -
            		      <%=mm.yearString(Integer.parseInt(list1.get(0).getFromYear()))%>
            		      <br>
                                                    जिल्हा गोषवारा</p>
                                                 
        <table border="1" width="100%">
<%
		if(list1.get(0).getOrderType() == 2)
		{
%>
        	<thead>
        		<tr>
        			<th rowspan="2">अ. क्र.</th>
        			<th rowspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;विभाग&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
        			<th rowspan="2">मुंगदाळ</th>
        			<th rowspan="2">तुर डाळ</th>
        			<th rowspan="2">मुंग</th>
        			<th rowspan="2">मटकी</th>
        			<th rowspan="2">हरभरा</th>
                    <th rowspan="2">वटाणा</th>
                    <th rowspan="2">सोया वडी</th>
					<th rowspan="2">Extra2</th>
					<th rowspan="2">Extra3</th>
					<th rowspan="2">Extra4</th>
					<th rowspan="2">Extra5</th>
					<th rowspan="2">Extra6</th>
                    <th rowspan="2">चवळी</th>
        			<th colspan="6">मसाल्याचे पदार्थ</th>
      			</tr>
      			<tr>
        			<th>तेल (सोया अॅगमार्क)</th>
        			<th>मीठ (आयोडिनयुक्त)</th>
        			<th>कांदा लसूण मसाला</th>
        			<th>हळद (अॅगमार्क)</th>
        			<th>जिरे</th>
        			<th>मोहरी</th> 			
        		</tr>
        	</thead>
<%
		}
		else
		{
%>
			<thead>
        		<tr>
        			<th>अ. क्र.</th>
        			<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;विभाग&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
        			<th>तांदूळ</th> 			
        		</tr>
        	</thead>
<%		
		}
%>			
        	<tbody> 
<%
		int i = 1;
		for(SectionWiseItemSum s4 : list3)
		{
			if(list1.get(0).getOrderType() == 2)
			{
%>
				<tr>
					<td class="fontMarathiNumber center" ><%=i++ %></td>
					<td class="bold"><%=s4.getTalukaMarathi() %></td>
					<td class="fontMarathiNumber right"><%=s4.getMungdaal() %></td>
					<td class="fontMarathiNumber right"><%=s4.getMatki() %></td>
					<td class="fontMarathiNumber right"><%=s4.getMung() %></td>
					<td class="fontMarathiNumber right"><%=s4.getMasuldaal() %></td>
					<td class="fontMarathiNumber right"><%=s4.getHarbara() %></td>
					<td class="fontMarathiNumber right"><%=s4.getVatana() %></td>
					<td class="fontMarathiNumber right"><%=s4.getExtra1() %></td>
					<td class="fontMarathiNumber right"><%=s4.getExtra2() %></td>
					<td class="fontMarathiNumber right"><%=s4.getExtra3() %></td>
					<td class="fontMarathiNumber right"><%=s4.getExtra4() %></td>
					<td class="fontMarathiNumber right"><%=s4.getExtra5() %></td>
					<td class="fontMarathiNumber right"><%=s4.getExtra6() %></td>
					<td class="fontMarathiNumber right"><%=s4.getChvli() %></td>
					<td class="fontMarathiNumber right"><%=s4.getTel() %></td>
					<td class="fontMarathiNumber right"><%=s4.getMith() %></td>
					<td class="fontMarathiNumber right"><%=s4.getMirchi() %></td>
					<td class="fontMarathiNumber right"><%=s4.getHalad() %></td>
					<td class="fontMarathiNumber right"><%=s4.getJire() %></td>
					<td class="fontMarathiNumber right"><%=s4.getMohari() %></td>
				</tr>
<%
				sum.setMungdaal(Double.parseDouble(tdf.format(sum.getMungdaal()+s4.getMungdaal())));
				sum.setMatki(Double.parseDouble(tdf.format(sum.getMatki() + s4.getMatki())));
				sum.setMung(Double.parseDouble(tdf.format(sum.getMung() + s4.getMung())));
				sum.setMasuldaal(Double.parseDouble(tdf.format(sum.getMasuldaal() + s4.getMasuldaal())));
				sum.setHarbara(Double.parseDouble(tdf.format(sum.getHarbara() + s4.getHarbara())));
				sum.setVatana(Double.parseDouble(tdf.format(sum.getVatana() + s4.getVatana())));
				sum.setExtra1(Double.parseDouble(tdf.format(sum.getExtra1() + s4.getExtra1())));
				sum.setExtra2(Double.parseDouble(tdf.format(sum.getExtra2() + s4.getExtra2())));
				sum.setExtra3(Double.parseDouble(tdf.format(sum.getExtra3() + s4.getExtra3())));
				sum.setExtra4(Double.parseDouble(tdf.format(sum.getExtra4() + s4.getExtra4())));
				sum.setExtra5(Double.parseDouble(tdf.format(sum.getExtra5() + s4.getExtra5())));
				sum.setExtra6(Double.parseDouble(tdf.format(sum.getExtra6() + s4.getExtra6())));
				sum.setChvli(Double.parseDouble(tdf.format(sum.getChvli() + s4.getChvli())));
				sum.setTel(Double.parseDouble(tdf.format(sum.getTel() + s4.getTel())));
				sum.setMith(Double.parseDouble(tdf.format(sum.getMith() + s4.getMith())));
				sum.setMirchi(Double.parseDouble(tdf.format(sum.getMirchi() + s4.getMirchi())));
				sum.setHalad(Double.parseDouble(tdf.format(sum.getHalad() + s4.getHalad())));
				sum.setJire(Double.parseDouble(tdf.format(sum.getJire() + s4.getJire())));
				sum.setMohari(Double.parseDouble(tdf.format(sum.getMohari() + s4.getMohari())));   
			}
			else
			{
%>
				<tr class="right">
					<td class="fontMarathiNumber"><center><%=i++ %></center></td>
					<td class="bold"><center><%=s4.getTalukaMarathi()%></center></td>
					<td class="fontMarathiNumber right"><%=s4.getTandul()%></td>
				</tr>
<%	
				sum.setTandul(Double.parseDouble(tdf.format(sum.getTandul() + s4.getTandul()))); 
			}
		}
		if(list1.get(0).getOrderType() == 2)
		{
%>
				<tr>
					<td colspan="2" class="bold">एकुण मागणी</td>
					<td class="fontMarathiNumberBold right"><%=tdf.format(sum.getMungdaal()) %></td>
					<td class="fontMarathiNumberBold right"><%=tdf.format(sum.getMatki()) %></td>
					<td class="fontMarathiNumberBold right"><%=tdf.format(sum.getMung()) %></td>
					<td class="fontMarathiNumberBold right"><%=tdf.format(sum.getMasuldaal()) %></td>
					<td class="fontMarathiNumberBold right"><%=tdf.format(sum.getHarbara()) %></td>
					<td class="fontMarathiNumberBold right"><%=tdf.format(sum.getVatana()) %></td>
					<td class="fontMarathiNumberBold right"><%=tdf.format(sum.getExtra1()) %></td>
					<td class="fontMarathiNumberBold right"><%=tdf.format(sum.getExtra2()) %></td>
					<td class="fontMarathiNumberBold right"><%=tdf.format(sum.getExtra3()) %></td>
					<td class="fontMarathiNumberBold right"><%=tdf.format(sum.getExtra4()) %></td>
					<td class="fontMarathiNumberBold right"><%=tdf.format(sum.getExtra5()) %></td>
					<td class="fontMarathiNumberBold right"><%=tdf.format(sum.getExtra6()) %></td>
					<td class="fontMarathiNumberBold right"><%=tdf.format(sum.getChvli()) %></td>
					<td class="fontMarathiNumberBold right"><%=tdf.format(sum.getTel()) %></td>
					<td class="fontMarathiNumberBold right"><%=tdf.format(sum.getMith()) %></td>
					<td class="fontMarathiNumberBold right"><%=tdf.format(sum.getMirchi()) %></td>
					<td class="fontMarathiNumberBold right"><%=tdf.format(sum.getHalad()) %></td>
					<td class="fontMarathiNumberBold right"><%=tdf.format(sum.getJire()) %></td>
					<td class="fontMarathiNumberBold right"><%=tdf.format(sum.getMohari()) %></td>
				</tr>
<%	
		}
		else
		{
%>
				<tr>
					<td colspan="2" class="bold right"><b>एकुण मागणी</b></td>
					<td class="fontMarathiNumberBold right"><%=tdf.format(sum.getTandul()) %></td>
				</tr>
<%
		}
   	}
   	catch(Exception e)
   	{
   		out.print("<h2>No such data is found for this District Order</h2>");
   	}
%>       	
        	</tbody>
        </table>
    </body>
</html>