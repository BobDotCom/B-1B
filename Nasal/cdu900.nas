#cdu900
var cdu_set = func(n,m){

#n >= 0 are direct menu settings
if (n >= 0){
  setprop("instrumentation/cdu900/menu", n);
  setprop("instrumentation/cdu900/submenu", m);
  setprop("instrumentation/cdu900/sel_subm", "");
  setprop("instrumentation/cdu900/line-selected", "");
}


var cdu = [
#com1 and 2 entries
  [ "COM SET", 
    { sub1: "COM1 MHZ", sub2: "instrumentation/comm/frequencies/selected-mhz", sub3: "COM1 STBY", sub4: "instrumentation/comm/frequencies/standby-mhz", sub5: "---", sub6: "instrumentation/cdu900/expr/none"},
    { sub1: "COM2 MHZ", sub2: "instrumentation/comm[1]/frequencies/selected-mhz", sub3: "COM2 STBY", sub4: "instrumentation/comm[1]/frequencies/standby-mhz", sub5: "---", sub6: "instrumentation/cdu900/expr/none"},
  ],
#nav1 and 2,adf entries
  [ "NAV SET", 
    { sub1: "NAV1 MHZ", sub2: "instrumentation/nav[0]/frequencies/selected-mhz", sub3: "NAV1 STBY", sub4: "instrumentation/nav[0]/frequencies/standby-mhz", sub5: "NAV1 HDG", sub6: "instrumentation/nav[0]/radials/selected-deg"},
    { sub1: "NAV2 MHZ", sub2: "instrumentation/nav[1]/frequencies/selected-mhz", sub3: "NAV2 STBY", sub4: "instrumentation/nav[1]/frequencies/standby-mhz", sub5: "NAV2 HDG", sub6: "instrumentation/nav[1]/radials/selected-deg"},
    { sub1: "ADF1 KHZ", sub2: "instrumentation/adf[0]/frequencies/selected-khz", sub3: "ADF1 STBY", sub4: "instrumentation/adf[0]/frequencies/standby-khz", sub5: "ADF1 HDG", sub6: "instrumentation/adf[0]/rotation-deg"},
  ],
#IFF(identify friend foe) entries
  [ "IDFY FRI-FOE", 
    { sub1: "ONBOARD",sub2: "instrumentation/cdu900/expr/leet", sub3: getprop("sim/multiplay/callsign"), sub4: "instrumentation/cdu900/expr/none", sub5: "ENJOY", sub6: "instrumentation/cdu900/expr/oneone"},

  ],
#M3(ATHS) entries
  [ "ATHS", 
    { sub1: "NONE",sub2: "instrumentation/cdu900/expr/none", sub3: "---", sub4: "instrumentation/cdu900/expr/none", sub5: "NOT AVAILABLE", sub6: "instrumentation/cdu900/expr/none"},
  ],
#STR(TGT) entries
  [ "CODE", 
    { sub1: "LISTING",sub2: "instrumentation/cdu900/expr/none", sub3: "---", sub4: "instrumentation/cdu900/expr/none", sub5: "NOT AVAILABLE", sub6: "instrumentation/cdu900/expr/none"},
  ],
#FLPN(CODE) entries
  [ "FLIGHTPLAN", 
    { sub1: "LISTING",sub2: "instrumentation/cdu900/expr/none", sub3: "---", sub4: "instrumentation/cdu900/expr/none", sub5: "NOT AVAILABLE", sub6: "instrumentation/cdu900/expr/none"},
  ],
#PSN(FDLS) entries
  [ "POS INFO", 
    { sub1: "LONGITUDE",sub2: "position/longitude-deg", sub3: "LATITUDE", sub4: "position/latitude-deg", sub5: "ALTITUDE-FT", sub6: "position/altitude-ft"},
    { sub1: "GS KTS",sub2: "velocities/groundspeed-kt", sub3: "AS KTS", sub4: "velocities/airspeed-kt", sub5: "MACH", sub6: "velocities/mach"},
  ],
#DVR(DATA) entries
  [ "DATA", 
    { sub1: "TOT FUEL NORM",sub2: "consumables/fuel/total-fuel-norm", sub3: "TOT FUEL LBS", sub4: "consumables/fuel/total-fuel-lbs", sub5: "GROSS WGT LBS", sub6: "yasim/gross-weight-lbs"},
  ],
];

#n == -1 are submenu toggle settings
if (n == -1){
  var menu_set = getprop("instrumentation/cdu900/menu");
  n = menu_set;
  var nr = size(cdu[n]) - 1;
  #debug.dump(nr);
  var submenu_set = getprop("instrumentation/cdu900/submenu");
  m = submenu_set + m;
  if (m < 1){
    m = 1;
  }
  if (m > nr){
    m = nr;
  }
  setprop("instrumentation/cdu900/sel_subm", "");
  setprop("instrumentation/cdu900/line-selected", "");
}

#n == -2 are sub2/4/6-line2/4/6 selected
if (n == -2){
  var submenu_set = getprop("instrumentation/cdu900/submenu");
  var menu_set = getprop("instrumentation/cdu900/menu");
  var sel_subm = cdu[menu_set][submenu_set]["sub"~ m ~""];
  setprop("instrumentation/cdu900/sel_subm", sel_subm);
  setprop("instrumentation/cdu900/line-selected", m);
  n = menu_set;
  m = submenu_set;
}

#n == -10 manipulate aerrow selected
if (n == -10){
  var sel_subm = getprop("instrumentation/cdu900/sel_subm");
  if (sel_subm){
    var subm_value = getprop(""~ sel_subm ~"");
    #debug.dump(subm_value);
    subm_value = subm_value + m;
    setprop(""~ sel_subm ~"", subm_value);
  }
  #set entries
  var submenu_set = getprop("instrumentation/cdu900/submenu");
  var menu_set = getprop("instrumentation/cdu900/menu");
  n = menu_set;
  m = submenu_set;
}

setprop("instrumentation/cdu900/menu", n);
setprop("instrumentation/cdu900/submenu", m);
setprop("instrumentation/cdu900/line0", cdu[n][0]);
setprop("instrumentation/cdu900/line1", cdu[n][m]["sub1"]);
setprop("instrumentation/cdu900/line2", getprop(""~ cdu[n][m]["sub2"] ~""));
setprop("instrumentation/cdu900/line3", cdu[n][m]["sub3"]);
setprop("instrumentation/cdu900/line4", getprop(""~ cdu[n][m]["sub4"] ~""));
setprop("instrumentation/cdu900/line5", cdu[n][m]["sub5"]);
setprop("instrumentation/cdu900/line6", getprop(""~ cdu[n][m]["sub6"] ~""));

}

#var type = cdu[0]["menu0"];
#cdu[0].menu0 = "gbu-31";# set type to gbu-31
