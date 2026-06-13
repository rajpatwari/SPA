<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="org.spa.helper.TalukaOrderDetailDSHelper"%>
<%@page import="org.spa.entity.*"%>
<%@page import="org.spa.ds.*"%>
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

        <title>Invoice Preview</title>
        <link rel="stylesheet" type="text/css"
              href="./../resources/css/ext-all.css" />

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
            .fontMarathiNumberAmt {
                font:normal normal 22px Kiran,Tahoma;
                text-decoration:none;
            }
            .fontsize10 {
                font:normal normal 10px Tahoma;
                text-decoration:none;
            }
            .fontsize12 {
                font:normal normal 12px Tahoma;
                text-decoration:none;
            }
            .fontsize14 {
                font:normal normal 14px Tahoma;
                text-decoration:none;
            }
            .fontsize16Bold {
                font:normal normal 16px Tahoma bold;
                text-decoration:none;
            }
            .fontsize18 {
                font:normal normal 18px Tahoma;
                text-decoration:none;
            }
            .fontsize20Bold {
                font:normal normal 20px Tahoma bold;
                text-decoration:none;
            }
            .fontsize18Bold {
                font:normal normal 18px Tahoma bold;
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
                border-style: inset;
                border-color: gray;
                background-color: white;
            }

            P.breakhere {page-break-before: always;}
            -->
        </style>
        <script type="text/javascript" src="./../resources/adapter/ext/ext-base.js"></script>
        <!-- ENDLIBS -->

        <script type="text/javascript" src="./../resources/js/ext-all.js"></script>
        
    </head>
	<body>
<%
	NumberFormat twoDecimalFormatter = new DecimalFormat("#0.00");
	NumberFormat threeDecimalFormatter = new DecimalFormat("#0.000");
	NumberFormat zeroDecimalFormatter = new DecimalFormat("#");
	int invoiceID = Integer.parseInt(request.getParameter("invoiceID"));
	TalukaInvoice tInvoice = new InvoiceDS().readInvoice(invoiceID);
	TalukaOrderDetailDSHelper dSHelper = new TalukaOrderDetailDSHelper();
	TalukaOrder talukaOrderHelper = dSHelper.talukaOrderDetails(tInvoice.getOrderID());
	SectionWiseItemSum s2 = null;
	ArrayList<SectionWiseItemSum> list = new TalukaOrderDS().getAllSectionForOrder(tInvoice.getTalukaID(),tInvoice.getOrderID());
	SectionWiseItemSum s =  new TalukaOrderDS().getTalukaReturnDetails(tInvoice.getOrderID());
	s2 = new SectionWiseItemSum();
	s2.setMungdaal(0.0);
	s2.setMatki(0.0);
	s2.setMung(0.0);
	s2.setMasuldaal(0.0);
	s2.setHarbara(0.0);
	s2.setVatana(0.0);
	s2.setExtra1(0.0);
	s2.setExtra2(0.0);
	s2.setExtra3(0.0);
	s2.setExtra4(0.0);
	s2.setExtra5(0.0);
	s2.setExtra6(0.0);
	s2.setChvli(0.0);
	s2.setTel(0.0);
	s2.setMith(0.0);
	s2.setMirchi(0.0);
	s2.setHalad(0.0);
	s2.setJire(0.0);
	s2.setMohari(0.0);
	s2.setTandul(0.0);        
    	for(SectionWiseItemSum s1 : list)
    	{
    		s2.setMungdaal(s2.getMungdaal()+s1.getMungdaal());
    		s2.setMatki(s2.getMatki() + s1.getMatki());
    		s2.setMung(s2.getMung() + s1.getMung());
    		s2.setMasuldaal(s2.getMasuldaal()+s1.getMasuldaal());
    		s2.setHarbara(s2.getHarbara()+s1.getHarbara());
    		s2.setVatana(s2.getVatana()+s1.getVatana());
    		s2.setExtra1(s2.getExtra1()+s1.getExtra1());
    		s2.setExtra2(s2.getExtra2()+s1.getExtra2());
    		s2.setExtra3(s2.getExtra3()+s1.getExtra3());
    		s2.setExtra4(s2.getExtra4()+s1.getExtra4());
    		s2.setExtra5(s2.getExtra5()+s1.getExtra5());
    		s2.setExtra6(s2.getExtra6()+s1.getExtra6());
    		s2.setChvli(s2.getChvli() + s1.getChvli());
    		s2.setTel(s2.getTel() + s1.getTel());
    		s2.setMith(s2.getMith() + s1.getMith());
    		s2.setMirchi(s2.getMirchi() + s1.getMirchi());
    		s2.setHalad(s2.getHalad() + s1.getHalad());
    		s2.setJire(s2.getJire() + s1.getJire());
    		s2.setMohari(s2.getMohari() + s1.getMohari());
    		s2.setTandul(s2.getTandul() + s1.getTandul());
    	}
    	s2.setMungdaal(s2.getMungdaal()-s.getMungdaal());
 	s2.setMatki(s2.getMatki()- s.getMatki());
 	s2.setMung(s2.getMung()- s.getMung());
 	s2.setMasuldaal(s2.getMasuldaal()- s.getMasuldaal());
 	s2.setHarbara(s2.getHarbara()- s.getHarbara());
 	s2.setVatana(s2.getVatana()- s.getVatana());
 	s2.setExtra1(s2.getExtra1()- s.getExtra1());
 	s2.setExtra2(s2.getExtra2()- s.getExtra2());
 	s2.setExtra3(s2.getExtra3()- s.getExtra3());
 	s2.setExtra4(s2.getExtra4()- s.getExtra4());
 	s2.setExtra5(s2.getExtra5()- s.getExtra5());
 	s2.setExtra6(s2.getExtra6()- s.getExtra6());
 	s2.setChvli(s2.getChvli()- s.getChvli());
 	s2.setTel(s2.getTel() -s.getTel());
 	s2.setMith(s2.getMith()- s.getMith());
 	s2.setMirchi(s2.getMirchi() - s.getMirchi() );
 	s2.setHalad(s2.getHalad()  - s.getHalad());
 	s2.setJire(s2.getJire() - s.getJire());
 	s2.setMohari(s2.getMohari() - s.getMohari());
 	s2.setTandul(s2.getTandul() - s.getTandul());
	ArrayList<Item> itemList = new InvoiceDS().getAllItemByVersion(tInvoice.getInvoiceDate());
	int version = itemList.get(0).getVersion();
	DispatchTalukaOrder rate = new DispatchTalukaOrder();
	DispatchTalukaOrder vat = new DispatchTalukaOrder();
	double kRate = 0.0,rRate = 0.0, tRate=0.0;
	for(Item i : itemList)
	{
		if(i.getItemId() == 1)
        {
        	rate.setMungdaal(i.getRatePerKg());
        	vat.setMungdaal(i.getVat());
        }
        if(i.getItemId() == 2)
        {
        	rate.setMatki(i.getRatePerKg());
        	vat.setMatki(i.getVat());
        }
        if(i.getItemId() == 3)
        {
        	rate.setMung(i.getRatePerKg());
        	vat.setMung(i.getVat());
        }
        if(i.getItemId() == 4)
        {
        	rate.setMasuldaal(i.getRatePerKg());
        	vat.setMasuldaal(i.getVat());
        }
        if(i.getItemId() == 5)
        {
        	rate.setChvli(i.getRatePerKg());
        	vat.setChvli(i.getVat());
        }
        if(i.getItemId() == 6)
        {
        	rate.setTel(i.getRatePerKg());
        	vat.setTel(i.getVat());
        }
        if(i.getItemId() == 7)
        {
        	rate.setMith(i.getRatePerKg());
        	vat.setMith(i.getVat());
        }
        if(i.getItemId() == 8)
        {
        	rate.setMirchi(i.getRatePerKg());
        	vat.setMirchi(i.getVat());
        }
        if(i.getItemId() == 9)
        {
        	rate.setHalad(i.getRatePerKg());
        	vat.setHalad(i.getVat());
        }
        if(i.getItemId() == 10)
        {
        	rate.setJire(i.getRatePerKg());
        	vat.setJire(i.getVat());
        }
        if(i.getItemId() == 11)
        {
        	rate.setMohari(i.getRatePerKg());
        	vat.setMohari(i.getVat());
        }
        if(i.getItemId() == 12)
        {
        	//rate.setTandul(i.getRatePerKg());
        	//vat.setTandul(i.getVat());
        	kRate = i.getkRate();
        	rRate = i.getrRate();
        }
        if(i.getItemId() == 13)
        {
        	rate.setHarbara(i.getRatePerKg());
        	vat.setHarbara(i.getVat());
        }
        if(i.getItemId() == 14)
        {
        	rate.setVatana(i.getRatePerKg());
        	vat.setVatana(i.getVat());
        }
        if(i.getItemId() == 15)
         {
         	rate.setExtra1(i.getRatePerKg());
         	vat.setExtra1(i.getVat());
         }
         if(i.getItemId() == 16)
         {
         	rate.setExtra2(i.getRatePerKg());
         	vat.setExtra2(i.getVat());
         }
         if(i.getItemId() == 17)
         {
         	rate.setExtra3(i.getRatePerKg());
         	vat.setExtra3(i.getVat());
         }
         if(i.getItemId() == 18)
         {
         	rate.setExtra4(i.getRatePerKg());
         	vat.setExtra4(i.getVat());
         }
         if(i.getItemId() == 19)
         {
         	rate.setExtra5(i.getRatePerKg());
         	vat.setExtra5(i.getVat());
         }
         if(i.getItemId() == 20)
         {
         	rate.setExtra6(i.getRatePerKg());
         	vat.setExtra6(i.getVat());
         }
	}
	double weightTotal = 0.0 ,taxTotal = 0.0,amountTotal = 0.0;
	NumberToMarathiWord nm = new NumberToMarathiWord();
	if(talukaOrderHelper.getOrderType() == 2)
	{
        	weightTotal= s2.getMungdaal() + s2.getMatki() + s2.getMung() + s2.getMasuldaal() + s2.getHarbara() + s2.getVatana() + s2.getExtra1() + s2.getExtra2() + s2.getExtra3() + s2.getExtra4() + s2.getExtra5() + s2.getExtra6() + s2.getChvli() + s2.getTel() + s2.getMith() + s2.getMirchi() + s2.getHalad() + s2.getJire() + s2.getMohari() ;
        	taxTotal= ((s2.getMungdaal())*((rate.getMungdaal()*vat.getMungdaal())/(100+vat.getMungdaal())))+((s2.getMatki())*((rate.getMatki()*vat.getMatki())/(100+vat.getMatki())))+((s2.getMung())*((rate.getMung()*vat.getMung())/(100+vat.getMung())))+((s2.getMasuldaal())*((rate.getMasuldaal()*vat.getMasuldaal())/(100+vat.getMasuldaal())))+((s2.getHarbara())*((rate.getHarbara()*vat.getHarbara())/(100+vat.getHarbara())))+((s2.getVatana())*((rate.getVatana()*vat.getVatana())/(100+vat.getVatana())))+((s2.getExtra1())*((rate.getExtra1()*vat.getExtra1())/(100+vat.getExtra1())))+((s2.getExtra2())*((rate.getExtra2()*vat.getExtra2())/(100+vat.getExtra2())))+((s2.getExtra3())*((rate.getExtra3()*vat.getExtra3())/(100+vat.getExtra3())))+((s2.getExtra4())*((rate.getExtra4()*vat.getExtra4())/(100+vat.getExtra4())))+((s2.getExtra5())*((rate.getExtra5()*vat.getExtra5())/(100+vat.getExtra5())))+((s2.getExtra6())*((rate.getExtra6()*vat.getExtra6())/(100+vat.getExtra6())))+((s2.getChvli())*((rate.getChvli()*vat.getChvli())/(100+vat.getChvli())))+((s2.getTel())*((rate.getTel()*vat.getTel())/(100+vat.getTel())))+((s2.getMith())*((rate.getMith()*vat.getMith())/(100+vat.getMith())))+((s2.getMirchi())*((rate.getMirchi()*vat.getMirchi())/(100+vat.getMirchi())))+((s2.getHalad())*((rate.getHalad()*vat.getHalad())/(100+vat.getHalad())))+((s2.getJire())*((rate.getJire()*vat.getJire())/(100+vat.getJire())))+(s2.getMohari())*((rate.getMohari()*vat.getMohari())/(100+vat.getMohari()));
        	amountTotal = (s2.getMungdaal()*rate.getMungdaal())+(s2.getMatki()*rate.getMatki())+(s2.getMung()*rate.getMung())+(s2.getMasuldaal()*rate.getMasuldaal())+(s2.getHarbara()*rate.getHarbara())+(s2.getVatana()*rate.getVatana())+(s2.getExtra1()*rate.getExtra1())+(s2.getExtra2()*rate.getExtra2())+(s2.getExtra3()*rate.getExtra3())+(s2.getExtra4()*rate.getExtra4())+(s2.getExtra5()*rate.getExtra5())+(s2.getExtra6()*rate.getExtra6())+(s2.getChvli()*rate.getChvli())+(s2.getTel()*rate.getTel())+(s2.getMith()*rate.getMith())+(s2.getMirchi()*rate.getMirchi())+(s2.getHalad()*rate.getHalad())+(s2.getJire()*rate.getJire())+(s2.getMohari()*rate.getMohari());
%>
		<table border="0" width="100%">
			<tr>
                <td class="left" width="50%">धुळेच्या न्याय कशाकक्षा अंतर्गत </td>
                <td class="right" width="50%">&nbsp;</td>
            </tr> 
			<tr>
                <td class="left" width="50%"></td>
                <td class="right" width="50%">&nbsp;</td>
            </tr> 
		</table>
        <center> <font class="fontsize20Bold" style="font-size:35px"> <b> केंद्रीय भांडार</b></font><br>
        	ऑफिस : १०२, पहिला मजला, बीजीटीए गोदावरी, <br>
			प्लॉट नं. जी-१, वडाळा ट्रॅक टर्मिनल, <br>
			सायन, मुंबई, महाराष्ट्र - ४०००३७ <br>
        TAX INVOICE<br>
        	कॅश क्रेडिट मेमो</center>
		<table border="0" width="100%">
            <tbody class="fontsize14">  
            	<tr>
                    <td class="left" width="70%"> बील क्रमांक :- <b>  शा पो आ शा तां - <%=tInvoice.getInvoiceIDMan()%></b> </td>
                    <td class="left" width="30%">तारीख :<b>  <%=tInvoice.getInvoiceDate() %> </b></td>
                </tr> 
                <tr>
                    <td class="left" width="70%">अधिषक / गटशिक्षणाधिकारी (शा पो आ)</td>
                    <td class="left" width="30%"></td>
                <tr>
                    <td class="left" width="70%">पंचायत समिती कार्यालय, <b><%=talukaOrderHelper.getTalukaName()%></b></td>
                    <td class="left" width="30%">माहे <b><%=talukaOrderHelper.getFromMonth()%> - <%=talukaOrderHelper.getFromYear()%>  ते  <%=talukaOrderHelper.getToMonth()%> - <%=talukaOrderHelper.getToYear() %></b></td>
                </tr>
                <tr>
                    <td class="left" width="70%">जिल्हा - <b><%=talukaOrderHelper.getDistrictName()%></b></td>
                    <td class="left" width="30%">इयत्ता - <b><%=talukaOrderHelper.getOrderTypeDetails()%></b></td>
                </tr>
                <tr>
                    <td class="left" colspan="2">&nbsp;</td>
                </tr>
                <tr>
                    <td class="left" colspan="2">मा शिक्षणाधिकारी प्राथमिक जि प धुळे य़ांचे दि. <%= talukaOrderHelper.gettOrderDate() %> चे पुरवठा आदेशानुसार</td>
                </tr>
            </tbody>
        </table>
        <br/>
       	<table  class="printstyle fontsize15"  width="800">
            	<thead class="fontsize16Bold">
            		<tr class="center">
	                    <td>अ. क्र.</td>
	                    <td>मालाचा तपशिल</td>
	                    <td>वजन कि-ग्रॅम / लिटर</td>
	                    <td>दर प्र-कि-ग्रॅम</td>
	                    <td>GST%</td>
	                    <td>GST रक्कम रु.</td>
	                    <td>बिलाची एकुण रक्कम रु</td>
	                </tr>
            	</thead>
            	<tbody class="fontsize15" class="center">
            		<tr class="fontMarathiNumber right">
            			<td> <center>1</center> </td>
            			<td> <center>मुंगदाळ</center> </td>
            			<td class="fontMarathiNumberAmt right"><%=threeDecimalFormatter.format(s2.getMungdaal())%></td>
            			<td class="fontMarathiNumberAmt right"><%=twoDecimalFormatter.format(rate.getMungdaal())%></td>
            			<td class="fontMarathiNumberAmt right"><%=twoDecimalFormatter.format(vat.getMungdaal())%></td>
	                    <td class="fontMarathiNumberAmt right"><%if(vat.getMungdaal()!=0){out.print(twoDecimalFormatter.format((s2.getMungdaal())*((rate.getMungdaal()*vat.getMungdaal())/(100+vat.getMungdaal()))));} %></td>
	                    <td class="fontMarathiNumberAmt right"><%=twoDecimalFormatter.format(s2.getMungdaal()*rate.getMungdaal()) %></td>
            		</tr>
	                <tr class="fontMarathiNumber right">
	                	<td><center>2</center> </td>
	                	<td><center>तुर डाळ</center> </td>
	                	<td class="fontMarathiNumberAmt right"><%=threeDecimalFormatter.format(s2.getMatki()) %></td>
	                	<td class="fontMarathiNumberAmt right"><%=twoDecimalFormatter.format(rate.getMatki()) %></td>
	                	<td class="fontMarathiNumberAmt right"><%=twoDecimalFormatter.format(vat.getMatki()) %></td>
	                    <td class="fontMarathiNumberAmt right"><%if(vat.getMatki()!=0){out.print(twoDecimalFormatter.format((s2.getMatki())*((rate.getMatki()*vat.getMatki())/(100+vat.getMatki()))));} %></td>
	                    <td class="fontMarathiNumberAmt right"><%=twoDecimalFormatter.format(s2.getMatki()*rate.getMatki()) %></td>            
	                </tr>
					<tr class="fontMarathiNumber right">
	                    <td><center>3</center></td>
	                    <td><center>मुंग</center></td>
	                    <td class="fontMarathiNumberAmt right"><%=threeDecimalFormatter.format(s2.getMung()) %></td>
	                    <td class="fontMarathiNumberAmt right"><%=twoDecimalFormatter.format(rate.getMung()) %> </td>
	                    <td class="fontMarathiNumberAmt right"><%=twoDecimalFormatter.format(vat.getMung()) %> </td>
	                    <td class="fontMarathiNumberAmt right"><%if(vat.getMung()!=0){out.print(twoDecimalFormatter.format((s2.getMung())*((rate.getMung()*vat.getMung())/(100+vat.getMung()))));} %></td>
	                    <td class="fontMarathiNumberAmt right"><%=twoDecimalFormatter.format(s2.getMung()*rate.getMung()) %></td>
	                </tr>
					<tr class="fontMarathiNumber right">
	                	<td><center>4</center></td>
	                    <td><center>मटकी</center></td>
	                    <td class="fontMarathiNumberAmt right"><%=threeDecimalFormatter.format(s2.getMasuldaal()) %></td>
	                    <td class="fontMarathiNumberAmt right"><%=twoDecimalFormatter.format(rate.getMasuldaal()) %></td>
	                    <td class="fontMarathiNumberAmt right"><%=twoDecimalFormatter.format(vat.getMasuldaal()) %></td>
	                    <td class="fontMarathiNumberAmt right"><%if(vat.getMasuldaal()!=0){out.print(twoDecimalFormatter.format((s2.getMasuldaal())*((rate.getMasuldaal()*vat.getMasuldaal())/(100+vat.getMasuldaal()))));} %></td>
	                    <td class="fontMarathiNumberAmt right"><%=twoDecimalFormatter.format(s2.getMasuldaal()*rate.getMasuldaal()) %></td>
	                </tr>
					<tr class="fontMarathiNumber right">
	                	<td><center>5</center></td>
	                    <td><center>हरभरा</center></td>
	                    <td class="fontMarathiNumberAmt right"><%=threeDecimalFormatter.format(s2.getHarbara()) %></td>
	                    <td class="fontMarathiNumberAmt right"><%=twoDecimalFormatter.format(rate.getHarbara()) %></td>
	                    <td class="fontMarathiNumberAmt right"><%=twoDecimalFormatter.format(vat.getHarbara()) %></td>
	                    <td class="fontMarathiNumberAmt right"><%if(vat.getHarbara()!=0){out.print(twoDecimalFormatter.format((s2.getHarbara())*((rate.getHarbara()*vat.getHarbara())/(100+vat.getHarbara()))));} %></td>
	                    <td class="fontMarathiNumberAmt right"><%=twoDecimalFormatter.format(s2.getHarbara()*rate.getHarbara()) %></td>
	                </tr>
					<tr class="fontMarathiNumber right">
	                	<td><center>6</center></td>
	                    <td><center>वटाणा</center></td>
	                    <td class="fontMarathiNumberAmt right"><%=threeDecimalFormatter.format(s2.getVatana()) %></td>
	                    <td class="fontMarathiNumberAmt right"><%=twoDecimalFormatter.format(rate.getVatana()) %></td>
	                    <td class="fontMarathiNumberAmt right"><%=twoDecimalFormatter.format(vat.getVatana()) %></td>
	                    <td class="fontMarathiNumberAmt right"><%if(vat.getVatana()!=0){out.print(twoDecimalFormatter.format((s2.getVatana())*((rate.getVatana()*vat.getVatana())/(100+vat.getVatana()))));} %></td>
	                    <td class="fontMarathiNumberAmt right"><%=twoDecimalFormatter.format(s2.getVatana()*rate.getVatana()) %></td>
	                </tr>
					<tr class="fontMarathiNumber right">
	                	<td><center>7</center></td>
	                    <td><center>सोया वडी</center></td>
	                    <td class="fontMarathiNumberAmt right"><%=threeDecimalFormatter.format(s2.getExtra1()) %></td>
	                    <td class="fontMarathiNumberAmt right"><%=twoDecimalFormatter.format(rate.getExtra1()) %></td>
	                    <td class="fontMarathiNumberAmt right"><%=twoDecimalFormatter.format(vat.getExtra1()) %></td>
	                    <td class="fontMarathiNumberAmt right"><%if(vat.getExtra1()!=0){out.print(twoDecimalFormatter.format((s2.getExtra1())*((rate.getExtra1()*vat.getExtra1())/(100+vat.getExtra1()))));} %></td>
	                    <td class="fontMarathiNumberAmt right"><%=twoDecimalFormatter.format(s2.getExtra1()*rate.getExtra1()) %></td>
	                </tr>
	                <tr class="fontMarathiNumber right">
	                	<td><center>4a</center></td>
	                    <td><center>Extra2</center></td>
	                    <td class="fontMarathiNumberAmt right"><%=threeDecimalFormatter.format(s2.getExtra2()) %></td>
	                    <td class="fontMarathiNumberAmt right"><%=twoDecimalFormatter.format(rate.getExtra2()) %></td>
	                    <td class="fontMarathiNumberAmt right"><%=twoDecimalFormatter.format(vat.getExtra2()) %></td>
	                    <td class="fontMarathiNumberAmt right"><%if(vat.getExtra2()!=0){out.print(twoDecimalFormatter.format((s2.getExtra2())*((rate.getExtra2()*vat.getExtra2())/(100+vat.getExtra2()))));} %></td>
	                    <td class="fontMarathiNumberAmt right"><%=twoDecimalFormatter.format(s2.getExtra2()*rate.getExtra2()) %></td>
	                </tr>
	                <tr class="fontMarathiNumber right">
	                	<td><center>4b</center></td>
	                    <td><center>Extra3</center></td>
	                    <td class="fontMarathiNumberAmt right"><%=threeDecimalFormatter.format(s2.getExtra3()) %></td>
	                    <td class="fontMarathiNumberAmt right"><%=twoDecimalFormatter.format(rate.getExtra3()) %></td>
	                    <td class="fontMarathiNumberAmt right"><%=twoDecimalFormatter.format(vat.getExtra3()) %></td>
	                    <td class="fontMarathiNumberAmt right"><%if(vat.getExtra3()!=0){out.print(twoDecimalFormatter.format((s2.getExtra3())*((rate.getExtra3()*vat.getExtra3())/(100+vat.getExtra3()))));} %></td>
	                    <td class="fontMarathiNumberAmt right"><%=twoDecimalFormatter.format(s2.getExtra3()*rate.getExtra3()) %></td>
	                </tr>
	                <tr class="fontMarathiNumber right">
	                	<td><center>4c</center></td>
	                    <td><center>Extra4</center></td>
	                    <td class="fontMarathiNumberAmt right"><%=threeDecimalFormatter.format(s2.getExtra4()) %></td>
	                    <td class="fontMarathiNumberAmt right"><%=twoDecimalFormatter.format(rate.getExtra4()) %></td>
	                    <td class="fontMarathiNumberAmt right"><%=twoDecimalFormatter.format(vat.getExtra4()) %></td>
	                    <td class="fontMarathiNumberAmt right"><%if(vat.getExtra4()!=0){out.print(twoDecimalFormatter.format((s2.getExtra4())*((rate.getExtra4()*vat.getExtra4())/(100+vat.getExtra4()))));} %></td>
	                    <td class="fontMarathiNumberAmt right"><%=twoDecimalFormatter.format(s2.getExtra4()*rate.getExtra4()) %></td>
	                </tr>
	                <tr class="fontMarathiNumber right">
	                	<td><center>4d</center></td>
	                    <td><center>Extra5</center></td>
	                    <td class="fontMarathiNumberAmt right"><%=threeDecimalFormatter.format(s2.getExtra5()) %></td>
	                    <td class="fontMarathiNumberAmt right"><%=twoDecimalFormatter.format(rate.getExtra5()) %></td>
	                    <td class="fontMarathiNumberAmt right"><%=twoDecimalFormatter.format(vat.getExtra5()) %></td>
	                    <td class="fontMarathiNumberAmt right"><%if(vat.getExtra5()!=0){out.print(twoDecimalFormatter.format((s2.getExtra5())*((rate.getExtra5()*vat.getExtra5())/(100+vat.getExtra5()))));} %></td>
	                    <td class="fontMarathiNumberAmt right"><%=twoDecimalFormatter.format(s2.getExtra5()*rate.getExtra5()) %></td>
	                </tr>
	                <tr class="fontMarathiNumber right">
	                	<td><center>4e</center></td>
	                    <td><center>Extra6</center></td>
	                    <td class="fontMarathiNumberAmt right"><%=threeDecimalFormatter.format(s2.getExtra6()) %></td>
	                    <td class="fontMarathiNumberAmt right"><%=twoDecimalFormatter.format(rate.getExtra6()) %></td>
	                    <td class="fontMarathiNumberAmt right"><%=twoDecimalFormatter.format(vat.getExtra6()) %></td>
	                    <td class="fontMarathiNumberAmt right"><%if(vat.getExtra6()!=0){out.print(twoDecimalFormatter.format((s2.getExtra6())*((rate.getExtra6()*vat.getExtra6())/(100+vat.getExtra6()))));} %></td>
	                    <td class="fontMarathiNumberAmt right"><%=twoDecimalFormatter.format(s2.getExtra6()*rate.getExtra6()) %></td>
	                </tr>
					-->
	                <tr class="fontMarathiNumber right">
	                    <td><center>7</center></td>
	                    <td><center>चवळी</center></td>
	                    <td class="fontMarathiNumberAmt right"><%=threeDecimalFormatter.format(s2.getChvli()) %></td>
	                    <td class="fontMarathiNumberAmt right"><%=twoDecimalFormatter.format(rate.getChvli()) %></td>
	                    <td class="fontMarathiNumberAmt right"><%=twoDecimalFormatter.format(vat.getChvli()) %></td>
	                    <td class="fontMarathiNumberAmt right"><%if(vat.getChvli()!=0){out.print(twoDecimalFormatter.format((s2.getChvli())*((rate.getChvli()*vat.getChvli())/(100+vat.getChvli()))));} %></td>
	                    <td class="fontMarathiNumberAmt right"><%=twoDecimalFormatter.format(s2.getChvli()*rate.getChvli()) %></td>
	                </tr>	                
					<!-- -->
	                <tr class="fontMarathiNumber right">
	                    <td><center>9</center></td>
	                    <td><center>तेल (सोया अॅगमार्क)</center></td>
	                    <td class="fontMarathiNumberAmt right"><%=threeDecimalFormatter.format(s2.getTel()) %></td>
	                    <td class="fontMarathiNumberAmt right"><%=twoDecimalFormatter.format(rate.getTel()) %></td>
	                    <td class="fontMarathiNumberAmt right"><%=twoDecimalFormatter.format(vat.getTel()) %></td>
	                    <td class="fontMarathiNumberAmt right"><%if(vat.getTel()!=0){out.print(twoDecimalFormatter.format((s2.getTel())*((rate.getTel()*vat.getTel())/(100+vat.getTel()))));} %></td>
	                    <td class="fontMarathiNumberAmt right"><%=twoDecimalFormatter.format(s2.getTel()*rate.getTel()) %></td>
	                </tr>	                
					<!-- -->
	                <tr class="fontMarathiNumber right">
	                	<td ><center>10</center></td>
	                    <td><center>मीठ (आयोडिनयुक्त)</center></td>
	                    <td class="fontMarathiNumberAmt right"><%=threeDecimalFormatter.format(s2.getMith()) %></td>
	                    <td class="fontMarathiNumberAmt right"><%=twoDecimalFormatter.format(rate.getMith()) %></td>
	                    <td class="fontMarathiNumberAmt right"><%=twoDecimalFormatter.format(vat.getMith()) %></td>
	                    <td class="fontMarathiNumberAmt right"><%if(vat.getMith()!=0){out.print(twoDecimalFormatter.format((s2.getMith())*((rate.getMith()*vat.getMith())/(100+vat.getMith()))));} %></td>
	                    <td class="fontMarathiNumberAmt right"><%=twoDecimalFormatter.format(s2.getMith()*rate.getMith()) %></td>                
	                </tr>	                
	                <tr class="fontMarathiNumber right">
	                    <td><center>11</center></td>
	                    <td><center>कांदा लसूण मसाला</center></td>
	                    <td class="fontMarathiNumberAmt right"><%=threeDecimalFormatter.format(s2.getMirchi()) %></td>
	                    <td class="fontMarathiNumberAmt right"><%=twoDecimalFormatter.format(rate.getMirchi()) %></td>
	                    <td class="fontMarathiNumberAmt right"><%=twoDecimalFormatter.format(vat.getMirchi()) %></td>
	                    <td class="fontMarathiNumberAmt right"><%if(vat.getMirchi()!=0){out.print(twoDecimalFormatter.format((s2.getMirchi())*((rate.getMirchi()*vat.getMirchi())/(100+vat.getMirchi()))));} %></td>
	                    <td class="fontMarathiNumberAmt right"><%=twoDecimalFormatter.format(s2.getMirchi()*rate.getMirchi()) %></td>
	                </tr>	  	                              
	                <tr class="fontMarathiNumber right">
	                    <td><center>11</center></td>
	                    <td><center>हळद (अॅगमार्क)</center></td>
	                    <td class="fontMarathiNumberAmt right"><%=threeDecimalFormatter.format(s2.getHalad()) %></td>
	                    <td class="fontMarathiNumberAmt right"><%=twoDecimalFormatter.format(rate.getHalad()) %></td>
	                    <td class="fontMarathiNumberAmt right"><%=twoDecimalFormatter.format(vat.getHalad()) %></td>
	                    <td class="fontMarathiNumberAmt right"><%if(vat.getHalad()!=0){out.print(twoDecimalFormatter.format((s2.getHalad())*((rate.getHalad()*vat.getHalad())/(100+vat.getHalad()))));} %></td>
	                    <td class="fontMarathiNumberAmt right"><%=twoDecimalFormatter.format(s2.getHalad()*rate.getHalad()) %></td>
	                </tr>	              
	                <tr class="fontMarathiNumber right">
	                    <td><center>13</center></td>
	                    <td><center>जिरे</center></td>
	                    <td class="fontMarathiNumberAmt right"><%=threeDecimalFormatter.format(s2.getJire()) %></td>
	                    <td class="fontMarathiNumberAmt right"><%=twoDecimalFormatter.format(rate.getJire()) %></td>
	                    <td class="fontMarathiNumberAmt right"><%=twoDecimalFormatter.format(vat.getJire()) %></td>
	                    <td class="fontMarathiNumberAmt right"><%if(vat.getJire()!=0){out.print(twoDecimalFormatter.format((s2.getJire())*((rate.getJire()*vat.getJire())/(100+vat.getJire()))));} %></td>
	                    <td class="fontMarathiNumberAmt right"><%=twoDecimalFormatter.format(s2.getJire()*rate.getJire()) %></td>
	                </tr>	                
	                <tr class="fontMarathiNumber right">
	                    <td><center>14</center></td>
	                    <td><center>मोहरी</center></td>
	                    <td class="fontMarathiNumberAmt right"><%=threeDecimalFormatter.format(s2.getMohari()) %></td>
	                    <td class="fontMarathiNumberAmt right"><%=twoDecimalFormatter.format(rate.getMohari()) %></td>
	                    <td class="fontMarathiNumberAmt right"><%=twoDecimalFormatter.format(vat.getMohari()) %></td>
	                    <td class="fontMarathiNumberAmt right"><%if(vat.getMohari()!=0){out.print(twoDecimalFormatter.format((s2.getMohari())*((rate.getMohari()*vat.getMohari())/(100+vat.getMohari()))));} %></td>
	                    <td class="fontMarathiNumberAmt right"><%=twoDecimalFormatter.format(s2.getMohari()*rate.getMohari()) %></td>
	                </tr>
	                <tr>
	                    <td colspan="2"><center><b>Total</b></center></td>
	                    <td class="fontMarathiNumberAmt right"><b><%=threeDecimalFormatter.format(weightTotal) %></b></td>
	                    <td></td>
	                    <td></td>
	                    <td class="fontMarathiNumberAmt right"><b><%if(taxTotal!=0){out.print(twoDecimalFormatter.format(taxTotal));} %></b></td>
	                    <td class="fontMarathiNumberAmt right"><b><%=twoDecimalFormatter.format(amountTotal) %></b></td>
	                </tr>
	                <tr class="fontMarathiNumber left">
	                    <td colspan="7"><b> अक्षरी रुपये -  <%=nm.convertToWord(amountTotal) %></b></td>
	                </tr>
	            </tbody>
    	    </table>
       	
   	    <br>  	    
      		वरील दरात लागन्या सर्व करांचा समावेश अाहे<br>I / we certify that our registration certificate under the GST Act, 2017 is in force on the date on which the supply of goods specified in this Tax Invoice is made by me/us & the transaction of supply covered by this Tax Invoice had been effected by me/us & it shall be accounted for in the turnover of supplies while filing of return & the due tax if any payable on the supplies has been paid or shall be paid. Further certified that the particulars given above are true and correct & the amount indicated represents the prices actually charged and that there is no flow if additional consideration directly or indirectly from the buyer.
 <br>
      	GSTIN :- 27AAAFC5403F1ZZ<br>
      	<table border="0" width="100%">
			<tr>
                <td class="left" width="33%">&nbsp;</td>
                <td class="center" width="33%">&nbsp;</td>
                <td class="center" width="33%"><center>केंद्रीय भांडार</center></td>
            </tr> 
			<tr>
                <td class="left" width="33%">बिल कारणार</td>
                <td class="center" width="33%"></td>
                <td class="center" width="33%">&nbsp;</td>
            </tr>  
			<tr>
                <td class="left" width="33%">&nbsp;</td>
                <td class="center" width="33%">&nbsp;</td>
                <td class="center" width="33%"><center>धुळे</center></td>
            </tr> 
		</table>
       	<hr class="noprint" style="color: red">
<%
	}
	else
	{
		for(int i =1; i<=2; i++)
		{
			if(i==1)
				tRate = kRate;
			else
				tRate = rRate;
%>	
		<table border="0" width="100%">
			<tr>
                <td class="left" width="50%">धुळेच्या न्याय कशाकक्षा अंतर्गत </td>
                <td class="right" width="50%">&nbsp;</td>
            </tr> 
			<tr>
                <td class="left" width="50%"></td>
                <td class="right" width="50%">&nbsp;</td>
            </tr> 
		</table>
        <center> <font class="fontsize20Bold" style="font-size:35px"> <b> केंद्रीय भांडार </b></font><br>
        	ऑफिस : १०२, पहिला मजला, बीजीटीए गोदावरी, <br>
			प्लॉट नं. जी-१, वडाळा ट्रॅक टर्मिनल, <br>
			सायन, मुंबई, महाराष्ट्र - ४०००३७ <br>
        TAX INVOICE<br>
        	कॅश क्रेडिट मेमो</center>
		<table border="0" width="100%">
        	<tbody class="fontsize14">  
            	<tr>
                    <td class="left" width="70%"> बील क्रमांक :- <b>  शा पो आ शा तां - <%if(i==1){out.print("<b>"+tInvoice.getInvoiceIDMan1()+"</b>");}else{out.print("<b>"+tInvoice.getInvoiceIDMan2()+"</b>");}%></b> </td>
                    <td class="left" width="30%">तारीख :<b>  <%=tInvoice.getInvoiceDate() %> </b></td>
                </tr> 
                <tr>
                    <td class="left" width="70%">मे. गटशिक्षणाधिकारी अधिखक (शा पो आ)</td>
                    <td class="left" width="30%"></td>
                </tr>
                <tr>
                    <td class="left" width="70%">पंचायत समिती कार्यालय, <b><%=talukaOrderHelper.getTalukaName()%></b></td>
                    <td class="left" width="30%">माहे <b><%=talukaOrderHelper.getFromMonth()%> - <%=talukaOrderHelper.getFromYear()%>  ते  <%=talukaOrderHelper.getToMonth()%> - <%=talukaOrderHelper.getToYear() %></b></td>
                </tr>
                <tr>
                    <td class="left" width="70%">जिल्हा - <b><%=talukaOrderHelper.getDistrictName()%></b></td>
                    <td class="left" width="30%">इयत्ता - <b><%=talukaOrderHelper.getOrderTypeDetails()%></b></td>
                </tr>
                <tr>
                    <td class="left" colspan="2">&nbsp;</td>
                </tr>
                <tr>
                    <td class="left" colspan="2">मा शिक्षणाधिकारी प्राथमिक जि प धुळे य़ांचे दि.  <%= talukaOrderHelper.gettOrderDate() %> चे पुरवठा आदेशानुसार</td>
                </tr>
            	<tr>
                    <td class="right" colspan="2"><%if(i==1){out.print("<b>(केंद्र हिस्सा)</b>");}else{out.print("<b>(राज्य हिस्सा)</b>");}%></td>
                </tr>
            </tbody>
        </table>
        <br/>
		<table  class="printstyle fontsize15"  width="800">
           	<thead class="fontsize16Bold">
           		<tr class="center">
                    <td><b>अ. क्र.</b></td>
                    <td><b>मालाचा तपशिल</b></td>
                    <td><b>वजन कि-ग्रॅम / लिटर</b></td>
                    <td><b>वाहतूक दर प्र-कि-ग्रॅम</b></td>
                    <td><b>बिलाची एकुण रक्कम रु</b></td>
                </tr>
           	</thead>
           	<tbody class="fontsize15" class="center">
           		<tr class="fontMarathiNumber right" height="80">
           			<td> <center>1</center> </td>
           			<td> <center>शासकीय तांदुळ वाहतुक</center> </td>
           			<td class="fontMarathiNumberAmt right"><%=threeDecimalFormatter.format(s2.getTandul())%></td>
           			<td class="fontMarathiNumberAmt right"><%=twoDecimalFormatter.format(tRate)%></td>
           			<td class="fontMarathiNumberAmt right"><%=twoDecimalFormatter.format(s2.getTandul()*tRate)%></td>
           		</tr>
                <tr>
                	<td colspan="3" class="left fontMarathiNumber"><b> अक्षरी रुपये -  <%=nm.convertToWord(s2.getTandul()*tRate) %></b></td>
                    <td ><center><b>Total</b></center></td>
           			<td class="right fontMarathiNumberAmt"><%=twoDecimalFormatter.format(s2.getTandul()*tRate)%></td>
                </tr>
            </tbody>
   	    </table> 
   	    <br>  	    
      		वरील दरात लागन्या सर्व करांचा समावेश अाहे<br>
      	I / we certify that our registration certificate under the GST Act, 2017 is in force on the date on which the supply of goods specified in this Tax Invoice is made by me/us & the transaction of supply covered by this Tax Invoice had been effected by me/us & it shall be accounted for in the turnover of supplies while filing of return & the due tax if any payable on the supplies has been paid or shall be paid. Further certified that the particulars given above are true and correct & the amount indicated represents the prices actually charged and that there is no flow if additional consideration directly or indirectly from the buyer.
 <br>
      	GSTIN :- 27AAAFC5403F1ZZ<br>
      	<table border="0" width="100%">
			<tr>
                <td class="left" width="33%">&nbsp;</td>
                <td class="center" width="33%">&nbsp;</td>
                <td class="center" width="33%"><center>केंद्रीय भांडार</center></td>
            </tr> 
			<tr>
                <td class="left" width="33%">बिल कारणार</td>
                <td class="center" width="33%"></td>
                <td class="center" width="33%">&nbsp;</td>
            </tr>  
			<tr>
                <td class="left" width="33%">&nbsp;</td>
                <td class="center" width="33%">&nbsp;</td>
                <td class="center" width="33%"><center>धुळे</center></td>
            </tr>
		</table>
<%
			if(i==1)
			{
%>		
		<hr class="noprint" style="color: red">
      	<p class="breakhere"></p>
<%
			}
			else
			{
%>		
		<hr class="noprint" style="color: red">
<%
			}
		}
	}
%>
	</body>
</html>