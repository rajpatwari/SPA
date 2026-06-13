<%@page import="org.spa.entity.Beat"%>
<%@page import="org.spa.entity.School"%>
<%@page import="org.spa.entity.Section"%>
<%@page import="org.spa.entity.Taluka"%>
<%@page import="org.spa.ds.DistrictMaster"%>
<%@page import="org.spa.entity.District"%>
<%@page import="java.util.Vector"%>
<%@page import="java.util.List"%>
<%@page import="flexjson.JSONDeserializer"%>
<%
            String s = "{success: false}";
            Beat beat = new Beat();
            beat.setBeat(request.getParameter("beatEnglish"));
            beat.setBeatMarathi(request.getParameter("beatMarathi"));
            beat.setBeatID(Integer.parseInt(request.getParameter("beatID")));
            DistrictMaster DS = new DistrictMaster();
            int dups  = DS.getBeatDups(beat); // checking for duplication
            if( dups == 0) 
            {
                DS.updateBeat(beat);
                s = "{success: true}";
            }
            else
            {
            }     
            out.write(s);
%>
