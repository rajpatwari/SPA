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
                font:normal normal 18px Kiran,Tahoma;
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
            .fontsize20Bold {
                font:normal normal 20px Tahoma bold;
                text-decoration:none;
            }
            .fontsize24Bold {
                font:normal normal 24px Tahoma bold;
                text-decoration:none;
            }
            .fontsize16Bold {
                font:normal normal 16px Tahoma bold;
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
	double kweightTotal = 0.0, rweightTotal = 0.0, kamountTotal = 0.0,ramountTotal = 0.0,tamountTotal = 0.0;
	NumberFormat twoDecimalFormatter = new DecimalFormat("#0.00");
	NumberFormat threeDecimalFormatter = new DecimalFormat("#0.000");
	NumberFormat zeroDecimalFormatter = new DecimalFormat("#");
	TalukaInvoice talukaInvoice = new InvoiceDS().readDistrictRiceSalesInvoice(Integer.parseInt(request.getParameter("invoiceID")));
	
	int orde1to5 = talukaInvoice.getOrderID();
	int orde6to8 = talukaInvoice.getOrderID1();
	String previewDate = talukaInvoice.getInvoiceDate();
	TalukaOrderDetailDSHelper dSHelper = new TalukaOrderDetailDSHelper();
	List<TalukaOrder> t = dSHelper.districtOrderDetails(orde1to5);
	List<TalukaOrder> t1 = dSHelper.districtOrderDetails(orde6to8);
	List<TalukaOrder> t2 = new ArrayList<TalukaOrder>();
	int flag = 0, counter = 0 ;
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
		for(TalukaOrder to : t)
		{
			for(TalukaOrder to1 : t1)
			{
				if(to.getTalukaName().equalsIgnoreCase(to1.getTalukaName()))
				{
					to.setWeight1(to1.getWeight());
				}
			}
			t2.add(to);
		}				
		ArrayList<Item> itemList = new InvoiceDS().getAllItemByVersion(previewDate);
		int version = itemList.get(0).getVersion();
		DispatchTalukaOrder rate = new DispatchTalukaOrder();
		DispatchTalukaOrder vat = new DispatchTalukaOrder();
		double kRate = 0.0,rRate = 0.0,tRate = 1.0,tweight= 0.0;
		for(Item i : itemList)
		{
	        if(i.getItemId() == 12)
	        {
	        	tRate = i.getTranRate();
	        }
		}	
		NumberToMarathiWord nm = new NumberToMarathiWord();
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
        <center> <font class="fontsize24Bold"> <b>गणेश इंटरप्राइजेस </b></font><br>
       	 	डि-१८९, एमआयडीसी अवधान धुळे<br>
        TAX INVOICE<br>
        	कॅश क्रेडिट मेमो</center>	            
	    <table border="0" width="100%">
             <tbody class="fontsize14">   
             	<tr>
                     <td class="left" width="65%"> बील क्रमांक :- <b>  शा पो आ शा तां - <%=talukaInvoice.getInvoiceIDMan() %> </b></td>
                     <td class="left" width="35%">तारीख :<b> <%=previewDate %> </b> </td>
                 </tr> 
	             <tr>
                     <td class="left" width="65%">प्रति,</td>
                     <td class="left" width="35%"></td>
	             </tr> 
	             <tr>
                     <td class="left" width="65%"> केंद्रीय भांडार</td>
                     <td class="left" width="35%">(<%=t.get(0).getDistrictName()%> जिल्हा शा पो आ तादुळ वाहतुक)</td>
	             </tr>
	             <tr>
	                 <td class="left" width="65%">ऑफिस : १०२, पहिला मजला, बीजीटीए गोदावरी, प्लॉट नं. जी-१, वडाळा ट्रॅक टर्मिनल, सायन, मुंबई, महाराष्ट्र - ४०००३७ </td>
	                 <td class="left" width="35%">माहे - <b><%=t.get(0).getFromMonth()%> - <%=t.get(0).getFromYear()%>  ते  <%=t.get(0).getToMonth()%> - <%=t.get(0).getToYear() %></b></td>
	             </tr>
	         </tbody>
		</table>
		<table  class="printstyle fontsize15"  width="800">
           	<thead class="fontsize16Bold">
           		<tr class="center">
                    <td><b>अ. क्र.</b></td>
                    <td><b>तालुक्याचे ना</b>व</td>
                    <td><b>१ ली ते ५ वी</b></td>
                    <td><b>६ वी ते ८ वी</b></td>
                    <td><b>केलेला तादुळ<br>(कि.ग्रा.)</b></td>
                    <td><b>तादुळ वाटप कालावधी</b></td>
                    <td><b>वाहतूक दर<br>प्र-कि-ग्रॅम</b></td>
                    <td><b>एकुण रक्कम रु</b></td>
                </tr>
           	</thead>
           	<tbody class="fontsize15" class="center">
<%			
		int k = 0;
		tamountTotal = 0.0;
		double total1to5 = 0.0,total6to8 = 0.0;
		tweight = 0.0;
		for(TalukaOrder tOrder : t2)
		{
%>
           		<tr class="fontMarathiNumber right">
           			<td> <center><%=++k %></center> </td>
           			<td> <center><%=tOrder.getTalukaName() %></center> </td>
           			<td><%=threeDecimalFormatter.format(tOrder.getWeight())%></td>
           			<td><%=threeDecimalFormatter.format(tOrder.getWeight1())%></td>
           			<td><%=threeDecimalFormatter.format(tOrder.getWeight()+tOrder.getWeight1())%></td>
           			<td> <center><%=tOrder.getFromMonth()%> - <%=tOrder.getFromYear()%>  ते <br> <%=tOrder.getToMonth()%> - <%=tOrder.getToYear() %></center></td>	            			
           			<td><%=threeDecimalFormatter.format(tRate)%></td>
           			<td><%=twoDecimalFormatter.format((tOrder.getWeight()+tOrder.getWeight1())*tRate)%></td>
           		</tr>
<%
			total1to5 = total1to5 + tOrder.getWeight();
			total6to8 = total6to8 + tOrder.getWeight1();
		    tamountTotal = tamountTotal + ((tOrder.getWeight()+tOrder.getWeight1())*tRate);
		}
%>
				<tr>
                	<td colspan="2" class="left"><b> Total </b></td>
                	<td  class="fontMarathiNumber right"><b><%=threeDecimalFormatter.format(total1to5)%></b></td>
                	<td  class="fontMarathiNumber right"><b><%=threeDecimalFormatter.format(total6to8)%></b></td>
                	<td  class="fontMarathiNumber right"><b><%=threeDecimalFormatter.format(total1to5+total6to8)%></b></td>
                    <td ></td>
                    <td ></td>
           			<td  class="fontMarathiNumber right"><b><%=twoDecimalFormatter.format((total1to5+total6to8)*tRate)%></b></td>
                </tr>
                <tr class="fontMarathiNumber">
                	<td colspan="6" class="left"><b> अक्षरी रुपये -  <%=nm.convertToWord((total1to5+total6to8)*tRate) %></b></td>
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
                <td class="center" width="33%"><center>गणेश इंटरप्राइजेस </center></td>
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
	}
%>		
	</body>
</html>