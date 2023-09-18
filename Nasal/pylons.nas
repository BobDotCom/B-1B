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
var p1_ext_fwd = nil;
var p2_ext_fwd = nil;
var p3_ext_int = nil;
var p4_ext_int = nil;
var p5_ext_int = nil;
var p6_ext_int = nil;
var p7_ext_aft = nil;
var p8_ext_aft = nil;

var msgA = "If you need to repair now, then use Menu-Location-SelectAirport instead.";
var msgB = "Please land before changing payload.";
var msgC = "Please land before refueling.";


var fuelTankFwd = stations.FuelTank.new("Fwd Bay 3000 Gal Tank", "TK3000", 8, 2975, "sim/model/A-6E/fwdtank");
var fuelTankIntmd = stations.FuelTank.new("Intmd Bay 3000 Gal Tank", "TK3000", 9, 2975, "sim/model/A-6E/intmdtank");
var fuelTankAft = stations.FuelTank.new("Aft Bay 3000 Gal Tank", "TK3000", 10, 2975, "sim/model/A-6E/afttank");

var pylonSets = {
    # INTERIOR BAYS
    empty: {name: "Empty", content: [], fireOrder: [], launcherDragArea: 0.0, launcherMass: 0, launcherJettisonable: 0, showLongTypeInsteadOfCount: 0, category: 1},
    # CBM Launcher (2,816 to 3,513 lb (1,277 to 1,593 kg) )
    mk82: {name: "28 x MK-82", content: ["MK-82","MK-82","MK-82","MK-82","MK-82","MK-82","MK-82","MK-82","MK-82","MK-82","MK-82","MK-82","MK-82","MK-82","MK-82","MK-82","MK-82","MK-82","MK-82","MK-82","MK-82","MK-82","MK-82","MK-82","MK-82","MK-82","MK-82","MK-82"], fireOrder: [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27], launcherDragArea: 0.0, launcherMass: 2816, launcherJettisonable: 0, showLongTypeInsteadOfCount: 0, category: 2},
    mk82air: {name: "28 x MK-82AIR", content: ["MK-82AIR","MK-82AIR","MK-82AIR","MK-82AIR","MK-82AIR","MK-82AIR","MK-82AIR","MK-82AIR","MK-82AIR","MK-82AIR","MK-82AIR","MK-82AIR","MK-82AIR","MK-82AIR","MK-82AIR","MK-82AIR","MK-82AIR","MK-82AIR","MK-82AIR","MK-82AIR","MK-82AIR","MK-82AIR","MK-82AIR","MK-82AIR","MK-82AIR","MK-82AIR","MK-82AIR","MK-82AIR"], fireOrder: [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27], launcherDragArea: 0.0, launcherMass: 2816, launcherJettisonable: 0, showLongTypeInsteadOfCount: 0, category: 2},
    # Unplanned:
    # MK-36 Destructor - No need for mines in OPRF atm
    # MK-62 Quickstrike - No need for mines in OPRF atm

    # SECBM Launcher (2,816 lb (1,277 kg) empty )
    c87: {name: "10 x CBU-87", content: ["CBU-87","CBU-87","CBU-87","CBU-87","CBU-87","CBU-87","CBU-87","CBU-87","CBU-87","CBU-87"], fireOrder: [0,1,2,3,4,5,6,7,8,9], launcherDragArea: 0.0, launcherMass: 2816, launcherJettisonable: 0, showLongTypeInsteadOfCount: 0, category: 2},
    c105: {name: "10 x CBU-105", content: ["CBU-105","CBU-105","CBU-105","CBU-105","CBU-105","CBU-105","CBU-105","CBU-105","CBU-105","CBU-105"], fireOrder: [0,1,2,3,4,5,6,7,8,9], launcherDragArea: 0.0, launcherMass: 2816, launcherJettisonable: 0, showLongTypeInsteadOfCount: 0, category: 2},
    g38: {name: "6 x GBU-38", content: ["GBU-38","GBU-38","GBU-38","GBU-38","GBU-38","GBU-38"], fireOrder: [0,1,2,3,4,5], launcherDragArea: 0.0, launcherMass: 2816, launcherJettisonable: 0, showLongTypeInsteadOfCount: 0, category: 2},

    # Unplanned:
    # CBU-89 GATOR mine system - No need for anti-tank/personnel mines in OPRF atm
    # CBU-104 GATOR mine system - Same as the CBU-89, but with the WCMD kit
    # Unmodeled:
    # CBU-97 Sensor Fuzed Weapon - Same as CBU-87, but has guiding bomblets. We don't have this yet.
    # CBU-103 Combined Effects Munition - Our current CBU-105 is actually a CBU-103. It should be renamed, and CBU-105 placed on TODO list

    # MPRL Launcher (1,300 to 2,055 lb (590 kg))
    mk84: {name: "8 x MK-84", content: ["MK-84","MK-84","MK-84","MK-84","MK-84","MK-84","MK-84","MK-84"], fireOrder: [0,1,2,3,4,5,6,7], launcherDragArea: 0.0, launcherMass: 1300, launcherJettisonable: 0, showLongTypeInsteadOfCount: 0, category: 2},
    g31: {name: "8 x GBU-31", content: ["GBU-31","GBU-31","GBU-31","GBU-31","GBU-31","GBU-31","GBU-31","GBU-31"], fireOrder: [0,1,2,3,4,5,6,7], launcherDragArea: 0.0, launcherMass: 1300, launcherJettisonable: 0, showLongTypeInsteadOfCount: 0, category: 2},
    a154: {name: "8 x AGM-154A", content: ["AGM-154A","AGM-154A","AGM-154A","AGM-154A","AGM-154A","AGM-154A","AGM-154A","AGM-154A"], fireOrder: [0,1,2,3,4,5,6,7], launcherDragArea: 0.0, launcherMass: 1300, launcherJettisonable: 0, showLongTypeInsteadOfCount: 0, category: 2},
    a158: {name: "8 x AGM-158", content: ["AGM-158","AGM-158","AGM-158","AGM-158","AGM-158","AGM-158","AGM-158","AGM-158"], fireOrder: [0,1,2,3,4,5,6,7], launcherDragArea: 0.0, launcherMass: 1300, launcherJettisonable: 0, showLongTypeInsteadOfCount: 0, category: 2},
    # Unmodeled: Mk-65 naval mines, 4/6-pack GBU-39

    # MPRL (Mixed)
    g3128: {name: "4 x GBU-31, 4 x GBU-32, 4 x GBU-38", content: ["GBU-31","GBU-31","GBU-31","GBU-31","GBU-32","GBU-32","GBU-32","GBU-32","GBU-38","GBU-38","GBU-38","GBU-38"], fireOrder: [0,1,2,3,4,5,6,7,8,9,10,11], launcherDragArea: 0.0, launcherMass: 1300, launcherJettisonable: 0, showLongTypeInsteadOfCount: 0, category: 2},
    g38x16: {name: "16 x GBU-38", content: ["GBU-38","GBU-38","GBU-38","GBU-38","GBU-38","GBU-38","GBU-38","GBU-38","GBU-38","GBU-38","GBU-38","GBU-38","GBU-38","GBU-38","GBU-38","GBU-38"], fireOrder: [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15], launcherDragArea: 0.0, launcherMass: 1300, launcherJettisonable: 0, showLongTypeInsteadOfCount: 0, category: 2},


    # Fuel
    fuelfwd: {name: fuelTankFwd.type, content: [fuelTankFwd], fireOrder: [0], launcherDragArea: 0.0, launcherMass: 0, launcherJettisonable: 0, showLongTypeInsteadOfCount: 1, category: 2},
    fuelintmd: {name: fuelTankIntmd.type, content: [fuelTankIntmd], fireOrder: [0], launcherDragArea: 0.0, launcherMass: 0, launcherJettisonable: 0, showLongTypeInsteadOfCount: 1, category: 2},
    fuelaft: {name: fuelTankAft.type, content: [fuelTankAft], fireOrder: [0], launcherDragArea: 0.0, launcherMass: 0, launcherJettisonable: 0, showLongTypeInsteadOfCount: 1, category: 2},

    # Nuclear (MPRL)
    #b617: {name: "8 x B61-7", content: ["B61-7","B61-7","B61-7","B61-7","B61-7","B61-7","B61-7"], fireOrder: [0,1,2,3,4,5,6,7], launcherDragArea: 0.0, launcherMass:1300, launcherJettisonable: 0, showLongTypeInsteadOfCount: 0, category: 2},
    #b6112: {name: "8 x B61-12", content: ["B61-12","B61-12","B61-12","B61-12","B61-12","B61-12","B61-12"], fireOrder: [0,1,2,3,4,5,6,7], launcherDragArea: 0.0, launcherMass:1300, launcherJettisonable: 0, showLongTypeInsteadOfCount: 0, category: 2},
    # Unmodeled: B28, AGM-69, B83

    # Mixed nuclear
    # Unmodeled: AGM-86B/small fuel tank

    # EXTERIOR PYLONS
    ext_mk82_x6: {name: "6 x MK-82", content: ["MK-82","MK-82","MK-82","MK-82","MK-82","MK-82"], fireOrder: [0,1,2,3,4,5], launcherDragArea: 0.0, launcherMass: 100, launcherJettisonable: 0, showLongTypeInsteadOfCount: 0, category: 2},
    ext_mk82_x4: {name: "4 x MK-82", content: ["MK-82","MK-82","MK-82","MK-82"], fireOrder: [0,1,2,3], launcherDragArea: 0.0, launcherMass: 100, launcherJettisonable: 0, showLongTypeInsteadOfCount: 0, category: 2},


};

#sets
var bayFset = [pylonSets.empty, pylonSets.mk82, pylonSets.mk82air, pylonSets.c87, pylonSets.c105, pylonSets.mk84, pylonSets.g31, pylonSets.a154, pylonSets.a158, pylonSets.fuelfwd]; # pylonSets.b617, pylonSets.b6112
var bayIset = [pylonSets.empty, pylonSets.mk82, pylonSets.mk82air, pylonSets.c87, pylonSets.c105, pylonSets.mk84, pylonSets.g31, pylonSets.a154, pylonSets.a158, pylonSets.fuelintmd]; # pylonSets.b617, pylonSets.b6112
var bayAset = [pylonSets.empty, pylonSets.mk82, pylonSets.mk82air, pylonSets.c87, pylonSets.c105, pylonSets.mk84, pylonSets.g31, pylonSets.a154, pylonSets.a158, pylonSets.fuelaft]; # pylonSets.b617, pylonSets.b6112
#var bayFset = [pylonSets.empty, pylonSets.mk82, pylonSets.mk82air, pylonSets.c87, pylonSets.c105, pylonSets.g38, pylonSets.mk84, pylonSets.g31, pylonSets.a154, pylonSets.a158, pylonSets.g3128, pylonSets.g38x16, pylonSets.fuelfwd]; # pylonSets.b617, pylonSets.b6112
#var bayIset = [pylonSets.empty, pylonSets.mk82, pylonSets.mk82air, pylonSets.c87, pylonSets.c105, pylonSets.g38, pylonSets.mk84, pylonSets.g31, pylonSets.a154, pylonSets.a158, pylonSets.g3128, pylonSets.g38x16, pylonSets.fuelintmd]; # pylonSets.b617, pylonSets.b6112
#var bayAset = [pylonSets.empty, pylonSets.mk82, pylonSets.mk82air, pylonSets.c87, pylonSets.c105, pylonSets.g38, pylonSets.mk84, pylonSets.g31, pylonSets.a154, pylonSets.a158, pylonSets.g3128, pylonSets.g38x16, pylonSets.fuelaft]; # pylonSets.b617, pylonSets.b6112

var p1set = [pylonSets.empty, pylonSets.ext_mk82_x6];
var p2set = [pylonSets.empty, pylonSets.ext_mk82_x6];
var p3set = [pylonSets.empty, pylonSets.ext_mk82_x6];
var p4set = [pylonSets.empty, pylonSets.ext_mk82_x6];
var p5set = [pylonSets.empty, pylonSets.ext_mk82_x4];
var p6set = [pylonSets.empty, pylonSets.ext_mk82_x4];
var p7set = [pylonSets.empty, pylonSets.ext_mk82_x6];
var p8set = [pylonSets.empty, pylonSets.ext_mk82_x6];

# pylons
# pylonS = stations.InternalStation.new("External 1", 11, [pylonSets.empty], props.globals.getNode("sim/weight[11]/weight-lb",1),func{return getprop("payload/armament/fire-control/serviceable")},func{return getprop("controls/armament/station[3]/selected")});
bay_fwd = stations.Pylon.new("Fwd Bay", 0, [15.261, 1, -1.25], bayFset,  4, props.globals.getNode("sim/weight[4]/weight-lb",1),props.globals.getNode("sim/drag[0]/dragarea-sqft",1),func{return getprop("payload/armament/fire-control/serviceable")},func{return getprop("controls/armament/station[0]/selected");});
bay_intmd = stations.Pylon.new("Middle Bay", 1, [20.3225, 1, -1.25], bayIset,  5, props.globals.getNode("sim/weight[5]/weight-lb",1),props.globals.getNode("sim/drag[1]/dragarea-sqft",1),func{return getprop("payload/armament/fire-control/serviceable")},func{return getprop("controls/armament/station[1]/selected");});
bay_aft = stations.Pylon.new("Aft Bay", 2, [28.0253, 1, -1.25], bayAset,  6, props.globals.getNode("sim/weight[6]/weight-lb",1),props.globals.getNode("sim/drag[2]/dragarea-sqft",1),func{return getprop("payload/armament/fire-control/serviceable")},func{return getprop("controls/armament/station[2]/selected");});
p1_ext_fwd = stations.Pylon.new("Ext Fwd 1",  3, [20.3225, 1, -1.25], p1set,  7,  props.globals.getNode("sim/weight[7]/weight-lb",1), props.globals.getNode("sim/drag[3]/dragarea-sqft",1),func{return getprop("payload/armament/fire-control/serviceable")}, func{return getprop("controls/armament/station[3]/selected");});
p2_ext_fwd = stations.Pylon.new("Ext Fwd 2",  4, [20.3225, 1, -1.25], p2set,  8,  props.globals.getNode("sim/weight[8]/weight-lb",1), props.globals.getNode("sim/drag[4]/dragarea-sqft",1),func{return getprop("payload/armament/fire-control/serviceable")}, func{return getprop("controls/armament/station[4]/selected");});
p3_ext_int = stations.Pylon.new("Ext Int 3",  5, [20.3225, 1, -1.25], p3set,  9,  props.globals.getNode("sim/weight[9]/weight-lb",1), props.globals.getNode("sim/drag[5]/dragarea-sqft",1),func{return getprop("payload/armament/fire-control/serviceable")}, func{return getprop("controls/armament/station[5]/selected");});
p4_ext_int = stations.Pylon.new("Ext Int 4",  6, [20.3225, 1, -1.25], p4set, 10, props.globals.getNode("sim/weight[10]/weight-lb",1), props.globals.getNode("sim/drag[6]/dragarea-sqft",1),func{return getprop("payload/armament/fire-control/serviceable")}, func{return getprop("controls/armament/station[6]/selected");});
p5_ext_int = stations.Pylon.new("Ext Int 5",  7, [20.3225, 1, -1.25], p5set, 11, props.globals.getNode("sim/weight[11]/weight-lb",1), props.globals.getNode("sim/drag[7]/dragarea-sqft",1),func{return getprop("payload/armament/fire-control/serviceable")}, func{return getprop("controls/armament/station[7]/selected");});
p6_ext_int = stations.Pylon.new("Ext Int 6",  8, [20.3225, 1, -1.25], p6set, 12, props.globals.getNode("sim/weight[12]/weight-lb",1), props.globals.getNode("sim/drag[8]/dragarea-sqft",1),func{return getprop("payload/armament/fire-control/serviceable")}, func{return getprop("controls/armament/station[8]/selected");});
p7_ext_aft = stations.Pylon.new("Ext Aft 7",  9, [20.3225, 1, -1.25], p7set, 13, props.globals.getNode("sim/weight[13]/weight-lb",1), props.globals.getNode("sim/drag[9]/dragarea-sqft",1),func{return getprop("payload/armament/fire-control/serviceable")}, func{return getprop("controls/armament/station[9]/selected");});
p8_ext_aft = stations.Pylon.new("Ext Aft 8", 10, [20.3225, 1, -1.25], p8set, 14, props.globals.getNode("sim/weight[14]/weight-lb",1),props.globals.getNode("sim/drag[10]/dragarea-sqft",1),func{return getprop("payload/armament/fire-control/serviceable")},func{return getprop("controls/armament/station[14]/selected");});



var pylons = [bay_fwd,bay_intmd,bay_aft,p1_ext_fwd,p2_ext_fwd,p3_ext_int,p4_ext_int,p5_ext_int,p6_ext_int,p7_ext_aft,p8_ext_aft];

# The order of first vector in this line is the default pylon order weapons is released in.
# The order of second vector in this line is the order cycle key would cycle through the weapons:
fcs = fc.FireControl.new(pylons, [0,1,2,3,4,5,6,7,8,9,10], ["MK-82","MK-82AIR","MK-84","GBU-31","GBU-32","GBU-38","AGM-154A","AGM-158","CBU-87","CBU-105"]);

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

