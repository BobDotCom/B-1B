##
# Wrapper around stepProps() which emulates the "old" wing sweep behavior for
# configurations that aren't using the new mechanism.
#
wingSweep = func {
    if(arg[0] == 0) { return; }
    if(props.globals.getNode("sim/wing-sweep") != nil) {
        stepProps("controls/flight/wing-sweep", "sim/wing-sweep", arg[0]);
        return;
    }
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
##
#wingsweep monitor to adjust position of the weight of the wings
##
setlistener("controls/flight/wing-sweep", func {
var sweep = getprop("controls/flight/wing-sweep");
var wingm = 20000;# estimated mass of both wings
var fwdsweep = wingm * sweep;
var aftsweep = wingm - fwdsweep;
setprop("sim/weight[0]/weight-lb", fwdsweep);
setprop("sim/weight[1]/weight-lb", aftsweep);
},0,0);

##
#wingsweep monitor to adjust wingfuel position
##
var fuelsweep = func {
var sweep = getprop("controls/flight/wing-sweep");
var fuelml = getprop("consumables/fuel/tank[0]/level-lbs");
var fuelmr = getprop("consumables/fuel/tank[1]/level-lbs");

var aftfuel = ((fuelml + fuelmr) * (1 - sweep));
var fwdfuel = (aftfuel * (-1));
setprop("sim/weight[2]/weight-lb", fwdfuel);
setprop("sim/weight[3]/weight-lb", aftfuel);
settimer(fuelsweep, 0.3);
}

##
#wingsweep mapped to rotor in order to display state in multiplayer
##
setlistener("surface-positions/wing-sweep-pos-norm", func {
var sweep = getprop("surface-positions/wing-sweep-pos-norm");
setprop("rotors/main/blade[0]/position-deg", sweep);
},0,0);
##
#mapping to properties available in multiplayer
##
setlistener("controls/engines/engine[0]/afterburner", func {
var conv = getprop("controls/engines/engine[0]/afterburner");
setprop("engines/engine[4]/n1", conv);
},0,0);
setlistener("controls/engines/engine[1]/afterburner", func {
var conv = getprop("controls/engines/engine[1]/afterburner");
setprop("engines/engine[5]/n1", conv);
},0,0);
setlistener("controls/engines/engine[2]/afterburner", func {
var conv = getprop("controls/engines/engine[2]/afterburner");
setprop("engines/engine[6]/n1", conv);
},0,0);
setlistener("controls/engines/engine[3]/afterburner", func {
var conv = getprop("controls/engines/engine[3]/afterburner");
setprop("engines/engine[7]/n1", conv);
},0,0);
setlistener("controls/engines/engine[0]/cutoff", func {
var conv = getprop("controls/engines/engine[0]/cutoff");
setprop("engines/engine[4]/n2", conv);
},1,0);
setlistener("controls/engines/engine[1]/cutoff", func {
var conv = getprop("controls/engines/engine[0]/cutoff");
setprop("engines/engine[5]/n2", conv);
},1,0);
setlistener("controls/engines/engine[2]/cutoff", func {
var conv = getprop("controls/engines/engine[0]/cutoff");
setprop("engines/engine[6]/n2", conv);
},1,0);
setlistener("controls/engines/engine[3]/cutoff", func {
var conv = getprop("controls/engines/engine[0]/cutoff");
setprop("engines/engine[7]/n2", conv);
},1,0);

##
# enables hud for sniper pod view/dialog
##
setlistener("sim/current-view/name", func {
var view = getprop("sim/current-view/name");
if (view == 'Sniper Pod view') {
setprop("sim/hud/visibility[1]", 1);
#var sniper_pod_menu = #gui.Dialog.new("dialog","Aircraft/B-1B/Dialogs/sniperpodmenu.xml","sniperpodmenu");
#sniper_pod_menu.open();
} else {
setprop("sim/hud/visibility[1]", 0);
}
},0,0);