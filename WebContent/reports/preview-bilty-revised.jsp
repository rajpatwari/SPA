<%@page import="org.spa.helper.NumberToMarathiWord"%>
<%@page import="java.util.StringTokenizer"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="org.spa.ds.DispatchDS"%>
<%@page import="org.spa.entity.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<html>
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
                font:normal normal 24px Kiran,Verdana;
                text-decoration:none;
            }
            .fontMarathiNumberBold {
                font:normal normal bold 24px Kiran,Verdana;
                text-decoration:none;
            }
            .fontsize10 {
                font:normal normal 10px Tahoma;
                text-decoration:none;
            }
            .fontsize12 {
                font:normal normal 12px ;
                text-decoration:none;
                letter-spacing:1px;
            }
            .fontsize14-plain {
                font:normal normal 14px Tahoma ;
                text-decoration:none;
                letter-spacing:1px;
            }
            .fontsize14 {
                font:normal normal 14px Tahoma;
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
                padding: 5px;  height: 12px;
                border-style: inset;
                border-color: gray;
                background-color: white;
            }
            table.printstyle td {
                border-width: 1px;
                font:normal normal 12px ;
                height: 12px;
                border-style: inset;
                border-color: gray;
                background-color: white;
            }
            table.printstyle th {
                border-width: 1px; font:normal bold 12px Tahoma;

                border-style: inset;  height: 12px;
                border-color: gray;
                background-color: white;
            }
            P.breakhere {page-break-before: always;}
            .small  { font-size: 70%; }
            .bold   { font-weight: bold; }
            .notice { color: red; background-color: yellow; }
            @media print  { .noprint  { display: none; } }
            @media screen { .noscreen { display: none; } }
            -->
        </style>
    </head>
    <%
    	int dispatchID = Integer.parseInt(request.getParameter("dispatchID"));
    	int biltyID = Integer.parseInt(request.getParameter("draftBiltyNo"));
    	Dispatch dispatch = new DispatchDS().getDispatches(dispatchID);        
    %>
    <body class="fontsize14" >
        <table class="center" border="0">
            <tbody>
                <tr>
                    <td ><font style="text-decoration: line-through;font-size:20px">This is preview version, not for a print</font></td>
                </tr>
                <tr>
                    <td><u>SUBJECT TO DHULE JURISDICTION</u></td>
                </tr>
                <tr>
                    <td class="fontsize16"><b>महाराष्ट्र महिला सहकारी गृहउद्योग संस्था मर्या.</b></td>
                </tr>
                <tr>
                    <td>गट नं . ११६ , पारोळा रोड, पो. बाळापुर (फागणे) , ता. जि. धुळे</td>
                </tr>
            </tbody>
        </table>        
        <table border="0">
            <tbody >
                <tr>
                    <td width="60">क्रमांक - <%=biltyID %></td><td  class="fontMarathiNumber"></td><td class="right">ता. </td>
                    <td width="90" ><span><font class="fontMarathiNumber"></font>/<font  class="fontMarathiNumber"></font>/<font class="fontMarathiNumber"></font></span></td>
                </tr>
            </tbody>
        </table>
        <table border="0" >
            <tbody>
                <!--<tr>
                    <td  valign="top" >श्रीमान -  ()</td>
                    <td ></td>
                    <td align="right">गांव -</td>
                    <td width="110" >&nbsp;</td>
                </tr>-->
                <tr>
                    <td width="100" valign="top" colspan="2">जिल्हा - <%=dispatch.getDistrictMarathi() %> </td>
                    <td align="right">तालुका -<%=dispatch.getTalukaMarathi() %></td>
                    <td width="110">&nbsp;</td>
                </tr>
                <tr>
                    <td width="630" valign="top" > ड्रायव्हरचे नांव - <%=dispatch.getDriverName() %> </td>
                    <td ></td>
                    <td align="right" width="190">ड्रायव्हर ला. नं. - <%=dispatch.getDriverLicense() %></td>
                    <td width="110" >&nbsp;</td>
                </tr>
                <tr>
                    <td width="100" valign="top" colspan="4">ट्रक नं. - </td>
                </tr>
            </tbody>
        </table>
        <table border="1" class="printstyle" >
            <thead>
                <tr class="center">
                    <th  rowspan="2" >अनं.</th>
                    <th width="140" rowspan="2" >मालकी विगत</th>
                    <th rowspan="2" >पाकीट</th>
                    <th rowspan="2">गोणी (पाकीट)</th>
                    <th  rowspan="2"  >वजन किलो ग्रॅम</th>
                    <th>भाडे/टन</th>
                    <th>एकंदर भाडे</th>
                    <th>अँडव्हांस दिले</th>
                    <th>भाडे बाकी</th>
                </tr>
                <tr class="center">
                    <th >रुपये</th>
                    <th >रुपये</th>
                    <th >रुपये</th>
                    <th >रुपये</th>
                </tr>
            </thead>
            <tbody>
                <tr class="center">
                    <td class="fontMarathiNumber">1</td>
                    <td> ग्रॅम</td>
                    <td class="fontMarathiNumber"></td>
                    <td class="fontMarathiNumber center"> ()</td>
                    <td class="fontMarathiNumber"></td>
                    <td class="fontMarathiNumber center"><%=dispatch.getFreightPerTonInRupees() %></td>
                    <td class="fontMarathiNumber center"></td>
                    <td class="fontMarathiNumber center"><%=dispatch.getAdvanceFrieght() %></td>
                    <td class="fontMarathiNumber center"></td>
                </tr>
                <tr class="center">
                    <td class="fontMarathiNumber">2</td>
                    <td> ग्रॅम</td>
                    <td class="fontMarathiNumber"></td>
                    <td  class="fontMarathiNumber center"> ()</td>
                    <td  class="fontMarathiNumber"></td>
                    <td colspan="4" rowspan="2" class="fontsize16">बाकी <b><%=NumberToMarathiWord.convertToWord(12300.00)%></b> अक्षरी रू. माल पोहोचल्या नंतर दयावयाचे आहेत.</td>
                </tr>
                <tr class="center">
                    <td  class="fontMarathiNumber">3</td>
                    <td> ग्रॅम</td>
                    <td class="fontMarathiNumber"></td>
                    <td  class="fontMarathiNumber center"> ()</td>
                    <td  class="fontMarathiNumber"></td>
                </tr>
                <tr class="center">
                    <td class="fontsize16" colspan="2"><b>एकुण</b></td>
                    <td class="fontMarathiNumber"></td>
                    <td  class="fontMarathiNumber">()</td>
                    <td ><span class="fontMarathiNumber"></span></td>
                    <td class="fontMarathiNumber center"></td>
                    <td class="fontMarathiNumber center"></td>
                    <td class="fontMarathiNumber center"></td>
                    <td class="fontMarathiNumber center"></td>
                </tr>
            </tbody>
        </table>
       <!--आपका माल पुरा सही  सलामत पोहचाने मे अगर रास्ते मे कोई प्रकारकी अस्मानी सुलतानी हो जाये। माल ट्रन्सफर करने कोई नुकसानी हुई उसकी हर प्रकारची जिम्मेदारी हम. हमारी मोटार, मालिक और यहां  मोटार, एजंट इन्होको सिर पर है। उपर लिखा हुआ माल  मालिक बगैर अन्य कोई उतार लिया तो मालधनी उसकी जो किमंत मांगेगा ओ सब देनेको हम बंधे हुवे है।
        <br>मोटार मालिक ड्रायव्हर कि सही __________________________
    </b>ता. की उपरके नंबर की मोटार हमने खात्री की और पुरी जबाबदारी समझकर किराया ठहरकर दिया है।
    मोटार एजंट मो.नं. ______________________
    <p align="right" style="padding: 1px">तर्फे महाराष्ट्र महिला सहकारी गृहउद्योग संस्था मर्या.</p>
    सूचनाः मालधनी के अधिकार पत्र के अनुसार मोटार से माल भरकर बाहर निकलने के बाद हर तरहकी नुकसान की जिम्मेदारी मालधनी की है। मोटारसें माल मंगानेवालेने हर तरहकी जबाबदारी अपनी खुद की समझके माल मंगवाना।-->
    डिलेव्हरी मेमो प्रमाणे माल अंगणवाडी येथे पोहोच करण्यासाठी ताब्यात मिळाला.
    <br/><br/><br/><br/><br/><br/>
    <label>ड्रायव्हरची सही</label> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <label style="margin-left: 70px">गोडाउन कीपर</label> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <label style="margin-left: 70px">महिला सहकारी गृहउद्योग संस्था मर्या.धुळे- तर्फे </label><br/>
    
</body>
</html>