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
	double kweightTotal = 0.0, rweightTotal = 0.0, kamountTotal = 0.0,ramountTotal = 0.0,tamountTotal = 0.0;
	NumberFormat twoDecimalFormatter = new DecimalFormat("#0.00");
	NumberFormat threeDecimalFormatter = new DecimalFormat("#0.000");
	NumberFormat zeroDecimalFormatter = new DecimalFormat("#");
	int invoiceID = Integer.parseInt(request.getParameter("invoiceID"));
	TalukaInvoice tInvoice = new InvoiceDS().readDistrictInvoice(invoiceID);
	TalukaOrderDetailDSHelper dSHelper = new TalukaOrderDetailDSHelper();
	List<TalukaOrder> t = dSHelper.districtOrderDetails(tInvoice.getOrderID());
	int flag = 0, counter = 0 ;
	if(t.isEmpty())
	{
		out.println("<h1>Taluka Order is Not Created for This District order</h1>");	
	}
	else
	{
		for(TalukaOrder to : t)
		{
			counter++;
			if(to.getInvoiceID() == 0)
			{
				flag++;
			}
		}
		if(flag == counter)
		{
			out.println("<h1>Taluka Bill is not Created for This District order</h1>");
		}
		else
		{
			if(t.get(0).getOrderType() == 2)
			{
				out.println("<h1>District Bill Not Created for Ration Order Only for Rice Order</h1>");
			}
			else
			{
				ArrayList<Item> itemList = new InvoiceDS().getAllItemByVersion(tInvoice.getInvoiceDate());
				int version = itemList.get(0).getVersion();
				DispatchTalukaOrder rate = new DispatchTalukaOrder();
				DispatchTalukaOrder vat = new DispatchTalukaOrder();
				double kRate = 0.0,rRate = 0.0,tRate = 0.0,tweight= 0.0;
				for(Item i : itemList)
				{
			        if(i.getItemId() == 12)
			        {
			        	kRate = i.getkRate();
			        	rRate = i.getrRate();
			        }
				}	
				NumberToMarathiWord nm = new NumberToMarathiWord();
%>			            
		   
<%
				for(int i =1; i<=2; i++)
				{
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
	                    <td class="left" width="75%">शिक्षणाधिकारी अधिखक (प्राथमिक)</td>
	                    <td class="left" width="25%"></td>
		            </tr>
		            <tr>
		                <td class="left" width="75%">जिल्हा परिषद , <b><%=t.get(0).getDistrictName()%></b></td>
		                <td class="left" width="25%">माहे <b><%=t.get(0).getFromMonth()%> - <%=t.get(0).getFromYear()%>  ते  <%=t.get(0).getToMonth()%> - <%=t.get(0).getToYear() %></b></td>
		            </tr>
		            <tr>
		                <td class="left" width="75%">जिल्हा - <b><%=t.get(0).getDistrictName()%></b></td>
		                <td class="left" width="25%">इयत्ता - <b><%=t.get(0).getOrderTypeDetails()%></b></td>
		            </tr>
		            <tr>
		                <td class="left" colspan="2">&nbsp;</td>
		            </tr>
		            <tr>
		                <td class="left" colspan="2">मा शिक्षणाधिकारी प्राथमिक जि प <b><%=t.get(0).getDistrictName()%></b> य़ांचे दि. <%=t.get(0).gettOrderDate()  %> चे पुरवठा आदेशानुसार</td>
		        	</tr>
		    	</tbody>
			</table>
		    <br/>
            <table border="0" width="100%">
                <tbody class="fontsize16">
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
	                    <td><b>तालुक्याचे ना</b>व</td>
	                    <td><b>तादुळ वाटप कालावधी</b></td>
	                    <td><b>केलेला तादुळ(कि.ग्रा.)</b></td>
	                    <td><b>वाहतूक दर प्र-कि-ग्रॅम</b></td>
	                    <td><b>एकुण रक्कम रु</b></td>
	                </tr>
            	</thead>
            	<tbody class="fontsize15" class="center">
<%			
					if(i==1)
					{
						tRate = kRate;
					}
					else
					{
						tRate = rRate;
					}
					int k = 0;
					tamountTotal = 0.0;
					tweight = 0.0;
					for(TalukaOrder tOrder : t)
					{
%>
            		<tr class="fontMarathiNumber right">
            			<td> <center><%=++k %></center> </td>
            			<td> <center><%=tOrder.getTalukaName() %></center> </td>
            			<td> <center><%=tOrder.getFromMonth()%> - <%=tOrder.getFromYear()%>  ते  <%=tOrder.getToMonth()%> - <%=tOrder.getToYear() %></center></td>
            			<td><%=threeDecimalFormatter.format(tOrder.getWeight())%></td>
            			<td><%=twoDecimalFormatter.format(tRate)%></td>
            			<td><%=twoDecimalFormatter.format(tOrder.getWeight()*tRate)%></td>
            		</tr>
<%
						tamountTotal = tamountTotal + (tOrder.getWeight()*tRate);
						tweight = tweight + tOrder.getWeight();
					}
					if(i==1)
					{
						kamountTotal = tamountTotal;
					}
					else
					{
						ramountTotal = tamountTotal;
					}
%>
					<tr class="fontMarathiNumber right">
	                	<td colspan="3" class="left"><b> Total </b></td>
	                	<td><b><%=threeDecimalFormatter.format(tweight)%></b></td>
	                    <td ></td>
            			<td class="right"><b><%=twoDecimalFormatter.format(tamountTotal)%></b></td>
	                </tr>
	                <tr class="fontMarathiNumber">
	                	<td colspan="6" class="left"><b> अक्षरी रुपये -  <%=nm.convertToWord(tamountTotal) %></b></td>
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
					if(i==1)
					{
%>
	       	<p class="breakhere"></p>
<%
					}
				}
%> 	    	       
<%			
			}
		}
	}
%>
		
	</body>
</html>