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

        <script>
            var date, invoiceNumber, invoiceNumber1, invoiceNumber2 ;
            Ext.onReady(function() 
           	{
            	invoiceNumber = new Ext.form.NumberField(
            	{
                    name: 'brokenDateField',
                    id: 'invoice',
                    allowBlank: false,
                    applyTo : 'invoiceNumber',
                    emptyText :'बिल नं.'
                });
            });
            Ext.onReady(function() 
           	{
            	invoiceNumber1 = new Ext.form.NumberField(
            	{
                    name: 'brokenDateField',
                    id: 'invoice1',
                    allowBlank: false,
                    applyTo : 'invoiceNumber1',
                    emptyText :'बिल नं.'
                });
            	invoiceNumber2 = new Ext.form.NumberField(
            	{
                    name: 'brokenDateField',
                    id: 'invoice2',
                    allowBlank: false,
                    applyTo : 'invoiceNumber2',
                    emptyText :'बिल नं.'
                });
            });
            validate = function()
            {
                if(date.getValue().length == 0 || invoiceNumber.getValue().length == 0)
                {
                    return false;
                }
                return true;
            };
            validate1 = function()
            {
            	if(invoiceNumber1.getValue().length == 0)
                {
                    return false;
                }
            	if(invoiceNumber2.getValue().length == 0)
                {
                    return false;
                }
                return true;
            };
        </script>
    </head>
	<body>
<%
	NumberFormat twoDecimalFormatter = new DecimalFormat("#0.00");
	NumberFormat threeDecimalFormatter = new DecimalFormat("#0.000");
	NumberFormat zeroDecimalFormatter = new DecimalFormat("#");
	String orderID = request.getParameter("orderID");
	String talukaID = request.getParameter("talukaID");
	String previewDate = request.getParameter("previewDate");
	//System.out.println(orderID +"\t"+talukaID+"\t"+previewDate);
	TalukaOrderDetailDSHelper dSHelper = new TalukaOrderDetailDSHelper();
	TalukaOrder talukaOrderHelper = dSHelper.talukaOrderDetails(Integer.parseInt(orderID));
	SectionWiseItemSum s2 = null;
	ArrayList<SectionWiseItemSum> list = new TalukaOrderDS().getAllSectionForOrder(Integer.parseInt(talukaID),Integer.parseInt(orderID));
	SectionWiseItemSum s =  new TalukaOrderDS().getTalukaReturnDetails(Integer.parseInt(orderID));
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
 	s2.setHarbara(s2.getHarbara() - s.getHarbara());
 	s2.setVatana(s2.getVatana() - s.getVatana());
 	s2.setExtra1(s2.getExtra1() - s.getExtra1());
 	s2.setExtra2(s2.getExtra2() - s.getExtra2());
 	s2.setExtra3(s2.getExtra3() - s.getExtra3());
 	s2.setExtra4(s2.getExtra4() - s.getExtra4());
 	s2.setExtra5(s2.getExtra5() - s.getExtra5());
 	s2.setExtra6(s2.getExtra6() - s.getExtra6());
	s2.setChvli(s2.getChvli()- s.getChvli());
	s2.setTel(s2.getTel() -s.getTel());
	s2.setMith(s2.getMith()- s.getMith());
	s2.setMirchi(s2.getMirchi() - s.getMirchi() );
	s2.setHalad(s2.getHalad()  - s.getHalad());
	s2.setJire(s2.getJire() - s.getJire());
	s2.setMohari(s2.getMohari() - s.getMohari());
	s2.setTandul(s2.getTandul() - s.getTandul()); 
	ArrayList<Item> itemList = new InvoiceDS().getAllItemByVersion(previewDate);
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
	String msg = request.getParameter("msg");
    if (msg != null) 
    {
%>
            <p class="center" style="text-decoration: blink;color: red"><%=msg%></p>
<%
	}
	if(talukaOrderHelper.getOrderType() == 2)
	{
        	weightTotal= s2.getMungdaal() + s2.getMatki() + s2.getMung() + s2.getMasuldaal() + s2.getHarbara() + s2.getVatana() + s2.getExtra1() + s2.getExtra2() + s2.getExtra3() + s2.getExtra4() + s2.getExtra5() + s2.getExtra6() + s2.getChvli() + s2.getTel() + s2.getMith() + s2.getMirchi() + s2.getHalad() + s2.getJire() + s2.getMohari() ;
        	taxTotal= ((s2.getMungdaal())*((rate.getMungdaal()*vat.getMungdaal())/(100+vat.getMungdaal())))+((s2.getMatki())*((rate.getMatki()*vat.getMatki())/(100+vat.getMatki())))+((s2.getMung())*((rate.getMung()*vat.getMung())/(100+vat.getMung()))) +((s2.getMasuldaal())*((rate.getMasuldaal()*vat.getMasuldaal())/(100+vat.getMasuldaal()))) +((s2.getHarbara())*((rate.getHarbara()*vat.getHarbara())/(100+vat.getHarbara())))+((s2.getVatana())*((rate.getVatana()*vat.getVatana())/(100+vat.getVatana())))+((s2.getExtra1())*((rate.getExtra1()*vat.getExtra1())/(100+vat.getExtra1())))+((s2.getExtra2())*((rate.getExtra2()*vat.getExtra2())/(100+vat.getExtra2())))+((s2.getExtra3())*((rate.getExtra3()*vat.getExtra3())/(100+vat.getExtra3())))+((s2.getExtra4())*((rate.getExtra4()*vat.getExtra4())/(100+vat.getExtra4())))+((s2.getExtra5())*((rate.getExtra5()*vat.getExtra5())/(100+vat.getExtra5())))+((s2.getExtra6())*((rate.getExtra6()*vat.getExtra6())/(100+vat.getExtra6())))+((s2.getChvli())*((rate.getChvli()*vat.getChvli())/(100+vat.getChvli())))+((s2.getTel())*((rate.getTel()*vat.getTel())/(100+vat.getTel())))+((s2.getMith())*((rate.getMith()*vat.getMith())/(100+vat.getMith())))+((s2.getMirchi())*((rate.getMirchi()*vat.getMirchi())/(100+vat.getMirchi())))+((s2.getHalad())*((rate.getHalad()*vat.getHalad())/(100+vat.getHalad())))+((s2.getJire())*((rate.getJire()*vat.getJire())/(100+vat.getJire())))+(s2.getMohari())*((rate.getMohari()*vat.getMohari())/(100+vat.getMohari()));
        	amountTotal = (s2.getMungdaal()*rate.getMungdaal())+(s2.getMatki()*rate.getMatki())+(s2.getMung()*rate.getMung())+(s2.getMasuldaal()*rate.getMasuldaal())+(s2.getHarbara()*rate.getHarbara())+(s2.getVatana()*rate.getVatana())+(s2.getExtra1()*rate.getExtra1())+(s2.getExtra2()*rate.getExtra2())+(s2.getExtra3()*rate.getExtra3())+(s2.getExtra4()*rate.getExtra4())+(s2.getExtra5()*rate.getExtra5())+(s2.getExtra6()*rate.getExtra6())+(s2.getChvli()*rate.getChvli())+(s2.getTel()*rate.getTel())+(s2.getMith()*rate.getMith())+(s2.getMirchi()*rate.getMirchi())+(s2.getHalad()*rate.getHalad())+(s2.getJire()*rate.getJire())+(s2.getMohari()*rate.getMohari());
%>
		<form  action="../create/create-invoice.jsp" accept-charset="ISO-8859-1" method="POST" onsubmit="return validate(this)">
            <input type="hidden" name="orderID" value="<%=orderID%>" >
            <input type="hidden" name="talukaID" value="<%=talukaID%>" >
            <input type="hidden" name="version" value="<%=version%>" >
            <input type="hidden" name="weightTotal" value="<%=weightTotal%>" >
            <input type="hidden" name="total" id="total" value="<%=amountTotal%>" >
            <input type="hidden" name="invoiceDate" id="invoiceDate" value="<%=previewDate%>" >
            <input type="hidden" name="orderType" id="orderType" value="<%=talukaOrderHelper.getOrderType()%>" >
            <p class="center">Bill Preview (Not for print)</p>
			<table border="0" width="100%">
                <tbody class="fontsize14">   
                	<tr>
                        <td class="left" width="75%"></td>
                        <td class="left" width="25%"><input type="text"  id="invoiceNumber"  name="invoiceNumber" ><input type="submit" name="create bill" value="बिल बनवा"></td>
                    </tr>                 
                    <tr>
                        <td class="left" width="75%">मे. गटशिक्षणाधिकारी अधिखक (शा पो आ)</td>
                        <td class="left" width="25%">तारीख : <%=previewDate %></td>
                    </tr>
                    <tr>
                        <td class="left" width="75%">पंचायत समिती कार्यालय, <b><%=talukaOrderHelper.getTalukaName()%></b></td>
                        <td class="left" width="25%">माहे <b><%=talukaOrderHelper.getFromMonth()%> - <%=talukaOrderHelper.getFromYear()%>  ते  <%=talukaOrderHelper.getToMonth()%> - <%=talukaOrderHelper.getToYear() %></b></td>
                    </tr>
                    <tr>
                        <td class="left" width="75%">जिल्हा - <b><%=talukaOrderHelper.getDistrictName()%></b></td>
                        <td class="left" width="25%">इयत्ता - <b><%=talukaOrderHelper.getOrderTypeDetails()%></b></td>
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
	                    <td>व्हॅट रक्कम रु. ५%</td>
	                    <td>बिलाची एकुण रक्कम रु</td>
	                </tr>
            	</thead>
            	<tbody class="fontsize15" class="center">
            		<tr class="fontMarathiNumber right">
            			<td> <center>1</center> </td>
            			<td> <center>मुंगदाळ</center> </td>
            			<td><%=threeDecimalFormatter.format(s2.getMungdaal())%></td>
            			<td><%=twoDecimalFormatter.format(rate.getMungdaal())%></td>
	                    <td><%if(vat.getMungdaal()!=0){out.print(twoDecimalFormatter.format((s2.getMungdaal())*((rate.getMungdaal()*vat.getMungdaal())/(100+vat.getMungdaal()))));} %></td>
	                    <td><%=twoDecimalFormatter.format(s2.getMungdaal()*rate.getMungdaal()) %></td>
            		</tr>
	                <tr class="fontMarathiNumber right">
	                	<td><center>2</center> </td>
	                	<td><center>तुर डाळ</center> </td>
	                	<td><%=threeDecimalFormatter.format(s2.getMatki()) %></td>
	                	<td><%=twoDecimalFormatter.format(rate.getMatki()) %></td>
	                    <td><%if(vat.getMatki()!=0){out.print(twoDecimalFormatter.format((s2.getMatki())*((rate.getMatki()*vat.getMatki())/(100+vat.getMatki()))));} %></td>
	                    <td><%=twoDecimalFormatter.format(s2.getMatki()*rate.getMatki()) %></td>            
	                </tr>
					<tr class="fontMarathiNumber right">
	                    <td><center>3</center></td>
	                    <td><center>मुंग</center></td>
	                    <td><%=threeDecimalFormatter.format(s2.getMung()) %></td>
	                    <td><%=twoDecimalFormatter.format(rate.getMung()) %> </td>
	                    <td><%if(vat.getMung()!=0){out.print(twoDecimalFormatter.format((s2.getMung())*((rate.getMung()*vat.getMung())/(100+vat.getMung()))));} %></td>
	                    <td><%=twoDecimalFormatter.format(s2.getMung()*rate.getMung()) %></td>
	                </tr>
	                <tr class="fontMarathiNumber right">
	                	<td><center>4</center></td>
	                    <td><center>मटकी</center></td>
	                    <td><%=threeDecimalFormatter.format(s2.getMasuldaal()) %></td>
	                    <td><%=twoDecimalFormatter.format(rate.getMasuldaal()) %></td>
	                    <td><%if(vat.getMasuldaal()!=0){out.print(twoDecimalFormatter.format((s2.getMasuldaal())*((rate.getMasuldaal()*vat.getMasuldaal())/(100+vat.getMasuldaal()))));} %></td>
	                    <td><%=twoDecimalFormatter.format(s2.getMasuldaal()*rate.getMasuldaal()) %></td>
	                </tr>
	                <tr class="fontMarathiNumber right">
	                	<td><center>5</center></td>
	                    <td><center>हरभरा</center></td>
	                    <td><%=threeDecimalFormatter.format(s2.getHarbara()) %></td>
	                    <td><%=twoDecimalFormatter.format(rate.getHarbara()) %></td>
	                    <td><%if(vat.getHarbara()!=0){out.print(twoDecimalFormatter.format((s2.getHarbara())*((rate.getHarbara()*vat.getHarbara())/(100+vat.getHarbara()))));} %></td>
	                    <td><%=twoDecimalFormatter.format(s2.getHarbara()*rate.getHarbara()) %></td>
	                </tr>
	                <tr class="fontMarathiNumber right">
	                	<td><center>6</center></td>
	                    <td><center>वटाणा</center></td>
	                    <td><%=threeDecimalFormatter.format(s2.getVatana()) %></td>
	                    <td><%=twoDecimalFormatter.format(rate.getVatana()) %></td>
	                    <td><%if(vat.getVatana()!=0){out.print(twoDecimalFormatter.format((s2.getVatana())*((rate.getVatana()*vat.getVatana())/(100+vat.getVatana()))));} %></td>
	                    <td><%=twoDecimalFormatter.format(s2.getVatana()*rate.getVatana()) %></td>
	                </tr>
                    <tr class="fontMarathiNumber right">
                    	<td><center>7</center></td>
	                    <td><center>सोया वडी</center></td>
                        <td><%=threeDecimalFormatter.format(s2.getExtra1()) %></td>
                        <td><%=twoDecimalFormatter.format(rate.getExtra1()) %></td>
                        <td><%if(vat.getExtra1()!=0){out.print(twoDecimalFormatter.format((s2.getExtra1())*((rate.getExtra1()*vat.getExtra1())/(100+vat.getExtra1()))));} %></td>
                        <td><%=twoDecimalFormatter.format(s2.getExtra1()*rate.getExtra1()) %></td>
                    </tr>
                    <tr class="fontMarathiNumber right">
                    	<td><center>8</center></td>
                        <td><center>Extra2</center></td>
                        <td><%=threeDecimalFormatter.format(s2.getExtra2()) %></td>
                        <td><%=twoDecimalFormatter.format(rate.getExtra2()) %></td>
                        <td><%if(vat.getExtra2()!=0){out.print(twoDecimalFormatter.format((s2.getExtra2())*((rate.getExtra2()*vat.getExtra2())/(100+vat.getExtra2()))));} %></td>
                        <td><%=twoDecimalFormatter.format(s2.getExtra2()*rate.getExtra2()) %></td>
                    </tr>
                    <tr class="fontMarathiNumber right">
                    	<td><center>9</center></td>
                        <td><center>Extra3</center></td>
                        <td><%=threeDecimalFormatter.format(s2.getExtra3()) %></td>
                        <td><%=twoDecimalFormatter.format(rate.getExtra3()) %></td>
                        <td><%if(vat.getExtra3()!=0){out.print(twoDecimalFormatter.format((s2.getExtra3())*((rate.getExtra3()*vat.getExtra3())/(100+vat.getExtra3()))));} %></td>
                        <td><%=twoDecimalFormatter.format(s2.getExtra3()*rate.getExtra3()) %></td>
                    </tr>
                    <tr class="fontMarathiNumber right">
                    	<td><center>10</center></td>
                        <td><center>Extra4</center></td>
                        <td><%=threeDecimalFormatter.format(s2.getExtra4()) %></td>
                        <td><%=twoDecimalFormatter.format(rate.getExtra4()) %></td>
                        <td><%if(vat.getExtra4()!=0){out.print(twoDecimalFormatter.format((s2.getExtra4())*((rate.getExtra4()*vat.getExtra4())/(100+vat.getExtra4()))));} %></td>
                        <td><%=twoDecimalFormatter.format(s2.getExtra4()*rate.getExtra4()) %></td>
                    </tr>
                    <tr class="fontMarathiNumber right">
                    	<td><center>11</center></td>
                        <td><center>Extra5</center></td>
                        <td><%=threeDecimalFormatter.format(s2.getExtra5()) %></td>
                        <td><%=twoDecimalFormatter.format(rate.getExtra5()) %></td>
                        <td><%if(vat.getExtra5()!=0){out.print(twoDecimalFormatter.format((s2.getExtra5())*((rate.getExtra5()*vat.getExtra5())/(100+vat.getExtra5()))));} %></td>
                        <td><%=twoDecimalFormatter.format(s2.getExtra5()*rate.getExtra5()) %></td>
                    </tr>
                    <tr class="fontMarathiNumber right">
                    	<td><center>12</center></td>
                        <td><center>Extra6</center></td>
                        <td><%=threeDecimalFormatter.format(s2.getExtra6()) %></td>
                        <td><%=twoDecimalFormatter.format(rate.getExtra6()) %></td>
                        <td><%if(vat.getExtra6()!=0){out.print(twoDecimalFormatter.format((s2.getExtra6())*((rate.getExtra6()*vat.getExtra6())/(100+vat.getExtra6()))));} %></td>
                        <td><%=twoDecimalFormatter.format(s2.getExtra6()*rate.getExtra6()) %></td>
                    </tr>
	                <tr class="fontMarathiNumber right">
	                    <td><center>13</center></td>
	                    <td><center>चवली</center></td>
	                    <td><%=threeDecimalFormatter.format(s2.getChvli()) %></td>
	                    <td><%=twoDecimalFormatter.format(rate.getChvli()) %></td>
	                    <td><%if(vat.getChvli()!=0){out.print(twoDecimalFormatter.format((s2.getChvli())*((rate.getChvli()*vat.getChvli())/(100+vat.getChvli()))));} %></td>
	                    <td><%=twoDecimalFormatter.format(s2.getChvli()*rate.getChvli()) %></td>
	                </tr>	                
	                <tr class="fontMarathiNumber right">
	                    <td><center>14</center></td>
	                    <td><center>तेल (सोया अॅगमार्क)</center></td>
	                    <td><%=threeDecimalFormatter.format(s2.getTel()) %></td>
	                    <td><%=twoDecimalFormatter.format(rate.getTel()) %></td>
	                    <td><%if(vat.getTel()!=0){out.print(twoDecimalFormatter.format((s2.getTel())*((rate.getTel()*vat.getTel())/(100+vat.getTel()))));} %></td>
	                    <td><%=twoDecimalFormatter.format(s2.getTel()*rate.getTel()) %></td>
	                </tr>	                
	                <tr class="fontMarathiNumber right">
	                	<td><center>15</center></td>
	                    <td><center>मीठ (आयोडिनयुक्त)</center></td>
	                    <td><%=threeDecimalFormatter.format(s2.getMith()) %></td>
	                    <td><%=twoDecimalFormatter.format(rate.getMith()) %></td>
	                    <td><%if(vat.getMith()!=0){out.print(twoDecimalFormatter.format((s2.getMith())*((rate.getMith()*vat.getMith())/(100+vat.getMith()))));} %></td>
	                    <td><%=twoDecimalFormatter.format(s2.getMith()*rate.getMith()) %></td>                
	                </tr>	                
	                <tr class="fontMarathiNumber right">
	                    <td><center>16</center></td>
	                    <td><center>कांदा लसूण मसाला</center></td>
	                    <td><%=threeDecimalFormatter.format(s2.getMirchi()) %></td>
	                    <td><%=twoDecimalFormatter.format(rate.getMirchi()) %></td>
	                    <td><%if(vat.getMirchi()!=0){out.print(twoDecimalFormatter.format((s2.getMirchi())*((rate.getMirchi()*vat.getMirchi())/(100+vat.getMirchi()))));} %></td>
	                    <td><%=twoDecimalFormatter.format(s2.getMirchi()*rate.getMirchi()) %></td>
	                </tr>	  	                              
	                <tr class="fontMarathiNumber right">
	                    <td><center>17</center></td>
	                    <td><center>हळद (अॅगमार्क)</center></td>
	                    <td><%=threeDecimalFormatter.format(s2.getHalad()) %></td>
	                    <td><%=twoDecimalFormatter.format(rate.getHalad()) %></td>
	                    <td><%if(vat.getHalad()!=0){out.print(twoDecimalFormatter.format((s2.getHalad())*((rate.getHalad()*vat.getHalad())/(100+vat.getHalad()))));} %></td>
	                    <td><%=twoDecimalFormatter.format(s2.getHalad()*rate.getHalad()) %></td>
	                </tr>	              
	                <tr class="fontMarathiNumber right">
	                    <td><center>18</center></td>
	                    <td><center>जिरे</center></td>
	                    <td><%=threeDecimalFormatter.format(s2.getJire()) %></td>
	                    <td><%=twoDecimalFormatter.format(rate.getJire()) %></td>
	                    <td><%if(vat.getJire()!=0){out.print(twoDecimalFormatter.format((s2.getJire())*((rate.getJire()*vat.getJire())/(100+vat.getJire()))));} %></td>
	                    <td><%=twoDecimalFormatter.format(s2.getJire()*rate.getJire()) %></td>
	                </tr>	                
	                <tr class="fontMarathiNumber right">
	                    <td><center>19</center></td>
	                    <td><center>मोहरी</center></td>
	                    <td ><%=threeDecimalFormatter.format(s2.getMohari()) %></td>
	                    <td><%=twoDecimalFormatter.format(rate.getMohari()) %></td>
	                    <td><%if(vat.getMohari()!=0){out.print(twoDecimalFormatter.format((s2.getMohari())*((rate.getMohari()*vat.getMohari())/(100+vat.getMohari()))));} %></td>
	                    <td><%=twoDecimalFormatter.format(s2.getMohari()*rate.getMohari()) %></td>
	                </tr>
	                <tr>
	                    <td colspan="2"><center><b>Total</b></center></td>
	                    <td class="fontMarathiNumber right"><b><%=threeDecimalFormatter.format(weightTotal) %></b></td>
	                    <td></td>
	                    <td class="fontMarathiNumber right"><b><%if(taxTotal!=0){out.print(twoDecimalFormatter.format(taxTotal));} %></b></td>
	                    <td class="fontMarathiNumber right"><b><%=twoDecimalFormatter.format(amountTotal) %></b></td>
	                </tr>
	                <tr class="fontMarathiNumber left">
	                    <td colspan="6"><b> अक्षरी रुपये -  <%=nm.convertToWord(amountTotal) %></b></td>
	                </tr>
	            </tbody>
    	    </table>
    	</form>
       	<hr class="noprint" style="color: red">
       	<p class="breakhere"></p>
       	<br><br>
<%
	}
	else
	{
%>
		<form  action="../create/create-invoice.jsp" accept-charset="ISO-8859-1" method="POST" onsubmit="return validate1(this)">
            <input type="hidden" name="orderID1" value="<%=orderID%>" >
            <input type="hidden" name="talukaID1" value="<%=talukaID%>" >
            <input type="hidden" name="version1" value="<%=version%>" >
            <input type="hidden" name="weightTotal1" value="<%=s2.getTandul()%>" >
            <input type="hidden" name="total1" id="total1" value="<%=(s2.getTandul()*kRate)%>" >
            <input type="hidden" name="total2" id="total2" value="<%=(s2.getTandul()*rRate)%>" >
            <input type="hidden" name="invoiceDate1" id="invoiceDate1" value="<%=previewDate%>" >
            <input type="hidden" name="orderType1" id="orderType1" value="<%=talukaOrderHelper.getOrderType()%>" >
            <p class="center">Bill Preview (Not for print)</p>
			<table border="0" width="100%">
                <tbody class="fontsize14">   
                	<tr>
                        <td class="right" width="75%"><b>केंद्र हिस्सा</b> <input type="text"  id="invoiceNumber1"  name="invoiceNumber1" > <b> राज्य हिस्सा </b> </td>
                        <td class="left" width="25%"> <input type="text"  id="invoiceNumber2"  name="invoiceNumber2" ><span id="msg"> </span><input type="submit" name="create bill" value="बिल बनवा"></td>
                    </tr>
                    <tr>
                        <td class="left" width="75%">मे. गटशिक्षणाधिकारी अधिखक (शा पो आ)</td>
                        <td class="left" width="25%">तारीख : <%=previewDate %></td>
                    </tr>
                    <tr>
                        <td class="left" width="75%">पंचायत समिती कार्यालय, <b><%=talukaOrderHelper.getTalukaName()%></b></td>
                        <td class="left" width="25%">माहे <b><%=talukaOrderHelper.getFromMonth()%> - <%=talukaOrderHelper.getFromYear()%>  ते  <%=talukaOrderHelper.getToMonth()%> - <%=talukaOrderHelper.getToYear() %></b></td>
                    </tr>
                    <tr>
                        <td class="left" width="75%">जिल्हा - <b><%=talukaOrderHelper.getDistrictName()%></b></td>
                        <td class="left" width="25%">इयत्ता - <b><%=talukaOrderHelper.getOrderTypeDetails()%></b></td>
                    </tr>
                    <tr>
                        <td class="left" colspan="2">&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="left" colspan="2">मा शिक्षणाधिकारी प्राथमिक जि प धुळे य़ांचे दि. <%= talukaOrderHelper.gettOrderDate() %> चे पुरवठा आदेशानुसार</td>
                    </tr>
                </tbody>
            </table>
            
<%
		for(int i =1; i<=2; i++)
		{
%>	
            <table border="0" width="100%">
                <tbody class="fontsize14">
                	<tr>
                        <td class="right" colspan="2"><%if(i==1){out.print("<b>(केंद्र हिस्सा)</b>");}else{out.print("<b>(राज्य हिस्सा)</b>");}%></td>
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
	                    <td>वाहतूक दर प्र-कि-ग्रॅम</td>
	                    <td>बिलाची एकुण रक्कम रु</td>
	                </tr>
            	</thead>
<%
			
			if(i==1)
			{
				tRate = kRate;
			}
			else
			{
				tRate = rRate;
			}
%>
            	<tbody class="fontsize15" class="center">
            		<tr class="fontMarathiNumber right" height="80">
            			<td> <center>1</center> </td>
            			<td> <center>शासकीय तांदुळ वाहतुक</center> </td>
            			<td><%=threeDecimalFormatter.format(s2.getTandul())%></td>
            			<td><%=twoDecimalFormatter.format(tRate)%></td>
            			<td><%=twoDecimalFormatter.format(s2.getTandul()*tRate)%></td>
            		</tr>
	                <tr>
	                	<td colspan="3" class="left fontMarathiNumber"><b> अक्षरी रुपये -  <%=nm.convertToWord(s2.getTandul()*tRate) %></b></td>
	                    <td ><center><b>Total</b></center></td>
            			<td class="right fontMarathiNumber"><%=twoDecimalFormatter.format(s2.getTandul()*tRate)%></td>
	                </tr>
	            </tbody>
    	    </table>    	    
        </form>
   	    <hr class="noprint" style="color: red">
       	<p class="breakhere"></p>
       	<br><br>
<%
		}
	}
%>
	</body>
</html>