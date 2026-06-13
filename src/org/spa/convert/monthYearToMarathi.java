package org.spa.convert;

public class monthYearToMarathi {
  public monthYearToMarathi() {}
  
  public String monthString(int mid) {
    String monthMarathi = null;
    switch (mid)
    {
    case 1: 
      monthMarathi = "जानेवारी";
      break;
    case 2: 
      monthMarathi = "फेब्रुवारी";
      break;
    case 3: 
      monthMarathi = "मार्च";
      break;
    case 4: 
      monthMarathi = "एप्रिल";
      break;
    case 5: 
      monthMarathi = "मे";
      break;
    case 6: 
      monthMarathi = "जुन";
      break;
    case 7: 
      monthMarathi = "जुलै";
      break;
    case 8: 
      monthMarathi = "ऑगस्ट";
      break;
    case 9: 
      monthMarathi = "सप्टेंबर";
      break;
    case 10: 
      monthMarathi = "ऑक्टोबर";
      break;
    case 11: 
      monthMarathi = "नोव्हेंबर";
      break;
    case 12: 
      monthMarathi = "डिसेंबर";
    }
    
    return monthMarathi;
  }
  
  public String yearString_old(int yid)
  {
    String yearMarathi = null;
    switch (yid)
    {
    case 2009: 
      yearMarathi = "२००९";
      break;
    case 2010: 
      yearMarathi = "२०१०";
      break;
    case 2011: 
      yearMarathi = "२०११";
      break;
    case 2012: 
      yearMarathi = "२०१२";
      break;
    case 2013: 
      yearMarathi = "२०१३";
      break;
    case 2014: 
      yearMarathi = "२०१४";
      break;
    case 2015: 
      yearMarathi = "२०१५";
      break;
    case 2016: 
      yearMarathi = "२०१६";
      break;
    case 2017: 
      yearMarathi = "२०१७";
      break;
    case 2018: 
      yearMarathi = "२०१८";
      break;
    case 2019: 
      yearMarathi = "२०१९";
      break;
    case 2020: 
      yearMarathi = "२०२०";
      break;
    }
    return yearMarathi;
  }
  
  public String yearString(int yid)
  {
    StringBuffer yearMarathi = new StringBuffer("");
    String englishYear = ""+yid;
    
    for(String s : englishYear.split("")){
    	System.out.println("S : ["+s+"]");
    	yearMarathi.append(englishNumberToMarathi(s));
    }
    System.out.println("yearMarathi : ["+yearMarathi.toString()+"]");
    return yearMarathi.toString();
    
  }
  public String englishNumberToMarathi(String ch){
    switch (ch)
    {
	    case "0": return "०";
	    case "1": return "१";
	    case "2": return "२";
	    case "3": return "३";
	    case "4": return "४";
	    case "5": return "५";
	    case "6": return "६";
	    case "7": return "७";
	    case "8": return "८";
	    case "9": return "९";
	}
    return null;
  }
}
