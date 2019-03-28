##### low level animation loop

setlistener("/sim/signals/fdm-initialized", func {

settimer(low_loop, 1);
});

var low_loop = func {

var calt = getprop("position/altitude-agl-ft");
var cspd = getprop("velocities/groundspeed-kt");

if((calt <= 300) and (cspd >= 430)) {
  setprop("controls/state/low_level", 1);
} else {
   setprop("controls/state/low_level", 0);
    }

settimer(low_loop, 1);
}

#### low level models position
#var low_model = func {
#var state = getprop("controls/state/low_level");
#if(state == 1) {

#var long = getprop("position/longitude-deg");
#var lat = getprop("position/latitude-deg");

#geo.put_model("Aircraft/B-1B/Models/aircraft_wash.xml", lat, long);

#}
#settimer(low_model, 1);
#}
