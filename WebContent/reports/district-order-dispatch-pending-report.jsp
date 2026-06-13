<%@page import="org.spa.entity.SectionWiseItemSum"%>
<%@page import="java.util.StringTokenizer"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="org.spa.ds.DispatchDS"%>
<%@page import="org.spa.entity.DispatchTalukaOrder"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <title>Ration Dispatch Report</title>
        <style type="text/css">
            <!--
            body {
                font-family:Tahoma;
            }
            img {
                border:0;
            }
            #page {
                width:590px;
                margin:0 auto;
                padding:0px;
            }
            #address {
                height:181px;
                margin-left:15px;
            }
            table {
                width:100%;
            }
            td {
                padding:0px;
            }
            tr.odd {
                background:#e1ffe1;
            }
            tr.center {
                text-align: center;
            }
            td.center {
                text-align: center;
            }
            tr.left {
                text-align: left;
            }
            th.left {
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
            th {
                font:normal bold 12px Tahoma;
                text-decoration:none;
            }
            right {
                text-align: right;
            }
            center {
                text-align: center;
            }
            .fontMarathiNumber {
                font:normal normal 20px Kiran,Tahoma;
                text-decoration:none;
            }
            .fontMarathiNumberBold {
                font:normal normal bold 20px/30px Kiran,Verdana;
                text-decoration:none;
            }
            .fontsize10 {
                font:normal normal 10px Tahoma;
                text-decoration:none;
            }
            .fontsize12 {
                font:normal normal 12px Tahoma;
                text-decoration:none;
                letter-spacing:1px;
            }
            .fontsize14 {
                font:normal normal 14px Tahoma;
                text-decoration:none;
            }
            .fontsize16 {
                font:normal normal 16px Tahoma;
                text-decoration:none;
            }
            .fontsize18 {
                font:normal normal 18px Tahoma;
                text-decoration:none;
            }
            table.printstyle {
                border-width: 1px;
                border-spacing: 0px ;
                border-style: inset;
                border-color: gray;
                border-collapse: collapse;
                background-color: white;
            }
            table.printstyle {
                border-width: 1px;
                border-spacing: 0px ;
                border-style: inset;
                border-color: gray;
                border-collapse: collapse;
                background-color: white;
            }
            table.printstyle th {
                border-width: 1px;
                padding: 1px;
                border-style: inset;
                border-color: gray;
                background-color: white;
            }
            table.printstyle td {
                border-width: 1px;
                padding: 1px;
                height: 12px;
                border-style: inset;
                border-color: gray;
                background-color: white;
            }
            P.breakhere {page-break-before: always;}
            .small  { font-size: 70%; }
            .bold   { font-weight: bold; }
            .notice { color: red; background-color: yellow; }
            @media print  { .noprint  { display: none; } }
            @media screen { .noscreen { display: none; } }
            -->
        </style>
    </head>
<%
	int districtOrderNumber = Integer.parseInt(request.getParameter("districtOrderID"));	
%>

    <body class="fontsize12">
        <table class="center" border="0">
            <tbody >
                <tr>
                    <td class="fontsize14"> Ration Pending Report - Taluka Order Wise </td>
                </tr>
                <%-- <tr>
                    <td class="fontsize14"><b>जिल्हा - <%=new LookUp().getDistrict(districtID).getDistrictMarathi()%>, ऑर्डर क्र. - <span class="fontMarathiNumberBold"><%=districtOrderNumber%></span>
                </tr> --%>
            </tbody>
        </table>

        <hr style="border:0.5px solid #000;" >


<%
	SectionWiseItemSum allSum = new SectionWiseItemSum();
	List<SectionWiseItemSum> list = new DispatchDS().getTalukaWiseDispatcheRemaining(districtOrderNumber);
    if(list != null)
    {
    	int srno = 0;
		for(SectionWiseItemSum d : list)
	    {    	
	    	if(d.getOrderType() == 2)
	    	{
%>
        <table border="1"  class="printstyle center" >
            <thead>
                <tr>
                    <th>क्र.</th>
                    <th>तालूका</th>
                    <th> </th>
        			<th >मुंगदाळ</th>
        			<th >तुर डाळ</th>
        			<th >मुंग</th>
        			<th >मटकी</th>
        			<th >हरभरा</th>
                    <th >वटाणा</th>
                    <th >सोया वडी</th>
                    <th >Extra2</th>
                    <th >Extra3</th>
                    <th >Extra4</th>
                    <th >Extra5</th>
                    <th >Extra6</th>
                    <th >चवळी</th>
                    <th >तेल (सोया अॅगमार्क)</th>
                    <th >मीठ (आयोडिनयुक्त)</th>
                    <th >कांदा लसूण मसाला</th>
                    <th >हळद (अॅगमार्क)</th>
                    <th >जिरे</th>
                    <th >मोहरी</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class="fontMarathiNumber" rowspan="3"><%=++srno%></td>
                    <td class="fontsize16 " rowspan="3"><%=d.getTalukaMarathi()%></td>
                    <td class="fontsize16 " >Taluka Order (KG) </td>
					<th class="fontMarathiNumber"><%=d.getOmungdaal() %></th>
                    <th class="fontMarathiNumber"><%=d.getOmatki() %></th>
                    <th class="fontMarathiNumber"><%=d.getOmung() %></th>
                    <th class="fontMarathiNumber"><%=d.getOmasuldaal() %></th>
                    <th class="fontMarathiNumber"><%=d.getOharbara() %></th>
                    <th class="fontMarathiNumber"><%=d.getOvatana() %></th>
                    <th class="fontMarathiNumber"><%=d.getOextra1() %></th>
                    <th class="fontMarathiNumber"><%=d.getOextra2() %></th>
                    <th class="fontMarathiNumber"><%=d.getOextra3() %></th>
                    <th class="fontMarathiNumber"><%=d.getOextra4() %></th>
                    <th class="fontMarathiNumber"><%=d.getOextra5() %></th>
                    <th class="fontMarathiNumber"><%=d.getOextra6() %></th>
                    <th class="fontMarathiNumber"><%=d.getOchvli() %></th>
                    <th class="fontMarathiNumber"><%=d.getOtel() %></th>
                    <th class="fontMarathiNumber"><%=d.getOmith() %></th>
                    <th class="fontMarathiNumber"><%=d.getOmirchi() %></th>
                    <th class="fontMarathiNumber"><%=d.getOhalad() %></th>
                    <th class="fontMarathiNumber"><%=d.getOjire() %></th>
                    <th class="fontMarathiNumber"><%=d.getOmohari() %></th>
                </tr>
                <tr>
                    <td class="fontsize16 " >Dispatched Order (KG)</td>   
					<th class="fontMarathiNumber"><%=d.getMungdaal() %></th>
                    <th class="fontMarathiNumber"><%=d.getMatki() %></th>
                    <th class="fontMarathiNumber"><%=d.getMung() %></th>
                    <th class="fontMarathiNumber"><%=d.getMasuldaal() %></th>
                    <th class="fontMarathiNumber"><%=d.getHarbara() %></th>
                    <th class="fontMarathiNumber"><%=d.getVatana() %></th>
                    <th class="fontMarathiNumber"><%=d.getExtra1() %></th>
                    <th class="fontMarathiNumber"><%=d.getExtra2() %></th>
                    <th class="fontMarathiNumber"><%=d.getExtra3() %></th>
                    <th class="fontMarathiNumber"><%=d.getExtra4() %></th>
                    <th class="fontMarathiNumber"><%=d.getExtra5() %></th>
                    <th class="fontMarathiNumber"><%=d.getExtra6() %></th>
                    <th class="fontMarathiNumber"><%=d.getChvli() %></th>
                    <th class="fontMarathiNumber"><%=d.getTel() %></th>
                    <th class="fontMarathiNumber"><%=d.getMith() %></th>
                    <th class="fontMarathiNumber"><%=d.getMirchi() %></th>
                    <th class="fontMarathiNumber"><%=d.getHalad() %></th>
                    <th class="fontMarathiNumber"><%=d.getJire() %></th>
                    <th class="fontMarathiNumber"><%=d.getMohari() %></th>
                </tr>
                <tr>                 
                    <td class="fontsize16 " >Pending Order (KG)</td>
					<th class="fontMarathiNumber"><%=d.getOmungdaal()-d.getMungdaal() %></th>
                    <th class="fontMarathiNumber"><%=d.getOmatki()-d.getMatki() %></th>
                    <th class="fontMarathiNumber"><%=d.getOmung()-d.getMung() %></th>
                    <th class="fontMarathiNumber"><%=d.getOmasuldaal()-d.getMasuldaal() %></th>
                    <th class="fontMarathiNumber"><%=d.getOharbara()-d.getHarbara() %></th>
                    <th class="fontMarathiNumber"><%=d.getOvatana()-d.getVatana() %></th>
                    <th class="fontMarathiNumber"><%=d.getOextra1()-d.getExtra1() %></th>
                    <th class="fontMarathiNumber"><%=d.getOextra2()-d.getExtra2() %></th>
                    <th class="fontMarathiNumber"><%=d.getOextra3()-d.getExtra3() %></th>
                    <th class="fontMarathiNumber"><%=d.getOextra4()-d.getExtra4() %></th>
                    <th class="fontMarathiNumber"><%=d.getOextra5()-d.getExtra5() %></th>
                    <th class="fontMarathiNumber"><%=d.getOextra6()-d.getExtra6() %></th>
                    <th class="fontMarathiNumber"><%=d.getOchvli()-d.getChvli() %></th>
                    <th class="fontMarathiNumber"><%=d.getOtel()-d.getTel() %></th>
                    <th class="fontMarathiNumber"><%=d.getOmith()-d.getMith() %></th>
                    <th class="fontMarathiNumber"><%=d.getOmirchi()-d.getMirchi() %></th>
                    <th class="fontMarathiNumber"><%=d.getOhalad()-d.getHalad() %></th>
                    <th class="fontMarathiNumber"><%=d.getOjire()-d.getJire() %></th>
                    <th class="fontMarathiNumber"><%=d.getOmohari()-d.getMohari() %></th>
                </tr>
            </tbody>
        </table>
<%
			}
		    else
		    {
%>
        <table border="1"  class="printstyle center" >
            <thead>
                <tr>
                    <th>क्र.</th>
                    <th>तालूका</th>
                    <th> </th>
                    <th >तांदूळ</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class="fontMarathiNumber" rowspan="3"><%=++srno%></td>
                    <td class="fontsize16 " rowspan="3"><%=d.getTalukaMarathi()%></td>
                    <td class="fontsize16 " >Taluka Order (KG) </td>
					<th class="fontMarathiNumber"><%=d.getOtandul() %></th>
                </tr>
                <tr>
                    <td class="fontsize16 " >Dispatched Order (KG)</td>   
					<th class="fontMarathiNumber"><%=d.getTandul() %></th>
                </tr>
                <tr>                 
                    <td class="fontsize16 " >Pending Order (KG)</td>
					<th class="fontMarathiNumber"><%=d.getOtandul()-d.getTandul() %></th>
                </tr>
            </tbody>
        </table>
<%
		    }
	    }
    }
    else
    {
%>
		<h1>No Data is available to Show</h1>
<%
    	
    }
%>
    </body>
</html>