_setlistener("/sim/signals/fdm-initialized", func {
    rtExec_loop();
	# This loads displays/displays.nas as a module. This can sometimes be buggy, please disable when not needed for development and add to -set
var hmd = modules.Module.new("displays");
hmd.setDebug(0); # From previous testing this causes FG to crash, So if you use this and FG crashes, check this is at 0
hmd.setFilePath(getprop("/sim/aircraft-dir")~"/Nasal/displays");
hmd.setMainFile("displays.nas");
hmd.load();
	init_b1b();
});

var ownship_pos = geo.Coord.new();
var SubSystem_Main = {
    new : func (_ident){

        var obj = { parents: [SubSystem_Main]};
        input = {
            # PFD
            alt_ft:               "instrumentation/altimeter/indicated-altitude-ft",
            heading:              "instrumentation/heading-indicator/indicated-heading-deg",
            ias:                  "instrumentation/airspeed-indicator/indicated-speed-kt",
            inhg:                 "instrumentation/altimeter/setting-inhg",
            mach:                 "instrumentation/airspeed-indicator/indicated-mach",
            Nz:                   "accelerations/pilot-gdamped",
            #pitch:                "instrumentation/attitude-indicator/indicated-pitch-deg",
            #roll:                 "instrumentation/attitude-indicator/indicated-roll-deg",
            pitch:                "orientation/pitch-deg",
            roll:                 "orientation/roll-deg",
            targetMach:           "autopilot/settings/target-mach",

            FrameRate                 : "sim/frame-rate",
            frame_rate_worst          : "sim/frame-rate-worst",
            alt_true_ft:          "position/altitude-ft",
            radarStandby:         "instrumentation/radar/radar-standby",
            rad_alt:              "instrumentation/radar-altimeter/radar-altitude-ft",
            rad_alt_ready:        "instrumentation/radar-altimeter/ready",
            rmActive:             "autopilot/route-manager/active",
            rmDist:               "autopilot/route-manager/wp/dist",
            rmId:                 "autopilot/route-manager/wp/id",
            rmBearing:            "autopilot/route-manager/wp/true-bearing-deg",
            RMCurrWaypoint:       "autopilot/route-manager/current-wp",
            headTrue:             "orientation/heading-deg",
            #rollTrue:             "orientation/roll-deg",
            #pitchTrue:            "orientation/pitch-deg",
            nav0InRange:          "instrumentation/nav[0]/in-range",
            APLockHeading:        "autopilot/locks/heading",
            APTrueHeadingErr:     "autopilot/internal/true-heading-error-deg",
            APnav0HeadingErr:     "autopilot/internal/nav1-heading-error-deg",
            APHeadingBug:         "autopilot/settings/heading-bug-deg",
            RMActive:             "autopilot/route-manager/active",
            nav0Heading:          "instrumentation/nav[0]/heading-deg",
            tas:                  "instrumentation/airspeed-indicator/true-speed-kt",
            gearsPos:             "gear/gear/position-norm",
            latitude:             "position/latitude-deg",
            longitude:            "position/longitude-deg",
            tacanCh:              "instrumentation/tacan/display/channel",
            ilsCh:                "instrumentation/nav[0]/frequencies/selected-mhz",
            servStatic:				 "systems/static/serviceable",
            servPitot:				 "systems/pitot/serviceable",
            servAtt                   : "instrumentation/attitude-indicator/serviceable",
            servHead                  : "instrumentation/heading-indicator/serviceable",
            servTurn                  : "instrumentation/turn-indicator/serviceable",
        };

        foreach (var name; keys(input)) {
            emesary.GlobalTransmitter.NotifyAll(notifications.FrameNotificationAddProperty.new(_ident,name, input[name]));
        }

        #
        # recipient that will be registered on the global transmitter and connect this
        # subsystem to allow subsystem notifications to be received
        obj.recipient = emesary.Recipient.new(_ident~".Subsystem");
        obj.recipient.Main = obj;

        obj.recipient.Receive = func(notification)
        {
            if (notification.NotificationType == "FrameNotification")
            {
                me.Main.update(notification);
                ownship_pos.set_latlon(getprop("position/latitude-deg"), getprop("position/longitude-deg"), getprop("position/altitude-ft")*FT2M);
                notification.ownship_pos = ownship_pos;
                return emesary.Transmitter.ReceiptStatus_OK;
            }
            return emesary.Transmitter.ReceiptStatus_NotProcessed;
        };
        #emesary.GlobalTransmitter.Register(obj.recipient);

        return obj;
    },
    update : func(notification) {
    },
};

subsystem = SubSystem_Main.new("SubSystem_Main");


# This loads displays/displays.nas as a module. This can sometimes be buggy, please disable when not needed for development and add to -set
#var hmd = modules.Module.new("displays");
#hmd.setDebug(0); # From previous testing this causes FG to crash, So if you use this and FG crashes, check this is at 0
#hmd.setFilePath(getprop("/sim/aircraft-dir")~"/Nasal/displays");
##hmd.setMainFile("displays.nas");
#hmd.load();

var init_b1b = func {
setprop("systems/refuel/serviceable", 'false');
setprop("instrumentation/teravd/target-vfpm-exec", 0);
setprop("instrumentation/teravd/target-alt-exec", 0);
setprop("autopilot/settings/target-altitude-ft", 0);
setprop("autopilot/settings/vertical-speed-fpm", 0);
setprop("instrumentation/teravd/alt-reached", 1);
setprop("instrumentation/teravd/ridge-clear", 0);
setprop("autopilot/settings/target-pitch-deg", 2);
setprop("controls/electric/battery-switch", 0);
setprop("controls/switches/terra-report", 0);
setprop("controls/switches/fltdir", 0.25);
setprop("controls/switches/radar-range", 0.25);
setprop("controls/switches/terrain-avoid-clrpln", 0);
setprop("controls/switches/terrain-avoid-rng", 0);
setprop("controls/switches/terrain-avoid-clr1000", 0);
setprop("instrumentation/teravd/target-vfpm", 0);
setprop("instrumentation/teravd/target-alt", 0);
setprop("controls/switches/terrain-avoid-rng-25", 0);
setprop("controls/switches/terrain-avoid-rng-50", 0);
setprop("controls/switches/terrain-follow-map", 0);
setprop("controls/switches/terrain-follow-clr", 0);
setprop("controls/engines/engine[0]/cutoff", 1);#start with engines off
setprop("controls/engines/engine[1]/cutoff", 1);
setprop("controls/engines/engine[2]/cutoff", 1);
setprop("controls/engines/engine[3]/cutoff", 1);
#setprop("consumables/fuel/tank[3]/level-gal_us", 5000);
#setprop("consumables/fuel/tank[5]/level-gal_us", 5000);
setprop("instrumentation/cg/cg_mac_set", 70);
setprop("instrumentation/cg/cg_mac", 30);
setprop("instrumentation/tacan/frequencies/selected-channel[12]", 2);
settimer(flightcontrols.fuelsweep, 1);
# setprop("ai/guided/id-number", 0);
# setprop("ai/guided/target-number", 0);
# setprop("ai/guided/id-release", 0);
# setprop("armament/sniper-pod/position-norm",0);
# setprop("armament/oso/bay-selected", 0);
# setprop("armament/bay0/launcher-pos", 0);
# setprop("armament/bay1/launcher-pos", 0);
# setprop("armament/bay2/launcher-pos", 0);

# #init the armaments
# setprop("armament/bay0/rack0",0);
# setprop("armament/bay0/rack0-armed",0);
# setprop("armament/bay0/rack1",0);
# setprop("armament/bay0/rack1-armed",0);
# setprop("armament/bay0/rack2",0);
# setprop("armament/bay0/rack2-armed",0);
# setprop("armament/bay0/rack3",0);
# setprop("armament/bay0/rack3-armed",0);
# setprop("armament/bay0/rack4",0);
# setprop("armament/bay0/rack4-armed",0);
# setprop("armament/bay0/rack5",0);
# setprop("armament/bay0/rack5-armed",0);
# setprop("armament/bay0/rack6",0);
# setprop("armament/bay0/rack6-armed",0);
# setprop("armament/bay0/rack7",0);
# setprop("armament/bay0/rack7-armed",0);
# setprop("armament/bay1/rack0",0);
# setprop("armament/bay1/rack0-armed",0);
# setprop("armament/bay1/rack1",0);
# setprop("armament/bay1/rack1-armed",0);
# setprop("armament/bay1/rack2",0);
# setprop("armament/bay1/rack2-armed",0);
# setprop("armament/bay1/rack3",0);
# setprop("armament/bay1/rack3-armed",0);
# setprop("armament/bay1/rack4",0);
# setprop("armament/bay1/rack4-armed",0);
# setprop("armament/bay1/rack5",0);
# setprop("armament/bay1/rack5-armed",0);
# setprop("armament/bay1/rack6",0);
# setprop("armament/bay1/rack6-armed",0);
# setprop("armament/bay1/rack7",0);
# setprop("armament/bay1/rack7-armed",0);
# setprop("armament/bay2/rack0",0);
# setprop("armament/bay2/rack0-armed",0);
# setprop("armament/bay2/rack1",0);
# setprop("armament/bay2/rack1-armed",0);
# setprop("armament/bay2/rack2",0);
# setprop("armament/bay2/rack2-armed",0);
# setprop("armament/bay2/rack3",0);
# setprop("armament/bay2/rack3-armed",0);
# setprop("armament/bay2/rack4",0);
# setprop("armament/bay2/rack4-armed",0);
# setprop("armament/bay2/rack5",0);
# setprop("armament/bay2/rack5-armed",0);
# setprop("armament/bay2/rack6",0);
# setprop("armament/bay2/rack6-armed",0);
# setprop("armament/bay2/rack7",0);
# setprop("armament/bay2/rack7-armed",0);


#init guidance info and wso panel.
for (var bay_num = 0; bay_num < 3; bay_num = bay_num + 1) {
	for (var bomb_num = 0; bomb_num < 8; bomb_num = bomb_num + 1) {
		setprop("ai/guided/bay"~bay_num~"/bomb["~bomb_num~"]/target-distance",9999.99);
		setprop("ai/guided/bay"~bay_num~"/bomb["~bomb_num~"]/target-distance-sec",9999.99);
		setprop("ai/guided/bay"~bay_num~"/bomb["~bomb_num~"]/target-longitude-deg",0);
		setprop("ai/guided/bay"~bay_num~"/bomb["~bomb_num~"]/target-latitude-deg",0);
	}
}
# weapons.wso_mfd_update(1,0); Disabled temp due to weapon system upgrade work




#init the wso
setprop("instrumentation/wso_mfd/menu", 0);
#damage
setprop("/armament/damage",0);


wingSweep(1);#sweep wings to fwd position
wingSweep(1);
wingSweep(1);
wingSweep(1);
settimer(cg.cg_dist, 2);
#radardist.init();
settimer(eta_waypoint, 1);
settimer(enginefire.fire_loop, 3);
#settimer(weapons.weapon_system, 3);
#fuel_syst();
settimer(eng_state, 3);
settimer(tacan_follow, 4);
setprop("sim/multiplay/generic/float[2]",0);
setprop("sim/multiplay/generic/float[3]",0);
setprop("sim/multiplay/generic/float[4]",0);
setprop("sim/multiplay/generic/float[5]",0);
b1b.elevon();
b1b.cdu_set(2,1);
print ("B-1B systems starting!");
}

var elevon = func() {
  var aileron = getprop("controls/flight/aileron");
  var elevon = aileron * 0.3;
  setprop("controls/flight/elevon",elevon);
  settimer(b1b.elevon,0);
}

### doors and animations
var hatch = aircraft.door.new ("canopy",15);
var bay_fwd = func(m) {
  interpolate("sim/multiplay/generic/float[2]",m,3);
  setprop("doors/bay_fwd/position-norm",m);
}
var bay_intmd = func(m) {
  interpolate("sim/multiplay/generic/float[3]",m,3);
  setprop("doors/bay_intmd/position-norm",m);
}
var bay_aft = func(m) {
  interpolate("sim/multiplay/generic/float[4]",m,3);
  setprop("doors/bay_aft/position-norm",m);
}
var refuel_door = func {
  interpolate("sim/multiplay/generic/float[5]",getprop("controls/switches/refuel-lid"),3);
}

### failure dialog
#var engine_failures = gui.Dialog.new("dialog","Aircraft/B-1B/Dialogs/failures.xml");
#var distance_tanker = gui.Dialog.new("dialog","Aircraft/B-1B/Dialogs/distance_to_tanker.xml");

### tacan follow autopilot
var tacan_follow = func {
var ap_state = getprop("autopilot/locks/heading");
if (ap_state == "tacan-hold") {
  var tacan_hdg = getprop("instrumentation/tacan/indicated-bearing-true-deg");
  setprop("autopilot/settings/heading-bug-deg", tacan_hdg);
}
settimer(tacan_follow, 1);
}

### format waypoint data loop
var eta_waypoint = func {
var eta = getprop("autopilot/route-manager/wp/eta");
if ((eta == nil) or (eta == '')) {
  settimer(eta_waypoint, 0.1);
  } else {
    var spliteta = split(":", eta);
    var eta0 = spliteta[0];
    if ((eta0 == nil) or (eta0 == '')){
      var eta0 = 0;
      }
    var eta1 = spliteta[1];
    if ((eta1 == nil) or (eta1 == '')){
      var eta1 = 0;
      }
  setprop("autopilot/route-manager/wp/eta_h", eta0);
  setprop("autopilot/route-manager/wp/eta_m", eta1);
  settimer(eta_waypoint, 0.1);
  }
}

### bug heading selector
var bug_hdg = func(n) {
var hdg = getprop("autopilot/settings/heading-bug-deg");
if (hdg == nil){
var hdg = 0;
}
var hdg_new = hdg + n;
if (hdg_new == 360){
var hdg_new = 0;
}
if (hdg_new == -1){
var hdg_new = 359;
}
setprop("autopilot/settings/heading-bug-deg",hdg_new);
}

### autoengage afterburner when full throttle applied
setlistener("controls/engines/engine[0]/throttle-lever", func(n) {
  var lever_eng0 = n.getValue();
  var enabled = getprop("controls/switches/engines/afterburner[0]");
  if ((lever_eng0 >= 0.98) and (enabled)) {
    setprop("controls/engines/engine[0]/afterburner", 1);
  } else {
    setprop("controls/engines/engine[0]/afterburner", 0);
    }
});
setlistener("controls/engines/engine[1]/throttle-lever", func(n) {
  var lever_eng1 = n.getValue();
  var enabled = getprop("controls/switches/engines/afterburner[1]");
  if ((lever_eng1 >= 0.98) and (enabled)) {
    setprop("controls/engines/engine[1]/afterburner", 1);
  } else {
    setprop("controls/engines/engine[1]/afterburner", 0);
    }
});
setlistener("controls/engines/engine[2]/throttle-lever", func(n) {
  var lever_eng2 = n.getValue();
  var enabled = getprop("controls/switches/engines/afterburner[2]");
  if ((lever_eng2 >= 0.98) and (enabled)) {
    setprop("controls/engines/engine[2]/afterburner", 1);
  } else {
    setprop("controls/engines/engine[2]/afterburner", 0);
    }
});
setlistener("controls/engines/engine[3]/throttle-lever", func(n) {
  var lever_eng3 = n.getValue();
  var enabled = getprop("controls/switches/engines/afterburner[3]");
  if ((lever_eng3 >= 0.98) and (enabled)) {
    setprop("controls/engines/engine[3]/afterburner", 1);
  } else {
    setprop("controls/engines/engine[3]/afterburner", 0);
    }
});

##
# Wrapper around stepProps() which emulates the "old" wing sweep behavior for
# configurations that aren't using the new mechanism.
#
wingSweep = func {
    if(arg[0] == 0) { return; }
    if(props.globals.getNode("/sim/wing-sweep") != nil) {
        stepProps("controls/flight/wing-sweep", "sim/wing-sweep", arg[0]);
        return;
    }
    # Hard-coded wing movement in 5 equal steps:
    val = 0.20 * arg[0] + getprop("controls/flight/wing-sweep");
    if(val > 1) { val = 1 } elsif(val < 0) { val = 0 }
    setprop("controls/flight/wing-sweep", val);
}

stepProps = func {
    dst = props.globals.getNode(arg[0]);
    array = props.globals.getNode(arg[1]);
    delta = arg[2];
    if(dst == nil or array == nil) { return; }

    sets = array.getChildren("setting");

    curr = array.getNode("current-setting", 1).getValue();
    if(curr == nil) { curr = 0; }
    curr = curr + delta;
    if   (curr < 0)           { curr = 0; }
    elsif(curr >= size(sets)) { curr = size(sets) - 1; }

    array.getNode("current-setting").setIntValue(curr);
    dst.setValue(sets[curr].getValue());
}
#
##### Terrain Follow Switch and Prty toggle switch
#
var ter_follow = func(number){

var terflw = getprop("controls/switches/terrain-follow");
var terflwmap = getprop("controls/switches/terrain-follow-map");

if(terflw == 1) {
	if(terflwmap == 0) {
	setprop("autopilot/locks/altitude", "agl-hold");
        setprop("controls/switches/terrain-follow-map-enabled", 0);#triggers the submodels radarpulse off

} elsif (terflwmap == 1) {
	setprop("autopilot/locks/altitude", "vertical-speed-hold");
        setprop("controls/switches/terrain-follow-map-enabled", 1);#triggers the submodels radarpulse on
}
} elsif(terflw == 0) {
	setprop("autopilot/locks/altitude", "");
        setprop("controls/switches/terrain-follow-map-enabled", 0);
}
} # End Function

#
##### Terrain Avoid Switch
#
var ter_avoid_switch = func {
var   tas = getprop("controls/switches/terrain-avoid");
var   rs = getprop("controls/switches/terrain-avoid-rng");

if (tas == 1) {
    if (rs == 0) {
    setprop("controls/switches/terrain-avoid-rng-25", 1);
    setprop("controls/switches/terrain-avoid-rng-50", 0);
  } elsif (rs == 1) {
    setprop("controls/switches/terrain-avoid-rng-25", 0);
    setprop("controls/switches/terrain-avoid-rng-50", 1);
     }
} else {
   setprop("controls/switches/terrain-avoid-rng-25", 0);
   setprop("controls/switches/terrain-avoid-rng-50", 0);
}
}
#
##### Terrain Avoid Toggle Radar Dist Switch
#
var radar_switch = func {
var rs = getprop("controls/switches/terrain-avoid-rng");
var tas = getprop("controls/switches/terrain-avoid");
   if(tas == 1) {
   if(rs == 0) {
   setprop("controls/switches/terrain-avoid-rng-25", 1);
   setprop("controls/switches/terrain-avoid-rng-50", 0);
} elsif (rs == 1) {
   setprop("controls/switches/terrain-avoid-rng-50", 1);
   setprop("controls/switches/terrain-avoid-rng-25", 0);
}
}
}

#
##### Terrain Avoid Toggle Radar Clearance
#
var radar_clrpln = func {

var rcs = getprop("controls/switches/terrain-avoid-clrpln");

if(rcs == 0) {
setprop("controls/switches/terrain-avoid-clr1000", 0);
}
if(rcs == 0.25) {
setprop("controls/switches/terrain-avoid-clr1000", 100);
}
if(rcs == 0.5) {
setprop("controls/switches/terrain-avoid-clr1000", 300);
}
if(rcs == 0.75) {
setprop("controls/switches/terrain-avoid-clr1000", 500);
}
if(rcs == 1.0) {
setprop("controls/switches/terrain-avoid-clr1000", 1000);
}

}

#
##### Terrain Follow Radar Clearance
#
var radar_setclr = func(number) {

var sclr = getprop("controls/switches/terrain-follow-setclr");
var oldclr = getprop("controls/switches/terrain-follow-clr");
if((number == 1) and (oldclr < 2000)) {
var newclr = (oldclr + 200);
setprop("controls/switches/terrain-follow-clr", newclr);
setprop("autopilot/settings/target-agl-ft", newclr);
} elsif((number == 0) and (oldclr > 0)) {
var newclr = (oldclr - 200);
setprop("controls/switches/terrain-follow-clr", newclr);
setprop("autopilot/settings/target-agl-ft", newclr);
}
}
#
##### Terrain Avoidance Radar Pulse (inspired from vulcanb2)
#

settimer(func {

  # Add listener for radar pulse contactm0d
  setlistener("sim/radar/teravd/contactm0d", func(n) {
    var contactm0d = n.getValue();
#    var solid = getprop(contactm0d ~ "/material/solid");
    
#    if (solid)
#    {
      var long = getprop(contactm0d ~ "/impact/longitude-deg");
      var lat = getprop(contactm0d ~ "/impact/latitude-deg");
      var elev_m = getprop(contactm0d ~ "/impact/elevation-m");
      var spd = getprop(contactm0d ~ "/impact/speed-mps");
      var time = getprop(contactm0d ~ "/sim/time/elapsed-sec");
      var elev_ft = int(elev_m * 3.28);
      var dist_ft = int(spd * time * 3.28);
      setprop("instrumentation/teravd/elevationm0d", elev_ft);
      setprop("instrumentation/teravd/distancem0d", dist_ft);

    settimer(teravd_m0d, 0);

#    }
  });
}, 0);

settimer(func {

  # Add listener for radar pulse contactm4d
  setlistener("sim/radar/teravd/contactm4d", func(n) {
    var contactm4d = n.getValue();
#    var solid = getprop(contactm4d ~ "/material/solid");
    
#    if (solid)
#    {
      var long = getprop(contactm4d ~ "/impact/longitude-deg");
      var lat = getprop(contactm4d ~ "/impact/latitude-deg");
      var elev_m = getprop(contactm4d ~ "/impact/elevation-m");
      var spd = getprop(contactm4d ~ "/impact/speed-mps");
      var time = getprop(contactm4d ~ "/sim/time/elapsed-sec");
      var elev_ft = int(elev_m * 3.28);
      var dist_ft = int(spd * time * 3.28);
      setprop("instrumentation/teravd/elevationm4d", elev_ft);
      setprop("instrumentation/teravd/distancem4d", dist_ft);

     settimer(teravd_m4d, 0);

#    }
  });
}, 0);

settimer(func {

  # Add listener for radar pulse contactm20d
  setlistener("sim/radar/teravd/contactm20d", func(n) {
    var contactm20d = n.getValue();
#    var solid = getprop(contactm20d ~ "/material/solid");
    
#    if (solid)
#    {
      var long = getprop(contactm20d ~ "/impact/longitude-deg");
      var lat = getprop(contactm20d ~ "/impact/latitude-deg");
      var elev_m = getprop(contactm20d ~ "/impact/elevation-m");
      var spd = getprop(contactm20d ~ "/impact/speed-mps");
      var time = getprop(contactm20d ~ "/sim/time/elapsed-sec");
      var elev_ft = int(elev_m * 3.28);
      var dist_ft = int(spd * time * 3.28);
      setprop("instrumentation/teravd/elevationm20d", elev_ft);
      setprop("instrumentation/teravd/distancem20d", dist_ft);

     settimer(teravd_m20d, 0);

#    }
  });
}, 0);


# control alt while climb and trigger end of climb

var teravd_m0d = func {
var calt = getprop("position/altitude-ft");
var cspd = getprop("velocities/groundspeed-kt");
var talt = getprop("autopilot/settings/target-altitude-ft");
var tvfpm = getprop("autopilot/settings/vertical-speed-fpm");
var rdist25 = getprop("controls/switches/terrain-avoid-rng-25");
var rdist50  = getprop("controls/switches/terrain-avoid-rng-50");

var elem0d = getprop("instrumentation/teravd/elevationm0d");
var distm0d = getprop("instrumentation/teravd/distancem0d");
var clr = getprop("controls/switches/terrain-avoid-clr1000");

if (rdist25 = 1) {
  var rdist = 15000;
  } elsif (rdist50 = 1) {
  var rdist = 30000;
}
var daltm0d = ((elem0d + clr) - calt);

if ((distm0d < rdist) and (daltm0d > 0)) {
  var talt = calt + daltm0d;
  var itime = distm0d / (cspd * 1.6878);
  var tvfpm = int((daltm0d) / (itime / 2)) * 60;
  setprop("instrumentation/teravd/target-vfpm", tvfpm);
  setprop("instrumentation/teravd/target-alt", talt);
  setprop("controls/switches/terra-report", 1);
  settimer(setvfpm, 0);
}
}


var teravd_m4d = func {
#var cpitch = getprop("orientation/pitch-deg");
var calt = getprop("position/altitude-ft");
var cspd = getprop("velocities/groundspeed-kt");
var talt = getprop("autopilot/settings/target-altitude-ft");
var tvfpm = getprop("autopilot/settings/vertical-speed-fpm");
var rdist25 = getprop("controls/switches/terrain-avoid-rng-25");
var rdist50  = getprop("controls/switches/terrain-avoid-rng-50");

var elem4d = getprop("instrumentation/teravd/elevationm4d");
var distm4d = getprop("instrumentation/teravd/distancem4d");
var clr = getprop("controls/switches/terrain-avoid-clr1000");

var evfpm = getprop("instrumentation/teravd/target-vfpm");
var etalt = getprop("instrumentation/teravd/target-alt");

if (rdist25 = 1) {
  var rdist = 15000;
  } elsif (rdist50 = 1) {
  var rdist = 30000;
}

var daltm4d = ((elem4d + clr) - calt);

if ((distm4d < rdist) and (daltm4d > 0)) {
var talt = calt + daltm4d;
var itime = distm4d / (cspd * 1.6878);
var tvfpm = int((daltm4d) / ((itime * 2) / 3)) * 60;

if (etalt < talt) {
  setprop("instrumentation/teravd/target-alt", talt);
}
if (evfpm < tvfpm) {
  setprop("instrumentation/teravd/target-vfpm", tvfpm);
}
setprop("controls/switches/terra-report", 1);
settimer(setvfpm, 0);
}
}

var teravd_m20d = func {
var calt = getprop("position/altitude-ft");
var cspd = getprop("velocities/groundspeed-kt");
var talt = getprop("autopilot/settings/target-altitude-ft");
var tvfpm = getprop("autopilot/settings/vertical-speed-fpm");
var rdist25 = getprop("controls/switches/terrain-avoid-rng-25");
var rdist50  = getprop("controls/switches/terrain-avoid-rng-50");

var evfpm = getprop("instrumentation/teravd/target-vfpm");
var etalt = getprop("instrumentation/teravd/target-alt");

var elem20d = getprop("instrumentation/teravd/elevationm20d");
var distm20d = getprop("instrumentation/teravd/distancem20d");
var clr = getprop("controls/switches/terrain-avoid-clr1000");
var prty = getprop("controls/switches/terrain-follow-map-enabled");

if (rdist25 = 1) {
var rdist2 = 15000;
} elsif (rdist50 = 1) {
  var rdist2 = 30000;
}

var daltm20d = ((elem20d + clr) - calt);

if ((distm20d < rdist2) and (daltm20d > 0)) {
  var talt = calt + daltm20d;
  var itime = distm20d / (cspd * 1.6878);
  var tvfpm = int((daltm20d) / (itime / 2)) * 60;

if (etalt < talt) {
  setprop("instrumentation/teravd/target-alt", talt);
}
if (evfpm < tvfpm) {
  setprop("instrumentation/teravd/target-vfpm", tvfpm);
}
setprop("controls/switches/terra-report", 1);
settimer(setvfpm, 0);
}

}


var setvfpm = func {
var calt = getprop("position/altitude-ft");
var talt = getprop("instrumentation/teravd/target-alt");
var tvfpm = getprop("instrumentation/teravd/target-vfpm");

setprop("controls/switches/apmode/alt-hold", 0);
setprop("controls/switches/apmode/ptch-hold", 0);
setprop("controls/switches/apmode/vfpm-hold", 0);
setprop("autopilot/settings/vertical-speed-fpm", tvfpm);
setprop("autopilot/locks/altitude", "vertical-speed-hold");
if (calt > talt) {
  setprop("autopilot/settings/vertical-speed-fpm", 0);
  setprop("controls/switches/terra-report", 0);
  setprop("instrumentation/teravd/target-vfpm", 0);
  setprop("instrumentation/teravd/target-alt", 0);
  #settimer(aglreinit, 0);
} else {
  settimer(setvfpm, 0.5);
  }
}


# reinit previous flight params
#var aglreinit = func {
#var terflw = getprop("controls/switches/terrain-follow");
#setprop("controls/switches/terra-report", 0);
#if(terflw == 1) {
#  setprop("autopilot/locks/altitude", "vertical-speed-hold");
#} elsif {
#  setprop("autopilot/locks/altitude", "vertical-speed-hold");
  #setprop("autopilot/locks/altitude", "altitude-hold");
# }
#}
### end of terrain avoidance behaviour #########################

### engine on/off workaround adapted from Citation Bravo

var eng_state = func {

    if(getprop("controls/engines/engine[0]/cutoff") == 0){
        setprop("controls/engines/engine[0]/throttle-lever",getprop("controls/engines/engine[0]/throttle"));
        interpolate("sim/model/B-1B/n1[0]",getprop("engines/engine/n1"),3);
        interpolate("sim/model/B-1B/n2[0]",getprop("engines/engine/n2"),3);
        #setprop("sim/model/B-1B/n1[0]",getprop("engines/engine/n1"));
        #setprop("sim/model/B-1B/n2[0]",getprop("engines/engine/n2"));
    }else{
        setprop("controls/engines/engine[0]/throttle-lever", 0);
        interpolate("sim/model/B-1B/n1[0]",0,10);
        interpolate("sim/model/B-1B/n2[0]",0,10);
    }

    if(getprop("controls/engines/engine[1]/cutoff") == 0){
        setprop("controls/engines/engine[1]/throttle-lever",getprop("controls/engines/engine[1]/throttle"));
        interpolate("sim/model/B-1B/n1[1]",getprop("engines/engine[1]/n1"),3);
        interpolate("sim/model/B-1B/n2[1]",getprop("engines/engine[1]/n2"),3);
        #setprop("sim/model/B-1B/n1[1]",getprop("engines/engine/n1"));
        #setprop("sim/model/B-1B/n2[1]",getprop("engines/engine/n2"));
    }else{
        setprop("controls/engines/engine[1]/throttle-lever", 0);
        interpolate("sim/model/B-1B/n1[1]",0,10);
        interpolate("sim/model/B-1B/n2[1]",0,10);
    }

    if(getprop("controls/engines/engine[2]/cutoff") == 0){
        setprop("controls/engines/engine[2]/throttle-lever",getprop("controls/engines/engine[2]/throttle"));
        interpolate("sim/model/B-1B/n1[2]",getprop("engines/engine[2]/n1"),3);
        interpolate("sim/model/B-1B/n2[2]",getprop("engines/engine[2]/n2"),3);
        #setprop("sim/model/B-1B/n1[2]",getprop("engines/engine/n1"));
        #setprop("sim/model/B-1B/n2[2]",getprop("engines/engine/n2"));
    }else{
        setprop("controls/engines/engine[2]/throttle-lever", 0);
        interpolate("sim/model/B-1B/n1[2]",0,10);
        interpolate("sim/model/B-1B/n2[2]",0,10);
    }

    if(getprop("controls/engines/engine[3]/cutoff") == 0){
        setprop("controls/engines/engine[3]/throttle-lever",getprop("controls/engines/engine[3]/throttle"));
        interpolate("sim/model/B-1B/n1[3]",getprop("engines/engine[3]/n1"),3);
        interpolate("sim/model/B-1B/n2[3]",getprop("engines/engine[3]/n2"),3);
        #setprop("sim/model/B-1B/n1[3]",getprop("engines/engine/n1"));
        #setprop("sim/model/B-1B/n2[3]",getprop("engines/engine/n2"));
    }else{
        setprop("controls/engines/engine[3]/throttle-lever", 0);
        interpolate("sim/model/B-1B/n1[3]",0,10);
        interpolate("sim/model/B-1B/n2[3]",0,10);
    }
settimer(eng_state, 0);
}


# checks wing sweep/flaps and allow flaps only to be extended at minimum sweep - adopted from limits.nas

checkFlaps = func(n) {
  var flapsetting = n.getValue();
  if (flapsetting == 0)
    return;
sweep = getprop("controls/flight/wing-sweep");

if ((flapsetting != 0) and (sweep != 1)) {

  controls.flapsDown(-1);
  ltext = "Flaps can only be extended at minimum wingsweep!";
  screen.log.write(ltext);
}
}
setlistener("controls/flight/flaps", checkFlaps);

checkSweep = func(n) {
  var sweepsetting = n.getValue();
  if (sweepsetting == 1)
    return;
  flaps = getprop("controls/flight/flaps");

  if ((sweepsetting != 1) and (flaps != 0)) {

    b1b.wingSweep(1);
    ltext = "Wings can only be swept with retracted flaps!";
    screen.log.write(ltext);
}
}
setlistener("controls/flight/wing-sweep", checkSweep);

###
# apmode listeners to controls switches apmode
###
var checkapmode = func {

var althold = getprop("controls/switches/apmode/alt-hold");
var vfpmhold = getprop("controls/switches/apmode/vfpm-hold");
var ptchhold = getprop("controls/switches/apmode/ptch-hold");
var bhdghold = getprop("controls/switches/apmode/bhdg-hold");
var thdghold = getprop("controls/switches/apmode/thdg-hold");
var spdhold = getprop("controls/switches/apmode/spd-hold");
var spdptchhold = getprop("controls/switches/apmode/spdptch-hold");
var aglhold = getprop("controls/switches/terrain-follow");

if (althold == 1) {
        setprop("autopilot/locks/altitude", "altitude-hold");
} elsif (vfpmhold == 1) {
 setprop("autopilot/locks/altitude", "vertical-speed-hold");
} elsif (ptchhold == 1) {
 setprop("autopilot/locks/altitude", "pitch-hold");
} elsif ((ptchhold != 1) and (vfpmhold != 1) and (althold != 1) and (aglhold != 1)) {
 setprop("autopilot/locks/altitude", "");
}
if (bhdghold == 1) {
        setprop("autopilot/locks/heading", "dg-heading-hold");
} elsif (thdghold == 1) {
 setprop("autopilot/locks/heading", "true-heading-hold");
} elsif ((bhdghold != 1) and (thdghold != 1)) {
 setprop("autopilot/locks/heading", "");
}
if (spdhold == 1) {
        setprop("autopilot/locks/speed", "speed-with-throttle");
} elsif (spdptchhold == 1) {
 setprop("autopilot/locks/speed", "speed-with-pitch-trim");
} elsif ((spdhold != 1) and (spdptchhold != 1)) {
 setprop("autopilot/locks/speed", "");
}

}

###
# flight director modes selector
###
var fltdir = func {

var fltd = getprop("controls/switches/fltdir");

if (fltd == 0.00) {
  setprop("instrumentation/adf/serviceable", "0");
  setprop("instrumentation/nav/serviceable", "0");
  setprop("instrumentation/tacan/serviceable", "0");
} elsif (fltd == 0.25) {
  setprop("instrumentation/adf/serviceable", "1");
  setprop("instrumentation/nav/serviceable", "1");
  setprop("instrumentation/tacan/serviceable", "1");
} elsif (fltd == 0.50) {
  setprop("instrumentation/adf/serviceable", "1");
  setprop("instrumentation/nav/serviceable", "1");
  setprop("instrumentation/tacan/serviceable", "0");
} elsif (fltd == 0.75) {
  setprop("instrumentation/adf/serviceable", "1");
  setprop("instrumentation/nav/serviceable", "0");
  setprop("instrumentation/tacan/serviceable", "0");
} elsif (fltd == 1.00) {
  setprop("instrumentation/adf/serviceable", "0");
#  setprop("instrumentation/nav/serviceable", "0");
  setprop("instrumentation/tacan/serviceable", "1");
}

}

var radar_range = func {

var radran = getprop("controls/switches/radar-range");

if (radran == 0.00) {
  setprop("instrumentation/radar/range[0]", "20");
} elsif (radran == 0.25) {
  setprop("instrumentation/radar/range[0]", "40");
} elsif (radran == 0.50) {
  setprop("instrumentation/radar/range[0]", "80");
} elsif (radran == 0.75) {
  setprop("instrumentation/radar/range[0]", "160");
} elsif (radran == 1.00) {
  setprop("instrumentation/radar/range[0]", "320");
}
}

##
aircraft.livery.init("Models/Liveries");

# tacan block
##
var tacan = func(add) {
  var ch2 = getprop("instrumentation/tacan/frequencies/selected-channel");
  var ch21 = int(ch2 / 10);
  var ch21_new = ch21;

  if ((add == 1) and (ch21 <= 11.5)) {
    var ch21_new = ch21 + 1;
  } elsif ((add == -1) and (ch21 >= 0.5)) {
      var ch21_new = ch21 - 1;
    }

  var ch1_new = int(ch21_new / 10);
  setprop("instrumentation/tacan/frequencies/selected-channel[1]", ch1_new);

  if (ch1_new >= 0.95) {
    var ch2_new = ch21_new - 10;
    setprop("instrumentation/tacan/frequencies/selected-channel[2]", ch2_new);
  } elsif (ch1_new <= 0.95) {
      var ch2_new = ch21_new;
      setprop("instrumentation/tacan/frequencies/selected-channel[2]", ch2_new);
    }
}

var tacanxy = func() {
  var xy = getprop("instrumentation/tacan/frequencies/selected-channel[4]");
  if (xy == "X") {
    setprop("instrumentation/tacan/frequencies/selected-channel[4]", "Y");
    } elsif (xy == "Y") {
        setprop("instrumentation/tacan/frequencies/selected-channel[4]", "X");
      }
}

#----------------------------------------------------------------------------
# View change: Ctrl-V switchback to view #0 but switch to OSO view when already
# in view #0.
#----------------------------------------------------------------------------
var toggle_cockpit_views = func() {
var CurrentView_Num = props.globals.getNode("sim/current-view/view-number");
var oso_view_num = view.indexof("OSO view");

  var cur_v = CurrentView_Num.getValue();
  if (cur_v != 0 ) {
    CurrentView_Num.setValue(0);
  } else {
    CurrentView_Num.setValue(oso_view_num);
  }
}

## FLARES
var flareCount = -1;
var flareStart = -1;

var loop_flare = func {
    # Flare/chaff release
    if (getprop("ai/submodels/submodel[24]/flare-release-snd") == nil) {
        setprop("ai/submodels/submodel[24]/flare-release-snd", 0);
        setprop("ai/submodels/submodel[24]/flare-release-out-snd", 0);
    }
    var flareOn = getprop("ai/submodels/submodel[24]/flare-release-cmd");
    if (flareOn == 1 and getprop("ai/submodels/submodel[24]/flare-release") == 0
            and getprop("ai/submodels/submodel[24]/flare-release-out-snd") == 0
            and getprop("ai/submodels/submodel[24]/flare-release-snd") == 0) {
        flareCount = getprop("ai/submodels/submodel[24]/count");
        flareStart = getprop("sim/time/elapsed-sec");
        setprop("ai/submodels/submodel[24]/flare-release-cmd", 0);
        if (flareCount > 0) {
            # release a flare
            setprop("ai/submodels/submodel[24]/flare-release-snd", 1);
            setprop("ai/submodels/submodel[24]/flare-release", 1);
            setprop("rotors/main/blade[3]/flap-deg", flareStart);
            setprop("rotors/main/blade[3]/position-deg", flareStart);
            damage.flare_released();
        } else {
            # play the sound for out of flares
            setprop("ai/submodels/submodel[24]/flare-release-out-snd", 1);
        }
    }
    if (getprop("ai/submodels/submodel[24]/flare-release-snd") == 1 and (flareStart + 1) < getprop("sim/time/elapsed-sec")) {
        setprop("ai/submodels/submodel[24]/flare-release-snd", 0);
        setprop("rotors/main/blade[3]/flap-deg", 0);
        setprop("rotors/main/blade[3]/position-deg", 0);#MP interpolates between numbers, so nil is better than 0.
    }
    if (getprop("ai/submodels/submodel[24]/flare-release-out-snd") == 1 and (flareStart + 1) < getprop("sim/time/elapsed-sec")) {
        setprop("ai/submodels/submodel[24]/flare-release-out-snd", 0);
    }
    if (flareCount > getprop("ai/submodels/submodel[24]/count")) {
        # A flare was released in last loop, we stop releasing flares, so user have to press button again to release new.
        setprop("ai/submodels/submodel[24]/flare-release", 0);
        flareCount = -1;
    }
}
var flaretimer = maketimer(0.1, loop_flare);
flaretimer.start();


##
# nuc switch
##
var nuc = func {
  if (getprop("controls/switches/nuc") == 1) {
    ltext = "Duke Nukem not available yet on this plane(t)!";
  screen.log.write(ltext);
  }
}

var vector_aicontacts_links = [];
var DLRecipient = emesary.Recipient.new("DLRecipient");
var startDLListener = func {
    DLRecipient.radar = radar_system.dlnkRadar;
    DLRecipient.Receive = func(notification) {
        if (notification.NotificationType == "DatalinkNotification") {
            #printf("DL recv: %s", notification.NotificationType);
            if (me.radar.enabled == 1) {
                vector_aicontacts_links = notification.vector;
            }
            return emesary.Transmitter.ReceiptStatus_OK;
        }
        return emesary.Transmitter.ReceiptStatus_NotProcessed;
    };
    emesary.GlobalTransmitter.Register(DLRecipient);
}
