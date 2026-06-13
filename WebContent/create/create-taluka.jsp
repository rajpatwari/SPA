<%@page import="org.spa.entity.Taluka"%>
<%@page import="org.spa.entity.District"%>
<%@page import="org.spa.ds.DistrictMaster"%>
<%@page import="java.util.Vector"%>
<%@page import="java.util.List"%>
<%@page import="flexjson.JSONDeserializer"%>
<%
            String s = "{success: false}";
            DistrictMaster dS = new DistrictMaster();
            Taluka t = new Taluka();
            String dID = request.getParameter("districtID");
            int districtID = Integer.parseInt(dID);
            t.setDistrictID(districtID);
            t.setTaluka(request.getParameter("talukaEnglish"));
            t.setTalukaMarathi(request.getParameter("talukaMarathi"));
         

            if (dS.getTalukaDups(t) == 0) { // checking for dupliaction
                    dS.createTaluka(t);
                s = "{success: true}";
            }
            out.write(s);
%>
