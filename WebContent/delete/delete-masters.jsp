<%@page import="org.spa.ds.DistrictMaster"%>
<%@page import="java.util.StringTokenizer"%>
<%@page import="java.util.Vector"%>
<%@page import="java.util.List"%>
<%@page import="flexjson.JSONDeserializer"%>
<%
            DistrictMaster dS = new DistrictMaster();
            String master = request.getParameter("master");
            String ids = request.getParameter("ids");
            int[] numIDS = new int[100];
            StringTokenizer st = new StringTokenizer(ids, ",");

            for (int i = 0; st.hasMoreElements(); i++) 
            {
                numIDS[i] = Integer.parseInt(st.nextToken());
            }

            if (master != null) 
            {
                if (master.equalsIgnoreCase("district")) 
                {
                    dS.deleteDistricts(numIDS);
                }

                if (master.equalsIgnoreCase("taluka")) 
                {
                    dS.deleteTalukas(numIDS);
                }

                if (master.equalsIgnoreCase("section")) 
                {
                    dS.deleteSections(numIDS);
                }                
                if (master.equalsIgnoreCase("beat")) 
                {
                    dS.deleteBeat(numIDS);
                }                
                if (master.equalsIgnoreCase("school")) 
                {
                    dS.deleteSchools(numIDS);
                }
            }

            String s = "{success: true}";
            out.write(s);
%>
