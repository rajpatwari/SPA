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
    Section s = new Section();
    String tID = request.getParameter("talukaID");
    int talukaID = Integer.parseInt(tID);
    s.setTalukaID(talukaID);
    s.setSection(request.getParameter("sectionEnglish"));
    s.setSectionMarathi(request.getParameter("sectionMarathi"));
    s.setBeatFlag(Integer.parseInt(request.getParameter("beatFlag")));   
    s.setSectionID(0);
    if (dS.getSectionDups(s) == 0) 
    {
        // checking for duplication
        dS.createSection(s);
        st = "{success: true}";
    }
    out.write(st);
%>
