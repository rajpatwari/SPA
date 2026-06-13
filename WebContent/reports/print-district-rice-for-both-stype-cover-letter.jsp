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
	
	int talukaID = Integer.parseInt(request.getParameter("talukaId").trim());
	int orde1to5 = Integer.parseInt(request.getParameter("orderId1to5").trim());
	int orde6to8 = Integer.parseInt(request.getParameter("orderId6to8").trim());
	String fromDate = session.getAttribute("fromYear").toString().trim();
    String toDate =  session.getAttribute("toYear").toString().trim();
	NumberToMarathiWord nm = new NumberToMarathiWord();

	Taluka t = new DistrictMaster().talukaDetailsByTalukaId(talukaID);
	String talukaName = t.getTalukaMarathi();
	//System.out.println(orde1to5+"\t"+orde6to8+"\t"+talukaName);
	String dd = ""; //= st.nextToken("/") ;
	String mm = ""; // st.nextToken("/") ;
	String yy = ""; // st.nextToken("/") ;
	StringTokenizer st = null;
	String dd1 = ""; //= st.nextToken("/") ;
	String mm1 = ""; // st.nextToken("/") ;
	String yy1 = ""; // st.nextToken("/") ;
	StringTokenizer st1 = null;
	List<TalukaInvoice> l = new TalukaOrderDetailDSHelper().talukaCoverLetterDetails(talukaName, orde1to5, orde6to8);
	st = new StringTokenizer(fromDate,"/");
    dd=st.nextToken("/");
    mm =st.nextToken("/");
    yy =st.nextToken("/");
    
    st1 = new StringTokenizer(toDate,"/");
    dd1 =st1.nextToken("/");
    mm1 =st1.nextToken("/");
    yy1 =st1.nextToken("/");
    if(l.isEmpty() != true)
    {
%>	
		<center> 
		<font class="fontsize20Bold"> <b> केंद्रीय भांडार </b></font><br>
        Ganesh Enterprises<br>
        	189 MIDC Avdhan Dhule<br>
        	424006<br>
        </center>
        <hr style="color: red">
		<table  class="fontsize15"  width="800">
	   		<tr class="">
	            <td>जावक क्र. </td>
	            <td>दिनांक</td>
	        </tr>
	        <tr class="">
	            <td>&nbsp; </td>
	            <td>&nbsp; </td>
	        </tr>
	        <tr class="">
	            <td>प्रति, </td>
	            <td>&nbsp; </td>
	        </tr>
	        <tr class="">
	            <td>मा. शिक्षणाधिकारी (प्राथमिक)</td>
	            <td>&nbsp; </td>
	        </tr>
	        <tr class="">
	            <td>जि.प.</td>
	            <td>&nbsp; </td>
	        </tr>
	        <tr class="">
	            <td>&nbsp; </td>
	            <td>&nbsp; </td>
	        </tr>
	        <tr class="">
	            <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;विषय : शालेय पोषण आहार योजना सन <%=yy %>-<%=yy1 %> चे अन्न, धान्यादी </td>
	        </tr>
	        <tr class="">
	            <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;मालाचे देयके सादर करणेबाबत</td>
	        </tr>
	        <tr class="">
	            <td>&nbsp; </td>
	            <td>&nbsp; </td>
	        </tr>
	        <tr class="">
	            <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;संदर्भ : मा. गट शिक्षणाधिकारी ता.<b><%=l.get(1).getTalukaMarathi() %></b> जि. <b><%=l.get(1).getDistrictMarathi() %></b> यांचे</td>
	        </tr>
	        <tr class="">
	            <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;माहे <b><%=l.get(1).getFromMonth()%> - <%=l.get(1).getFromYear()%>  ते  <%=l.get(1).getToMonth()%> - <%=l.get(1).getToYear() %></b> चे मागणी पत्राप्रमाणे</td>
	        </tr>
	        <tr class="">
	            <td>&nbsp; </td>
	            <td>&nbsp; </td>
	        </tr>
	        <tr class="">
	            <td>महोदय,</td>
	            <td>&nbsp; </td>
	        </tr>
	        <tr class="">
	            <td colspan="2"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;वरील विषयी व संदर्भीय पत्रानुसार कळविण्यात येते की, शालेय पोषण आहार योजने अंतर्गत माहे</td>
	        </tr>
	        <tr class="">
	            <td colspan="2"> माहे <b><%=l.get(1).getFromMonth()%> - <%=l.get(1).getFromYear()%>  ते  <%=l.get(1).getToMonth()%> - <%=l.get(1).getToYear() %></b> चे मागणी पत्रानुसार अन्नधान्यादी मालाचा पुरवठा केलेले</td>
	        </tr>
	        <tr class="">
	            <td colspan="2"> आहे. पुरवठा केलेल्या मालाची डिलेव्हरी चलन शाळा निहाय पोहचसह या सोबत सादर करीत आहोत. </td>
	        </tr>                
	        <tr class="">
	            <td>&nbsp; </td>
	            <td>&nbsp; </td>
	        </tr>
	        <tr class="">
	            <td colspan="2"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;सदर पुरवठचयाचे देयके खालील तपशिलप्रमाणे आपले मंजुरीस्तव व पुढील योग्य त्या कार्यवाही  </td>
	        </tr>   
	        <tr class="">
	            <td colspan="2"> स्तव सादर करण्यात येत आहेत. </td>
	        </tr>  
	        <tr class="">
	            <td>&nbsp; </td>
	            <td>&nbsp; </td>
	        </tr>              
	        <tr class="">
	            <td>करिता विनंती, </td>
	            <td>&nbsp; </td>
	        </tr>  
	        <tr class="">
	            <td>&nbsp; </td>
	            <td>&nbsp; </td>
	        </tr>
        </table>
		<table  class="printstyle fontsize15"  width="800">
           	<thead class="fontsize16Bold">
           		<tr class="center">
                    <td><b>अ. क्र.</b></td>
                    <td><b>तालुक्याचे नाव</b></td>
                    <td><b>तपशिल</b></td>
                    <td><b>बील क्रमांक</b></td>
                    <td><b>रक्कम रु</b></td>
                </tr>
           	</thead>
           	<tbody class="fontsize15" class="center">
<%			
	int i = 0;
	double total = 0.0;
	for(TalukaInvoice tOrder : l)
	{
		if(tOrder.getInvoiceIDMan() != 0)
		{
%>		
           		<tr class="fontMarathiNumber right">
           			<td> <center><%=++i %></center> </td>
           			<td> <center><%=tOrder.getTalukaMarathi() %></center> </td>
           			<td><center><b><%=l.get(1).getFromMonth()%> - <%=l.get(1).getFromYear()%>  ते  <%=l.get(1).getToMonth()%> - <%=l.get(1).getToYear() %></b></center></td>
           			<td><center><%=tOrder.getInvoiceIDMan()%></center></td>
           			<td><%=twoDecimalFormatter.format(tOrder.getTotalAmount())%></td>	            			
           		</tr>
<%	
			total = total + tOrder.getTotalAmount();
		}
		else
		{
%>		
	       		<tr class="fontMarathiNumber right">
	       			<td> <center><%=++i %></center> </td>
	       			<td> <center><%=tOrder.getTalukaMarathi() %></center> </td>
	       			<td><center><b><%=l.get(1).getFromMonth()%> - <%=l.get(1).getFromYear()%>  ते  <%=l.get(1).getToMonth()%> - <%=l.get(1).getToYear() %></b></center></td>
	       			<td><center><%=tOrder.getInvoiceIDMan1()%></center></td>
	       			<td><%=twoDecimalFormatter.format(tOrder.getTotalAmount1())%></td>	            			
	       		</tr>
	       		<tr class="fontMarathiNumber right">
	       			<td> <center><%=++i %></center> </td>
	       			<td> <center><%=tOrder.getTalukaMarathi() %></center> </td>
	       			<td><center><b><%=l.get(1).getFromMonth()%> - <%=l.get(1).getFromYear()%>  ते  <%=l.get(1).getToMonth()%> - <%=l.get(1).getToYear() %></b></center></td>
	       			<td><center><%=tOrder.getInvoiceIDMan2()%></center></td>
	       			<td><%=twoDecimalFormatter.format(tOrder.getTotalAmount2())%></td>	            			
	       		</tr>
<%				
			total = total + tOrder.getTotalAmount1()+tOrder.getTotalAmount2();
		}
	}
    
%>	
                <tr class="fontMarathiNumber">
                	<td colspan="4" class="left"><b> अक्षरी रुपये -  <%=nm.convertToWord(total) %></b></td>
                	<td class="right"><%=twoDecimalFormatter.format(total)%></td>
                </tr>			
            </tbody>
   	    </table>   
<%	
	}
    else
    {
    	out.print("<h1><b>No Date is avalable for this Taluka....</b></h1>");
    }
%>		
	</body>
</html>