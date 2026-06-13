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
            var date, invoiceNumber1, invoiceNumber2 ;
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
            	if(invoiceNumber.getValue().length == 0)
                {
                    return false;
                }
                return true;
            };
        </script>
    </head>
	<body>
<%
	int version;
	double kweightTotal = 0.0, rweightTotal = 0.0, kamountTotal = 0.0,ramountTotal = 0.0,tamountTotal = 0.0;
	NumberFormat twoDecimalFormatter = new DecimalFormat("#0.00");
	NumberFormat threeDecimalFormatter = new DecimalFormat("#0.000");
	NumberFormat zeroDecimalFormatter = new DecimalFormat("#");
	TalukaInvoice talukaInvoice = new InvoiceDS().readDistrictRiceSalesInvoice(Integer.parseInt(request.getParameter("invoiceID")));
	
	int orde1to5 = talukaInvoice.getOrderID();
	int orde6to8 = talukaInvoice.getOrderID1();
	String previewDate = talukaInvoice.getInvoiceDate();
	TalukaOrderDetailDSHelper dSHelper = new TalukaOrderDetailDSHelper();
	DispatchTalukaOrder t = dSHelper.districtOrderDetailsByID(orde1to5);
	DispatchTalukaOrder t1 = dSHelper.districtReturnDetailsByID(orde1to5);
	DispatchTalukaOrder t2 = dSHelper.districtOrderDetailsByID(orde6to8);
	DispatchTalukaOrder t3 = dSHelper.districtReturnDetailsByID(orde6to8);
	int flag = 0, counter = 0 ;
	if(t == null)
	{
		out.println("<h1>Taluka Order is Not Created for This District order</h1>");	
	}
	else
	{	
		if(t1 != null)
		{
			t.setMungdaal(t.getMungdaal()-t1.getMungdaal()+t2.getMungdaal()-t3.getMungdaal());
            t.setMatki(t.getMatki()-t1.getMatki()+t2.getMatki()-t3.getMatki());
            t.setMung(t.getMung()-t1.getMung()+t2.getMung()-t3.getMung());
            t.setMasuldaal(t.getMasuldaal()-t1.getMasuldaal()+t2.getMasuldaal()-t3.getMasuldaal());
            t.setHarbara(t.getHarbara()-t1.getHarbara()+t2.getHarbara()-t3.getHarbara());
            t.setVatana(t.getVatana()-t1.getVatana()+t2.getVatana()-t3.getVatana());
            t.setExtra1(t.getExtra1()-t1.getExtra1()+t2.getExtra1()-t3.getExtra1());
            t.setExtra2(t.getExtra2()-t1.getExtra2()+t2.getExtra2()-t3.getExtra2());
            t.setExtra3(t.getExtra3()-t1.getExtra3()+t2.getExtra3()-t3.getExtra3());
            t.setExtra4(t.getExtra4()-t1.getExtra4()+t2.getExtra4()-t3.getExtra4());
            t.setExtra5(t.getExtra5()-t1.getExtra5()+t2.getExtra5()-t3.getExtra5());
            t.setExtra6(t.getExtra6()-t1.getExtra6()+t2.getExtra6()-t3.getExtra6());
            t.setChvli(t.getChvli()-t1.getChvli()+t2.getChvli()-t3.getChvli());
            t.setTel(t.getTel()-t1.getTel()+t2.getTel()-t3.getTel());
            t.setMith(t.getMith()-t1.getMith()+t2.getMith()-t3.getMith());
            t.setMirchi(t.getMirchi()-t1.getMirchi()+t2.getMirchi()-t3.getMirchi());
            t.setHalad(t.getHalad()-t1.getHalad()+t2.getHalad()-t3.getHalad());
            t.setJire(t.getJire()-t1.getJire()+t2.getJire()-t3.getJire());
            t.setMohari(t.getMohari()-t1.getMohari()+t2.getMohari()-t3.getMohari());
            t.setTandul(t.getTandul()-t1.getTandul()+t2.getTandul()-t3.getTandul());  		
			ArrayList<Item> itemList = new InvoiceDS().getAllItemByVersion(previewDate);
			version = itemList.get(0).getVersion();
			DispatchTalukaOrder rate = new DispatchTalukaOrder();
			DispatchTalukaOrder vat = new DispatchTalukaOrder();
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
		        	rate.setTandul(i.getRatePerKg());
		        	vat.setTandul(i.getVat());
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
			NumberToMarathiWord nm = new NumberToMarathiWord();
			double weight1 = 0.0, weight2 = 0.0, vattotal1 = 0.0, total1 = 0.0, total2 = 0.0;
      total1 = (t.getMungdaal()*(rate.getMungdaal()-(rate.getMungdaal()*1/100)))+(t.getMatki()*(rate.getMatki()-(rate.getMatki()*1/100)))+(t.getMung()*(rate.getMung()-(rate.getMung()*1/100)))+(t.getMasuldaal()*(rate.getMasuldaal()-(rate.getMasuldaal()*1/100)))+(t.getHarbara()*(rate.getHarbara()-(rate.getHarbara()*1/100)))+(t.getVatana()*(rate.getVatana()-(rate.getVatana()*1/100)))+(t.getExtra1()*(rate.getExtra1()-(rate.getExtra1()*1/100)))+(t.getExtra2()*(rate.getExtra2()-(rate.getExtra2()*1/100)))+(t.getExtra3()*(rate.getExtra3()-(rate.getExtra3()*1/100)))+(t.getExtra4()*(rate.getExtra4()-(rate.getExtra4()*1/100)))+(t.getExtra5()*(rate.getExtra5()-(rate.getExtra5()*1/100)))+(t.getExtra6()*(rate.getExtra6()-(rate.getExtra6()*1/100)))+(t.getChvli()*(rate.getChvli()-(rate.getChvli()*1/100)))+(t.getMith()*(rate.getMith()-(rate.getMith()*1/100)))+(t.getMirchi()*(rate.getMirchi()-(rate.getMirchi()*1/100)))+(t.getHalad()*(rate.getHalad()-(rate.getHalad()*1/100)));
      total2 = (t.getTel()*(rate.getTel()-(rate.getTel()*1/100)))+(t.getJire()*(rate.getJire()-(rate.getJire()*1/100)))+(t.getMohari()*(rate.getMohari()-(rate.getMohari()*1/100)))+(t.getMirchi()*(rate.getMirchi()-(rate.getMirchi()*1/100)));
      weight1 = (t.getMungdaal())+(t.getMatki())+(t.getMung())+(t.getMasuldaal())+(t.getHarbara())+(t.getVatana())+(t.getExtra1())+(t.getExtra2())+(t.getExtra3())+(t.getExtra4())+(t.getExtra5())+(t.getExtra6())+(t.getChvli())+(t.getMith())+(t.getMirchi())+(t.getHalad());
			weight2 = (t.getTel())+(t.getJire())+(t.getMohari())+(t.getMirchi());
			vattotal1 = ((t.getTel())*(((rate.getTel()-(rate.getTel()*1/100))*vat.getTel())/(100+vat.getTel())))+((t.getJire())*(((rate.getJire()-(rate.getJire()*1/100))*vat.getJire())/(100+vat.getJire())))+((t.getMohari())*(((rate.getMohari()-(rate.getMohari()*1/100))*vat.getMohari())/(100+vat.getMohari())))+((t.getMirchi())*(((rate.getMirchi()-(rate.getMirchi()*1/100))*vat.getMirchi())/(100+vat.getMirchi())));
			if(version == 1)
			{
%>			            
	    <table border="0" width="100%">
			<tr>
                <td class="left" width="50%">धुळेच्या न्याय कशाकक्षा अंतर्गत </td>
                <td class="right" width="50%">फॅक्टरी - ०२५६२-२३९४७७</td>
            </tr> 
			<tr>
                <td class="left" width="50%"></td>
                <td class="right" width="50%">आॅफीस - ०२५६२-२३६०७७</td>
            </tr> 
		</table>
        <center> <font class="fontsize24Bold"> <b>गणेश इंटरप्राइजेस</b></font><br>
       	 	डि-१८९, एमआयडीसी अवधान धुळे<br>
        TAX INVOICE<br>
        	कॅश क्रेडिट मेमो</center>	       
		<table border="0" width="100%">
             <tbody class="fontsize14">   
             	<tr>
                     <td class="left" width="65%"> बील क्रमांक :- <b>  शा पो आ शा तां - <%=talukaInvoice.getInvoiceIDMan1() %> </b></td>
                     <td class="left" width="35%">तारीख :<b> <%=previewDate %> </b> </td>
                 </tr> 
	             <tr>
                     <td class="left" width="65%">प्रति,</td>
                     <td class="left" width="35%"></td>
	             </tr> 
	             <tr>
                     <td class="left" width="65%">केंद्रीय भांडार</td>
                     <td class="left" width="35%">(<%=t.getDistrictName()%> जिल्हा शा पो आ तादुळ वाहतुक)</td>
	             </tr>
	             <tr>
	                 <td class="left" width="65%">ऑफिस : १०२, पहिला मजला, बीजीटीए गोदावरी, प्लॉट नं. जी-१, वडाळा ट्रॅक टर्मिनल, सायन, मुंबई, महाराष्ट्र - ४०००३७ </td>
	                 <td class="left" width="25%">माहे <b><%=t.getFromMonth()%> - <%=t.getFromMonthYear()%>  ते  <%=t.getToMonth()%> - <%=t.getToMonthYear() %></b></td>
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
                    <td>बिलाची एकुण रक्कम रु</td>
                </tr>
           	</thead>
           	<tbody class="fontsize15" class="center">
           		<tr class="fontMarathiNumber right">
           			<td> <center>1</center> </td>
           			<td> <center>मुंगदाळ</center> </td>
           			<td><%=threeDecimalFormatter.format(t.getMungdaal())%></td>
           			<td><%=twoDecimalFormatter.format(rate.getMungdaal()-(rate.getMungdaal()*1/100))%></td>
                    <td><%=twoDecimalFormatter.format(t.getMungdaal()*(rate.getMungdaal()-(rate.getMungdaal()*1/100))) %></td>
           		</tr>
                <tr class="fontMarathiNumber right">
                	<td><center>2</center> </td>
                	<td><center>तुर डाळ</center> </td>
                	<td><%=threeDecimalFormatter.format(t.getMatki()) %></td>
                	<td><%=twoDecimalFormatter.format(rate.getMatki()-(rate.getMatki()*1/100)) %></td>
                    <td><%=twoDecimalFormatter.format(t.getMatki()*(rate.getMatki()-(rate.getMatki()*1/100))) %></td>            
                </tr>
                <tr class="fontMarathiNumber right">
                    <td><center>3</center></td>
                    <td><center>Extra2</center></td>
                    <td><%=threeDecimalFormatter.format(t.getExtra2()) %></td>
                    <td><%=twoDecimalFormatter.format(rate.getExtra2()-(rate.getExtra2()*1/100)) %></td>
                    <td><%=twoDecimalFormatter.format(t.getExtra2()*(rate.getExtra2()-(rate.getExtra2()*1/100))) %></td>
                </tr>
                <tr class="fontMarathiNumber right">
                    <td><center>4</center></td>
                    <td><center>मुंग</center></td>
                    <td><%=threeDecimalFormatter.format(t.getMung()) %></td>
                    <td><%=twoDecimalFormatter.format(rate.getMung()-(rate.getMung()*1/100)) %> </td>
                    <td><%=twoDecimalFormatter.format(t.getMung()*(rate.getMung()-(rate.getMung()*1/100))) %></td>
                </tr>
                <tr class="fontMarathiNumber right">
                 	<td><center>5</center></td>
                    <td><center>मटकी</center></td>
                    <td><%=threeDecimalFormatter.format(t.getMasuldaal()) %></td>
                    <td><%=twoDecimalFormatter.format(rate.getMasuldaal()-(rate.getMasuldaal()*1/100)) %></td>
                    <td><%=twoDecimalFormatter.format(t.getMasuldaal()*(rate.getMasuldaal()-(rate.getMasuldaal()*1/100))) %></td>
                </tr>
                <tr class="fontMarathiNumber right">
                 	<td><center>6</center></td>
                    <td><center>हरभरा</center></td>
                    <td><%=threeDecimalFormatter.format(t.getHarbara()) %></td>
                    <td><%=twoDecimalFormatter.format(rate.getHarbara()-(rate.getHarbara()*1/100)) %></td>
                    <td><%=twoDecimalFormatter.format(t.getHarbara()*(rate.getHarbara()-(rate.getHarbara()*1/100))) %></td>
                </tr>
                <!--
                <tr class="fontMarathiNumber right">
                    <td><center>7</center></td>
                    <td><center>Extra3</center></td>
                    <td><%=threeDecimalFormatter.format(t.getExtra3()) %></td>
                    <td><%=twoDecimalFormatter.format(rate.getExtra3()-(rate.getExtra3()*1/100)) %></td>
                    <td><%=twoDecimalFormatter.format((t.getExtra3())*(((rate.getExtra3()-(rate.getExtra3()*1/100))*vat.getExtra3())/(100+vat.getExtra3()))) %></td>
                    <td><%=twoDecimalFormatter.format(t.getExtra3()*(rate.getExtra3()-(rate.getExtra3()*1/100))) %></td>
                </tr>
                <tr class="fontMarathiNumber right">
                    <td><center>8</center></td>
                    <td><center>Extra4</center></td>
                    <td><%=threeDecimalFormatter.format(t.getExtra4()) %></td>
                    <td><%=twoDecimalFormatter.format(rate.getExtra4()-(rate.getExtra4()*1/100)) %></td>
                    <td><%=twoDecimalFormatter.format(vat.getExtra4()) %></td>
                    <td><%=twoDecimalFormatter.format((t.getExtra4())*(((rate.getExtra4()-(rate.getExtra4()*1/100))*vat.getExtra4())/(100+vat.getExtra4()))) %></td>
                    <td><%=twoDecimalFormatter.format(t.getExtra4()*(rate.getExtra4()-(rate.getExtra4()*1/100))) %></td>
                </tr>
                <tr class="fontMarathiNumber right">
                    <td><center>9</center></td>
                    <td><center>Extra5</center></td>
                    <td><%=threeDecimalFormatter.format(t.getExtra5()) %></td>
                    <td><%=twoDecimalFormatter.format(rate.getExtra5()-(rate.getExtra5()*1/100)) %></td>
                    <td><%=twoDecimalFormatter.format(vat.getExtra5()) %></td>
                    <td><%=twoDecimalFormatter.format((t.getExtra5())*(((rate.getExtra5()-(rate.getExtra5()*1/100))*vat.getExtra5())/(100+vat.getExtra5()))) %></td>
                    <td><%=twoDecimalFormatter.format(t.getExtra5()*(rate.getExtra5()-(rate.getExtra5()*1/100))) %></td>
                </tr>
                <tr class="fontMarathiNumber right">
                    <td><center>10</center></td>
                    <td><center>Extra6</center></td>
                    <td><%=threeDecimalFormatter.format(t.getExtra6()) %></td>
                    <td><%=twoDecimalFormatter.format(rate.getExtra6()-(rate.getExtra6()*1/100)) %></td>
                    <td><%=twoDecimalFormatter.format(vat.getExtra6()) %></td>
                    <td><%=twoDecimalFormatter.format((t.getExtra6())*(((rate.getExtra6()-(rate.getExtra6()*1/100))*vat.getExtra6())/(100+vat.getExtra6()))) %></td>
                    <td><%=twoDecimalFormatter.format(t.getExtra6()*(rate.getExtra6()-(rate.getExtra6()*1/100))) %></td>
                </tr>
                -->
            	<tr>
                	<td colspan="2" class="left"><b> Total </b></td>
                	<td  class="fontMarathiNumber right"><b><%=threeDecimalFormatter.format(weight1)%></b></td>
                	<td></td>
                	<td  class="fontMarathiNumber right"><b><%=twoDecimalFormatter.format(total1) %></b></td>
                </tr>
                <tr class="fontMarathiNumber">
                	<td colspan="5" class="left"><b> अक्षरी रुपये -  <%=nm.convertToWord((total1)) %></b></td>
                </tr>
            </tbody>
   	    </table> 
   	    <font class="fontsize14">
      		वरील दरात लागन्या सर्व करांचा समावेश अाहे -<br>
      	I /We hereby certify that my/our registration certificate under the Maharashtra Value 
      	Added Tax Act 2002 is in force on the date on which the sale of the goods specified in 
      	this Invoice id made by me/us that the transaction of sale covered by this Invoice has 
      	been effected by me/us it shall be accounted for in the turnover of sales while filling 
      	of return and the due tax ,if any payable on the sale has been paid or shall be paid E$ O.E <br>
      	CST TIN No. :- 27AADFG1586E1ZI<br>
      	TIN NO.  :- 27AADFG1586E1ZI</font>
      	<table border="0" width="100%">
			<tr>
                <td class="left" width="33%">&nbsp;</td>
                <td class="center" width="33%">&nbsp;</td>
                <td class="center" width="33%"><center>कगणेश इंटरप्राइजेस</center></td>
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
       	<br><br>
   	    <hr class="noprint" style="color: red">
       	<br><br>
      	<p class="breakhere"></p>
       	
       	<table border="0" width="100%">
			<tr>
                <td class="left" width="50%">धुळेच्या न्याय कशाकक्षा अंतर्गत </td>
                <td class="right" width="50%">फॅक्टरी - ०२५६२-२३९४७७</td>
            </tr> 
			<tr>
                <td class="left" width="50%"></td>
                <td class="right" width="50%">आॅफीस - ०२५६२-२३६०७७</td>
            </tr> 
		</table>
        <center> <font class="fontsize24Bold"> <b>गणेश इंटरप्राइजेस </b></font><br>
       	 	डि-१८९, एमआयडीसी अवधान धुळे<br>
        TAX INVOICE<br>
        	कॅश क्रेडिट मेमो</center>	       
		<table border="0" width="100%">
             <tbody class="fontsize14">   
             	<tr>
                     <td class="left" width="65%"> बील क्रमांक :- <b>  शा पो आ शा तां - <%=talukaInvoice.getInvoiceIDMan2() %> </b></td>
                     <td class="left" width="35%">तारीख :<b> <%=previewDate %> </b> </td>
                 </tr> 
	             <tr>
                     <td class="left" width="65%">प्रति,</td>
                     <td class="left" width="35%"></td>
	             </tr> 
	             <tr>
                     <td class="left" width="65%"> केंद्रीय भांडार</td>
                     <td class="left" width="35%">(<%=t.getDistrictName()%> जिल्हा शा पो आ तादुळ वाहतुक)</td>
	             </tr>
	             <tr>
	                 <td class="left" width="65%">ऑफिस : १०२, पहिला मजला, बीजीटीए गोदावरी, प्लॉट नं. जी-१, वडाळा ट्रॅक टर्मिनल, सायन, मुंबई, महाराष्ट्र - ४०००३७ </td>
	                 <td class="left" width="25%">माहे <b><%=t.getFromMonth()%> - <%=t.getFromMonthYear()%>  ते  <%=t.getToMonth()%> - <%=t.getToMonthYear() %></b></td>
		         </tr>
	         </tbody>
		</table>
       	
   	    <table  class="printstyle fontsize15"  width="800">
           	<thead class="fontsize16Bold">
           		<tr class="center">
                    <td>अ. क्र.</td>
                    <td>मालाचा तपशिल</td>
                    <td>वजन कि-ग्रॅम / लिटर</td>
                    <td>दर प्र-कि-ग्रॅम</td>
                    <td>व्हॅट रक्कम रु. ६%</td>
                    <td>बिलाची एकुण रक्कम रु</td>
                </tr>
           	</thead>
           	<tbody class="fontsize15" class="center">            		          
                <tr class="fontMarathiNumber right">
                    <td><center>1</center></td>
                    <td><center>तेल (सोया अॅगमार्क)</center></td>
                    <td><%=threeDecimalFormatter.format(t.getTel()) %></td>
                    <td><%=twoDecimalFormatter.format(rate.getTel()-(rate.getTel()*1/100)) %></td>
                    <td><%=twoDecimalFormatter.format((t.getTel())*(((rate.getTel()-(rate.getTel()*1/100))*vat.getTel())/(100+vat.getTel()))) %></td>
                    <td><%=twoDecimalFormatter.format(t.getTel()*(rate.getTel()-(rate.getTel()*1/100))) %></td>
                </tr>	                    
                <tr class="fontMarathiNumber right">
                    <td><center>2</center></td>
                    <td><center>जिरे</center></td>
                    <td><%=threeDecimalFormatter.format(t.getJire()) %></td>
                    <td><%=twoDecimalFormatter.format(rate.getJire()-(rate.getJire()*1/100)) %></td>
                    <td><%=twoDecimalFormatter.format((t.getJire())*(((rate.getJire()-(rate.getJire()*1/100))*vat.getJire())/(100+vat.getJire()))) %></td>
                    <td><%=twoDecimalFormatter.format(t.getJire()*(rate.getJire()-(rate.getJire()*1/100))) %></td>
                </tr>	                
                <tr class="fontMarathiNumber right">
                    <td><center>3</center></td>
                    <td><center>मोहरी</center></td>
                    <td ><%=threeDecimalFormatter.format(t.getMohari()) %></td>
                    <td><%=twoDecimalFormatter.format(rate.getMohari()-(rate.getMohari()*1/100)) %></td>
                    <td><%=twoDecimalFormatter.format((t.getMohari())*(((rate.getMohari()-(rate.getMohari()*1/100))*vat.getMohari())/(100+vat.getMohari()))) %></td>
                    <td><%=twoDecimalFormatter.format(t.getMohari()*(rate.getMohari()-(rate.getMohari()*1/100))) %></td>
                </tr>
                <tr>
                	<td colspan="2" class="left"><b> Total </b></td>
                	<td  class="fontMarathiNumber right"><b><%=threeDecimalFormatter.format(weight2)%></b></td>
                	<td></td>
                	<td  class="fontMarathiNumber right"><b><%=twoDecimalFormatter.format(vattotal1) %></b></td>
                	<td  class="fontMarathiNumber right"><b><%=twoDecimalFormatter.format(total2) %></b></td>
                </tr>
                <tr class="fontMarathiNumber">
                	<td colspan="6" class="left"><b> अक्षरी रुपये -  <%=nm.convertToWord((total2)) %></b></td>
                </tr>
            </tbody>
   	    </table>
   	    <font class="fontsize14">
      		वरील दरात लागन्या सर्व करांचा समावेश अाहे -<br>
      	I /We hereby certify that my/our registration certificate under the Maharashtra Value 
      	Added Tax Act 2002 is in force on the date on which the sale of the goods specified in 
      	this Invoice id made by me/us that the transaction of sale covered by this Invoice has 
      	been effected by me/us it shall be accounted for in the turnover of sales while filling 
      	of return and the due tax ,if any payable on the sale has been paid or shall be paid E$ O.E <br>
      	CST TIN No. :- 27AADFG1586E1ZI<br>
      	TIN NO.  :- 27AADFG1586E1ZI</font>
      	<table border="0" width="100%">
			<tr>
                <td class="left" width="33%">&nbsp;</td>
                <td class="center" width="33%">&nbsp;</td>
                <td class="center" width="33%"><center>गणेश इंटरप्राइजेस</center></td>
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
       	<br><br>
   	    <hr class="noprint" style="color: red">
<%			
			}
			else
			{
%>
		<table border="0" width="100%">
			<tr>
                <td class="left" width="50%">धुळेच्या न्याय कशाकक्षा अंतर्गत </td>
                <td class="right" width="50%">फॅक्टरी - ०२५६२-२३९४७७</td>
            </tr> 
			<tr>
                <td class="left" width="50%"></td>
                <td class="right" width="50%">आॅफीस - ०२५६२-२३६०७७</td>
            </tr> 
		</table>
        <center> <font class="fontsize24Bold"> <b> गणेश इंटरप्राइजेस </b></font><br>
       	 	डि-१८९, एमआयडीसी अवधान धुळे<br>
        TAX INVOICE<br>
        	कॅश क्रेडिट मेमो</center>	       
		<table border="0" width="100%">
             <tbody class="fontsize14">   
             	<tr>
                     <td class="left" width="65%"> बील क्रमांक :- <b>  शा पो आ शा तां - <%=talukaInvoice.getInvoiceIDMan1() %> </b></td>
                     <td class="left" width="35%">तारीख :<b> <%=previewDate %> </b> </td>
                 </tr> 
	             <tr>
                     <td class="left" width="65%">प्रति,</td>
                     <td class="left" width="35%"></td>
	             </tr> 
	             <tr>
                     <td class="left" width="65%"> केंद्रीय भांडार</td>
                     <td class="left" width="35%">(<%=t.getDistrictName()%> जिल्हा शा पो आ तादुळ वाहतुक)</td>
	             </tr>
	             <tr>
	                 <td class="left" width="65%">ऑफिस : १०२, पहिला मजला, बीजीटीए गोदावरी, प्लॉट नं. जी-१, वडाळा ट्रॅक टर्मिनल, सायन, मुंबई, महाराष्ट्र - ४०००३७ </td>
	                 <td class="left" width="25%">माहे <b><%=t.getFromMonth()%> - <%=t.getFromMonthYear()%>  ते  <%=t.getToMonth()%> - <%=t.getToMonthYear() %></b></td>
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
                    <td>बिलाची एकुण रक्कम रु</td>
                </tr>
           	</thead>
           	<tbody class="fontsize15" class="center">
           		<tr class="fontMarathiNumber right">
           			<td> <center>1</center> </td>
           			<td> <center>मुंगदाळ</center> </td>
           			<td><%=threeDecimalFormatter.format(t.getMungdaal())%></td>
           			<td><%=twoDecimalFormatter.format(rate.getMungdaal()-(rate.getMungdaal()*1/100))%></td>
                    <td><%=twoDecimalFormatter.format(t.getMungdaal()*(rate.getMungdaal()-(rate.getMungdaal()*1/100))) %></td>
           		</tr>
                <tr class="fontMarathiNumber right">
                	<td><center>2</center> </td>
                	<td><center>तुर डाळ</center> </td>
                	<td><%=threeDecimalFormatter.format(t.getMatki()) %></td>
                	<td><%=twoDecimalFormatter.format(rate.getMatki()-(rate.getMatki()*1/100)) %></td>
                    <td><%=twoDecimalFormatter.format(t.getMatki()*(rate.getMatki()-(rate.getMatki()*1/100))) %></td>            
                </tr>
                <tr class="fontMarathiNumber right">
                    <td><center>3</center></td>
                    <td><center>मुंग</center></td>
                    <td><%=threeDecimalFormatter.format(t.getMung()) %></td>
                    <td><%=twoDecimalFormatter.format(rate.getMung()-(rate.getMung()*1/100)) %> </td>
                    <td><%=twoDecimalFormatter.format(t.getMung()*(rate.getMung()-(rate.getMung()*1/100))) %></td>
                </tr>
                <tr class="fontMarathiNumber right">
                	<td><center>4</center></td>
                    <td><center>मटकी</center></td>
                    <td><%=threeDecimalFormatter.format(t.getMasuldaal()) %></td>
                    <td><%=twoDecimalFormatter.format(rate.getMasuldaal()-(rate.getMasuldaal()*1/100)) %></td>
                    <td><%=twoDecimalFormatter.format(t.getMasuldaal()*(rate.getMasuldaal()-(rate.getMasuldaal()*1/100))) %></td>
                </tr>
                <tr class="fontMarathiNumber right">
                	<td><center>5</center></td>
                    <td><center>हरभरा</center></td>
                    <td><%=threeDecimalFormatter.format(t.getHarbara()) %></td>
                    <td><%=twoDecimalFormatter.format(rate.getHarbara()-(rate.getHarbara()*1/100)) %></td>
                    <td><%=twoDecimalFormatter.format(t.getHarbara()*(rate.getHarbara()-(rate.getHarbara()*1/100))) %></td>
                </tr>
                <tr class="fontMarathiNumber right">
                	<td><center>6</center></td>
                    <td><center>वटाणा</center></td>
                    <td><%=threeDecimalFormatter.format(t.getVatana()) %></td>
                    <td><%=twoDecimalFormatter.format(rate.getVatana()-(rate.getVatana()*1/100)) %></td>
                    <td><%=twoDecimalFormatter.format(t.getVatana()*(rate.getVatana()-(rate.getVatana()*1/100))) %></td>
                </tr>
                <tr class="fontMarathiNumber right">
                    <td><center>7</center></td>
                    <td><center>चवली</center></td>
                    <td><%=threeDecimalFormatter.format(t.getChvli()) %></td>
                    <td><%=twoDecimalFormatter.format(rate.getChvli()-(rate.getChvli()*1/100)) %></td>
                    <td><%=twoDecimalFormatter.format(t.getChvli()*(rate.getChvli()-(rate.getChvli()*1/100))) %></td>
                </tr>	            
                <tr class="fontMarathiNumber right">
                	<td><center>8</center></td>
                    <td><center>मीठ (आयोडिनयुक्त)</center></td>
                    <td><%=threeDecimalFormatter.format(t.getMith()) %></td>
                    <td><%=twoDecimalFormatter.format(rate.getMith()-(rate.getMith()*1/100)) %></td>
                    <td><%=twoDecimalFormatter.format(t.getMith()*(rate.getMith()-(rate.getMith()*1/100))) %></td>                
                </tr>	                              
            	<tr>
                	<td colspan="2" class="left"><b> Total </b></td>
                	<td  class="fontMarathiNumber right"><b><%=threeDecimalFormatter.format(weight1)%></b></td>
                	<td></td>
                	<td  class="fontMarathiNumber right"><b><%=twoDecimalFormatter.format(total1) %></b></td>
                </tr>
                <tr class="fontMarathiNumber">
                	<td colspan="5" class="left"><b> अक्षरी रुपये -  <%=nm.convertToWord((total1)) %></b></td>
                </tr>
            </tbody>
   	    </table> 
   	    <font class="fontsize14">
      		वरील दरात लागन्या सर्व करांचा समावेश अाहे -<br>
      	I /We hereby certify that my/our registration certificate under the Maharashtra Value 
      	Added Tax Act 2002 is in force on the date on which the sale of the goods specified in 
      	this Invoice id made by me/us that the transaction of sale covered by this Invoice has 
      	been effected by me/us it shall be accounted for in the turnover of sales while filling 
      	of return and the due tax ,if any payable on the sale has been paid or shall be paid E$ O.E <br>
      	CST TIN No. :- 27AADFG1586E1ZI<br>
      	TIN NO.  :- 27AADFG1586E1ZI</font>
      	<table border="0" width="100%">
			<tr>
                <td class="left" width="33%">&nbsp;</td>
                <td class="center" width="33%">&nbsp;</td>
                <td class="center" width="33%"><center>गणेश इंटरप्राइजेस</center></td>
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
       	<br><br>
   	    <hr class="noprint" style="color: red">
       	<br><br>
      	<p class="breakhere"></p>
       	
       	<table border="0" width="100%">
			<tr>
                <td class="left" width="50%">धुळेच्या न्याय कशाकक्षा अंतर्गत </td>
                <td class="right" width="50%">फॅक्टरी - ०२५६२-२३९४७७</td>
            </tr> 
			<tr>
                <td class="left" width="50%"></td>
                <td class="right" width="50%">आॅफीस - ०२५६२-२३६०७७</td>
            </tr> 
		</table>
        <center> <font class="fontsize24Bold"> <b>गणेश इंटरप्राइजेस</b></font><br>
       	 	डि-१८९, एमआयडीसी अवधान धुळे<br>
        TAX INVOICE<br>
        	कॅश क्रेडिट मेमो</center>	       
		<table border="0" width="100%">
             <tbody class="fontsize14">   
             	<tr>
                     <td class="left" width="65%"> बील क्रमांक :- <b>  शा पो आ शा तां - <%=talukaInvoice.getInvoiceIDMan2() %> </b></td>
                     <td class="left" width="35%">तारीख :<b> <%=previewDate %> </b> </td>
                 </tr> 
	             <tr>
                     <td class="left" width="65%">प्रति,</td>
                     <td class="left" width="35%"></td>
	             </tr> 
	             <tr>
                     <td class="left" width="65%"> केंद्रीय भांडार</td>
                     <td class="left" width="35%">(<%=t.getDistrictName()%> जिल्हा शा पो आ तादुळ वाहतुक)</td>
	             </tr>
	             <tr>
	                 <td class="left" width="65%">ऑफिस : १०२, पहिला मजला, बीजीटीए गोदावरी, प्लॉट नं. जी-१, वडाळा ट्रॅक टर्मिनल, सायन, मुंबई, महाराष्ट्र - ४०००३७ </td>
	                 <td class="left" width="25%">माहे <b><%=t.getFromMonth()%> - <%=t.getFromMonthYear()%>  ते  <%=t.getToMonth()%> - <%=t.getToMonthYear() %></b></td>
		         </tr>
	         </tbody>
		</table>
       	
   	    <table  class="printstyle fontsize15"  width="800">
           	<thead class="fontsize16Bold">
           		<tr class="center">
                    <td>अ. क्र.</td>
                    <td>मालाचा तपशिल</td>
                    <td>वजन कि-ग्रॅम / लिटर</td>
                    <td>दर प्र-कि-ग्रॅम</td>
                    <td>व्हॅट %</td>
                    <td>व्हॅट रक्कम रु.</td>
                    <td>बिलाची एकुण रक्कम रु</td>
                </tr>
           	</thead>
           	<tbody class="fontsize15" class="center">            		          
                <tr class="fontMarathiNumber right">
                    <td><center>1</center></td>
                    <td><center>तेल (सोया अॅगमार्क)</center></td>
                    <td><%=threeDecimalFormatter.format(t.getTel()) %></td>
                    <td><%=twoDecimalFormatter.format(rate.getTel()-(rate.getTel()*1/100)) %></td>
                    <td><%=twoDecimalFormatter.format(vat.getTel())%></td>
                    <td><%=twoDecimalFormatter.format((t.getTel())*(((rate.getTel()-(rate.getTel()*1/100))*vat.getTel())/(100+vat.getTel()))) %></td>
                    <td><%=twoDecimalFormatter.format(t.getTel()*(rate.getTel()-(rate.getTel()*1/100))) %></td>
                </tr>	                    
                <tr class="fontMarathiNumber right">
                    <td><center>2</center></td>
                    <td><center>जिरे</center></td>
                    <td><%=threeDecimalFormatter.format(t.getJire()) %></td>
                    <td><%=twoDecimalFormatter.format(rate.getJire()-(rate.getJire()*1/100)) %></td>
                    <td><%=twoDecimalFormatter.format(vat.getJire()) %></td>
                    <td><%=twoDecimalFormatter.format((t.getJire())*(((rate.getJire()-(rate.getJire()*1/100))*vat.getJire())/(100+vat.getJire()))) %></td>
                    <td><%=twoDecimalFormatter.format(t.getJire()*(rate.getJire()-(rate.getJire()*1/100))) %></td>
                </tr>	                
                <tr class="fontMarathiNumber right">
                    <td><center>3</center></td>
                    <td><center>मोहरी</center></td>
                    <td ><%=threeDecimalFormatter.format(t.getMohari()) %></td>
                    <td><%=twoDecimalFormatter.format(rate.getMohari()-(rate.getMohari()*1/100)) %></td>
                    <td><%=twoDecimalFormatter.format(vat.getMohari()) %></td>
                    <td><%=twoDecimalFormatter.format((t.getMohari())*(((rate.getMohari()-(rate.getMohari()*1/100))*vat.getMohari())/(100+vat.getMohari()))) %></td>
                    <td><%=twoDecimalFormatter.format(t.getMohari()*(rate.getMohari()-(rate.getMohari()*1/100))) %></td>
                </tr>	                
                <tr class="fontMarathiNumber right">
                    <td><center>4</center></td>
                    <td><center>कांदा लसूण मसाला</center></td>
                    <td><%=threeDecimalFormatter.format(t.getMirchi()) %></td>
                    <td><%=twoDecimalFormatter.format(rate.getMirchi()-(rate.getMirchi()*1/100)) %></td>
                    <td><%=twoDecimalFormatter.format(vat.getMirchi()) %></td>
                    <td><%=twoDecimalFormatter.format((t.getMirchi())*(((rate.getMirchi()-(rate.getMirchi()*1/100))*vat.getMirchi())/(100+vat.getMirchi()))) %></td>
                    <td><%=twoDecimalFormatter.format(t.getMirchi()*(rate.getMirchi()-(rate.getMirchi()*1/100))) %></td>
                </tr>	  
                <tr class="fontMarathiNumber right">
                    <td><center>5</center></td>
                    <td><center>सोया वडी</center></td>
                    <td><%=threeDecimalFormatter.format(t.getExtra1()) %></td>
                    <td><%=twoDecimalFormatter.format(rate.getExtra1()-(rate.getExtra1()*1/100)) %></td>
                    <td><%=twoDecimalFormatter.format(vat.getExtra1()) %></td>
                    <td><%=twoDecimalFormatter.format((t.getExtra1())*(((rate.getExtra1()-(rate.getExtra1()*1/100))*vat.getExtra1())/(100+vat.getExtra1()))) %></td>
                    <td><%=twoDecimalFormatter.format(t.getExtra1()*(rate.getExtra1()-(rate.getExtra1()*1/100))) %></td>
                </tr>
                <tr class="fontMarathiNumber right">
                    <td><center>6</center></td>
                    <td><center>Extra2</center></td>
                    <td><%=threeDecimalFormatter.format(t.getExtra2()) %></td>
                    <td><%=twoDecimalFormatter.format(rate.getExtra2()-(rate.getExtra2()*1/100)) %></td>
                    <td><%=twoDecimalFormatter.format(vat.getExtra2()) %></td>
                    <td><%=twoDecimalFormatter.format((t.getExtra2())*(((rate.getExtra2()-(rate.getExtra2()*1/100))*vat.getExtra2())/(100+vat.getExtra2()))) %></td>
                    <td><%=twoDecimalFormatter.format(t.getExtra2()*(rate.getExtra2()-(rate.getExtra2()*1/100))) %></td>
                </tr>
                <!-- Extra3, Extra4, Extra5, Extra6 hidden -->
                <!--
                <tr class="fontMarathiNumber right">
                    <td><center>7</center></td>
                    <td><center>Extra3</center></td>
                    <td><%=threeDecimalFormatter.format(t.getExtra3()) %></td>
                    <td><%=twoDecimalFormatter.format(rate.getExtra3()-(rate.getExtra3()*1/100)) %></td>
                    <td><%=twoDecimalFormatter.format(vat.getExtra3()) %></td>
                    <td><%=twoDecimalFormatter.format((t.getExtra3())*(((rate.getExtra3()-(rate.getExtra3()*1/100))*vat.getExtra3())/(100+vat.getExtra3()))) %></td>
                    <td><%=twoDecimalFormatter.format(t.getExtra3()*(rate.getExtra3()-(rate.getExtra3()*1/100))) %></td>
                </tr>
                <tr class="fontMarathiNumber right">
                    <td><center>8</center></td>
                    <td><center>Extra4</center></td>
                    <td><%=threeDecimalFormatter.format(t.getExtra4()) %></td>
                    <td><%=twoDecimalFormatter.format(rate.getExtra4()-(rate.getExtra4()*1/100)) %></td>
                    <td><%=twoDecimalFormatter.format(vat.getExtra4()) %></td>
                    <td><%=twoDecimalFormatter.format((t.getExtra4())*(((rate.getExtra4()-(rate.getExtra4()*1/100))*vat.getExtra4())/(100+vat.getExtra4()))) %></td>
                    <td><%=twoDecimalFormatter.format(t.getExtra4()*(rate.getExtra4()-(rate.getExtra4()*1/100))) %></td>
                </tr>
                <tr class="fontMarathiNumber right">
                    <td><center>9</center></td>
                    <td><center>Extra5</center></td>
                    <td><%=threeDecimalFormatter.format(t.getExtra5()) %></td>
                    <td><%=twoDecimalFormatter.format(rate.getExtra5()-(rate.getExtra5()*1/100)) %></td>
                    <td><%=twoDecimalFormatter.format(vat.getExtra5()) %></td>
                    <td><%=twoDecimalFormatter.format((t.getExtra5())*(((rate.getExtra5()-(rate.getExtra5()*1/100))*vat.getExtra5())/(100+vat.getExtra5()))) %></td>
                    <td><%=twoDecimalFormatter.format(t.getExtra5()*(rate.getExtra5()-(rate.getExtra5()*1/100))) %></td>
                </tr>
                <tr class="fontMarathiNumber right">
                    <td><center>10</center></td>
                    <td><center>Extra6</center></td>
                    <td><%=threeDecimalFormatter.format(t.getExtra6()) %></td>
                    <td><%=twoDecimalFormatter.format(rate.getExtra6()-(rate.getExtra6()*1/100)) %></td>
                    <td><%=twoDecimalFormatter.format(vat.getExtra6()) %></td>
                    <td><%=twoDecimalFormatter.format((t.getExtra6())*(((rate.getExtra6()-(rate.getExtra6()*1/100))*vat.getExtra6())/(100+vat.getExtra6()))) %></td>
                    <td><%=twoDecimalFormatter.format(t.getExtra6()*(rate.getExtra6()-(rate.getExtra6()*1/100))) %></td>
                </tr>
                -->
                <tr class="fontMarathiNumber right">
                    <td><center>11</center></td>
                    <td><center>हळद (अॅगमार्क)</center></td>
                    <td><%=threeDecimalFormatter.format(t.getHalad()) %></td>
                    <td><%=twoDecimalFormatter.format(rate.getHalad()-(rate.getHalad()*1/100)) %></td>
                    <td><%=twoDecimalFormatter.format(vat.getHalad()) %></td>
                    <td><%=twoDecimalFormatter.format((t.getHalad())*(((rate.getHalad()-(rate.getHalad()*1/100))*vat.getHalad())/(100+vat.getHalad()))) %></td>
                    <td><%=twoDecimalFormatter.format(t.getHalad()*(rate.getHalad()-(rate.getHalad()*1/100))) %></td>
                </tr>
                <tr>
                	<td colspan="2" class="left"><b> Total </b></td>
                	<td  class="fontMarathiNumber right"><b><%=threeDecimalFormatter.format(weight2)%></b></td>
                	<td></td>
                	<td></td>
                	<td  class="fontMarathiNumber right"><b><%=twoDecimalFormatter.format(vattotal1) %></b></td>
                	<td  class="fontMarathiNumber right"><b><%=twoDecimalFormatter.format(total2) %></b></td>
                </tr>
                <tr class="fontMarathiNumber">
                	<td colspan="7" class="left"><b> अक्षरी रुपये -  <%=nm.convertToWord((total2)) %></b></td>
                </tr>
            </tbody>
   	    </table>
   	    <font class="fontsize14">
      		वरील दरात लागन्या सर्व करांचा समावेश अाहे -<br>
      	I /We hereby certify that my/our registration certificate under the Maharashtra Value 
      	Added Tax Act 2002 is in force on the date on which the sale of the goods specified in 
      	this Invoice id made by me/us that the transaction of sale covered by this Invoice has 
      	been effected by me/us it shall be accounted for in the turnover of sales while filling 
      	of return and the due tax ,if any payable on the sale has been paid or shall be paid E$ O.E <br>
      	CST TIN No. :- 27AADFG1586E1ZI<br>
      	TIN NO.  :- 27AADFG1586E1ZI</font>
      	<table border="0" width="100%">
			<tr>
                <td class="left" width="33%">&nbsp;</td>
                <td class="center" width="33%">&nbsp;</td>
                <td class="center" width="33%"><center>गणेश इंटरप्राइजेस</center></td>
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
       	<br><br>
   	    <hr class="noprint" style="color: red">
<%
			}
		}
	}
%>
		
	</body>
</html>