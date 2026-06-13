<%@page import="java.util.StringTokenizer"%>
<%@page import="org.spa.entity.User"%>
<%@page import="org.spa.ds.UserDS"%>
<%
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String financialYear = request.getParameter("financial-year");

            if(!"select".equalsIgnoreCase(financialYear))
            {
                StringTokenizer tokenizer = new StringTokenizer(financialYear, ">");
                String fromYear = tokenizer.nextToken();
                String toYear = tokenizer.nextToken();

                UserDS dS = new UserDS();
                User user = dS.getUser(username, password);
                if (user != null)
                {
                    session.setAttribute("user", user);
                    session.setAttribute("fromYear", fromYear);
                    session.setAttribute("toYear", toYear);
        %>
                    <jsp:forward page="dashboard.jsp"></jsp:forward>
        <%
                }
                else
                {
                    session.invalidate();
        %>
                    <jsp:forward page="index.jsp"></jsp:forward>
        <%      }
            }
            else
            {
        %>
                <jsp:forward page="index.jsp"></jsp:forward>
        <%
            }
        %>
