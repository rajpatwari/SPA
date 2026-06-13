<%@page import="org.spa.entity.Root"%>
<%@page import="org.spa.ds.RootDS"%>
<%@page import="java.util.Vector"%>
<%@page import="java.util.List"%>
<%@page import="flexjson.JSONDeserializer"%>
<%
    RootDS dS = new RootDS();
    Root root = new Root();
    String s = "{success: false}";
    root.setRootMasterID(0);
    root.setSchoolID(Integer.parseInt(request.getParameter("schoolCombo")));
    root.setRootMasterID(Integer.parseInt(request.getParameter("srootMasterID")));
    if(dS.createSchoolToRoot(root) != 0 ) 
    { 
         s = "{success: true}";
    }
    out.write(s);
%>
