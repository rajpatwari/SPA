package org.spa.helper;

import flexjson.JSONDeserializer;
import java.io.PrintStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import org.spa.entity.DispatchTalukaOrder;

public class DispatchTalukaOrderHelper
{
  public DispatchTalukaOrderHelper() {}
  
  public List<DispatchTalukaOrder> convert(String jsonString)
  {
    List list = null;
    List dList = new ArrayList();
    try {
      list = (List)new JSONDeserializer().use("data", DispatchTalukaOrder.class).deserialize(jsonString);
      DispatchTalukaOrder detail = null;
      for (Object ob : list) {
        Map map2 = (Map)ob;
        detail = new DispatchTalukaOrder();
        java.util.Set set = map2.entrySet();
        for (Object o2 : set) {
          Map.Entry en = (Map.Entry)o2;
          String key = (String)en.getKey();
          Object valObj = en.getValue();
          String value = "";
          
          if ((valObj instanceof Integer)) {
            Integer valueInt = (Integer)valObj;
            value = valueInt.toString();
          }
          else if ((valObj instanceof Double)) {
            Double valueDouble = (Double)valObj;
            value = valueDouble.toString();
          }
          else {
            value = (String)valObj;
          }
          
          if ((value != null) && (value.length() != 0) && ("dispatchDetailsID".equals(key))) {
            detail.setDispatchDetailsID(Integer.valueOf(Integer.parseInt(value)));
          }
          if ((value != null) && (value.length() != 0) && ("itemID".equals(key))) {
            detail.setItemID(Integer.valueOf(Integer.parseInt(value)));
          }
          if ((value != null) && (value.length() != 0) && ("itemMarathi".equals(key))) {
            detail.setItemMarathi(value);
          }
          if ((value != null) && (value.length() != 0) && ("talukaOrderID".equals(key))) {
            detail.setTalukaOrderID(Integer.valueOf(Integer.parseInt(value)));
          }
          if ((value != null) && (value.length() != 0) && ("totalLoad".equals(key))) {
            detail.setTotalLoad(Double.valueOf(Double.parseDouble(value)));
          }
          if ((value != null) && (value.length() != 0) && ("totalPreviousDispatch".equals(key))) {
            detail.setTotalPreviousDispatch(Double.valueOf(Double.parseDouble(value)));
          }
          if ((value != null) && (value.length() != 0) && ("currentStock".equals(key))) {
            detail.setCurrentStock(Double.valueOf(Double.parseDouble(value)));
          }
          if ((value != null) && (value.length() != 0) && ("totalLoadPending".equals(key))) {
            detail.setTotalLoadPending(Double.valueOf(Double.parseDouble(value)));
          }
          if ((value != null) && (value.length() != 0) && ("dispatchLoading".equals(key))) {
            detail.setDispatchLoading(Double.valueOf(Double.parseDouble(value)));
          }
        }
        dList.add(detail);
        System.out.println(detail);
      }
    }
    catch (IndexOutOfBoundsException e) {
      return null;
    }
    
    return dList;
  }
}
