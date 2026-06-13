<%@page import="org.spa.entity.Root"%>
<%@page import="org.spa.ds.RootDS"%>
<%@page import="java.util.Vector"%>
<%@page import="java.util.List"%>
<%@page import="flexjson.JSONDeserializer"%>
<%
      String s = "{success: false}";
      Root root = new Root();
      root.setRoot(request.getParameter("erootEnglish"));
      root.setRootMarathi(request.getParameter("erootMarathi"));
      root.setRootMasterID(Integer.parseInt(request.getParameter("erootMasterID")));
      RootDS DS = new RootDS();
      if( DS.getRootDups(root) == 0) 
      {
          DS.updateRoot(root);
          s = "{success: true}";
      } 
      out.write(s);
%>
