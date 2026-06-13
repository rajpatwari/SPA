<%@page import="org.spa.entity.Beat"%>
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
            Beat beat = new Beat();
            beat.setSectionID(Integer.parseInt(request.getParameter("section")));
            beat.setBeat(request.getParameter("beatEnglish"));
            beat.setBeatMarathi(request.getParameter("beatMarathi"));

            if (dS.getBeatDups(beat) == 0) 
            {
                // checking for duplication
                dS.createBeat(beat);
                st = "{success: true}";
            }
            out.write(st);
%>
