<%@page import="org.spa.entity.Section"%>
<%@page import="org.spa.entity.Taluka"%>
<%@page import="org.spa.ds.DistrictMaster"%>
<%@page import="org.spa.entity.District"%>
<%@page import="java.util.Vector"%>
<%@page import="java.util.List"%>
<%@page import="flexjson.JSONDeserializer"%>
<%
            String s = "{success: false}";
            Section se = new Section();

            se.setSection(request.getParameter("sectionEnglish"));
            se.setSectionMarathi(request.getParameter("sectionMarathi"));
            se.setSectionID(Integer.parseInt(request.getParameter("sectionID")));
            se.setBeatFlag(Integer.parseInt(request.getParameter("beatFlag")));  
            //se.setTeacher(request.getParameter("teacher"));
            //se.setContactNumber(request.getParameter("contactNumber"));

            DistrictMaster masterDS = new DistrictMaster();
            int dups  = masterDS.getSectionDups(se); // checking for dupliaction

            if( dups == 0) 
            {
                masterDS.updateSection(se);
                s = "{success: true}";
            }           
            out.write(s);
%>
