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
	String orde1to5 = request.getParameter("orde1to5");
	String orde6to8 = request.getParameter("orde6to8");
	String orderType = request.getParameter("orderType");
	String previewDate = request.getParameter("salesBillDate");
	TalukaOrderDetailDSHelper dSHelper = new TalukaOrderDetailDSHelper();
	DispatchTalukaOrder t = dSHelper.districtOrderDetailsByID(Integer.parseInt(orde1to5));
	DispatchTalukaOrder t1 = dSHelper.districtReturnDetailsByID(Integer.parseInt(orde1to5));
	DispatchTalukaOrder t2 = dSHelper.districtOrderDetailsByID(Integer.parseInt(orde6to8));
	DispatchTalukaOrder t3 = dSHelper.districtReturnDetailsByID(Integer.parseInt(orde6to8));
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
			total1 = (t.getMungdaal()*(rate.getMungdaal()-(rate.getMungdaal()*1/100)))+(t.getMatki()*(rate.getMatki()-(rate.getMatki()*1/100)))+(t.getMung()*(rate.getMung()-(rate.getMung()*1/100)))+(t.getMasuldaal()*(rate.getMasuldaal()-(rate.getMasuldaal()*1/100)))+(t.getHarbara()*(rate.getHarbara()-(rate.getHarbara()*1/100)))+(t.getVatana()*(rate.getVatana()-(rate.getVatana()*1/100)))+(t.getExtra1()*(rate.getExtra1()-(rate.getExtra1()*1/100)))+(t.getExtra2()*(rate.getExtra2()-(rate.getExtra2()*1/100)))+(t.getExtra3()*(rate.getExtra3()-(rate.getExtra3()*1/100)))+(t.getExtra4()*(rate.getExtra4()-(rate.getExtra4()*1/100)))+(t.getExtra5()*(rate.getExtra5()-(rate.getExtra5()*1/100)))+(t.getExtra6()*(rate.getExtra6()-(rate.getExtra6()*1/100)))+(t.getChvli()*(rate.getChvli()-(rate.getChvli()*1/100)))+(t.getMith()*(rate.getMith()-(rate.getMith()*1/100)))+(t.getHalad()*(rate.getHalad()-(rate.getHalad()*1/100)));
			total2 = (t.getTel()*(rate.getTel()-(rate.getTel()*1/100)))+(t.getJire()*(rate.getJire()-(rate.getJire()*1/100)))+(t.getMohari()*(rate.getMohari()-(rate.getMohari()*1/100)))+(t.getMirchi()*(rate.getMirchi()-(rate.getMirchi()*1/100)));
			weight1 = (t.getMungdaal())+(t.getMatki())+(t.getMung())+(t.getMasuldaal())+(t.getHarbara())+(t.getVatana())+(t.getExtra1())+(t.getExtra2())+(t.getExtra3())+(t.getExtra4())+(t.getExtra5())+(t.getExtra6())+(t.getChvli())+(t.getMith())+(t.getMirchi())+(t.getHalad());
			weight2 = (t.getTel())+(t.getJire())+(t.getMohari())+(t.getMirchi());
			vattotal1 = ((t.getTel())*(((rate.getTel()-(rate.getTel()*1/100))*vat.getTel())/(100+vat.getTel())))+((t.getJire())*(((rate.getJire()-(rate.getJire()*1/100))*vat.getJire())/(100+vat.getJire())))+((t.getMohari())*(((rate.getMohari()-(rate.getMohari()*1/100))*vat.getMohari())/(100+vat.getMohari())))+((t.getMirchi())*(((rate.getMirchi()-(rate.getMirchi()*1/100))*vat.getMirchi())/(100+vat.getMirchi())));
%>			            
	    <form  action="../create/create-district-ration-invoice.jsp" accept-charset="ISO-8859-1" method="POST" onsubmit="return validate(this)">
		    <input type="hidden" name="orde1to5" value="<%=orde1to5%>" >
		    <input type="hidden" name="orde6to8" value="<%=orde6to8%>" >
		    <input type="hidden" name="version" value="<%=version%>" >
		    <input type="hidden" name="orderType" value="<%=orderType%>" >
		    <input type="hidden" name="invoiceDate" id="invoiceDate" value="<%=previewDate%>" >
	    	<p class="center">Bill Preview (Not for print)</p>
			<table border="0" width="100%">
	            <tbody class="fontsize14">   	             	  
					<tr>
                        <td class="right" width="75%"><b>करा विना</b> <input type="text"  id="invoiceNumber1"  name="invoiceNumber1" > <b> करा सहित </b> </td>
                        <td class="left" width="25%"> <input type="text"  id="invoiceNumber2"  name="invoiceNumber2" ><span id="msg"> </span><input type="submit" name="create bill" value="बिल बनवा"></td>
                    </tr>                                
	                <tr>
	                    <td class="left" width="75%"></td>
	                    <td class="left" width="25%">तारीख : <%=previewDate %></td>
		            </tr>
		            <tr>
	                    <td class="left" width="75%">&nbsp;</td>
	                    <td class="left" width="25%"></td>
		            </tr>
		            <tr>
		                <td class="left" width="75%"></td>
		                <td class="left" width="25%">माहे <b><%=t.getFromMonth()%> - <%=t.getFromMonthYear()%>  ते  <%=t.getToMonth()%> - <%=t.getToMonthYear() %></b></td>
		            </tr>
		            <tr>
		                <td class="left" colspan="2">&nbsp;</td>
		            </tr>
		     	</tbody>
		    </table>
<%
			if(version == 1)
			{
%>
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
								<tr class="fontMarathiNumber right">
									<td><center>7</center></td>
									<td><center>वटाणा</center></td>
									<td><%=threeDecimalFormatter.format(t.getVatana()) %></td>
									<td><%=twoDecimalFormatter.format(rate.getVatana()-(rate.getVatana()*1/100)) %></td>
									<td><%=twoDecimalFormatter.format(t.getVatana()*(rate.getVatana()-(rate.getVatana()*1/100))) %></td>
								</tr>
                                <tr class="fontMarathiNumber right">
                                    <td><center>8</center></td>
                                      <td><center>सोया वडी</center></td>
                                    <td><%=threeDecimalFormatter.format(t.getExtra1()) %></td>
                                    <td><%=twoDecimalFormatter.format(rate.getExtra1()-(rate.getExtra1()*1/100)) %></td>
                                    <td><%=twoDecimalFormatter.format(t.getExtra1()*(rate.getExtra1()-(rate.getExtra1()*1/100))) %></td>
                                </tr>
                                <!--
                                <tr class="fontMarathiNumber right">
                                    <td><center>9</center></td>
                                    <td><center>Extra3</center></td>
                                    <td><%=threeDecimalFormatter.format(t.getExtra3()) %></td>
                                    <td><%=twoDecimalFormatter.format(rate.getExtra3()-(rate.getExtra3()*1/100)) %></td>
                                    <td><%=twoDecimalFormatter.format(t.getExtra3()*(rate.getExtra3()-(rate.getExtra3()*1/100))) %></td>
                                </tr>
                                <tr class="fontMarathiNumber right">
                                    <td><center>10</center></td>
                                    <td><center>Extra4</center></td>
                                    <td><%=threeDecimalFormatter.format(t.getExtra4()) %></td>
                                    <td><%=twoDecimalFormatter.format(rate.getExtra4()-(rate.getExtra4()*1/100)) %></td>
                                    <td><%=twoDecimalFormatter.format(t.getExtra4()*(rate.getExtra4()-(rate.getExtra4()*1/100))) %></td>
                                </tr>
                                <tr class="fontMarathiNumber right">
                                    <td><center>11</center></td>
                                    <td><center>Extra5</center></td>
                                    <td><%=threeDecimalFormatter.format(t.getExtra5()) %></td>
                                    <td><%=twoDecimalFormatter.format(rate.getExtra5()-(rate.getExtra5()*1/100)) %></td>
                                    <td><%=twoDecimalFormatter.format(t.getExtra5()*(rate.getExtra5()-(rate.getExtra5()*1/100))) %></td>
                                </tr>
                                <tr class="fontMarathiNumber right">
                                    <td><center>12</center></td>
                                    <td><center>Extra6</center></td>
                                    <td><%=threeDecimalFormatter.format(t.getExtra6()) %></td>
                                    <td><%=twoDecimalFormatter.format(rate.getExtra6()-(rate.getExtra6()*1/100)) %></td>
                                    <td><%=twoDecimalFormatter.format(t.getExtra6()*(rate.getExtra6()-(rate.getExtra6()*1/100))) %></td>
                                </tr>
                                -->
								<tr class="fontMarathiNumber right">
									<td><center>9</center></td>
									<td><center>चवली</center></td>
									<td><%=threeDecimalFormatter.format(t.getChvli()) %></td>
									<td><%=twoDecimalFormatter.format(rate.getChvli()-(rate.getChvli()*1/100)) %></td>
									<td><%=twoDecimalFormatter.format(t.getChvli()*(rate.getChvli()-(rate.getChvli()*1/100))) %></td>
								</tr>
								<tr class="fontMarathiNumber right">
									<td><center>10</center></td>
									<td><center>मीठ (आयोडिनयुक्त)</center></td>
									<td><%=threeDecimalFormatter.format(t.getMith()) %></td>
									<td><%=twoDecimalFormatter.format(rate.getMith()-(rate.getMith()*1/100)) %></td>
									<td><%=twoDecimalFormatter.format(t.getMith()*(rate.getMith()-(rate.getMith()*1/100))) %></td>
								</tr>
								<tr class="fontMarathiNumber right">
									<td><center>11</center></td>
									<td><center>कांदा लसूण मसाला</center></td>
									<td><%=threeDecimalFormatter.format(t.getMirchi()) %></td>
									<td><%=twoDecimalFormatter.format(rate.getMirchi()-(rate.getMirchi()*1/100)) %></td>
									<td><%=twoDecimalFormatter.format(t.getMirchi()*(rate.getMirchi()-(rate.getMirchi()*1/100))) %></td>
								</tr>
								<tr class="fontMarathiNumber right">
									<td><center>12</center></td>
									<td><center>हळद (अॅगमार्क)</center></td>
									<td><%=threeDecimalFormatter.format(t.getHalad()) %></td>
									<td><%=twoDecimalFormatter.format(rate.getHalad()-(rate.getHalad()*1/100)) %></td>
									<td><%=twoDecimalFormatter.format(t.getHalad()*(rate.getHalad()-(rate.getHalad()*1/100))) %></td>
								</tr>
	            	<tr>
	                	<td colspan="2" class="left"><b> Total </b></td>
	                	<td class="fontMarathiNumber right"><b><%=threeDecimalFormatter.format(weight1)%></b></td>
	                	<td></td>
	                	<td class="fontMarathiNumber right"><b><%=twoDecimalFormatter.format(total1) %></b></td>
	                </tr>
	                <tr class="fontMarathiNumber">
	                	<td colspan="6" class="left"><b> अक्षरी रुपये -  <%=nm.convertToWord(total1) %></b></td>
	                </tr>
	            </tbody>
    	    </table> 
	       	<br><br>
    	    <hr class="noprint" style="color: red">
	       	<br><br>
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
	                	<td class="fontMarathiNumber right"><b><%=threeDecimalFormatter.format(weight2)%></b></td>
	                	<td></td>
	                	<td class="fontMarathiNumber right"><b><%=twoDecimalFormatter.format(vattotal1) %></b></td>
	                	<td class="fontMarathiNumber right"><b><%=twoDecimalFormatter.format(total2) %></b></td>
	                </tr>
	                <tr class="fontMarathiNumber">
	                	<td colspan="6" class="left"><b> अक्षरी रुपये -  <%=nm.convertToWord(total2) %></b></td>
	                </tr>
	            </tbody>
    	    </table>  	    
	       	<br><br>
<%
			}
			else
			{
%>
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
					<tr class="fontMarathiNumber right">
						<td><center>7</center></td>
						<td><center>वटाणा</center></td>
						<td><%=threeDecimalFormatter.format(t.getVatana()) %></td>
						<td><%=twoDecimalFormatter.format(rate.getVatana()-(rate.getVatana()*1/100)) %></td>
						<td><%=twoDecimalFormatter.format(t.getVatana()*(rate.getVatana()-(rate.getVatana()*1/100))) %></td>
					</tr>
					<tr class="fontMarathiNumber right">
						<td><center>8</center></td>
						<td><center>सोया वडी</center></td>
						<td><%=threeDecimalFormatter.format(t.getExtra1()) %></td>
						<td><%=twoDecimalFormatter.format(rate.getExtra1()-(rate.getExtra1()*1/100)) %></td>
						<td><%=twoDecimalFormatter.format(t.getExtra1()*(rate.getExtra1()-(rate.getExtra1()*1/100))) %></td>
					</tr>
					<!--
					<tr class="fontMarathiNumber right">
						<td><center>9</center></td>
						<td><center>Extra3</center></td>
						<td><%=threeDecimalFormatter.format(t.getExtra3()) %></td>
						<td><%=twoDecimalFormatter.format(rate.getExtra3()-(rate.getExtra3()*1/100)) %></td>
						<td><%=twoDecimalFormatter.format(t.getExtra3()*(rate.getExtra3()-(rate.getExtra3()*1/100))) %></td>
					</tr>
					<tr class="fontMarathiNumber right">
						<td><center>10</center></td>
						<td><center>Extra4</center></td>
						<td><%=threeDecimalFormatter.format(t.getExtra4()) %></td>
						<td><%=twoDecimalFormatter.format(rate.getExtra4()-(rate.getExtra4()*1/100)) %></td>
						<td><%=twoDecimalFormatter.format(t.getExtra4()*(rate.getExtra4()-(rate.getExtra4()*1/100))) %></td>
					</tr>
					<tr class="fontMarathiNumber right">
						<td><center>11</center></td>
						<td><center>Extra5</center></td>
						<td><%=threeDecimalFormatter.format(t.getExtra5()) %></td>
						<td><%=twoDecimalFormatter.format(rate.getExtra5()-(rate.getExtra5()*1/100)) %></td>
						<td><%=twoDecimalFormatter.format(t.getExtra5()*(rate.getExtra5()-(rate.getExtra5()*1/100))) %></td>
					</tr>
					<tr class="fontMarathiNumber right">
						<td><center>12</center></td>
						<td><center>Extra6</center></td>
						<td><%=threeDecimalFormatter.format(t.getExtra6()) %></td>
						<td><%=twoDecimalFormatter.format(rate.getExtra6()-(rate.getExtra6()*1/100)) %></td>
						<td><%=twoDecimalFormatter.format(t.getExtra6()*(rate.getExtra6()-(rate.getExtra6()*1/100))) %></td>
					</tr>
					-->
					<tr class="fontMarathiNumber right">
						<td><center>9</center></td>
						<td><center>चवली</center></td>
						<td><%=threeDecimalFormatter.format(t.getChvli()) %></td>
						<td><%=twoDecimalFormatter.format(rate.getChvli()-(rate.getChvli()*1/100)) %></td>
						<td><%=twoDecimalFormatter.format(t.getChvli()*(rate.getChvli()-(rate.getChvli()*1/100))) %></td>
					</tr>
					<tr class="fontMarathiNumber right">
						<td><center>10</center></td>
						<td><center>मीठ (आयोडिनयुक्त)</center></td>
						<td><%=threeDecimalFormatter.format(t.getMith()) %></td>
						<td><%=twoDecimalFormatter.format(rate.getMith()-(rate.getMith()*1/100)) %></td>
						<td><%=twoDecimalFormatter.format(t.getMith()*(rate.getMith()-(rate.getMith()*1/100))) %></td>
					</tr>
					<tr class="fontMarathiNumber right">
						<td><center>11</center></td>
						<td><center>हळद (अॅगमार्क)</center></td>
						<td><%=threeDecimalFormatter.format(t.getHalad()) %></td>
						<td><%=twoDecimalFormatter.format(rate.getHalad()-(rate.getHalad()*1/100)) %></td>
						<td><%=twoDecimalFormatter.format(t.getHalad()*(rate.getHalad()-(rate.getHalad()*1/100))) %></td>
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
	   	    <br/><br/>
    	    <hr class="noprint" style="color: red">
	       	<br/><br/>
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
	                <tr class="fontMarathiNumber right">
	                    <td><center>4</center></td>
	                    <td><center>कांदा लसूण मसाला</center></td>
	                    <td><%=threeDecimalFormatter.format(t.getMirchi()) %></td>
	                    <td><%=twoDecimalFormatter.format(rate.getMirchi()-(rate.getMirchi()*1/100)) %></td>
	                    <td><%=twoDecimalFormatter.format((t.getMirchi())*(((rate.getMirchi()-(rate.getMirchi()*1/100))*vat.getMirchi())/(100+vat.getMirchi()))) %></td>
	                    <td><%=twoDecimalFormatter.format(t.getMirchi()*(rate.getMirchi()-(rate.getMirchi()*1/100))) %></td>
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
	   	    <br/><br/>
<%
				
			}
%>
	       	<input type="hidden" name="weight" value="<%=(weight1+weight2)%>" >
		    <input type="hidden" name="total1" id="total1" value="<%=(total1)%>" >
		    <input type="hidden" name="total2" id="total2" value="<%=(total2)%>" >
    	    <hr class="noprint" style="color: red">
        </form>
<%			
		}
	}
%>
		
	</body>
</html>