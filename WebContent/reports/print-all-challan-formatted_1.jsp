<%-- 
    Document   : taluka-report
    Created on : Feb 6, 2013, 2:30:34 PM
    Author     : anita
--%>
<%@page import="java.util.StringTokenizer"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="org.spa.helper.TalukaOrderDetailDSHelper"%>
<%@page import="org.spa.entity.*"%>
<%@page import="org.spa.ds.*"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="org.spa.convert.monthYearToMarathi" %>
<%@page import="org.spa.connect.dbConnection" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html lang="mr">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">        
        <title>HTML Invoice Template</title>
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
            td.right {
                text-align: right;
            }
            tr.right {
                text-align: right;
            }
            right {
                text-align: right;
            }
            .fontMarathiNumber {
                font:normal normal 12px/15px Kiran,Tahoma;
                text-decoration:none;
            }
            .fontMarathiNumber16 {
                font:normal normal bold 18px/22px Kiran,Tahoma;
                text-decoration:none;
                margin: 0px;
                padding:0px;
            }
            .fontMarathiNumber10 {
                font:normal normal 10px/30px Kiran,Tahoma;
                text-decoration:none;
            }
            .fontsize10 {
                font:normal normal 10px Tahoma;
                text-decoration:none;
            }
            .fontsize12
            {
                font:normal normal 12px Tahoma;
                text-decoration:none;
            }
            .fontsize14 {
                font:normal normal 14px Tahoma;
                text-decoration:none;
            }
            .fontsize15 {
                font:normal normal 14.8px Tahoma;
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
                border-width: 0px;
                padding: 0px;
                border-style: inset;
                border-color: gray;
                background-color: white;
            }

			P.breakhere {page-break-before: always;}

            .small  { font-size: 70%; }
            .bold   { font-weight: bold; }
            .notice { color: red; background-color: yellow; }
            @media print  { .noprint  { display: none; border:0} .noborder  {  border:0} }

            @media screen { .noscreen { display: none; } }
            -->
        </style>
<%
	NumberFormat twoDecimalFormatter = new DecimalFormat("#.00");
	NumberFormat threeDecimalFormatter = new DecimalFormat("#0.000");
	NumberFormat zeroDecimalFormatter = new DecimalFormat("#");

    String talukaOrderID = request.getParameter("talukaOrderID");
    String beatID = request.getParameter("beatID");
    int orderType = Integer.parseInt(request.getParameter("orderType"));
/*
    System.out.println("talukaOrderID " + talukaOrderID);
    System.out.println("beatID " + beatID);
    System.out.println("orderType " + orderType);
*/
    int tOrderID = Integer.parseInt(talukaOrderID);
    int tID = Integer.parseInt(beatID);
    int i = 0;

    TalukaOrderDS DS = new TalukaOrderDS();
    DistrictMaster DM = new DistrictMaster();                    
    TalukaOrderDetailDSHelper dSHelper = new TalukaOrderDetailDSHelper();
                              
    TalukaOrder talukaOrderHelper = dSHelper.talukaOrderDetails(tOrderID);                    
    ArrayList<SectionWiseItemSum> sectionOrder = DS.getAllTalukaOrderDetails(tID,tOrderID);
%>
        
    </head>
    <body>  
<%

	String dd = ""; //= st.nextToken("/") ;
	String mm = ""; // st.nextToken("/") ;
	String yy = ""; // st.nextToken("/") ;
	String challanDate = null;
	StringTokenizer st = null;
    SectionWiseItemSum allSum = new SectionWiseItemSum();
    if( orderType == 1 )
    { 
        for(SectionWiseItemSum sectionWiseItemSum : sectionOrder )
        {
	         i = 0; 
	         challanDate = sectionWiseItemSum.getChallanDate();
	         if(challanDate != null) 
	         {
	             st = new StringTokenizer(challanDate,"/");
	             dd=st.nextToken("/");
	             mm =st.nextToken("/");
	             yy =st.nextToken("/");
	         }
%>   			
    	<br/>  
    	<br/>  
    	<br/>  
    	<br/>  
    	<br/>   
        <table align="center" width="1200" >   
			<tr>		
	            <td width="400">
	            	<table>
	            		<tr>
		            		<td width="150"  height="40"><span class="noprint">पावती क्र. </span></td>
		            		<td width="250"><span class="fontMarathiNumber16"><%=sectionWiseItemSum.getChallanNumber()%></span></td>
	            		</tr>
	            	</table>
	            </td>
	            <td width="500" class="center"><span class="noprint">शालेय पोषण आहार धान्यादी मालाची पोहोच पावती</span></td>
	            <td width="300">
	            	<table>
	            		<tr>
		            		<td width="50"><span class="noprint">दिनांक</span>&nbsp;</td>
		            		<td width="350"><span class="fontsize15"><font face="Kiran"><%=dd%></font>/<font  face="Kiran"><%=mm%></font>/<font face="Kiran"><%=yy%></font></span></td>
	            		</tr>
	            	</table>
	            </td>
			</tr>
			<tr>
				<td colspan="3" class="fontsize12"><span class="noprint">प्रती,</span>&nbsp;</td>
			</tr>
			<tr>
				<td colspan="3" class="fontsize12" height="10"><span class="noprint">शाळा प्रमुख / मुख्याध्यापक</span>&nbsp;</td>
			</tr>
			<tr>
				<td colspan="2" >
					<table width="900">
						<tr>
							<td width ="300" class="fontsize10" height="15"><span class="noprint">शाळेचे नाव</span>&nbsp;</td>
							<td width ="600" class="fontsize15"><%=sectionWiseItemSum.getSchoolMarathi() %></td>
						</tr>
					</table>
				</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td colspan="2" >
					<table width="900">
						<tr>
							<td width ="300" class = "fontsize10" height="15"><span class="noprint">तालुका</span>&nbsp;</td>
							<td width ="250" class="fontsize15"><%=talukaOrderHelper.getTalukaName()%></td>
							<td width ="100" class = "fontsize10" ><span class="noprint">जिल्हा</span>&nbsp;</td>
							<td width ="250" class="fontsize15"><%=talukaOrderHelper.getDistrictName()%></td>
						</tr>
					</table>
				</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td colspan="3" class="fontsize10"><span class="noprint">महोदय,</span></td>
			</tr>
			<tr>
				<td colspan="2" >
					<table>
						<tr>
							<td width ="300" class="fontsize10"><span class="noprint">आपल्या मागणीनुसार आपणांस माहे </span>&nbsp;</td>
							<td width ="600" class="fontsize15"><%=talukaOrderHelper.getFromMonth() %>-<%=talukaOrderHelper.getFromYear() %> व <%=talukaOrderHelper.getToMonth() %>-<%=talukaOrderHelper.getToYear() %> <span class="noprint fontsize10"> करिता </span></td>
						</tr>
					</table>
				</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td colspan="3" >
					<table>
						<tr>
							<td width ="75" ><span class="fontsize10 noprint">इयत्ता</span>&nbsp;&nbsp;&nbsp;</td>
							<td class="fontsize15"> <%=talukaOrderHelper.getOrderTypeDetails() %> <span class="fontsize10 noprint"> साठी खालील तपशिलाप्रमाणे शालेय पोषण आहार योजनेअंतर्गत धान्यादी वस्तुंचा पुरवठा करण्यात आला आहे. </span></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td colspan="2" >
					<table>
						<tr>
							<td width ="300"><span class="fontsize10 noprint">सदर वस्तुंचा पुरवठा वाहन क्र.</span>&nbsp;</td>
							<td width ="600" class="fontsize15"> <%if(sectionWiseItemSum.getTruckNo() != null){out.print(sectionWiseItemSum.getTruckNo());}else{out.print("");} %>	<span class="fontsize10 noprint">मधुन करण्यात आला आहे.</span></td>
						</tr>
					</table>
				</td>
				<td>&nbsp;</td>
			</tr>
			
			<tr>
				<td colspan="2" >
					<table>
						<tr height="10">
	                         <th width="100" ><span class="fontsize14 noprint">अ. क्र.</span></th>
	                         <th width="300" ><span class="fontsize14 noprint">धान्याचे नाव</span></th>
	                         <th width="500" colspan="2"><span class="fontsize14 noprint">एकूण पुर-वठा(किलो)</span></th>
	                     </tr>
	                     <tr>
	                         <td width="100" class="center"><span class="fontsize14 noprint">1</span></td>
	                         <td width="300" class="center"><span class="fontsize14 noprint">तांदुळ</span></td>
	                         <td width="250" class="left"><span class="fontMarathiNumber16">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=(long)(sectionWiseItemSum.getTandul()) %>&nbsp;&nbsp;</span></td>
	                         <td width="250" class="left"><span class="fontMarathiNumber16">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<% if((sectionWiseItemSum.getTandul()-(long)sectionWiseItemSum.getTandul())*1000 == 0){out.print("000");}else{out.print(Math.round((sectionWiseItemSum.getTandul()-(long)sectionWiseItemSum.getTandul())*1000));} %></span></td>
	                     </tr>
		             </table> 		             
		         </td> 
				 <td>&nbsp;</td>
          	</tr>
	    </table> 
        <p class="breakhere"></p>
<%
        }  
    }
    else
    { 
        for(SectionWiseItemSum sectionWiseItemSum : sectionOrder )
        {
	         i = 0; 
	         challanDate = sectionWiseItemSum.getChallanDate();
	         if(challanDate != null) 
	         {
	             st = new StringTokenizer(challanDate,"/");
	             dd=st.nextToken("/");
	             mm =st.nextToken("/");
	             yy =st.nextToken("/");
	         }
%>   	
        <table align="center" width="1200" >   
			<tr>		
	            <td width="400" height="10">
	            	<table>
	            		<tr>
		            		<td width="100"><span class="noprint">पावती क्र. </span></td>
		            		<td width="300"><span class="fontMarathiNumber16"><%=sectionWiseItemSum.getChallanNumber()%></span></td>
	            		</tr>
	            	</table>
	            </td>
	            <td width="900" class="center"><span class="noprint">शालेय पोषण आहार धान्यादी मालाची पोहोच पावती</span></td>
	            <td width="300">
	            	<table>
	            		<tr>
		            		<td width="200"><span class="noprint">दिनांक</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
		            		<td width="200"><span class="fontsize15"><font face="Kiran"><%=dd%></font>/<font  face="Kiran"><%=mm%></font>/<font face="Kiran"><%=yy%></font></span></td>
	            		</tr>
	            	</table>
	            </td>
			</tr>
			<tr>
				<td colspan="3" class="fontsize12"><span class="noprint">प्रती,</span>&nbsp;</td>
			</tr>
			<tr>
				<td colspan="3" class="fontsize12" height="40"><span class="noprint">शाळा प्रमुख / मुख्याध्यापक</span>&nbsp;</td>
			</tr>
			<tr>
				<td colspan="2" >
					<table>
						<tr>
							<td width ="320" class="fontsize10" height="30"><span class="noprint">शाळेचे नाव</span>&nbsp;</td>
							<td width ="580" class="fontsize15"><%=sectionWiseItemSum.getSchoolMarathi() %></td>
						</tr>
					</table>
				</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td colspan="2" >
					<table>
						<tr>
							<td width ="320" class = "fontsize10" height="30"><span class="noprint">तालुका</span>&nbsp;</td>
							<td width ="225" class="fontsize15"><%=talukaOrderHelper.getTalukaName()%></td>
							<td width ="130" class = "fontsize10" ><span class="noprint">जिल्हा</span>&nbsp;</td>
							<td width ="225" class="fontsize15"><%=talukaOrderHelper.getDistrictName()%></td>
						</tr>
					</table>
				</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td colspan="3" class="fontsize10"><span class="noprint">महोदय,</span></td>
			</tr>
			<tr>
				<td colspan="2" >
					<table>
						<tr>
							<td width ="320" class = "fontsize10" height="20"><span class="noprint">आपल्या मागणीनुसार आपणांस माहे </span>&nbsp;</td>
							<td width ="580" class="fontsize15"><%=talukaOrderHelper.getFromMonth() %>-<%=talukaOrderHelper.getFromYear() %> व <%=talukaOrderHelper.getToMonth() %>-<%=talukaOrderHelper.getToYear() %> <span class="noprint fontsize10"> करिता </span></td>
						</tr>
					</table>
				</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td colspan="3" >
					<table>
						<tr>
							<td width ="20"><span class="fontsize10 noprint">इयत्ता</span>&nbsp;</td>
							<td class="fontsize15"> <%=talukaOrderHelper.getOrderTypeDetails() %> <span class="fontsize10 noprint"> साठी खालील तपशिलाप्रमाणे शालेय पोषण आहार योजनेअंतर्गत धान्यादी वस्तुंचा पुरवठा करण्यात आला आहे. </span></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td colspan="2" >
					<table>
						<tr>
							<td width ="320"><span class="fontsize10 noprint">सदर वस्तुंचा पुरवठा वाहन क्र.</span>&nbsp;</td>
							<td width ="580" class="fontsize15"> <%if(sectionWiseItemSum.getTruckNo() != null){out.print(sectionWiseItemSum.getTruckNo());}else{out.print("");} %>	<span class="fontsize10 noprint">मधुन करण्यात आला आहे.</span></td>
						</tr>
					</table>
				</td>
				<td>&nbsp;</td>
			</tr>
			
			<tr>
				<td colspan="2" >
					<table>
						<tr height="28">
	                         <th width="100" ><span class="fontsize14 noprint">अ. क्र.</span></th>
	                         <th width="200" ><span class="fontsize14 noprint">पुरवठा प्रकार</span></th>
	                         <th width="100" colspan="2"><span class="fontsize14 noprint">एकूण पुर-वठा(किलो)</span></th>
	                         <th width="150" ><span class="fontsize14 noprint">अ. क्र.</span></th>
	                         <th width="200" ><span class="fontsize14 noprint">पुरवठा प्रकार</span></th>
	                         <th width="150" colspan="2"><span class="fontsize14 noprint">एकूण पुर-वठा(किलो)</span></th>
	                     </tr>
	                     <tr>
	                         <td width="100" class="center"><span class="fontsize14 noprint">1</span></td>
	                         <td width="200" class="center"><span class="fontsize14 noprint">तुर डाळ</span></td>
	                         <td width="75" class="right"><span class="fontMarathiNumber16"><%=(long)(sectionWiseItemSum.getMungdaal()) %>&nbsp;&nbsp;</span></td>
	                         <td width="25" class="right"><span class="fontMarathiNumber16"><% if((sectionWiseItemSum.getMungdaal()-(long)sectionWiseItemSum.getMungdaal())*1000 == 0){out.print("000");}else{out.print(Math.round((sectionWiseItemSum.getMungdaal()-(long)sectionWiseItemSum.getMungdaal())*1000));} %></span></td>
	                         <td width="150" class="center"><span class="fontsize14 noprint">7</span></td>
	                         <td width="200" class="center"><span class="fontsize14 noprint">मीठ (आयोडिनयुक्त)</span></td>
	                         <td width="75" class="right"><span class="fontMarathiNumber16"><%=(long)(sectionWiseItemSum.getMith()) %></span></td>
	                         <td width="75" class="right"><span class="fontMarathiNumber16"><% if((sectionWiseItemSum.getMith()-(long)sectionWiseItemSum.getMith())*1000 == 0){out.print("000");}else{out.print(Math.round((sectionWiseItemSum.getMith()-(long)sectionWiseItemSum.getMith())*1000));} %></span></td>
	                     </tr>
	                     <tr>
	                         <td width="100" class="center"><span class="fontsize14 noprint">2</span></td>
	                         <td width="200" class="center"><span class="fontsize14 noprint">तुर डाळ</span></td>
	                         <td width="75" class="right"><span class="fontMarathiNumber16"><%=(long)(sectionWiseItemSum.getMatki()) %>&nbsp;&nbsp;</span></td>
	                         <td width="25" class="right"><span class="fontMarathiNumber16"><% if((sectionWiseItemSum.getMatki()-(long)sectionWiseItemSum.getMatki())*1000 == 0){out.print("000");}else{out.print(Math.round((sectionWiseItemSum.getMatki()-(long)sectionWiseItemSum.getMatki())*1000));} %></span></td>
	                         <td width="150" class="center"><span class="fontsize14 noprint">8</span></td>
	                         <td width="200" class="center"><span class="fontsize14 noprint">कांदा लसूण मसाला</span></td>
	                         <td width="75" class="right"><span class="fontMarathiNumber16"><%=(long)(sectionWiseItemSum.getMirchi()) %></span></td>
	                         <td width="75" class="right"><span class="fontMarathiNumber16"><% if((sectionWiseItemSum.getMirchi()-(long)sectionWiseItemSum.getMirchi())*1000 == 0){out.print("000");}else{out.print(Math.round((sectionWiseItemSum.getMirchi()-(long)sectionWiseItemSum.getMirchi())*1000));} %></span></td>
	                     </tr>
	                     <tr>
	                         <td width="100" class="center"><span class="fontsize14 noprint">3</span></td>
	                         <td width="200" class="center"><span class="fontsize14 noprint">हरभरा</span></td>
	                         <td width="75" class="right"><span class="fontMarathiNumber16"><%=(long)(sectionWiseItemSum.getMung()) %>&nbsp;&nbsp;</span></td>
	                         <td width="25" class="right"><span class="fontMarathiNumber16"><% if((sectionWiseItemSum.getMung()-(long)sectionWiseItemSum.getMung())*1000 == 0){out.print("000");}else{out.print(Math.round((sectionWiseItemSum.getMung()-(long)sectionWiseItemSum.getMung())*1000));} %></span></td>
	                         <td width="150" class="center"><span class="fontsize14 noprint">9</span></td>
	                         <td width="200" class="center"><span class="fontsize14 noprint">हळद (अॅगमार्क)</span></td>
	                         <td width="75" class="right"><span class="fontMarathiNumber16"><%=(long)(sectionWiseItemSum.getHalad()) %></span></td>
	                         <td width="75" class="right"><span class="fontMarathiNumber16"><% if((sectionWiseItemSum.getHalad()-(long)sectionWiseItemSum.getHalad())*1000 == 0){out.print("000");}else{out.print(Math.round((sectionWiseItemSum.getHalad()-(long)sectionWiseItemSum.getHalad())*1000));} %></span></td>
	                     </tr>
	                     <tr>
	                         <td width="100" class="center"><span class="fontsize14 noprint">4</span></td>
	                         <td width="200" class="center"><span class="fontsize14 noprint">मटकी</span></td>
	                         <td width="75" class="right"><span class="fontMarathiNumber16"><%=(long)(sectionWiseItemSum.getMasuldaal()) %>&nbsp;&nbsp;</span></td>
	                         <td width="25" class="right"><span class="fontMarathiNumber16"><% if((sectionWiseItemSum.getMasuldaal()-(long)sectionWiseItemSum.getMasuldaal())*1000 == 0){out.print("000");}else{out.print(Math.round((sectionWiseItemSum.getMasuldaal()-(long)sectionWiseItemSum.getMasuldaal())*1000));} %></span></td>
	                         <td width="150" class="center"><span class="fontsize14 noprint">10</span></td>
	                         <td width="200" class="center"><span class="fontsize14 noprint">जिरे</span></td>
	                         <td width="75" class="right"><span class="fontMarathiNumber16"><%=(long)(sectionWiseItemSum.getJire()) %></span></td>
	                         <td width="75" class="right"><span class="fontMarathiNumber16"><% if((sectionWiseItemSum.getJire()-(long)sectionWiseItemSum.getJire())*1000 == 0){out.print("000");}else{out.print(Math.round((sectionWiseItemSum.getJire()-(long)sectionWiseItemSum.getJire())*1000));} %></span></td>
	                     </tr>
	                     <tr>
	                         <td width="100" class="center"><span class="fontsize14 noprint">5</span></td>
	                         <td width="200" class="center"><span class="fontsize14 noprint">चवली</span></td>
	                         <td width="75" class="right"><span class="fontMarathiNumber16"><%=(long)(sectionWiseItemSum.getChvli()) %>&nbsp;&nbsp;</span></td>
	                         <td width="25" class="right"><span class="fontMarathiNumber16"><% if((sectionWiseItemSum.getChvli()-(long)sectionWiseItemSum.getChvli())*1000 == 0){out.print("000");}else{out.print(Math.round((sectionWiseItemSum.getChvli()-(long)sectionWiseItemSum.getChvli())*1000));} %></span></td>
	                         <td width="150" class="center"><span class="fontsize14 noprint">11</span></td>
	                         <td width="200" class="center"><span class="fontsize14 noprint">मोहरी</span></td>
	                         <td width="75" class="right"><span class="fontMarathiNumber16"><%=(long)(sectionWiseItemSum.getMohari()) %></span></td>
	                         <td width="75" class="right"><span class="fontMarathiNumber16"><% if((sectionWiseItemSum.getMohari()-(long)sectionWiseItemSum.getMohari())*1000 == 0){out.print("000");}else{out.print(Math.round((sectionWiseItemSum.getMohari()-(long)sectionWiseItemSum.getMohari())*1000));} %></span></td>
	                     </tr>	                     
	                     <tr>
	                         <td width="100" class="center"><span class="fontsize14 noprint">6</span></td>
	                         <td width="200" class="center"><span class="fontsize14 noprint">तेल (सोया अॅगमार्क)</span></td>
	                         <td width="100" class="right" colspan="2"><span class="fontMarathiNumber16"><%=threeDecimalFormatter.format(sectionWiseItemSum.getTel()) %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></td>
	                         <td width="150" class="center"><span class="fontsize14 noprint">12</span></td>
	                         <td width="200" class="center"><span class="fontsize14 noprint"></span>&nbsp;</td>
	                         <td width="150" class="right" colspan="2"><span class="fontMarathiNumber16 right">&nbsp;</span></td>
	                     </tr>
		             </table> 		             
		         </td> 
				 <td>&nbsp;</td>
          	</tr>
	    </table> 
<%
        }  
    }
%>       
	</body>
</html>
