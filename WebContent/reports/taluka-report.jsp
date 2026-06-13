<%-- 
    Document   : taluka-report
    Created on : Feb 6, 2013, 2:30:34 PM
    Author     : anita
--%>
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
        <title>तालुका गोषवारा</title>
        <style>
            .fontMarathiNumber {
                font:normal normal 24px/30px Kiran,Verdana;
                text-decoration:none;
            }
            .fontMarathiNumberBold {
                font:normal normal bold 26px/30px Kiran,Verdana;
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
            .fontsize12 {
                font:normal normal 12px Tahoma;
                text-decoration:none;
            }
            .fontsize14 {
                font:normal normal 14px Tahoma;
                text-decoration:none;
            }
            .fontsize18 {
                font:normal normal bold 18px Tahoma;
                text-decoration:none;
            }

        </style>
        <%
                    NumberFormat twoDecimalFormatter = new DecimalFormat("#0.00");
                    NumberFormat zeroDecimalFormatter = new DecimalFormat("#0");
                    NumberFormat oneDecimalFormatter = new DecimalFormat("#0.0");
                    
                    String talukaOrderID = request.getParameter("talukaOrderID");
                    String talukaID = request.getParameter("talukaID");
                    int orderType = Integer.parseInt(request.getParameter("orderType"));
                    int tOrderID = Integer.parseInt(talukaOrderID);
                    int tID = Integer.parseInt(talukaID);
                    int i = 0;
                    TalukaOrderDS DS = new TalukaOrderDS();
                    
                    TalukaOrderDetailDSHelper dSHelper = new TalukaOrderDetailDSHelper();
                    
                    TalukaOrder talukaOrderHelper = dSHelper.talukaOrderDetails(tOrderID);
                    
                    ArrayList<SectionWiseItemSum> sectionOrder = DS.getAllSectionForOrder(tID,tOrderID);
        %>
        
    </head>
    <body>

        <p align="center"> शालेय पोषण आहार पुरवठा पंचायत समिती <%=talukaOrderHelper.getTalukaName()%>, जि. <%=talukaOrderHelper.getDistrictName()%> <br/>
            <%=talukaOrderHelper.getOrderTypeDetails()%> बालक लाभार्थी  <br/>            
            माहे - <%=talukaOrderHelper.getFromMonth()%>-<%=talukaOrderHelper.getFromYear()%> ते <%=talukaOrderHelper.getToMonth()%>-<%=talukaOrderHelper.getToYear()%><br/>
            तालुका गोषवारा - <%=talukaOrderHelper.getTalukaName()%></p>
        <table align="center" class="printstyle" width="1200" cellspacing="1" cellpadding="1">
            
    <%
        SectionWiseItemSum allSum = new SectionWiseItemSum();
        if( orderType == 2 )
        {
    %>
            <thead>
                <tr>
                    <th >अ. क्र.</th>
                    <th >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;विभाग&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>>
                    <th >मुंगदाळ</th>
					<th >तुर डाळ</th>
					<th >मुंग</th>
					<th >मटकी</th>
					<th >हरभरा</th>
					<th >वटाणा</th>
					<th >सोया वडी</th>
                    <th >Extra2</th>
                    <th >Extra3</th>
                    <th >Extra4</th>
                    <th >Extra5</th>
                    <th >Extra6</th>
					<th >चवळी</th>
                    <th >तेल (सोया अॅगमार्क)</th>
                    <th >मीठ (आयोडिनयुक्त)</th>
                    <th >कांदा लसूण मसाला</th>
                    <th >हळद (अॅगमार्क)</th>
                    <th >जिरे</th>
                    <th >मोहरी</th>
                </tr>
            </thead>
            <tbody>
    <%   
            for(SectionWiseItemSum sectionWiseItemSum : sectionOrder )
            {
                allSum.setMungdaal(allSum.getMungdaal()+ sectionWiseItemSum.getMungdaal());
                allSum.setMatki(allSum.getMatki()+ sectionWiseItemSum.getMatki());
                allSum.setMung(allSum.getMung()+ sectionWiseItemSum.getMung());
                allSum.setMasuldaal(allSum.getMasuldaal()+ sectionWiseItemSum.getMasuldaal());
                allSum.setHarbara(allSum.getHarbara()+ sectionWiseItemSum.getHarbara());
                allSum.setVatana(allSum.getVatana()+ sectionWiseItemSum.getVatana());
                allSum.setExtra1(allSum.getExtra1()+ sectionWiseItemSum.getExtra1());
                allSum.setExtra2(allSum.getExtra2()+ sectionWiseItemSum.getExtra2());
                allSum.setExtra3(allSum.getExtra3()+ sectionWiseItemSum.getExtra3());
                allSum.setExtra4(allSum.getExtra4()+ sectionWiseItemSum.getExtra4());
                allSum.setExtra5(allSum.getExtra5()+ sectionWiseItemSum.getExtra5());
                allSum.setExtra6(allSum.getExtra6()+ sectionWiseItemSum.getExtra6());
                allSum.setChvli(allSum.getChvli()+ sectionWiseItemSum.getChvli());
                allSum.setTel(allSum.getTel()+ sectionWiseItemSum.getTel());
                allSum.setMith(allSum.getMith()+ sectionWiseItemSum.getMith());
                allSum.setMirchi(allSum.getMirchi()+ sectionWiseItemSum.getMirchi());
                allSum.setHalad(allSum.getHalad()+ sectionWiseItemSum.getHalad());
                allSum.setJire(allSum.getJire()+ sectionWiseItemSum.getJire());
                allSum.setMohari(allSum.getMohari()+ sectionWiseItemSum.getMohari());
    %>
                <tr>
                    <th class="fontMarathiNumber"><%=i=i+1%></th>
                    <th ><%=sectionWiseItemSum.getSectionMarathi() %></th>
                    <th class="fontMarathiNumber"><%=sectionWiseItemSum.getMungdaal() %></th>
                    <th class="fontMarathiNumber"><%=sectionWiseItemSum.getMatki() %></th>
                    <th class="fontMarathiNumber"><%=sectionWiseItemSum.getMung() %></th>
                    <th class="fontMarathiNumber"><%=sectionWiseItemSum.getMasuldaal() %></th>
                    <th class="fontMarathiNumber"><%=sectionWiseItemSum.getHarbara() %></th>
                    <th class="fontMarathiNumber"><%=sectionWiseItemSum.getVatana() %></th>
                    <th class="fontMarathiNumber"><%=sectionWiseItemSum.getExtra1() %></th>
                    <th class="fontMarathiNumber"><%=sectionWiseItemSum.getExtra2() %></th>
                    <th class="fontMarathiNumber"><%=sectionWiseItemSum.getExtra3() %></th>
                    <th class="fontMarathiNumber"><%=sectionWiseItemSum.getExtra4() %></th>
                    <th class="fontMarathiNumber"><%=sectionWiseItemSum.getExtra5() %></th>
                    <th class="fontMarathiNumber"><%=sectionWiseItemSum.getExtra6() %></th>
                    <th class="fontMarathiNumber"><%=sectionWiseItemSum.getChvli() %></th>
                    <th class="fontMarathiNumber"><%=sectionWiseItemSum.getTel() %></th>
                    <th class="fontMarathiNumber"><%=sectionWiseItemSum.getMith() %></th>
                    <th class="fontMarathiNumber"><%=sectionWiseItemSum.getMirchi() %></th>
                    <th class="fontMarathiNumber"><%=sectionWiseItemSum.getHalad() %></th>
                    <th class="fontMarathiNumber"><%=sectionWiseItemSum.getJire() %></th>
                    <th class="fontMarathiNumber"><%=sectionWiseItemSum.getMohari() %></th>
                </tr>
    <%
            }  
    %>
                <tr>
                    <th colspan="2">एकूण</th>
                    <th class="fontMarathiNumber"><%= oneDecimalFormatter.format(allSum.getMungdaal()) %></th>
                    <th class="fontMarathiNumber"><%= oneDecimalFormatter.format(allSum.getMatki()) %></th>
                    <th class="fontMarathiNumber"><%= oneDecimalFormatter.format(allSum.getMung())%></th>
                    <th class="fontMarathiNumber"><%= oneDecimalFormatter.format(allSum.getMasuldaal())%></th>
                    <th class="fontMarathiNumber"><%= oneDecimalFormatter.format(allSum.getHarbara())%></th>
                    <th class="fontMarathiNumber"><%= oneDecimalFormatter.format(allSum.getVatana())%></th>
                    <th class="fontMarathiNumber"><%= oneDecimalFormatter.format(allSum.getExtra1())%></th>
                    <th class="fontMarathiNumber"><%= oneDecimalFormatter.format(allSum.getExtra2())%></th>
                    <th class="fontMarathiNumber"><%= oneDecimalFormatter.format(allSum.getExtra3())%></th>
                    <th class="fontMarathiNumber"><%= oneDecimalFormatter.format(allSum.getExtra4())%></th>
                    <th class="fontMarathiNumber"><%= oneDecimalFormatter.format(allSum.getExtra5())%></th>
                    <th class="fontMarathiNumber"><%= oneDecimalFormatter.format(allSum.getExtra6())%></th>
                    <th class="fontMarathiNumber"><%= oneDecimalFormatter.format(allSum.getChvli() )%></th>
                    <th class="fontMarathiNumber"><%= oneDecimalFormatter.format(allSum.getTel()) %></th>
                    <th class="fontMarathiNumber"><%= oneDecimalFormatter.format(allSum.getMith()) %></th>
                    <th class="fontMarathiNumber"><%= oneDecimalFormatter.format(allSum.getMirchi()) %></th>
                    <th class="fontMarathiNumber"><%= oneDecimalFormatter.format(allSum.getHalad()) %></th>
                    <th class="fontMarathiNumber"><%= oneDecimalFormatter.format(allSum.getJire()) %></th>
                    <th class="fontMarathiNumber"><%= oneDecimalFormatter.format(allSum.getMohari()) %></th>
                </tr>
    <%
        }
        else
        {
    %>
            <thead>
                <tr>
                    <th >अ. क्र.</th>
                    <th >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;विभाग&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>                   
                    <th >तांदूळ</th>
                </tr>
            </thead>
            <tbody>
    <%   
            for(SectionWiseItemSum sectionWiseItemSum : sectionOrder )
            {                
                allSum.setTandul(allSum.getTandul()+ sectionWiseItemSum.getTandul());
    %>
                <tr>
                    <th class="fontMarathiNumber"><%=i=i+1%></th>
                    <th ><%=sectionWiseItemSum.getSectionMarathi() %></th>                    
                    <th class="fontMarathiNumber"><%=sectionWiseItemSum.getTandul() %></th>
                </tr>
    <%
            }  
    %>
                <tr>
                    <th colspan="2">एकूण</th>
                    <th class="fontMarathiNumber"><%=allSum.getTandul() %></th>
                </tr>
    <%
        }
    %>  
                
            </tbody>
        </table>
    </body>
</html>
