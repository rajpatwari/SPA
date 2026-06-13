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
                    <td class="fontsize14"> Ration Dispatch Report </td>
                </tr>
                <%-- <tr>
                    <td class="fontsize14"><b>जिल्हा - <%=new LookUp().getDistrict(districtID).getDistrictMarathi()%>, ऑर्डर क्र. - <span class="fontMarathiNumberBold"><%=districtOrderNumber%></span>
                </tr> --%>
            </tbody>
        </table>

        <hr style="border:0.5px solid #000;" >


<%
	int srno = 0;
	String dd = ""; //= st.nextToken("/") ;
	String mm = ""; // st.nextToken("/") ;
	String yy = ""; // st.nextToken("/") ;
	String challanDate = null;
	StringTokenizer st = null;
	DispatchTalukaOrder allSum = new DispatchTalukaOrder();
	allSum.setMungdaal(0.0);
    allSum.setMatki(0.0);
    allSum.setMung(0.0);
    allSum.setMasuldaal(0.0);
    allSum.setHarbara(0.0);
    allSum.setVatana(0.0);
    allSum.setExtra1(0.0);
    allSum.setExtra2(0.0);
    allSum.setExtra3(0.0);
    allSum.setExtra4(0.0);
    allSum.setExtra5(0.0);
    allSum.setExtra6(0.0);
    allSum.setChvli(0.0);
    allSum.setTel(0.0);
    allSum.setMith(0.0);
    allSum.setMirchi(0.0);
    allSum.setHalad(0.0);
    allSum.setJire(0.0);
    allSum.setMohari(0.0);
    allSum.setTandul(0.0);
	List<DispatchTalukaOrder> list = new DispatchDS().getAllDispatcheDetailsByDistrictOrderID(districtOrderNumber);
    if(list != null)
    {
		for(DispatchTalukaOrder d : list)
	    {
	    	allSum.setMungdaal(allSum.getMungdaal()+ d.getMungdaal());
	        allSum.setMatki(allSum.getMatki()+ d.getMatki());
	        allSum.setMung(allSum.getMung()+ d.getMung());
	        allSum.setMasuldaal(allSum.getMasuldaal()+ d.getMasuldaal());
	        allSum.setHarbara(allSum.getHarbara()+ d.getHarbara());
	        allSum.setVatana(allSum.getVatana()+ d.getVatana());
	        allSum.setExtra1(allSum.getExtra1()+ d.getExtra1());
	        allSum.setExtra2(allSum.getExtra2()+ d.getExtra2());
	        allSum.setExtra3(allSum.getExtra3()+ d.getExtra3());
	        allSum.setExtra4(allSum.getExtra4()+ d.getExtra4());
	        allSum.setExtra5(allSum.getExtra5()+ d.getExtra5());
	        allSum.setExtra6(allSum.getExtra6()+ d.getExtra6());
	        allSum.setChvli(allSum.getChvli()+ d.getChvli());
	        allSum.setTel(allSum.getTel()+ d.getTel());
	        allSum.setMith(allSum.getMith()+ d.getMith());
	        allSum.setMirchi(allSum.getMirchi()+ d.getMirchi());
	        allSum.setHalad(allSum.getHalad()+ d.getHalad());
	        allSum.setJire(allSum.getJire()+ d.getJire());
	        allSum.setMohari(allSum.getMohari()+ d.getMohari());
	        allSum.setTandul(allSum.getTandul()+ d.getTandul());
	    	challanDate = d.getBiltyDate();
	        if(challanDate != null) 
	        {
	            st = new StringTokenizer(challanDate,"/");
	            dd=st.nextToken("/");
	            mm =st.nextToken("/");
	            yy =st.nextToken("/");
	        }
	    	if(d.getOrderType() == 2)
	    	{
%>
        <table border="1"  class="printstyle center" >
            <thead>
                <tr>
                    <th>क्र.</th>
                    <th>बिल्टी दिनांक</th>
                    <th>बिल्टी क्र.</th>
                    <th>ऑपरेटर</th>
                    <th>गाडी क्र.</th>
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
                    <td class="fontMarathiNumber "><%=++srno%></td>
                    <td><span><font class="fontMarathiNumber"><%=dd%></font>/<font  class="fontMarathiNumber"><%=mm%></font>/<font class="fontMarathiNumber"><%=yy%></font></span></td>
                    <td class="fontMarathiNumber "><%=d.getBiltyNo()%></td>
                    <td class="fontMarathiNumber "><%=d.getAgentName()%></td>
                    <td class="fontMarathiNumber "><%=d.getVehicleNumber()%></td>
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
                    <th>बिल्टी दिनांक</th>
                    <th>बिल्टी क्र.</th>
                    <th>ऑपरेटर</th>
                    <th>गाडी क्र.</th>
                    <th >तांदूळ</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class="fontMarathiNumber "><%=++srno%></td>
                    <td><span><font class="fontMarathiNumber"><%=dd%></font>/<font  class="fontMarathiNumber"><%=mm%></font>/<font class="fontMarathiNumber"><%=yy%></font></span></td>
                    <td class="fontMarathiNumber "><%=d.getBiltyNo()%></td>
                    <td class="fontMarathiNumber "><%=d.getAgentName()%></td>
                    <td class="fontMarathiNumber "><%=d.getVehicleNumber()%></td>
					<th class="fontMarathiNumber"><%=d.getTandul()%></th>
                </tr>
            </tbody>
        </table>
<%
			}
	    }
		if(list.get(0).getOrderType() == 2)
		{
%>
		<table border="1"  class="printstyle center" >
			<tr>	
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
			<tr>
			    <th class="fontMarathiNumber"><%=allSum.getMungdaal() %></th>
			    <th class="fontMarathiNumber"><%=allSum.getMatki() %></th>
			    <th class="fontMarathiNumber"><%=allSum.getMung() %></th>
			    <th class="fontMarathiNumber"><%=allSum.getMasuldaal() %></th>
			    <th class="fontMarathiNumber"><%=allSum.getHarbara() %></th>
      			<th class="fontMarathiNumber"><%=allSum.getVatana() %></th>
      			<th class="fontMarathiNumber"><%=allSum.getExtra1() %></th>
      			<th class="fontMarathiNumber"><%=allSum.getExtra2() %></th>
      			<th class="fontMarathiNumber"><%=allSum.getExtra3() %></th>
      			<th class="fontMarathiNumber"><%=allSum.getExtra4() %></th>
      			<th class="fontMarathiNumber"><%=allSum.getExtra5() %></th>
      			<th class="fontMarathiNumber"><%=allSum.getExtra6() %></th>
      			<th class="fontMarathiNumber"><%=allSum.getChvli() %></th>
			    <th class="fontMarathiNumber"><%=allSum.getTel() %></th>
			    <th class="fontMarathiNumber"><%=allSum.getMith() %></th>
			    <th class="fontMarathiNumber"><%=allSum.getMirchi() %></th>
			    <th class="fontMarathiNumber"><%=allSum.getHalad() %></th>
			    <th class="fontMarathiNumber"><%=allSum.getJire() %></th>
			    <th class="fontMarathiNumber"><%=allSum.getMohari() %></th>
			</tr>
		</table>
<%
		}
		else
		{
%>
		<table border="1"  class="printstyle center" >
			<tr>					    	
			    <th >तांदूळ</th>
			</tr>
			<tr>
			    <th class="fontMarathiNumber"><%=allSum.getTandul() %></th>
			</tr>
		</table>
<%
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