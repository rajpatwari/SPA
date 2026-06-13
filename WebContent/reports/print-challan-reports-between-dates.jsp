<%@page import="org.spa.ds.DistrictOrderDS"%>
<%@page import="org.spa.entity.SectionWiseItemSum"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.spa.ds.DispatchDS"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="org.spa.helper.TalukaOrderDetailDSHelper"%>
<%@page import="org.spa.entity.Section"%>
<%@page import="java.util.StringTokenizer"%>
<%@page import="java.sql.ResultSet"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <title>Date Wise Challan Report</title>
    <head>
        <style>
            .fontMarathiNumber {
                font:normal normal 18px Kiran,Verdana;
                text-decoration:none;
            }
            .fontMarathiNumberBold {
                font:normal normal bold 18px Kiran,Verdana;
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
                height: 13px;
                border-style: inset;
                border-color: gray;
                background-color: white;
            }
            .fontsize12 {
                font:normal normal 12px Tahoma;
                text-decoration:none;
            }
            .fontsize12bold {
                font:normal normal bold 12px Tahoma;
                text-decoration:none;
            }
            .fontsize14 {
                font:normal normal 14px Tahoma;
                text-decoration:none;
            }
            .fontsize16 {
                font:normal normal 16px Tahoma;
                text-decoration:none;
            }
            @media print  { .noprint  { display: none; border:0} .noborder  {  border:0} }

            @media screen { .noscreen { display: none; } }

        </style>
    </head>
<%
    String fromDate = request.getParameter("fromChallanDate");
    String toDate = request.getParameter("toChallanDate");
    String fd, fm, fy, td, tm, ty = "";

    StringTokenizer st1 = new StringTokenizer(fromDate, "/- ");
    fd = st1.nextToken();
    fm = st1.nextToken();
    fy = st1.nextToken();

    StringTokenizer st2 = new StringTokenizer(toDate, "/- ");
    td = st2.nextToken();
    tm = st2.nextToken();
    ty = st2.nextToken();    
    int i = 0;
%>

    <body>
<%
	SectionWiseItemSum allSum = new SectionWiseItemSum();
	List<SectionWiseItemSum> list1 = new DistrictOrderDS().getAllChallanDetailsBetweenDate(fromDate,toDate);
	if(list1 != null)
	{		
%>
  		<center><h3>चलान रिपोर्ट : <font face="Kiran"><%=fd%></font><span class="fontsize12">/</span><font face="Kiran"><%=fm%></font><span class="fontsize12">/</span><font face="Kiran"><%=fy%></font>
              - <font face="Kiran"><%=td%></font><span class="fontsize12">/</span><font face="Kiran"><%=tm%></font><span class="fontsize12">/</span><font face="Kiran"><%=ty%></font></h3> </center>

		<table align="center" class="printstyle fontsize12" width="1200" cellspacing="1" cellpadding="1">
			<thead>
                <tr>
                    <th >अ. क्र.</th>
                    <th >अंगणवाडी</th>
                    <th>तालुका</th>
                    <th>चलान क्र.</th>
                    <th>चलान दिनांक</th>
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
                    <th >तांदूळ</th>
                </tr>
            </thead>
            <tbody>
<%   
        for(SectionWiseItemSum sectionWiseItemSum : list1 )
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
            allSum.setTandul(allSum.getTandul()+ sectionWiseItemSum.getTandul());
            
            StringTokenizer st3 = new StringTokenizer(sectionWiseItemSum.getChallanDate(), "/- ");
   		    td = st3.nextToken();
   		    tm = st3.nextToken();
   		    ty = st3.nextToken();    
%>
                <tr>
                    <th class="fontMarathiNumber"><%=i=i+1%></th>
                    <th ><%=sectionWiseItemSum.getSchoolMarathi() %></th>
                    <th ><%=sectionWiseItemSum.getTalukaMarathi() %></th>
                    <th ><font face="Kiran"><%=sectionWiseItemSum.getChallanNumber()%></font></th>
                    <th ><font face="Kiran"><%=td%></font><span class="fontsize12">/</span><font face="Kiran"><%=tm%></font><span class="fontsize12">/</span><font face="Kiran"><%=ty%></font></th>
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
                    <th class="fontMarathiNumber"><%=sectionWiseItemSum.getTandul() %></th>
                </tr>
<%
            }  
%>
                <tr>
                    <th colspan="5" class="fontMarathiNumber">एकूण</th>
                    <th class="fontMarathiNumber"><%=allSum.getMungdaal() %></th>
                    <th class="fontMarathiNumber"><%=allSum.getMatki() %></th>
                    <th class="fontMarathiNumber"><%=allSum.getMung() %></th>
                    <th class="fontMarathiNumber"><%=allSum.getMasuldaal() %></th>
                    <th class="fontMarathiNumber"><%=allSum.getHarbara() %></th>
                    <th class="fontMarathiNumber"><%=allSum.getVatana() %></th>
                    <th class="fontMarathiNumber"><%=allSum.getExtra1() %></th>
                    <th class="fontMarathiNumber"><%=allSum.getExtra2() %></th>
                    <th class="fontMarathiNumber"><%=allSum.getExtra3() %></th>
                    <th class="fontMarathiNumber"><%=allSum.getExtra4() %></th>
                    <th class="fontMarathiNumber"><%=allSum.getExtra5() %></th>
                    <th class="fontMarathiNumber"><%=allSum.getExtra6() %></th>
                    <th class="fontMarathiNumber"><%=allSum.getChvli() %></th>
                    <th class="fontMarathiNumber"><%=allSum.getTel() %></th>
                    <th class="fontMarathiNumber"><%=allSum.getMith() %></th>
                    <th class="fontMarathiNumber"><%=allSum.getMirchi() %></th>
                    <th class="fontMarathiNumber"><%=allSum.getHalad() %></th>
                    <th class="fontMarathiNumber"><%=allSum.getJire() %></th>
                    <th class="fontMarathiNumber"><%=allSum.getMohari() %></th>
                    <th class="fontMarathiNumber"><%=allSum.getTandul() %></th>
                </tr>
        	</tbody>
        </table>
<%   
	}
	else
	{
%>
		<h1>No Challan is Created Between selected date</h1>
<%
	}
%>
    </body>
</html>