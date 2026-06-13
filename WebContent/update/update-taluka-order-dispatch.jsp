<%@page import="javax.xml.rpc.encoding.Deserializer"%>
<%@page import="java.util.List"%>
<%@page import="org.spa.entity.DispatchTalukaOrder"%>
<%@page import="org.spa.helper.DispatchTalukaOrderHelper"%>
<%@page import="org.spa.ds.DispatchDS"%>
<%@page import="flexjson.JSONDeserializer"%>
<%
	DispatchTalukaOrderHelper h = new DispatchTalukaOrderHelper();
	List<DispatchTalukaOrder> dList = h.convert(request.getParameter("postdata"));
	DispatchTalukaOrder dto = new DispatchTalukaOrder();
   	dto.setMungdaal(0.0);
   	dto.setMatki(0.0);
   	dto.setMung(0.0);
   	dto.setMasuldaal(0.0);
   	dto.setChvli(0.0);
   	dto.setTel(0.0);
   	dto.setMith(0.0);
   	dto.setMirchi(0.0);
   	dto.setHalad(0.0);
   	dto.setJire(0.0);
   	dto.setMohari(0.0);
   	dto.setTandul(0.0);
   	dto.setHarbara(0.0);
   	dto.setVatana(0.0);
   	dto.setExtra1(0.0);
	dto.setExtra2(0.0);
	dto.setExtra3(0.0);
	dto.setExtra4(0.0);
	dto.setExtra5(0.0);
	dto.setExtra6(0.0);
	for(DispatchTalukaOrder d : dList)
	{
		if(d.getItemID() == 1)
        	dto.setMungdaal(d.getDispatchLoading());
        if(d.getItemID() == 2)
        	dto.setMatki(d.getDispatchLoading());
        if(d.getItemID() == 3)
        	dto.setMung(d.getDispatchLoading());
        if(d.getItemID() == 4)
        	dto.setMasuldaal(d.getDispatchLoading());
        if(d.getItemID() == 5)
        	dto.setChvli(d.getDispatchLoading());
        if(d.getItemID() == 6)
        	dto.setTel(d.getDispatchLoading());
        if(d.getItemID() == 7)
        	dto.setMith(d.getDispatchLoading());
        if(d.getItemID() == 8)
        	dto.setMirchi(d.getDispatchLoading());
        if(d.getItemID() == 9)
        	dto.setHalad(d.getDispatchLoading());
        if(d.getItemID() == 10)
        	dto.setJire(d.getDispatchLoading());
        if(d.getItemID() == 11)
        	dto.setMohari(d.getDispatchLoading());
        if(d.getItemID() == 12)
        	dto.setTandul(d.getDispatchLoading());
        if(d.getItemID() == 13)
        	dto.setHarbara(d.getDispatchLoading());
        if(d.getItemID() == 14)
        	dto.setVatana(d.getDispatchLoading());
        if(d.getItemID() == 15)
         	dto.setExtra1(d.getDispatchLoading());
        if(d.getItemID() == 16)
         	dto.setExtra2(d.getDispatchLoading());
        if(d.getItemID() == 17)
         	dto.setExtra3(d.getDispatchLoading());
        if(d.getItemID() == 18)
         	dto.setExtra4(d.getDispatchLoading());
        if(d.getItemID() == 19)
         	dto.setExtra5(d.getDispatchLoading());
        if(d.getItemID() == 20)
         	dto.setExtra6(d.getDispatchLoading());
        dto.setDispatchDetailsID(d.getDispatchDetailsID());
        dto.setTalukaOrderID(d.getTalukaOrderID());
	}
	DispatchDS dS = new DispatchDS();
	dS.updateOrderDetails(dto);
	String s = "{success: true}";
	out.write(s);
%>

