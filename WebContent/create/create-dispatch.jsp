
<%@page import="org.spa.ds.DispatchDS"%>
<%@page import="org.spa.entity.Dispatch"%>
<%@page import="org.spa.entity.District"%>
<%@page import="java.util.Vector"%>
<%@page import="flexjson.JSONDeserializer"%>
<%
    Dispatch dispatch = new Dispatch();
    String s = "{success: false,header :'Save failed', msg: 'Error has occured in saving dispatch' }";

    dispatch.setFreightPerTonInRupees(Double.parseDouble(request.getParameter("freightRate")));
    dispatch.setTruckCapacity(Double.parseDouble(request.getParameter("truckCapacity")));
    dispatch.setAdvanceFrieght(Double.parseDouble(request.getParameter("advFreight")));    
    dispatch.setDistrictID(Integer.parseInt(request.getParameter("districtID")));     
    dispatch.setTalukaID(Integer.parseInt(request.getParameter("talukaID")));      
    dispatch.setDriverLicense(request.getParameter("driverLicense"));
    dispatch.setDriverName(request.getParameter("driverName"));
    dispatch.setVehicleNo(request.getParameter("vehicleNo"));
    dispatch.setAgentName(request.getParameter("agentName"));
    dispatch.setBiltyDate(request.getParameter("biltyDate"));
    dispatch.setDraftBiltyNo(Integer.parseInt(request.getParameter("draftBiltyNo")));

    DispatchDS dS = new DispatchDS();

    if(dS.createDispatch(dispatch) > 0){
        s = "{success: true,header :'Dispatch Saved...', msg: 'Dispatch has been saved' }";
    };  

    out.write(s);
%>
