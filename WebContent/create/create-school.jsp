<!-- Creating new school -->

<%@page import="org.spa.entity.User"%>
<%@page import="org.spa.entity.School"%>
<%@page import="org.spa.entity.Section"%>
<%@page import="org.spa.entity.Taluka"%>
<%@page import="org.spa.entity.District"%>
<%@page import="org.spa.ds.DistrictMaster"%>
<%@page import="java.util.Vector"%>
<%@page import="java.util.List"%>
<%@page import="flexjson.JSONDeserializer"%>
<%
            DistrictMaster dS = new DistrictMaster();
            String st = "{success: false}";
            School sc = new School();
            String sID = request.getParameter("beatID");
            int sectionID = Integer.parseInt(sID);
            sc.setSectionID(sectionID);
            sc.setSchool(request.getParameter("schoolEnglish"));
            sc.setSchoolMarathi(request.getParameter("schoolMarathi"));
            if (dS.getSchoolDups(sc) == 0) 
            { 
                // checking for duplication
                dS.createSchool(sc,(User)session.getAttribute("user"));
                st = "{success: true}";
            }
            out.write(st);
%>
