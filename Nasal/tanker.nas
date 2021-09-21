#####  Spawns a tanker for aar

var tanker_path = func {

# aircraft parameters
var calt_m = getprop("position/altitude-ft") / 3.28084;
var chdg = getprop("orientation/heading-deg");
var cpitch = getprop("orientation/pitch-deg");
var clat = getprop("position/latitude-deg");
var clong = getprop("position/longitude-deg");
var cspeed_mps = getprop("velocities/groundspeed-kt") * 0.51444;

#calc of spawnpoint
var cpos = geo.Coord.new().set_latlon(clat, clong, calt_m);
var adist = 5000;#in m
var apos = cpos.apply_course_distance(chdg, adist);
var alat = apos.lat();
var along = apos.lon();
var aalt_ft = getprop("ai/tanker/prop-altitude-ft");
if (aalt_ft == nil){
var aalt_ft = 9000;
}
var thdg = getprop("ai/tanker/prop-heading-deg");
if ((thdg == nil) or (thdg == 'current')){
var thdg = chdg;
}
var d_thdg = int(thdg);

setprop("ai/tanker/prop-latitude-deg",alat);
setprop("ai/tanker/prop-longitude-deg",along);
setprop("ai/tanker/prop-altitude-ft",aalt_ft);
setprop("ai/tanker/prop-heading-deg",thdg);

##calculation of flightpath of tanker
var apos = geo.Coord.new().set_latlon(alat, along, aalt_ft);
# fdist and ftime determine the speed of the tanker
var ftime = 1200;#flighttime in s
var tkias = getprop("ai/tanker/speed-kias");
var tktas = tkias + (tkias * 0.02 * aalt_ft / 1000);
var mps = tktas * 0.51444;
var fdist = mps * ftime;#100000 in m

var epos = apos.apply_course_distance(thdg, fdist);
var elat = epos.lat();
var elong = epos.lon();

#speed calculations
var tspeed = int(tktas);
var ispeed = tkias;
#var ispeed = int(tspeed - (tspeed * 0.02 * aalt_ft / 1000));

#interpolation to target
interpolate("ai/tanker/prop-latitude-deg",elat,ftime);
interpolate("ai/tanker/prop-longitude-deg",elong,ftime);

var n = 101;
###tanker model placing
aircraft.makeNode("models/model[" ~ n ~ "]/path");
aircraft.makeNode("models/model[" ~ n ~ "]/longitude-deg-prop");
aircraft.makeNode("models/model[" ~ n ~ "]/latitude-deg-prop");
aircraft.makeNode("models/model[" ~ n ~ "]/elevation-ft-prop");
aircraft.makeNode("models/model[" ~ n ~ "]/heading-deg-prop");
setprop ("models/model[" ~ n ~ "]/path", "Aircraft/KC135/Models/KC135.xml");
setprop ("models/model[" ~ n ~ "]/longitude-deg-prop", "ai/tanker/prop-longitude-deg");
setprop ("models/model[" ~ n ~ "]/latitude-deg-prop", "ai/tanker/prop-latitude-deg");
setprop ("models/model[" ~ n ~ "]/elevation-ft-prop", "ai/tanker/prop-altitude-ft");
setprop ("models/model[" ~ n ~ "]/heading-deg-prop", "ai/tanker/prop-heading-deg");
aircraft.makeNode("models/model[" ~ n ~ "]/load");

setprop("ai/models/tanker[1]/callsign",'ESSO3');
setprop("ai/models/tanker[1]/id",15);
setprop("ai/models/tanker[1]/subID",0);
setprop("ai/models/tanker[1]/tanker",'true');
setprop("ai/models/tanker[1]/valid",'true');
setprop("ai/models/tanker[1]/controls/flight/target-alt",aalt_ft);
setprop("ai/models/tanker[1]/controls/flight/target-hdg",chdg);
setprop("ai/models/tanker[1]/controls/flight/lateral-mode",'roll');
setprop("ai/models/tanker[1]/controls/flight/longitude-mode",'alt');
setprop("ai/models/tanker[1]/controls/flight/target-pitch",0);
setprop("ai/models/tanker[1]/controls/flight/target-roll",0);
setprop("ai/models/tanker[1]/controls/flight/target-speed",0);
setprop("ai/models/tanker[1]/controls/gear/gear-down",'false');
setprop("ai/models/tanker[1]/navaids/tacan/channel-ID",'042X');
setprop("ai/models/tanker[1]/orientation/pitch-deg",0);
setprop("ai/models/tanker[1]/orientation/roll-deg",0);
setprop("ai/models/tanker[1]/orientation/true-heading-deg",0);
setprop("ai/models/tanker[1]/position/altitude-ft",aalt_ft);
setprop("ai/models/tanker[1]/velocities/true-airspeed-kt",0);
setprop("ai/models/tanker[1]/velocities/vertical-speed-fps",0);
setprop("ai/models/tanker[1]/radar/bearing-deg",chdg);
setprop("ai/models/tanker[1]/radar/elevation-deg",0);
setprop("ai/models/tanker[1]/radar/in-range",'true');
setprop("ai/models/tanker[1]/radar/rotation",0);
setprop("ai/models/tanker[1]/refuel/contact",0);
var type = getprop("ai/tanker/type");
if (type == nil){
var type = 'boom';
}
setprop("ai/models/tanker[1]/refuel/type",type);

var ttext = "Tanker support available, tune your TACAN to 042X";
var vtext = "ESSO3 heading " ~ d_thdg ~ " at " ~ aalt_ft ~ "ft at " ~ tspeed ~ "KTAS /" ~ ispeed ~ "KIAS";
screen.log.write(ttext);
screen.log.write(vtext);

#var node = props.globals.getNode("/models", 1);
#props.dump(node);
distance_monitor();
settimer(remove_tanker,ftime);
}

#####
## calculate distance and update position
#####
var distance_monitor = func {

var chdg = getprop("orientation/heading-deg");
var clat = getprop("position/latitude-deg");
var clong = getprop("position/longitude-deg");
var tlat = getprop("ai/tanker/prop-latitude-deg");
var tlong = getprop("ai/tanker/prop-longitude-deg");
setprop("ai/models/tanker[1]/position/latitude-deg",tlat);
setprop("ai/models/tanker[1]/position/longitude-deg",tlong);
var cpos = geo.Coord.new().set_latlon(clat, clong);
var tpos = geo.Coord.new().set_latlon(tlat, tlong);

var tdist = cpos.distance_to(tpos);#in m
var tdist_nm = tdist / 1000 * 0.51444;
setprop("ai/tanker/prop-distance-nm",tdist_nm);
setprop("ai/models/tanker[1]/radar/range-nm",tdist_nm);
if (tdist_nm <= 0.05){
  setprop("ai/models/tanker[1]/refuel/contact",1);
  setprop("systems/refuel/contact",1);
  } else {
  setprop("ai/models/tanker[1]/refuel/contact",0);
  setprop("systems/refuel/contact",0);
  }

settimer(distance_monitor, 0);
}

var remove_tanker = func {
props.globals.getNode("/models", 1).removeChild("model[101]", 1);
var ltext = "Tanker returning to base";
screen.log.write(ltext);
}
