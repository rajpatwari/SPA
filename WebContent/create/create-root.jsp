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
    root.setRoot(request.getParameter("rootEnglish"));
    root.setRootMarathi(request.getParameter("rootMarathi"));
    if(dS.getRootDups(root) ==0 ) //  checking for duplication
    { 
         dS.createRoot(root);
         s = "{success: true}";
    }
    out.write(s);
%>
