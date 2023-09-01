var ARM_SIM = -1;
var ARM_OFF = 0;# these 3 are needed by fire-control.
var ARM_ARM = 1;
var pause_listener = 0;
var debug_a10 = 0;
props.globals.getNode("controls/armament/master-arm-switch",1).setIntValue(0);

var fcs = nil;
var pylonS = nil;
var bay_fwd = nil;
var bay_intmd = nil;
var bay_aft = nil;

var msgA = "If you need to repair now, then use Menu-Location-SelectAirport instead.";
var msgB = "Please land before changing payload.";
var msgC = "Please land before refueling.";


var pylonSets = {
    empty: {name: "Empty", content: [], fireOrder: [], launcherDragArea: 0.0, launcherMass: 0, launcherJettisonable: 0, showLongTypeInsteadOfCount: 0, category: 1},
    mk82: {name: "8 x MK-82", content: ["MK-82","MK-82","MK-82","MK-82","MK-82","MK-82","MK-82","MK-82"], fireOrder: [0,1,2,3,4,5,6,7], launcherDragArea: 0.0, launcherMass: 100, launcherJettisonable: 0, showLongTypeInsteadOfCount: 0, category: 2},
};

#sets
var bayFset = [pylonSets.empty, pylonSets.mk82];
var bayIset = [pylonSets.empty, pylonSets.mk82];
var bayAset = [pylonSets.empty, pylonSets.mk82];

# pylons
# pylonS = stations.InternalStation.new("External 1", 11, [pylonSets.empty], props.globals.getNode("sim/weight[11]/weight-lb",1),func{return getprop("payload/armament/fire-control/serviceable")},func{return getprop("controls/armament/station[3]/selected")});
bay_fwd = stations.Pylon.new("Fwd Bay", 0, [7.53, -5.93, -0.22], bayFset,  4, props.globals.getNode("sim/weight[4]/weight-lb",1),props.globals.getNode("sim/drag[0]/dragarea-sqft",1),func{return getprop("payload/armament/fire-control/serviceable")},func{return getprop("controls/armament/station[0]/selected");});
bay_intmd = stations.Pylon.new("Middle Bay", 1, [7.70, -4.86, -0.38], bayIset,  5, props.globals.getNode("sim/weight[5]/weight-lb",1),props.globals.getNode("sim/drag[1]/dragarea-sqft",1),func{return getprop("payload/armament/fire-control/serviceable")},func{return getprop("controls/armament/station[1]/selected");});
bay_aft = stations.Pylon.new("Aft Bay", 2, [7.65, -3.61, -0.52], bayAset,  6, props.globals.getNode("sim/weight[6]/weight-lb",1),props.globals.getNode("sim/drag[2]/dragarea-sqft",1),func{return getprop("payload/armament/fire-control/serviceable")},func{return getprop("controls/armament/station[2]/selected");});



var pylons = [bay_fwd,bay_intmd,bay_aft];

# The order of first vector in this line is the default pylon order weapons is released in.
# The order of second vector in this line is the order cycle key would cycle through the weapons:
fcs = fc.FireControl.new(pylons, [0,1,2], ["MK-82"]);

print("** Pylon & fire control system started. **");
# var getDLZ = func {
#     if (fcs != nil and getprop("model/A-10/master-arm-switch")) {
#         var w = fcs.getSelectedWeapon();
#         if (w!=nil and w.parents[0] == armament.AIM) {
#             var result = w.getDLZ(1);
#             if (result != nil and size(result) == 5 and result[4]<result[0]*1.5 and armament.contact != nil and armament.contact.get_display()) {
#                 #target is within 150% of max weapon fire range.
#         	    return result;
#             }
#         }
#     }
#     return nil;
# }

# var ripple = func {
#     fcs.setRippleMode(getprop("controls/armament/ripple"));
#     fcs.setRippleDelay(getprop("controls/armament/ripple-delay"));
# };

# setlistener("controls/armament/ripple-delay", ripple);
# setlistener("controls/armament/ripple", ripple);

