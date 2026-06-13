<%-- 
    Document   : get-all-school-order
    Created on : Jan 31, 2013, 5:37:42 PM
    Author     : anita
--%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="flexjson.JSONSerializer"%>
<%@page import="org.spa.entity.SectionWiseItemSum"%>
<%@page import="org.spa.ds.TalukaOrderDS"%>
<%
    String sr = null;
    String fromDate = session.getAttribute("fromYear").toString().trim();
    String toDate =  session.getAttribute("toYear").toString().trim();

    int beatID = Integer.parseInt(request.getParameter("beatID"));
    String tal_order_id = request.getParameter("taluka_order_id");
    int taluka_order_id = Integer.parseInt(tal_order_id);
    //int districtOrderID = Integer.parseInt(request.getParameter("district_order_id"));
	ArrayList<SectionWiseItemSum> list1 = new TalukaOrderDS().getAllTalukaReturnDetails(beatID,taluka_order_id);
	ArrayList<SectionWiseItemSum> list2 = new TalukaOrderDS().getAllTalukaOrderDetails(beatID,taluka_order_id);
	List<SectionWiseItemSum> list3 = new ArrayList<SectionWiseItemSum>();
	SectionWiseItemSum s = null;
	for(SectionWiseItemSum s1 : list1)
	{
		for(SectionWiseItemSum s2 : list2)
		{
			if(s1.getSchoolID() == s2.getSchoolID())
			{
				s = new SectionWiseItemSum();
				s = s1;
				s.setOmungdaal(s2.getMasuldaal());
				s.setOmatki(s2.getMatki());
				s.setOmung(s2.getMung());
				s.setOmasuldaal(s2.getMasuldaal());
				s.setOchvli(s2.getChvli());
				s.setOtel(s2.getTel());
				s.setOmith(s2.getMith());
				s.setOmirchi(s2.getMirchi());
				s.setOhalad(s2.getHalad());
				s.setOjire(s2.getJire());
				s.setOmohari(s2.getMohari());
				s.setOtandul(s2.getTandul());
			}
			list3.add(s);
		}
	}
	//s = new JSONSerializer().exclude("*.class").deepSerialize("root",new TalukaOrderDS().getAllTalukaOrderDetails(section_id,taluka_order_id,districtOrderID));
    sr = new JSONSerializer().exclude("*.class").deepSerialize("root",list3);

    out.write(sr);
%>