
<%@page import="org.spa.ds.DispatchDS"%>
<%@page import="org.spa.entity.Dispatch"%>
<%@page import="org.spa.entity.District"%>
<%@page import="java.util.Vector"%>
<%@page import="java.util.List"%>
<%@page import="flexjson.JSONDeserializer"%>
<%
     Dispatch dispatch = new Dispatch();
    String s = "{success: false,header :'Save failed', msg: 'Error has occured in saving dispatch' }";

    double freightRate = Double.parseDouble(request.getParameter("freightRate"));
    double truckCapacity = Double.parseDouble(request.getParameter("truckCapacity"));
    double advFreight = Double.parseDouble(request.getParameter("advFreight"));

    dispatch.setFreightPerTonInRupees(freightRate);
    dispatch.setTruckCapacity(truckCapacity);
    dispatch.setAdvanceFrieght(advFreight);

      int dispatchID = Integer.parseInt(request.getParameter("dispatchID"));   

    dispatch.setDispatchID(dispatchID);

    String driverLicense = request.getParameter("driverLicense");
    String driverName = request.getParameter("driverName");
    String vehicleNo = request.getParameter("vehicleNo");
    String agentName = request.getParameter("agentName");
    String biltyDate = request.getParameter("biltyDate");
    int draftBiltyNo = Integer.parseInt(request.getParameter("draftBiltyNo"));

    dispatch.setDriverLicense(driverLicense);
    dispatch.setDriverName(driverName);
    dispatch.setVehicleNo(vehicleNo);
    dispatch.setAgentName(agentName);
    dispatch.setBiltyDate(biltyDate);
    dispatch.setDraftBiltyNo(draftBiltyNo);

    DispatchDS dS = new DispatchDS();

    if(dS.updateDispatch(dispatch) > 0)
    {
        s = "{success: true,header :'Dispatch Update', msg: 'Dispatch have been Updated' }";
    };

    out.write(s);
%>