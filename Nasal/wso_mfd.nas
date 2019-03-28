#settings for the oso mfd

#header:
#line1 
#line2
#line3 
#line4
#line5 
#line6
#line7 
#line8
#footer:menu selections
setprop("instrumentation/ikb/ikb_none", 0);
setprop("instrumentation/ikb/ikb_input", 0);

var wso_mfd = [
#bay select [0]
  [ 
    ["BAY SELECT", "MENU CHANGE <"],
    ["FWD", "instrumentation/ikb/ikb_none", "SELECT <", "instrumentation/ikb/ikb_none"],
    ["INTMD", "instrumentation/ikb/ikb_none", "SELECT <", "instrumentation/ikb/ikb_none"],
	["AFT", "instrumentation/ikb/ikb_none", "SELECT <", "instrumentation/ikb/ikb_none"],
	["", "instrumentation/ikb/ikb_none", "", "instrumentation/ikb/ikb_none"],
	["", "instrumentation/ikb/ikb_none", "", "instrumentation/ikb/ikb_none"],
	["", "instrumentation/ikb/ikb_none", "", "instrumentation/ikb/ikb_none"],
	["", "instrumentation/ikb/ikb_none", "", "instrumentation/ikb/ikb_none"],
	["", "instrumentation/ikb/ikb_none", "", "instrumentation/ikb/ikb_none"],
	["", "instrumentation/ikb/ikb_none", "", "instrumentation/ikb/ikb_none"],
  ],
#bay fwd overview [1]
  [ 
    ["BAY FWD OVERVIEW", "MENU CHANGE <"],
    ["STAT1", "armament/bay0/rack0-armed", "DIST", "ai/guided/bay0/bomb[0]/target-distance"],
    ["STAT2", "armament/bay0/rack1-armed", "DIST", "ai/guided/bay0/bomb[1]/target-distance"],
    ["STAT3", "armament/bay0/rack2-armed", "DIST", "ai/guided/bay0/bomb[2]/target-distance"],
    ["STAT4", "armament/bay0/rack3-armed", "DIST", "ai/guided/bay0/bomb[3]/target-distance"],
    ["STAT5", "armament/bay0/rack4-armed", "DIST", "ai/guided/bay0/bomb[4]/target-distance"],
    ["STAT6", "armament/bay0/rack5-armed", "DIST", "ai/guided/bay0/bomb[5]/target-distance"],
    ["STAT7", "armament/bay0/rack6-armed", "DIST", "ai/guided/bay0/bomb[6]/target-distance"],
    ["STAT8", "armament/bay0/rack7-armed", "DIST", "ai/guided/bay0/bomb[7]/target-distance"],
  ],
#bay intmd overview
  [ 
    ["BAY INTMD OVERVIEW", "MENU CHANGE <"],
    ["STAT1", "armament/bay1/rack0-armed", "DIST", "ai/guided/bay1/bomb[0]/target-distance"],
    ["STAT2", "armament/bay1/rack1-armed", "DIST", "ai/guided/bay1/bomb[1]/target-distance"],
    ["STAT3", "armament/bay1/rack2-armed", "DIST", "ai/guided/bay1/bomb[2]/target-distance"],
    ["STAT4", "armament/bay1/rack3-armed", "DIST", "ai/guided/bay1/bomb[3]/target-distance"],
    ["STAT5", "armament/bay1/rack4-armed", "DIST", "ai/guided/bay1/bomb[4]/target-distance"],
    ["STAT6", "armament/bay1/rack5-armed", "DIST", "ai/guided/bay1/bomb[5]/target-distance"],
    ["STAT7", "armament/bay1/rack6-armed", "DIST", "ai/guided/bay1/bomb[6]/target-distance"],
    ["STAT8", "armament/bay1/rack7-armed", "DIST", "ai/guided/bay1/bomb[7]/target-distance"],
  ],
#bay aft overview
  [ 
    ["BAY AFT OVERVIEW", "MENU CHANGE <"],
    ["STAT1", "armament/bay1/rack0-armed", "DIST", "ai/guided/bay1/bomb[0]/target-distance"],
    ["STAT2", "armament/bay1/rack1-armed", "DIST", "ai/guided/bay1/bomb[1]/target-distance"],
    ["STAT3", "armament/bay1/rack2-armed", "DIST", "ai/guided/bay1/bomb[2]/target-distance"],
    ["STAT4", "armament/bay1/rack3-armed", "DIST", "ai/guided/bay1/bomb[3]/target-distance"],
    ["STAT5", "armament/bay1/rack4-armed", "DIST", "ai/guided/bay1/bomb[4]/target-distance"],
    ["STAT6", "armament/bay1/rack5-armed", "DIST", "ai/guided/bay1/bomb[5]/target-distance"],
    ["STAT7", "armament/bay1/rack6-armed", "DIST", "ai/guided/bay1/bomb[6]/target-distance"],
    ["STAT8", "armament/bay1/rack7-armed", "DIST", "ai/guided/bay1/bomb[7]/target-distance"],
  ],
#FWD station1 [4]
  [ 
    ["FWD STATION1", "MENU CHANGE <"],
    ["TYPE", "armament/bay0/rack0", "ARMED", "armament/bay0/rack0-armed"],
    ["LON", "ai/guided/bay0/bomb[0]/target-longitude-deg", "LAT", "ai/guided/bay0/bomb[0]/target-latitude-deg"],
    ["DIST", "ai/guided/bay0/bomb[0]/target-distance", "TIME", "ai/guided/bay0/bomb[0]/target-distance-sec"],
    ["-----", "instrumentation/ikb/ikb_none", "-----", "instrumentation/ikb/ikb_none"],
    ["IKB", "instrumentation/ikb/ikb_input", "SET IKB<", "instrumentation/ikb/ikb_none"],
    ["POS", "instrumentation/ikb/coord_pos", "", "instrumentation/ikb/ikb_none"],
    ["", "instrumentation/ikb/ikb_none", "SET LON<", "instrumentation/ikb/ikb_none"],
    ["", "instrumentation/ikb/ikb_none", "SET LAT<", "instrumentation/ikb/ikb_none"]
  ],
#FWD station2
  [ 
    ["FWD STATION2", "MENU CHANGE <"],
    ["TYPE", "armament/bay0/rack1", "ARMED", "armament/bay0/rack1-armed"],
    ["LON", "ai/guided/bay0/bomb[1]/target-longitude-deg", "LAT", "ai/guided/bay0/bomb[1]/target-latitude-deg"],
    ["DIST", "ai/guided/bay0/bomb[1]/target-distance", "TIME", "ai/guided/bay0/bomb[1]/target-distance-sec"],
    ["-----", "instrumentation/ikb/ikb_none", "-----", "instrumentation/ikb/ikb_none"],
    ["IKB", "instrumentation/ikb/ikb_input", "SET IKB<", "instrumentation/ikb/ikb_none"],
    ["POS", "instrumentation/ikb/coord_pos", "", "instrumentation/ikb/ikb_none"],
    ["", "instrumentation/ikb/ikb_none", "SET LON<", "instrumentation/ikb/ikb_none"],
    ["", "instrumentation/ikb/ikb_none", "SET LAT<", "instrumentation/ikb/ikb_none"]
  ],
#FWD tation3
  [ 
    ["FWD STATION3", "MENU CHANGE <"],
    ["TYPE", "armament/bay0/rack2", "ARMED", "armament/bay0/rack2-armed"],
    ["LON", "ai/guided/bay0/bomb[2]/target-longitude-deg", "LAT", "ai/guided/bay0/bomb[2]/target-latitude-deg"],
    ["DIST", "ai/guided/bay0/bomb[2]/target-distance", "TIME", "ai/guided/bay0/bomb[2]/target-distance-sec"],
    ["-----", "instrumentation/ikb/ikb_none", "-----", "instrumentation/ikb/ikb_none"],
    ["IKB", "instrumentation/ikb/ikb_input", "SET IKB<", "instrumentation/ikb/ikb_none"],
    ["POS", "instrumentation/ikb/coord_pos", "", "instrumentation/ikb/ikb_none"],
    ["", "instrumentation/ikb/ikb_none", "SET LON<", "instrumentation/ikb/ikb_none"],
    ["", "instrumentation/ikb/ikb_none", "SET LAT<", "instrumentation/ikb/ikb_none"]
  ],
#FWD station4
  [ 
    ["FWD STATION4", "MENU CHANGE <"],
    ["TYPE", "armament/bay0/rack3", "ARMED", "armament/bay0/rack3-armed"],
    ["LON", "ai/guided/bay0/bomb[3]/target-longitude-deg", "LAT", "ai/guided/bay0/bomb[3]/target-latitude-deg"],
    ["DIST", "ai/guided/bay0/bomb[3]/target-distance", "TIME", "ai/guided/bay0/bomb[3]/target-distance-sec"],
    ["-----", "instrumentation/ikb/ikb_none", "-----", "instrumentation/ikb/ikb_none"],
    ["IKB", "instrumentation/ikb/ikb_input", "SET IKB<", "instrumentation/ikb/ikb_none"],
    ["POS", "instrumentation/ikb/coord_pos", "", "instrumentation/ikb/ikb_none"],
    ["", "instrumentation/ikb/ikb_none", "SET LON<", "instrumentation/ikb/ikb_none"],
    ["", "instrumentation/ikb/ikb_none", "SET LAT<", "instrumentation/ikb/ikb_none"]
  ],
#FWD station5
  [ 
    ["FWD STATION5", "MENU CHANGE <"],
    ["TYPE", "armament/bay0/rack4", "ARMED", "armament/bay0/rack4-armed"],
    ["LON", "ai/guided/bay0/bomb[4]/target-longitude-deg", "LAT", "ai/guided/bay0/bomb[4]/target-latitude-deg"],
    ["DIST", "ai/guided/bay0/bomb[4]/target-distance", "TIME", "ai/guided/bay0/bomb[4]/target-distance-sec"],
    ["-----", "instrumentation/ikb/ikb_none", "-----", "instrumentation/ikb/ikb_none"],
    ["IKB", "instrumentation/ikb/ikb_input", "SET IKB<", "instrumentation/ikb/ikb_none"],
    ["POS", "instrumentation/ikb/coord_pos", "<", "instrumentation/ikb/ikb_none"],
    ["", "instrumentation/ikb/ikb_none", "SET LON", "instrumentation/ikb/ikb_none"],
    ["", "instrumentation/ikb/ikb_none", "SET LAT<", "instrumentation/ikb/ikb_none"]
  ],
#FWD station6
  [ 
    ["FWD STATION6", "MENU CHANGE <"],
    ["TYPE", "armament/bay0/rack5", "ARMED", "armament/bay0/rack5-armed"],
    ["LON", "ai/guided/bay0/bomb[5]/target-longitude-deg", "LAT", "ai/guided/bay0/bomb[5]/target-latitude-deg"],
    ["DIST", "ai/guided/bay0/bomb[5]/target-distance", "TIME", "ai/guided/bay0/bomb[5]/target-distance-sec"],
    ["-----", "instrumentation/ikb/ikb_none", "-----", "instrumentation/ikb/ikb_none"],
    ["IKB", "instrumentation/ikb/ikb_input", "SET IKB<", "instrumentation/ikb/ikb_none"],
    ["POS", "instrumentation/ikb/coord_pos", "", "instrumentation/ikb/ikb_none"],
    ["", "instrumentation/ikb/ikb_none", "SET LON<", "instrumentation/ikb/ikb_none"],
    ["", "instrumentation/ikb/ikb_none", "SET LAT<", "instrumentation/ikb/ikb_none"]
  ],
#FWD station7
  [ 
    ["FWD STATION7", "MENU CHANGE <"],
    ["TYPE", "armament/bay0/rack6", "ARMED", "armament/bay0/rack6-armed"],
    ["LON", "ai/guided/bay0/bomb[6]/target-longitude-deg", "LAT", "ai/guided/bay0/bomb[6]/target-latitude-deg"],
    ["DIST", "ai/guided/bay0/bomb[6]/target-distance", "TIME", "ai/guided/bay0/bomb[6]/target-distance-sec"],
    ["-----", "instrumentation/ikb/ikb_none", "-----", "instrumentation/ikb/ikb_none"],
    ["IKB", "instrumentation/ikb/ikb_input", "SET IKB<", "instrumentation/ikb/ikb_none"],
    ["POS", "instrumentation/ikb/coord_pos", "", "instrumentation/ikb/ikb_none"],
    ["", "instrumentation/ikb/ikb_none", "SET LON<", "instrumentation/ikb/ikb_none"],
    ["", "instrumentation/ikb/ikb_none", "SET LAT<", "instrumentation/ikb/ikb_none"]
  ],
#FWD station8
  [ 
    ["FWD STATION8", "MENU CHANGE <"],
    ["TYPE", "armament/bay0/rack7", "ARMED", "armament/bay0/rack7-armed"],
    ["LON", "ai/guided/bay0/bomb[7]/target-longitude-deg", "LAT", "ai/guided/bay0/bomb[7]/target-latitude-deg"],
    ["DIST", "ai/guided/bay0/bomb[7]/target-distance", "TIME", "ai/guided/bay0/bomb[7]/target-distance-sec"],
    ["-----", "instrumentation/ikb/ikb_none", "-----", "instrumentation/ikb/ikb_none"],
    ["IKB", "instrumentation/ikb/ikb_input", "SET IKB<", "instrumentation/ikb/ikb_none"],
    ["POS", "instrumentation/ikb/coord_pos", "", "instrumentation/ikb/ikb_none"],
    ["", "instrumentation/ikb/ikb_none", "SET LON<", "instrumentation/ikb/ikb_none"],
    ["", "instrumentation/ikb/ikb_none", "SET LAT<", "instrumentation/ikb/ikb_none"]
  ],
#INTMD station1 [12]
  [ 
    ["INTMD STATION1", "MENU CHANGE <"],
    ["TYPE", "armament/bay1/rack0", "ARMED", "armament/bay1/rack0-armed"],
    ["LON", "ai/guided/bay1/bomb[0]/target-longitude-deg", "LAT", "ai/guided/bay1/bomb[0]/target-latitude-deg"],
    ["DIST", "ai/guided/bay1/bomb[0]/target-distance", "TIME", "ai/guided/bay1/bomb[0]/target-distance-sec"],
    ["-----", "instrumentation/ikb/ikb_none", "-----", "instrumentation/ikb/ikb_none"],
    ["IKB", "instrumentation/ikb/ikb_input", "SET IKB<", "instrumentation/ikb/ikb_none"],
    ["POS", "instrumentation/ikb/coord_pos", "", "instrumentation/ikb/ikb_none"],
    ["", "instrumentation/ikb/ikb_none", "SET LON<", "instrumentation/ikb/ikb_none"],
    ["", "instrumentation/ikb/ikb_none", "SET LAT<", "instrumentation/ikb/ikb_none"]
  ],
#INTMD station2
  [ 
    ["INTMD STATION2", "MENU CHANGE <"],
    ["TYPE", "armament/bay1/rack1", "ARMED", "armament/bay1/rack1-armed"],
    ["LON", "ai/guided/bay1/bomb[1]/target-longitude-deg", "LAT", "ai/guided/bay1/bomb[1]/target-latitude-deg"],
    ["DIST", "ai/guided/bay1/bomb[1]/target-distance", "TIME", "ai/guided/bay1/bomb[1]/target-distance-sec"],
    ["-----", "instrumentation/ikb/ikb_none", "-----", "instrumentation/ikb/ikb_none"],
    ["IKB", "instrumentation/ikb/ikb_input", "SET IKB<", "instrumentation/ikb/ikb_none"],
    ["POS", "instrumentation/ikb/coord_pos", "", "instrumentation/ikb/ikb_none"],
    ["", "instrumentation/ikb/ikb_none", "SET LON<", "instrumentation/ikb/ikb_none"],
    ["", "instrumentation/ikb/ikb_none", "SET LAT<", "instrumentation/ikb/ikb_none"]
  ],
#INTMD tation3
  [ 
    ["INTMD STATION3", "MENU CHANGE <"],
    ["TYPE", "armament/bay1/rack2", "ARMED", "armament/bay1/rack2-armed"],
    ["LON", "ai/guided/bay1/bomb[2]/target-longitude-deg", "LAT", "ai/guided/bay1/bomb[2]/target-latitude-deg"],
    ["DIST", "ai/guided/bay1/bomb[2]/target-distance", "TIME", "ai/guided/bay1/bomb[2]/target-distance-sec"],
    ["-----", "instrumentation/ikb/ikb_none", "-----", "instrumentation/ikb/ikb_none"],
    ["IKB", "instrumentation/ikb/ikb_input", "SET IKB<", "instrumentation/ikb/ikb_none"],
    ["POS", "instrumentation/ikb/coord_pos", "", "instrumentation/ikb/ikb_none"],
    ["", "instrumentation/ikb/ikb_none", "SET LON<", "instrumentation/ikb/ikb_none"],
    ["", "instrumentation/ikb/ikb_none", "SET LAT<", "instrumentation/ikb/ikb_none"]
  ],
#INTMD station4
  [ 
    ["INTMD STATION4", "MENU CHANGE <"],
    ["TYPE", "armament/bay1/rack3", "ARMED", "armament/bay1/rack3-armed"],
    ["LON", "ai/guided/bay1/bomb[3]/target-longitude-deg", "LAT", "ai/guided/bay1/bomb[3]/target-latitude-deg"],
    ["DIST", "ai/guided/bay1/bomb[3]/target-distance", "TIME", "ai/guided/bay1/bomb[3]/target-distance-sec"],
    ["-----", "instrumentation/ikb/ikb_none", "-----", "instrumentation/ikb/ikb_none"],
    ["IKB", "instrumentation/ikb/ikb_input", "SET IKB<", "instrumentation/ikb/ikb_none"],
    ["POS", "instrumentation/ikb/coord_pos", "", "instrumentation/ikb/ikb_none"],
    ["", "instrumentation/ikb/ikb_none", "SET LON<", "instrumentation/ikb/ikb_none"],
    ["", "instrumentation/ikb/ikb_none", "SET LAT<", "instrumentation/ikb/ikb_none"]
  ],
#INTMD station5
  [ 
    ["INTMD STATION5", "MENU CHANGE <"],
    ["TYPE", "armament/bay1/rack4", "ARMED", "armament/bay1/rack4-armed"],
    ["LON", "ai/guided/bay1/bomb[4]/target-longitude-deg", "LAT", "ai/guided/bay1/bomb[4]/target-latitude-deg"],
    ["DIST", "ai/guided/bay1/bomb[4]/target-distance", "TIME", "ai/guided/bay1/bomb[4]/target-distance-sec"],
    ["-----", "instrumentation/ikb/ikb_none", "-----", "instrumentation/ikb/ikb_none"],
    ["IKB", "instrumentation/ikb/ikb_input", "SET IKB<", "instrumentation/ikb/ikb_none"],
    ["POS", "instrumentation/ikb/coord_pos", "<", "instrumentation/ikb/ikb_none"],
    ["", "instrumentation/ikb/ikb_none", "SET LON", "instrumentation/ikb/ikb_none"],
    ["", "instrumentation/ikb/ikb_none", "SET LAT<", "instrumentation/ikb/ikb_none"]
  ],
#INTMD station6
  [ 
    ["INTMD STATION6", "MENU CHANGE <"],
    ["TYPE", "armament/bay1/rack5", "ARMED", "armament/bay1/rack5-armed"],
    ["LON", "ai/guided/bay1/bomb[5]/target-longitude-deg", "LAT", "ai/guided/bay1/bomb[5]/target-latitude-deg"],
    ["DIST", "ai/guided/bay1/bomb[5]/target-distance", "TIME", "ai/guided/bay1/bomb[5]/target-distance-sec"],
    ["-----", "instrumentation/ikb/ikb_none", "-----", "instrumentation/ikb/ikb_none"],
    ["IKB", "instrumentation/ikb/ikb_input", "SET IKB<", "instrumentation/ikb/ikb_none"],
    ["POS", "instrumentation/ikb/coord_pos", "", "instrumentation/ikb/ikb_none"],
    ["", "instrumentation/ikb/ikb_none", "SET LON<", "instrumentation/ikb/ikb_none"],
    ["", "instrumentation/ikb/ikb_none", "SET LAT<", "instrumentation/ikb/ikb_none"]
  ],
#INTMD station7
  [ 
    ["INTMD STATION7", "MENU CHANGE <"],
    ["TYPE", "armament/bay1/rack6", "ARMED", "armament/bay1/rack6-armed"],
    ["LON", "ai/guided/bay1/bomb[6]/target-longitude-deg", "LAT", "ai/guided/bay1/bomb[6]/target-latitude-deg"],
    ["DIST", "ai/guided/bay1/bomb[6]/target-distance", "TIME", "ai/guided/bay1/bomb[6]/target-distance-sec"],
    ["-----", "instrumentation/ikb/ikb_none", "-----", "instrumentation/ikb/ikb_none"],
    ["IKB", "instrumentation/ikb/ikb_input", "SET IKB<", "instrumentation/ikb/ikb_none"],
    ["POS", "instrumentation/ikb/coord_pos", "", "instrumentation/ikb/ikb_none"],
    ["", "instrumentation/ikb/ikb_none", "SET LON<", "instrumentation/ikb/ikb_none"],
    ["", "instrumentation/ikb/ikb_none", "SET LAT<", "instrumentation/ikb/ikb_none"]
  ],
#INTMD station8
  [ 
    ["INTMD STATION8", "MENU CHANGE <"],
    ["TYPE", "armament/bay1/rack7", "ARMED", "armament/bay1/rack7-armed"],
    ["LON", "ai/guided/bay1/bomb[7]/target-longitude-deg", "LAT", "ai/guided/bay1/bomb[7]/target-latitude-deg"],
    ["DIST", "ai/guided/bay1/bomb[7]/target-distance", "TIME", "ai/guided/bay1/bomb[7]/target-distance-sec"],
    ["-----", "instrumentation/ikb/ikb_none", "-----", "instrumentation/ikb/ikb_none"],
    ["IKB", "instrumentation/ikb/ikb_input", "SET IKB<", "instrumentation/ikb/ikb_none"],
    ["POS", "instrumentation/ikb/coord_pos", "", "instrumentation/ikb/ikb_none"],
    ["", "instrumentation/ikb/ikb_none", "SET LON<", "instrumentation/ikb/ikb_none"],
    ["", "instrumentation/ikb/ikb_none", "SET LAT<", "instrumentation/ikb/ikb_none"]
  ],
#AFT station1 [20]
  [ 
    ["AFT STATION1", "MENU CHANGE <"],
    ["TYPE", "armament/bay2/rack0", "ARMED", "armament/bay2/rack0-armed"],
    ["LON", "ai/guided/bay2/bomb[0]/target-longitude-deg", "LAT", "ai/guided/bay2/bomb[0]/target-latitude-deg"],
    ["DIST", "ai/guided/bay2/bomb[0]/target-distance", "TIME", "ai/guided/bay2/bomb[0]/target-distance-sec"],
    ["-----", "instrumentation/ikb/ikb_none", "-----", "instrumentation/ikb/ikb_none"],
    ["IKB", "instrumentation/ikb/ikb_input", "SET IKB<", "instrumentation/ikb/ikb_none"],
    ["POS", "instrumentation/ikb/coord_pos", "", "instrumentation/ikb/ikb_none"],
    ["", "instrumentation/ikb/ikb_none", "SET LON<", "instrumentation/ikb/ikb_none"],
    ["", "instrumentation/ikb/ikb_none", "SET LAT<", "instrumentation/ikb/ikb_none"]
  ],
#AFT station2
  [ 
    ["AFT STATION2", "MENU CHANGE <"],
    ["TYPE", "armament/bay2/rack1", "ARMED", "armament/bay2/rack1-armed"],
    ["LON", "ai/guided/bay2/bomb[1]/target-longitude-deg", "LAT", "ai/guided/bay2/bomb[1]/target-latitude-deg"],
    ["DIST", "ai/guided/bay2/bomb[1]/target-distance", "TIME", "ai/guided/bay2/bomb[1]/target-distance-sec"],
    ["-----", "instrumentation/ikb/ikb_none", "-----", "instrumentation/ikb/ikb_none"],
    ["IKB", "instrumentation/ikb/ikb_input", "SET IKB<", "instrumentation/ikb/ikb_none"],
    ["POS", "instrumentation/ikb/coord_pos", "", "instrumentation/ikb/ikb_none"],
    ["", "instrumentation/ikb/ikb_none", "SET LON<", "instrumentation/ikb/ikb_none"],
    ["", "instrumentation/ikb/ikb_none", "SET LAT<", "instrumentation/ikb/ikb_none"]
  ],
#AFT tation3
  [ 
    ["AFT STATION3", "MENU CHANGE <"],
    ["TYPE", "armament/bay2/rack2", "ARMED", "armament/bay2/rack2-armed"],
    ["LON", "ai/guided/bay2/bomb[2]/target-longitude-deg", "LAT", "ai/guided/bay2/bomb[2]/target-latitude-deg"],
    ["DIST", "ai/guided/bay2/bomb[2]/target-distance", "TIME", "ai/guided/bay2/bomb[2]/target-distance-sec"],
    ["-----", "instrumentation/ikb/ikb_none", "-----", "instrumentation/ikb/ikb_none"],
    ["IKB", "instrumentation/ikb/ikb_input", "SET IKB<", "instrumentation/ikb/ikb_none"],
    ["POS", "instrumentation/ikb/coord_pos", "", "instrumentation/ikb/ikb_none"],
    ["", "instrumentation/ikb/ikb_none", "SET LON<", "instrumentation/ikb/ikb_none"],
    ["", "instrumentation/ikb/ikb_none", "SET LAT<", "instrumentation/ikb/ikb_none"]
  ],
#AFT station4
  [ 
    ["AFT STATION4", "MENU CHANGE <"],
    ["TYPE", "armament/bay2/rack3", "ARMED", "armament/bay2/rack3-armed"],
    ["LON", "ai/guided/bay2/bomb[3]/target-longitude-deg", "LAT", "ai/guided/bay2/bomb[3]/target-latitude-deg"],
    ["DIST", "ai/guided/bay2/bomb[3]/target-distance", "TIME", "ai/guided/bay2/bomb[3]/target-distance-sec"],
    ["-----", "instrumentation/ikb/ikb_none", "-----", "instrumentation/ikb/ikb_none"],
    ["IKB", "instrumentation/ikb/ikb_input", "SET IKB<", "instrumentation/ikb/ikb_none"],
    ["POS", "instrumentation/ikb/coord_pos", "", "instrumentation/ikb/ikb_none"],
    ["", "instrumentation/ikb/ikb_none", "SET LON<", "instrumentation/ikb/ikb_none"],
    ["", "instrumentation/ikb/ikb_none", "SET LAT<", "instrumentation/ikb/ikb_none"]
  ],
#AFT station5
  [ 
    ["AFT STATION5", "MENU CHANGE <"],
    ["TYPE", "armament/bay2/rack4", "ARMED", "armament/bay2/rack4-armed"],
    ["LON", "ai/guided/bay2/bomb[4]/target-longitude-deg", "LAT", "ai/guided/bay2/bomb[4]/target-latitude-deg"],
    ["DIST", "ai/guided/bay2/bomb[4]/target-distance", "TIME", "ai/guided/bay2/bomb[4]/target-distance-sec"],
    ["-----", "instrumentation/ikb/ikb_none", "-----", "instrumentation/ikb/ikb_none"],
    ["IKB", "instrumentation/ikb/ikb_input", "SET IKB<", "instrumentation/ikb/ikb_none"],
    ["POS", "instrumentation/ikb/coord_pos", "<", "instrumentation/ikb/ikb_none"],
    ["", "instrumentation/ikb/ikb_none", "SET LON", "instrumentation/ikb/ikb_none"],
    ["", "instrumentation/ikb/ikb_none", "SET LAT<", "instrumentation/ikb/ikb_none"]
  ],
#AFT station6
  [ 
    ["AFT STATION6", "MENU CHANGE <"],
    ["TYPE", "armament/bay2/rack5", "ARMED", "armament/bay2/rack5-armed"],
    ["LON", "ai/guided/bay2/bomb[5]/target-longitude-deg", "LAT", "ai/guided/bay2/bomb[5]/target-latitude-deg"],
    ["DIST", "ai/guided/bay2/bomb[5]/target-distance", "TIME", "ai/guided/bay2/bomb[5]/target-distance-sec"],
    ["-----", "instrumentation/ikb/ikb_none", "-----", "instrumentation/ikb/ikb_none"],
    ["IKB", "instrumentation/ikb/ikb_input", "SET IKB<", "instrumentation/ikb/ikb_none"],
    ["POS", "instrumentation/ikb/coord_pos", "", "instrumentation/ikb/ikb_none"],
    ["", "instrumentation/ikb/ikb_none", "SET LON<", "instrumentation/ikb/ikb_none"],
    ["", "instrumentation/ikb/ikb_none", "SET LAT<", "instrumentation/ikb/ikb_none"]
  ],
#AFT station7
  [ 
    ["AFT STATION7", "MENU CHANGE <"],
    ["TYPE", "armament/bay2/rack6", "ARMED", "armament/bay2/rack6-armed"],
    ["LON", "ai/guided/bay2/bomb[6]/target-longitude-deg", "LAT", "ai/guided/bay2/bomb[6]/target-latitude-deg"],
    ["DIST", "ai/guided/bay2/bomb[6]/target-distance", "TIME", "ai/guided/bay2/bomb[6]/target-distance-sec"],
    ["-----", "instrumentation/ikb/ikb_none", "-----", "instrumentation/ikb/ikb_none"],
    ["IKB", "instrumentation/ikb/ikb_input", "SET IKB<", "instrumentation/ikb/ikb_none"],
    ["POS", "instrumentation/ikb/coord_pos", "", "instrumentation/ikb/ikb_none"],
    ["", "instrumentation/ikb/ikb_none", "SET LON<", "instrumentation/ikb/ikb_none"],
    ["", "instrumentation/ikb/ikb_none", "SET LAT<", "instrumentation/ikb/ikb_none"]
  ],
#AFT station8 [27]
  [ 
    ["AFT STATION8", "MENU CHANGE <"],
    ["TYPE", "armament/bay2/rack7", "ARMED", "armament/bay2/rack7-armed"],
    ["LON", "ai/guided/bay2/bomb[7]/target-longitude-deg", "LAT", "ai/guided/bay2/bomb[7]/target-latitude-deg"],
    ["DIST", "ai/guided/bay2/bomb[7]/target-distance", "TIME", "ai/guided/bay2/bomb[7]/target-distance-sec"],
    ["-----", "instrumentation/ikb/ikb_none", "-----", "instrumentation/ikb/ikb_none"],
    ["IKB", "instrumentation/ikb/ikb_input", "SET IKB<", "instrumentation/ikb/ikb_none"],
    ["POS", "instrumentation/ikb/coord_pos", "", "instrumentation/ikb/ikb_none"],
    ["", "instrumentation/ikb/ikb_none", "SET LON<", "instrumentation/ikb/ikb_none"],
    ["", "instrumentation/ikb/ikb_none", "SET LAT<", "instrumentation/ikb/ikb_none"]
  ]
];

setprop("instrumentation/wso_mfd/menu", 0);

#m=direct menu select,n= incr/decr current
var wso_mfd_update = func(m,n){
  var cmenu = getprop("instrumentation/wso_mfd/menu");
  var cminu = 0;
  var bay = 0;
#4-11, 12-19, 20-27
  
  if(m == 1){
  
    #select the very top menu.
	if(n == 0){
	  setprop("instrumentation/wso_mfd/menu", n);
	  wso_mfd_draw();
	  return;
	}
	
    if((cmenu == 0) and (n < 4) ){
      setprop("instrumentation/wso_mfd/menu", n);
      wso_mfd_draw();
	  return;
    }
	
	if((cmenu < 4) and (cmenu > 0)){
		n = ((cmenu * 8) - 4) + (n - 1);
		setprop("instrumentation/wso_mfd/menu", n);
		wso_mfd_draw();
	}

	if((cmenu >= 4) and (cmenu <= 11)){
		bay = 0;
		cminu = cmenu - 4;
	} elsif((cmenu >= 12) and (cmenu <= 19)){
		bay = 1;
		cminu = cmenu - 12
	} elsif((cmenu >= 20) and (cmenu <= 27)){
		bay = 2;
		cminu = cmenu - 20;
	}
	
	
    if((cmenu > 3) and (cmenu < 28)){
      if (n == 5){
        tgt_input(0);
        wso_mfd_draw();
      }
      if (n == 7){
        setprop("ai/guided/bay" ~bay~ "/bomb["~ cminu ~"]/target-longitude-deg",getprop("instrumentation/ikb/ikb_input"));
        weapons.wpn_info[bay][cminu].lon = getprop("instrumentation/ikb/ikb_input");
        var talt_m = geo.elevation(wpn_info[bay][cminu]["lat"], wpn_info[bay][cminu]["lon"]);
        if ((talt_m == nil) or (talt_m == "")) {
          weapons.wpn_info[bay][cminu].talt_m = -11;
        } else {
            wpn_info[bay][cminu].talt_m = talt_m;
          }
        wso_mfd_draw();
      }
      if (n == 8){
        setprop("ai/guided/bay" ~bay~ "/bomb["~ cminu ~"]/target-latitude-deg",getprop("instrumentation/ikb/ikb_input"));
        weapons.wpn_info[bay][cminu].lat = getprop("instrumentation/ikb/ikb_input");
        var talt_m = geo.elevation(wpn_info[bay][cminu]["lat"], wpn_info[bay][cminu]["lon"]);
        if ((talt_m == nil) or (talt_m == "")) {
          weapons.wpn_info[bay][cminu].talt_m = -11;
        } else {
            weapons.wpn_info[bay][cminu].talt_m = talt_m;
          }
        wso_mfd_draw();
      }
    }
  }

  #incr current menu entry
  if(m == -1){
    n = cmenu + n;
    if ((n > 27) or (n < 0)){
      n = 0;
    }
    setprop("instrumentation/wso_mfd/menu", n);
    wso_mfd_draw();
  }
}

var wso_mfd_draw = func(){

  var n = getprop("instrumentation/wso_mfd/menu");
  #header
  setprop("instrumentation/wso_mfd/line00", wso_mfd[n][0][0]);
  #line1
  setprop("instrumentation/wso_mfd/line10", wso_mfd[n][1][0]);
  setprop("instrumentation/wso_mfd/line11", getprop(""~ wso_mfd[n][1][1] ~""));
  setprop("instrumentation/wso_mfd/line12", wso_mfd[n][1][2]);
  setprop("instrumentation/wso_mfd/line13", getprop(""~ wso_mfd[n][1][3] ~""));
  #line2
  setprop("instrumentation/wso_mfd/line20", wso_mfd[n][2][0]);
  setprop("instrumentation/wso_mfd/line21", getprop(""~ wso_mfd[n][2][1] ~""));
  setprop("instrumentation/wso_mfd/line22", wso_mfd[n][2][2]);
  setprop("instrumentation/wso_mfd/line23", getprop(""~ wso_mfd[n][2][3] ~""));
  #line3
  setprop("instrumentation/wso_mfd/line30", wso_mfd[n][3][0]);
  setprop("instrumentation/wso_mfd/line31", getprop(""~ wso_mfd[n][3][1] ~""));
  setprop("instrumentation/wso_mfd/line32", wso_mfd[n][3][2]);
  setprop("instrumentation/wso_mfd/line33", getprop(""~ wso_mfd[n][3][3] ~""));
  #line4
  setprop("instrumentation/wso_mfd/line40", wso_mfd[n][4][0]);
  setprop("instrumentation/wso_mfd/line41", getprop(""~ wso_mfd[n][4][1] ~""));
  setprop("instrumentation/wso_mfd/line42", wso_mfd[n][4][2]);
  setprop("instrumentation/wso_mfd/line43", getprop(""~ wso_mfd[n][4][3] ~""));
  #line5
  setprop("instrumentation/wso_mfd/line50", wso_mfd[n][5][0]);
  setprop("instrumentation/wso_mfd/line51", getprop(""~ wso_mfd[n][5][1] ~""));
  setprop("instrumentation/wso_mfd/line52", wso_mfd[n][5][2]);
  setprop("instrumentation/wso_mfd/line53", getprop(""~ wso_mfd[n][5][3] ~""));
  #line6
  setprop("instrumentation/wso_mfd/line60", wso_mfd[n][6][0]);
  setprop("instrumentation/wso_mfd/line61", getprop(""~ wso_mfd[n][6][1] ~""));
  setprop("instrumentation/wso_mfd/line62", wso_mfd[n][6][2]);
  setprop("instrumentation/wso_mfd/line63", getprop(""~ wso_mfd[n][6][3] ~""));
  #line7
  setprop("instrumentation/wso_mfd/line70", wso_mfd[n][7][0]);
  setprop("instrumentation/wso_mfd/line71", getprop(""~ wso_mfd[n][7][1] ~""));
  setprop("instrumentation/wso_mfd/line72", wso_mfd[n][7][2]);
  setprop("instrumentation/wso_mfd/line73", getprop(""~ wso_mfd[n][7][3] ~""));
  #line8
  setprop("instrumentation/wso_mfd/line80", wso_mfd[n][8][0]);
  setprop("instrumentation/wso_mfd/line81", getprop(""~ wso_mfd[n][8][1] ~""));
  setprop("instrumentation/wso_mfd/line82", wso_mfd[n][8][2]);
  setprop("instrumentation/wso_mfd/line83", getprop(""~ wso_mfd[n][8][3] ~""));
  #footer
  setprop("instrumentation/wso_mfd/line01", wso_mfd[n][0][1]);

}
