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
        <title>बीट गोषवारा</title>
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
            .fontMarathiNumber14 {
                font:normal normal bold 16px/20px Kiran,Tahoma;
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
<%
	NumberFormat twoDecimalFormatter = new DecimalFormat("#0.00");
    NumberFormat zeroDecimalFormatter = new DecimalFormat("#0");

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
        <table align="center" width="1200" border="1">   
        
<%

	String dd = ""; //= st.nextToken("/") ;
	String mm = ""; // st.nextToken("/") ;
	String yy = ""; // st.nextToken("/") ;
	String challanDate = null;
	StringTokenizer st = null;
    SectionWiseItemSum allSum = new SectionWiseItemSum();
    if( orderType == 2 )
    { 
        for(SectionWiseItemSum sectionWiseItemSum : sectionOrder )
        {
            for(int k =1; k<=2;k++)
            {
%>
        	<tr>
<%
               for(int j =1; j<=2;j++)
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
		        <td>
		             <table align="center" width="600" height ="50%" cellspacing="1" cellpadding="1"> 
		                 <tr class="center">
		                     <td colspan="3" class="fontsize14"><b>प्राथमिक शिक्षण संचनालय</b></td>
		                 </tr>
		                 <tr class="fontsize14 center">
		                     <td colspan="3" class="fontsize14"><b>डॉ. अॅनी बेझंट मार्ग , मध्यवर्ती इमारत, पुणे-४११००१</b></td>
		                 </tr>
		                 <tr class="fontsize10 center">
		                     <td colspan="3">दुरध्वनी (०२०)२६१२१३९४/९६, फॅक्स(०२०)२६०५४१०३/२६१२८१५ ई-मेल :depmah@gmail.com</td>
		                 </tr>
		                 <tr class="fontsize10">
		                     <td colspan="3">   <hr>
		                     </td>
		                 </tr>
		                 <tr class="fontsize10">
		                     <td  width="250">प्रती,</td>
		                     <td width="200"></td>
		                     <td width="200" height="10">पावती क्र. <span class="fontMarathiNumber14"><%=sectionWiseItemSum.getChallanNumber()%></span></td>
		                 </tr>
		                 <tr class="fontsize10">
		                     <td>शाळा प्रमुख / मुख्याध्यापक</td>
		                     <td></td>
		                     <td class="fontMarathiNumber10">दिनांक : <span class="fontsize14"><font face="Kiran"><%=dd%></font>/<font  face="Kiran"><%=mm%></font>/<font face="Kiran"><%=yy%></font></span></td>
		                 </tr>
		                 <tr class="fontsize10">
		                     <td colspan="2">शाळेचे नाव : <%=sectionWiseItemSum.getSchoolMarathi() %></td>
		                     <td></td>
		                 </tr>
		                 <tr>
		                     <td colspan="3" class="fontsize10">ता.<%=talukaOrderHelper.getTalukaName()%>, जि. <%=talukaOrderHelper.getDistrictName()%> </td>
		                 </tr>
		                 <tr>
		                     <td colspan="3" class="fontsize14 center">विषय : शालेय पोषण आहार तांदूळ मालाची पोहोच पावती</td>
		                 </tr>
		                 <tr>
		                     <td colspan="3" class="fontsize10">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;आपल्या मागणीनुसार आपणांस माहे <%=talukaOrderHelper.getFromMonth() %>-<%=talukaOrderHelper.getFromYear() %> व <%=talukaOrderHelper.getToMonth() %>-<%=talukaOrderHelper.getToYear() %> करिता इयत्ता <%=talukaOrderHelper.getOrderTypeDetails() %> साठी खालील तपशिलाप्रमाणे शालेय पोषण आहार योजनेअंतर्गत धान्यादी वस्तुंचा पुरवठा करण्यात आला आहे.</td>
		                 </tr>
		                 <tr>
		                     <td colspan="3" class="fontsize10">सदर वस्तुंचा पुरवठा वाहन क्र.<%if(sectionWiseItemSum.getTruckNo() != null){out.print(sectionWiseItemSum.getTruckNo());}else{out.print("_______________");} %> मधुन करण्यात आला आहे.</td>
		                 </tr>
		             </table>
		             <table align="center" class="printstyle" width="600" cellspacing="1" cellpadding="1">           
		                 <tbody>
		                     <tr>
		                         <th width="10%" >अ. क्र.</th>
		                         <th width="30%" >पुरवठा प्रकार</th>
		                         <th width="20%" >एकूण पुर-<br/>वठा(किलो)</th>
		                         <th width="10%" >अ. क्र.</th>
		                         <th width="30%" >पुरवठा प्रकार</th>
		                         <th width="20%" >एकूण पुर-<br/>वठा(किलो)</th>
		                     </tr>
							 <tr>
								 <th class="fontMarathiNumber"><%=1%></th>
								 <th class="fontsize12 center" >मुंगदाळ</th>
								 <th class="fontMarathiNumber"><%=sectionWiseItemSum.getMungdaal() %></th>
								 <th class="fontMarathiNumber"><%=8%></th>
								 <th class="fontsize12 center">तेल (सोया अॅगमार्क)</th>
								 <th class="fontMarathiNumber"><%=sectionWiseItemSum.getTel() %></th>
							 </tr>
							 <tr>
								 <th class="fontMarathiNumber"><%=2%></th>
								 <th class="fontsize12 center">तुर डाळ</th>
								 <th class="fontMarathiNumber"><%=sectionWiseItemSum.getMatki() %></th>
								 <th class="fontMarathiNumber"><%=9%></th>
								 <th class="fontsize12 center">मीठ (आयोडिनयुक्त)</th>
								 <th class="fontMarathiNumber"><%=sectionWiseItemSum.getMith() %></th>
							 </tr>
							 <tr>
								 <th class="fontMarathiNumber"><%=3%></th>
								 <th class="fontsize12 center">Extra2</th>
								 <th class="fontMarathiNumber"><%=sectionWiseItemSum.getExtra2() %></th>
								 <th class="fontMarathiNumber"><%=10%></th>
								 <th class="fontsize12 center">कांदा लसूण मसाला</th>
								 <th class="fontMarathiNumber"><%=sectionWiseItemSum.getMirchi() %></th>
							 </tr>
							 <tr>
								 <th class="fontMarathiNumber"><%=4%></th>
								 <th class="fontsize12 center">मुंग</th>
								 <th class="fontMarathiNumber"><%=sectionWiseItemSum.getMung() %></th>
								 <th class="fontMarathiNumber"><%=11%></th>
								 <th class="fontsize12 center">हळद (अॅगमार्क)</th>
								 <th class="fontMarathiNumber"><%=sectionWiseItemSum.getHalad() %></th>
							 </tr>
							 <tr>
								 <th class="fontMarathiNumber"><%=5%></th>
								 <th class="fontsize12 center">मटकी</th>
								 <th class="fontMarathiNumber"><%=sectionWiseItemSum.getMasuldaal() %></th>
								 <th class="fontMarathiNumber"><%=12%></th>
								 <th class="fontsize12 center">जिरे</th>
								 <th class="fontMarathiNumber"><%=sectionWiseItemSum.getJire() %></th>
							 </tr>
							 <tr>
								 <th class="fontMarathiNumber"><%=6%></th>
								 <th class="fontsize12 center">हरभरा</th>
								 <th class="fontMarathiNumber"><%=sectionWiseItemSum.getHarbara() %></th>
								 <th class="fontMarathiNumber"><%=13%></th>
								 <th class="fontsize12 center">मोहरी</th>
								 <th class="fontMarathiNumber"><%=sectionWiseItemSum.getMohari() %></th>
							 </tr>
							 <tr>
								 <th class="fontMarathiNumber"><%=7%></th>
								 <th class="fontsize12 center">वटाणा</th>
								 <th class="fontMarathiNumber"><%=sectionWiseItemSum.getVatana() %></th>
								 <th class="fontMarathiNumber"></th>
								 <th class="fontsize12 center"></th>
								 <th class="fontMarathiNumber"></th>
							 </tr>
							 <tr>
								 <th class="fontMarathiNumber"><%=8%></th>
								 <th class="fontsize12 center">सोया वडी</th>
								 <th class="fontMarathiNumber"><%=sectionWiseItemSum.getExtra1() %></th>
								 <th class="fontMarathiNumber"></th>
								 <th class="fontsize12 center"></th>
								 <th class="fontMarathiNumber"></th>
							 </tr>
							 <!--
							 <tr>
								 <th class="fontMarathiNumber"><%=9%></th>
								 <th class="fontsize12 center">Extra3</th>
								 <th class="fontMarathiNumber"><%=sectionWiseItemSum.getExtra3() %></th>
								 <th class="fontMarathiNumber"></th>
								 <th class="fontsize12 center"></th>
								 <th class="fontMarathiNumber"></th>
							 </tr>
							 <tr>
								 <th class="fontMarathiNumber"><%=10%></th>
								 <th class="fontsize12 center">Extra4</th>
								 <th class="fontMarathiNumber"><%=sectionWiseItemSum.getExtra4() %></th>
								 <th class="fontMarathiNumber"></th>
								 <th class="fontsize12 center"></th>
								 <th class="fontMarathiNumber"></th>
							 </tr>
							 <tr>
								 <th class="fontMarathiNumber"><%=11%></th>
								 <th class="fontsize12 center">Extra5</th>
								 <th class="fontMarathiNumber"><%=sectionWiseItemSum.getExtra5() %></th>
								 <th class="fontMarathiNumber"></th>
								 <th class="fontsize12 center"></th>
								 <th class="fontMarathiNumber"></th>
							 </tr>
							 <tr>
								 <th class="fontMarathiNumber"><%=12%></th>
								 <th class="fontsize12 center">Extra6</th>
								 <th class="fontMarathiNumber"><%=sectionWiseItemSum.getExtra6() %></th>
								 <th class="fontMarathiNumber"></th>
								 <th class="fontsize12 center"></th>
								 <th class="fontMarathiNumber"></th>
							 </tr>
							 -->
							 <tr>
								 <th class="fontMarathiNumber"><%=7%></th>
								 <th class="fontsize12 center">चवली</th>
								 <th class="fontMarathiNumber"><%=sectionWiseItemSum.getChvli() %></th>
							 </tr>
		                 </tbody>
		             </table> 
		             <table>
		                 <tr  class="fontsize10">
		                     <td></td>
		                     <td colspan="2" class="fontsize10 center">(सही/हुुद्दा) प्रतिनिधी</td>
		                 </tr>
		                 <tr  class="fontsize10">
		                     <td></td>
		                     <td colspan="2" class="fontsize10 center">महाराष्ट्र स्टेट को-अॉप. कन्झुमर्स फेडरेशन, मुंबई</td>
		                 </tr >
		                 <tr class="fontsize10">
		                     <td colspan="3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;वरील तपशिलाप्रमाणे शालेय पोषण आहार योजनेचा धान्यादी माल प्रत्यक्ष मोजून माझ्या ताब्यात मिळाला. तो योग्य दर्जाचा व वजनाचा प्राप्त झाला. करिता पोहोच पावती देण्यात येत आहे.</td>
		                 </tr>
		                 <tr>
		                     <td height="15"></td>
		                     <td></td>
		                     <td> </td>
		                 </tr>
		                 <tr class="fontsize10">
		                     <td width="33%">प्रत,</td>
		                     <td width="33%"></td>
		                     <td>माल ताब्यात घेणारयाची सही/ शिक्का</td>
		                 </tr>
		                  <tr>
		                     <td colspan="3" class="fontsize10">गटशिक्षणाधिकारी / प्रशासन अधिकारी / शिक्षण प्रमुख / शिक्षणाधिकारी महानगरपालिका (सर्व)</td>
		                 </tr>
		             </table>
		         </td> 
<%
        		}
%>
          	</tr>
<%
            }
        }  
    }
    else
    { 
        for(SectionWiseItemSum sectionWiseItemSum : sectionOrder )
        {
            for(int k =1; k<=2;k++)
            {
%>
         	<tr>
<%
		        for(int j =1; j<=2;j++)
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
				<td>
				    <table align="center" width="600" height ="50%" cellspacing="1" cellpadding="1"> 
				        <tr class="center">
				            <td colspan="3" class="fontsize14"><b>प्राथमिक शिक्षण संचनालय</b></td>
				        </tr>
				        <tr class="fontsize14 center">
				            <td colspan="3" class="fontsize14"><b>डॉ. अॅनी बेझंट मार्ग , मध्यवर्ती इमारत, पुणे-४११००१</b></td>
				        </tr>
				        <tr class="fontsize10 center">
				            <td colspan="3">दुरध्वनी (०२०)२६१२१३९४/९६, फॅक्स(०२०)२६०५४१०३/२६१२८१५ ई-मेल :depmah@gmail.com</td>
				        </tr>
				        <tr class="fontsize10">
				            <td colspan="3">   <hr>
				            </td>
				        </tr>
				        <tr class="fontsize10">
				            <td  width="250">प्रती,</td>
				            <td width="200"></td>
				            <td width="200" height="10">पावती क्र. <span class="fontMarathiNumber14"><%=sectionWiseItemSum.getChallanNumber()%></span></td>
				        </tr>
				        <tr class="fontsize10">
				            <td>शाळा प्रमुख / मुख्याध्यापक</td>
				            <td></td>
				            <td>दिनांक : <span class="fontsize14"><font class="fontMarathiNumber14"><%=dd%></font>/<font class="fontMarathiNumber14"><%=mm%></font>/<font class="fontMarathiNumber14"><%=yy%></font></span></td>
				        </tr>
				        <tr class="fontsize10">
				            <td colspan="2">शाळेचे नाव</td>
				            <td></td>
				        </tr>
				        <tr>
				            <td colspan="3" class="fontsize10">ता.<%=talukaOrderHelper.getTalukaName()%>, जि. <%=talukaOrderHelper.getDistrictName()%> </td>
				        </tr>
				        <tr>
				            <td colspan="3" class="fontsize14 center">विषय : शालेय पोषण आहार तांदूळ मालाची पोहोच पावती</td>
				        </tr>
				        <tr>
				            <td colspan="3" class="fontsize10">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;आपल्या मागणीनुसार आपणांस माहे <%=talukaOrderHelper.getFromMonth() %>-<%=talukaOrderHelper.getFromYear() %> व <%=talukaOrderHelper.getToMonth() %>-<%=talukaOrderHelper.getToYear() %> करिता इयत्ता <%=talukaOrderHelper.getOrderTypeDetails() %> साठी खालील तपशिलाप्रमाणे शालेय पोषण आहार योजनेअंतर्गत तांदुळाचा पुरवठा करण्यात आला आहे.</td>
				        </tr>
				        <tr>
				            <td colspan="3" class="fontsize10">सदर वस्तुंचा पुरवठा वाहन क्र.<%if(sectionWiseItemSum.getTruckNo() != null){out.print(sectionWiseItemSum.getTruckNo());}else{out.print("_______________");} %> मधुन करण्यात आला आहे.</td>
				        </tr>
				    </table>
				    <table align="center" class="printstyle" width="600" cellspacing="1" cellpadding="1">           
				        <tbody>
				            <tr>
				                <th width="10%" >अ. क्र.</th>
				                <th width="30%" >पुरवठा प्रकार</th>
				                <th width="20%" >एकूण पुरवठा(किलो)</th>
				            </tr>
				            <tr>
				                <th class="fontMarathiNumber"><%=1%></th>
				                <th class="fontsize12 center">तांदूळ</th>
				                <th class="fontMarathiNumber"><%=sectionWiseItemSum.getTandul() %></th>
				            </tr>
				        </tbody>
				    </table> 
				    <br/><br/><br/><br/><br/>
				    <table>
				        <tr  class="fontsize10">
				            <td></td>
				            <td colspan="2" class="fontsize10 center">(सही/हुुद्दा) प्रतिनिधी</td>
				        </tr>
				        <tr  class="fontsize10">
				            <td></td>
				            <td colspan="2" class="fontsize10 center">महाराष्ट्र स्टेट को-अॉप. कन्झुमर्स फेडरेशन, मुंबई</td>
				        </tr >
				        <tr class="fontsize10">
				            <td colspan="3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;वरील तपशिलाप्रमाणे शालेय पोषण आहार योजनेचा धान्यादी माल प्रत्यक्ष मोजून माझ्या ताब्यात मिळाला. तो योग्य दर्जाचा व वजनाचा प्राप्त झाला. करिता पोहोच पावती देण्यात येत आहे.</td>
				        </tr>
				        <tr>
				            <td height="15"></td>
				            <td></td>
				            <td> </td>
				        </tr>
				        <tr class="fontsize10">
				            <td width="33%">प्रत,</td>
				            <td width="33%"></td>
				            <td>माल ताब्यात घेणारयाची सही/ शिक्का</td>
				        </tr>
				         <tr>
				            <td colspan="3" class="fontsize10">गटशिक्षणाधिकारी / प्रशासन अधिकारी / शिक्षण प्रमुख / शिक्षणाधिकारी महानगरपालिका (सर्व)</td>
				        </tr>
				    </table>
				</td> 
				                
<%
               	}
%>
       		</tr>
<%
            }
 		}  
	}
%>
	    </table>        
	</body>
</html>
