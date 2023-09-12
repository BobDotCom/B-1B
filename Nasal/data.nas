var serialize = func() {
    # TGT,bay,rack,lat,lon,alt
    syncData();
	var ret = "";
	var iter = 0;
	for ( var bay = 0; bay < 3; bay = bay + 1 ) {
        for ( var rack = 0; rack < 16; rack = rack + 1 ) {
            ret = ret~sprintf("TGT,%d,%d,%s,%s,%s|", bay, rack, getprop("/ai/guided/bay"~bay~"/bomb["~rack~"]/target-latitude-deg"), getprop("/ai/guided/bay"~bay~"/bomb["~rack~"]/target-longitude-deg"), getprop("/ai/guided/bay"~bay~"/bomb["~rack~"]/target-altitude"));
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
            if (size(items) > 5) {
                # Altitude supported
                setprop("/ai/guided/bay"~bay~"/bomb["~rack~"]/target-altitude", items[5]);
            } else {
                setprop("/ai/guided/bay"~bay~"/bomb["~rack~"]/target-altitude", 0);
            }
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
    return;
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

var select = func (bay, rack) {
    var t_lat = getprop(sprintf("/ai/guided/bay%d/bomb[%d]/target-latitude-deg", bay, rack));
    var t_lon = getprop(sprintf("/ai/guided/bay%d/bomb[%d]/target-longitude-deg", bay, rack));
    # t_alt = geo.elevation(t_lat, t_lon);
    var t_alt = getprop(sprintf("/ai/guided/bay%d/bomb[%d]/target-altitude", bay, rack));
    if (t_lat < 90 and t_lat > -90 and t_lon < 180 and t_lon > -180 and pylons.fcs != nil) {
        pylons.fcs.selectPylon(bay, rack);
        var wp = pylons.fcs.getSelectedWeapon();
        if (wp != nil and wp.parents[0] == armament.AIM and wp.target_pnt == 1 and (wp.guidance=="gps" or wp.guidance=="gps-altitude")) {
            var coord = geo.Coord.new();
            coord.set_latlon(t_lat,t_lon,t_alt);
            var spot = radar_system.ContactTGP.new("GPS-Spot",coord,0);
            armament.contactPoint = spot;
            if (getprop("f16/stores/tgp-mounted") and 0) {
                tgp.flir_updater.click_coord_cam = armament.contactPoint.get_Coord();
                callsign = armament.contactPoint.getUnique();
                setprop("/aircraft/flir/target/auto-track", 1);
                flir_updater.offsetP = 0;
                flir_updater.offsetH = 0;
                setprop("f16/avionics/tgp-lock", 1);
            }
            wp.setContacts([spot]);
            # Temporarily
            # TODO: Figure out why this is needed
            wp.start();
        }
    }
}

setprop("sim/fg-home-export", getprop("sim/fg-home")~"/Export");


var status_update_func = func {
    for ( var bay = 0; bay < 3; bay = bay + 1 ) {
        for ( var rack = 0; rack < 16; rack = rack + 1 ) {
            var wpn = pylons.fcs._getSpecificWeapon(bay,rack);
            var txt = "";
            if (wpn == nil) {
                txt = "Not loaded";
            } else if (!wpn.isPowerOn()) {
                txt = "Off";
            } else if (wpn.status == armament.MISSILE_STANDBY) {
                txt = "Standby";
            } else if (wpn.status == armament.MISSILE_STARTING) {
                txt = "Starting";
            } else if (wpn.status == armament.MISSILE_SEARCH) {
                txt = "Ready";
            } else if (wpn.status == armament.MISSILE_LOCK) {
                txt = "Locked";
            } else if (wpn.status == armament.MISSILE_FLYING) {
                txt = "Deployed";
            } else {
                txt = "Error";
            }
            setprop("/ai/guided/bay"~bay~"/bomb["~rack~"]/status-text", txt);
        }
    }
}
var status_update = maketimer(0.25, status_update_func);