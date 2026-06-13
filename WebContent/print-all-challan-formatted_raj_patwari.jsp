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
                margin-left:05px;
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
                font:normal normal bold 18px/18px Kiran,Tahoma;
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
                font:normal normal 15px Tahoma;
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
    </head>
    <body>
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
    ArrayList<SectionWiseItemSum> sectionOrder = DS.getAllTalukaOrderDetailsforChallan(tID,tOrderID);

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
        	 i++;
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
        <table align="center" width="1200" >  
			<tr>		
	            <td width="400" height="73">
	            	<table>
	            		<tr>
		            		<td width="100"  height="40"><span class="noprint">पावती क्र. </span></td>
		            		<td width="300"><span class="fontMarathiNumber16"><%=sectionWiseItemSum.getChallanNumber()%></span></td>
	            		</tr>
	            	</table>
	            </td>
	            <td width="500" class="center"><span class="noprint">शालेय पोषण आहार धान्यादी मालाची पोहोच पावती</span></td>
	            <td width="300">
	            	<table>
	            		<tr>
		            		<td width="50"><span class="noprint">दिनांक</span>&nbsp;</td>
		            		<td width="350">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="fontsize16"><font face="Kiran"><%=dd%></font>/<font  face="Kiran"><%=mm%></font>/<font face="Kiran"><%=yy%></font></span></td>
	            		</tr>
	            	</table>
	            </td>
			</tr>
			<tr>
				<td colspan="3" class="fontsize12"><span class="noprint">प्रती,</span>&nbsp;</td>
			</tr>
			<tr>
				<td colspan="3" class="fontsize12"><span class="noprint">शाळा प्रमुख / मुख्याध्यापक</span>&nbsp;</td>
			</tr>
			<tr>
				<td colspan="2" >
					<table width="900"  cellspacing="0">
						<tr>
							<td width ="300" class="fontsize10"><span class="noprint">शाळेचे नाव</span>&nbsp;</td>
							<td width ="600" class="fontsize15"><%=sectionWiseItemSum.getSchoolMarathi() %></td>
						</tr>
					</table>
				</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td colspan="2" >
					<table width="900"  cellspacing="0">
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
				<td colspan="3" class="fontsize12"><span class="noprint">महोदय,</span></td>
			</tr>
			<tr>
				<td colspan="2" >
					<table cellspacing="0">
						<tr>
							<td width ="300" class="fontsize10"><span class="noprint">आपल्या मागणीनुसार आपणांस माहे </span>&nbsp;</td>
							<td width ="600" class="fontsize15" height="30"><%=talukaOrderHelper.getFromMonth() %>-<%=talukaOrderHelper.getFromYear() %> व <%=talukaOrderHelper.getToMonth() %>-<%=talukaOrderHelper.getToYear() %> <span class="noprint fontsize10"> करिता </span></td>
						</tr>
					</table>
				</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td colspan="3" >
					<table cellspacing="0">
						<tr>
							<td width ="75" ><span class="fontsize10 noprint">इयत्ता</span>&nbsp;&nbsp;&nbsp;</td>
							<td class="fontsize15"> <%=talukaOrderHelper.getOrderTypeDetails() %> <span class="fontsize10 noprint"> साठी खालील तपशिलाप्रमाणे शालेय पोषण आहार योजनेअंतर्गत धान्यादी वस्तुंचा पुरवठा करण्यात आला आहे. </span></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td colspan="2" >
					<table cellspacing="0">
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
						<tr height="25">
	                         <th width="100" ><span class="fontsize14 noprint">अ. क्र.</span>&nbsp;</th>
	                         <th width="300" ><span class="fontsize14 noprint">धान्याचे नाव</span>&nbsp;</th>
	                         <th width="500" colspan="2"><span class="fontsize14 noprint">एकूण पुर-वठा(किलो)</span>&nbsp;</th>
	                     </tr>
	                     <tr height="30">
	                         <td colspan="4"></td>
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
    	i=0;
        for(SectionWiseItemSum sectionWiseItemSum : sectionOrder )
        {
        	 i++;
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
        <table align="center">  
			<tr>
				<th width="350">&nbsp;</th>
				<th width="150">&nbsp;</th>
				<th width="700">&nbsp;</th>
				<th width="250">&nbsp;</th>
				<th width="50">&nbsp;</th>
				<th width="50">&nbsp;</th>
				<th width="250">&nbsp;</th>
				<th width="150">&nbsp;</th>
			</tr>
			<tr>		
	            <td colspan="1">
					<td><span class="fontMarathiNumber16"><%=sectionWiseItemSum.getChallanNumber()%></span></td>
				</td>
	            <td colspan="5">
					<td class="right"><span class="fontsize16"><font face="Kiran"><%=dd%></font>/<font  face="Kiran"><%=mm%></font>/<font face="Kiran"><%=yy%></font></span></td>
				</td>
			</tr>
			<tr><td class="fontsize12" height="32"><span class="noprint">प्रती,</span>&nbsp;</td></tr>
			<tr><td class="fontsize12"><span class="noprint">शाळा प्रमुख / मुख्याध्यापक</span>&nbsp;</td></tr>
			<tr>
				<td colspan="2"><td class="fontsize15"><%=sectionWiseItemSum.getSchoolMarathi() %></td></td>
			</tr>
			<tr>
				<td colspan="2">
					<td class="fontsize15"><%=talukaOrderHelper.getTalukaName()%></td>
				</td>
				<td class="fontsize15">&nbsp;&nbsp;&nbsp;<%=talukaOrderHelper.getDistrictName()%></td>
			</tr>
			<tr><td colspan="3" class="fontsize12"><span class="noprint">महोदय,</span></td></tr>
			<tr>
				<td colspan="2">
					<td class="fontsize15" height="35"><%=talukaOrderHelper.getFromMonth() %>-<%=talukaOrderHelper.getFromYear() %> व <%=talukaOrderHelper.getToMonth() %>-<%=talukaOrderHelper.getToYear() %> <span class="noprint fontsize10"> करिता </span></td>
				</td>
			</tr>
			<tr>
				<td class="fontsize15 left"> <%=talukaOrderHelper.getOrderTypeDetails() %> <span class="fontsize10 noprint"> साठी खालील तपशिलाप्रमाणे शालेय पोषण आहार योजनेअंतर्गत धान्यादी वस्तुंचा पुरवठा करण्यात आला आहे.</span></td>
			</tr>
			<tr>
				<td colspan="2">
					<td class="fontsize15"> <%if(sectionWiseItemSum.getTruckNo() != null){out.print(sectionWiseItemSum.getTruckNo());}else{out.print("");} %>	<span class="fontsize10 noprint">मधुन करण्यात आला आहे.</span></td>
				</td>
			</tr>			
			<tr><td height="35">&nbsp;</td></tr>
			<tr>
				<td colspan="2">
					<td class="left">
						<span class="fontMarathiNumber16"><%=(long)(sectionWiseItemSum.getMungdaal()) %></span>
					</td>
				</td>
				<td colspan="3">
					<td class="left">
						<span class="fontMarathiNumber16"><%=(long)(sectionWiseItemSum.getMith()) %>&nbsp;&nbsp;&nbsp;&nbsp;</span>
						<span class="fontMarathiNumber16"><% if((sectionWiseItemSum.getMith()-(long)sectionWiseItemSum.getMith())*1000 == 0){out.print("000");}else{out.print(Math.round((sectionWiseItemSum.getMith()-(long)sectionWiseItemSum.getMith())*1000));} %></span>
					</td>
				</td>
			</tr>
			<tr>
				 <td colspan="2">
					<td class="left">
						<span class="fontMarathiNumber16"><%=(long)(sectionWiseItemSum.getMatki()) %>&emsp;&nbsp;</span>
					</td>
				</td>
				<td colspan="3">
					<td class="left">
						<span class="fontMarathiNumber16"><%=(long)(sectionWiseItemSum.getMirchi()) %></span>
						<span class="fontMarathiNumber16">&nbsp;&nbsp;&nbsp;&nbsp;<% if((sectionWiseItemSum.getMirchi()-(long)sectionWiseItemSum.getMirchi())*1000 == 0){out.print("000");}else{out.print(Math.round((sectionWiseItemSum.getMirchi()-(long)sectionWiseItemSum.getMirchi())*1000));} %></span>
					</td>
				</td>
			</tr>
			<tr>
			<td colspan="2">
					<td class="left">
						<span class="fontMarathiNumber16"><%=(long)(sectionWiseItemSum.getMung()) %>&emsp;&nbsp;</span>
					</td>
				</td>
				<td colspan="3">
					<td class="left">
						<span class="fontMarathiNumber16"><%=(long)(sectionWiseItemSum.getHalad()) %></span>
						<span class="fontMarathiNumber16">&nbsp;&nbsp;&nbsp;&nbsp;<% if((sectionWiseItemSum.getHalad()-(long)sectionWiseItemSum.getHalad())*1000 == 0){out.print("000");}else{out.print(Math.round((sectionWiseItemSum.getHalad()-(long)sectionWiseItemSum.getHalad())*1000));} %></span>
					</td>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<td class="left">
						<span class="fontMarathiNumber16"><%=(long)(sectionWiseItemSum.getMasuldaal()) %>&emsp;&nbsp;</span>
					</td>
				</td>
				<td colspan="3">
					<td class="left">
						<span class="fontMarathiNumber16"><%=(long)(sectionWiseItemSum.getJire()) %></span>
						<span class="fontMarathiNumber16">&nbsp;&nbsp;&nbsp;&nbsp;<% if((sectionWiseItemSum.getJire()-(long)sectionWiseItemSum.getJire())*1000 == 0){out.print("000");}else{out.print(Math.round((sectionWiseItemSum.getJire()-(long)sectionWiseItemSum.getJire())*1000));} %></span>
					</td>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<td class="left">
						<span class="fontMarathiNumber16"><%=(long)(sectionWiseItemSum.getChvli()) %>&emsp;&nbsp;</span>
					</td>
				</td>
				<td colspan="3">
					<td class="left">
						<span class="fontMarathiNumber16"><%=(long)(sectionWiseItemSum.getMohari()) %></span>
						<span class="fontMarathiNumber16">&nbsp;&nbsp;&nbsp;&nbsp;<% if((sectionWiseItemSum.getMohari()-(long)sectionWiseItemSum.getMohari())*1000 == 0){out.print("000");}else{out.print(Math.round((sectionWiseItemSum.getMohari()-(long)sectionWiseItemSum.getMohari())*1000));} %></span>
					</td>
				</td>
			</tr>	  
			<tr>
				<td colspan="2">
					<td class="left">
						<span class="fontMarathiNumber16"><%=threeDecimalFormatter.format(sectionWiseItemSum.getTel()) %></span>
						<span class="fontMarathiNumber16"></span>
					</td>
				</td>
				<td colspan="3">
					<td class="left">
						<span class="fontMarathiNumber16"></span>
						<span class="fontMarathiNumber16"></span>
					</td>
				</td>
		   </tr>
	    </table> 
        <p class="breakhere"></p>
<%
        }  
    }        
%>       
	</body>
</html>