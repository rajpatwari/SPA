<%@page import="org.spa.entity.Taluka"%>
<%@page import="org.spa.ds.DistrictMaster"%>
<%@page import="org.spa.entity.District"%>
<%@page import="java.util.Vector"%>
<%@page import="java.util.List"%>
<%@page import="flexjson.JSONDeserializer"%>
<%
            String talukaID = request.getParameter("talukaID");
            String talukaEnglish = request.getParameter("talukaEnglish");
            String talukaMarathi = request.getParameter("talukaMarathi");
            String s = "{success: false}";
            Taluka t = new Taluka();

            t.setTaluka(talukaEnglish);
            t.setTalukaMarathi(talukaMarathi);
            t.setTalukaID(Integer.parseInt(talukaID));
            t.setDistrictID(Integer.parseInt(request.getParameter("districtID")));
            DistrictMaster masterDS = new DistrictMaster();
            int dups  = masterDS.getTalukaDups(t);

            if( dups == 0) {
                masterDS.updateTaluka(t);
                s = "{success: true}";
            }else{

            }         
          
          
            out.write(s);
%>
