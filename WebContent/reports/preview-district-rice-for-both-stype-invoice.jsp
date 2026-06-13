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
	double kweightTotal = 0.0, rweightTotal = 0.0, kamountTotal = 0.0,ramountTotal = 0.0,tamountTotal = 0.0;
	NumberFormat twoDecimalFormatter = new DecimalFormat("#0.00");
	NumberFormat threeDecimalFormatter = new DecimalFormat("#0.000");
	NumberFormat zeroDecimalFormatter = new DecimalFormat("#");
	String orde1to5 = request.getParameter("orde1to5");
	String orde6to8 = request.getParameter("orde6to8");
	String orderType = request.getParameter("orderType");
	String previewDate = request.getParameter("salesBillDate");
	TalukaOrderDetailDSHelper dSHelper = new TalukaOrderDetailDSHelper();
	List<TalukaOrder> t = dSHelper.districtOrderDetails(Integer.parseInt(orde1to5));
	List<TalukaOrder> t1 = dSHelper.districtOrderDetails(Integer.parseInt(orde6to8));
	List<TalukaOrder> t2 = new ArrayList<TalukaOrder>();
	int flag = 0, counter = 0 ;
	if(t.isEmpty() || t1.isEmpty())
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
			String msg = request.getParameter("msg");
			if (msg != null) 
		    {
%>
		<p class="center" style="text-decoration: blink;color: red"><%=msg%></p>
<%
			}				
%>			            
	    <form  action="../create/create-district-rice-invoice.jsp" accept-charset="ISO-8859-1" method="POST" onsubmit="return validate(this)">
		    <input type="hidden" name="orde1to5" value="<%=orde1to5%>" >
		    <input type="hidden" name="orde6to8" value="<%=orde6to8%>" >
		    <input type="hidden" name="version" value="<%=version%>" >
		    <input type="hidden" name="orderType" value="<%=orderType%>" >
		    <input type="hidden" name="invoiceDate" id="invoiceDate" value="<%=previewDate%>">
	    	<p class="center">Bill Preview (Not for print)</p>
			<table border="0" width="100%">
	             <tbody class="fontsize14">   
	             	<tr>
	                     <td class="right" width="75%"></td>
	                     <td class="left" width="25%"> <input type="text"  id="invoiceNumber"  name="invoiceNumber" ><input type="submit" name="create bill" value="बिल बनवा"></td>
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
		                 <td class="left" width="25%">माहे <b><%=t.get(0).getFromMonth()%> - <%=t.get(0).getFromYear()%>  ते  <%=t.get(0).getToMonth()%> - <%=t.get(0).getToYear() %></b></td>
		             </tr>
		             <tr>
		                 <td class="left" width="75%">जिल्हा - <b><%=t.get(0).getDistrictName()%></b></td>
		                 <td class="left" width="25%">इयत्ता - <b><%=t.get(0).getOrderTypeDetails()%></b></td>
		             </tr>
		             <tr>
		                 <td class="left" colspan="2">&nbsp;</td>
		             </tr>
		         </tbody>
		     </table>
	     	<br/>
			<table  class="printstyle fontsize15"  width="800">
            	<thead class="fontsize16Bold">
            		<tr class="center">
	                    <td><b>अ. क्र.</b></td>
	                    <td><b>तालुक्याचे ना</b>व</td>
	                    <td><b>1 to 5</b></td>
	                    <td><b>6 to 8</b></td>
	                    <td><b>केलेला तादुळ(कि.ग्रा.)</b></td>
	                    <td><b>तादुळ वाटप कालावधी</b></td>
	                    <td><b>वाहतूक दर प्र-कि-ग्रॅम</b></td>
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
            			<td> <center><%=tOrder.getFromMonth()%> - <%=tOrder.getFromYear()%>  ते  <%=tOrder.getToMonth()%> - <%=tOrder.getToYear() %></center></td>	            			
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
	                	<td class="fontMarathiNumber right"><b><%=threeDecimalFormatter.format(total6to8)%></b></td>
	                	<td class="fontMarathiNumber right"><b><%=threeDecimalFormatter.format(total1to5+total6to8)%></b></td>
	                    <td></td>
	                    <td></td>
            			<td class="fontMarathiNumber right"><b><%=twoDecimalFormatter.format((total1to5+total6to8)*tRate)%></b></td>
	                </tr>
	                <tr class="fontMarathiNumber">
	                	<td colspan="6" class="left"><b> अक्षरी रुपये -  <%=nm.convertToWord((total1to5+total6to8)*tRate) %></b></td>
	                </tr>
	            </tbody>
    	    </table>       	    
	       	<br><br>
    	    <hr class="noprint" style="color: red">
		    <input type="hidden" name="weight" value="<%=total1to5%>" >
		    <input type="hidden" name="weight1" value="<%=total6to8%>" >
		    <input type="hidden" name="total" id="total" value="<%=(total1to5+total6to8)*tRate%>" >
        </form>
<%			
		}
	}
%>
		
	</body>
</html>