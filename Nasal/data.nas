var serialize = func() {
    # TGT,bay,rack,lat,lon
    syncData();
	var ret = "";
	var iter = 0;
	for ( var bay = 0; bay < 3; bay = bay + 1 ) {
        for ( var rack = 0; rack < 8; rack = rack + 1 ) {
            ret = ret~sprintf("TGT,%d,%d,%s,%s|", bay, rack, getprop("/ai/guided/bay"~bay~"/bomb["~rack~"]/target-latitude-deg"), getprop("/ai/guided/bay"~bay~"/bomb["~rack~"]/target-longitude-deg"));
        }
    }
    return ret;
}

var unserialize = func(m) {
    var stpts = split("|",m);
    foreach(item;stpts) {
        var items = split(",", item);
        var key = items[0];
        if (key == "TGT") {
            var bay = items[1];
            var rack = items[2];
            setprop("/ai/guided/bay"~bay~"/bomb["~rack~"]/target-latitude-deg", items[3]);
            setprop("/ai/guided/bay"~bay~"/bomb["~rack~"]/target-longitude-deg", items[4]);
        }
    }
    syncData();
}


var saveSTPTs = func (path) {
    var text = serialize();
    var opn = nil;
    call(func{opn = io.open(path,"w");},nil, var err = []);
    if (size(err) or opn == nil) {
      print("error open file for writing STPTs");
      gui.showDialog("savefail");
      return 0;
    }
    call(func{var text = io.write(opn,text);},nil, var err = []);
    if (size(err)) {
      print("error writing file with STPTs");
      setprop("b1/preplanning-status", err[0]);
      io.close(opn);
      gui.showDialog("savefail");
      return 0;
    } else {
      io.close(opn);
      setprop("b1/preplanning-status", "DTC data saved");
      return 1;
    }
}

var loadSTPTs = func (path) {
    var text = nil;
    call(func{text=io.readfile(path);},nil, var err = []);
    if (size(err)) {
      print("Loading STPTs failed.");
      setprop("b1/preplanning-status", err[0]);
      gui.showDialog("loadfail");
    } elsif (text != nil) {
      unserialize(text);
      setprop("b1/preplanning-status", "DTC data loaded");
    }
}

var syncData = func {
    for ( var bay = 0; bay < 3; bay = bay + 1 ) {
        for ( var rack = 0; rack < 8; rack = rack + 1 ) {
            weapons.wpn_info[bay][rack].lat = getprop("/ai/guided/bay"~bay~"/bomb["~rack~"]/target-latitude-deg");
            weapons.wpn_info[bay][rack].lon = getprop("/ai/guided/bay"~bay~"/bomb["~rack~"]/target-longitude-deg");
            var talt_m = geo.elevation(weapons.wpn_info[bay][rack]["lat"], weapons.wpn_info[bay][rack]["lon"]);
            if ((talt_m == nil) or (talt_m == "")) {
              weapons.wpn_info[bay][rack].talt_m = -11;
            } else {
                weapons.wpn_info[bay][rack].talt_m = talt_m;
            }
        }
    }
}

setprop("sim/fg-home-export", getprop("sim/fg-home")~"/Export");
