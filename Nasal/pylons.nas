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


var fuelTankFwd = stations.FuelTank.new("Fwd Bay 3000 Gal Tank", "TK3000", 8, 2975, "sim/model/A-6E/fwdtank");
var fuelTankIntmd = stations.FuelTank.new("Intmd Bay 3000 Gal Tank", "TK3000", 9, 2975, "sim/model/A-6E/intmdtank");
var fuelTankAft = stations.FuelTank.new("Aft Bay 3000 Gal Tank", "TK3000", 10, 2975, "sim/model/A-6E/afttank");

var pylonSets = {
    # INTERIOR BAYS
    empty: {name: "Empty", content: [], fireOrder: [], launcherDragArea: 0.0, launcherMass: 0, launcherJettisonable: 0, showLongTypeInsteadOfCount: 0, category: 1},
    # CBM Launcher (2,816 to 3,513 lb (1,277 to 1,593 kg) )
    mk82: {name: "28 x MK-82", content: ["MK-82","MK-82","MK-82","MK-82","MK-82","MK-82","MK-82","MK-82","MK-82","MK-82","MK-82","MK-82","MK-82","MK-82","MK-82","MK-82","MK-82","MK-82","MK-82","MK-82","MK-82","MK-82","MK-82","MK-82","MK-82","MK-82","MK-82","MK-82"], fireOrder: [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27], launcherDragArea: 0.0, launcherMass: 2816, launcherJettisonable: 0, showLongTypeInsteadOfCount: 0, category: 2},
    mk82air: {name: "28 x MK-82AIR", content: ["MK-82AIR","MK-82AIR","MK-82AIR","MK-82AIR","MK-82AIR","MK-82AIR","MK-82AIR","MK-82AIR","MK-82AIR","MK-82AIR","MK-82AIR","MK-82AIR","MK-82AIR","MK-82AIR","MK-82AIR","MK-82AIR","MK-82AIR","MK-82AIR","MK-82AIR","MK-82AIR","MK-82AIR","MK-82AIR","MK-82AIR","MK-82AIR","MK-82AIR","MK-82AIR","MK-82AIR","MK-82AIR"], fireOrder: [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27], launcherDragArea: 0.0, launcherMass: 2816, launcherJettisonable: 0, showLongTypeInsteadOfCount: 0, category: 2},
    # Unmodeled: MK-36, MK-62

    # SECBM Launcher (2,816 lb (1,277 kg) empty )
    c87: {name: "10 x CBU-87", content: ["CBU-87","CBU-87","CBU-87","CBU-87","CBU-87","CBU-87","CBU-87","CBU-87","CBU-87","CBU-87"], fireOrder: [0,1,2,3,4,5,6,7,8,9], launcherDragArea: 0.0, launcherMass: 2816, launcherJettisonable: 0, showLongTypeInsteadOfCount: 0, category: 2},
    c105: {name: "10 x CBU-105", content: ["CBU-105","CBU-105","CBU-105","CBU-105","CBU-105","CBU-105","CBU-105","CBU-105","CBU-105","CBU-105"], fireOrder: [0,1,2,3,4,5,6,7,8,9], launcherDragArea: 0.0, launcherMass: 2816, launcherJettisonable: 0, showLongTypeInsteadOfCount: 0, category: 2},
    # Unmodeled: CBU-89, CBU-97, CBU-103, CBU-104, GBU-38

    # MPRL Launcher (1,300 to 2,055 lb (590 kg))
    mk84: {name: "8 x MK-84", content: ["MK-84","MK-84","MK-84","MK-84","MK-84","MK-84","MK-84","MK-84"], fireOrder: [0,1,2,3,4,5,6,7], launcherDragArea: 0.0, launcherMass: 1300, launcherJettisonable: 0, showLongTypeInsteadOfCount: 0, category: 2},
    g31: {name: "8 x GBU-31", content: ["GBU-31","GBU-31","GBU-31","GBU-31","GBU-31","GBU-31","GBU-31","GBU-31"], fireOrder: [0,1,2,3,4,5,6,7], launcherDragArea: 0.0, launcherMass: 1300, launcherJettisonable: 0, showLongTypeInsteadOfCount: 0, category: 2},
    a154: {name: "8 x AGM-154A", content: ["AGM-154A","AGM-154A","AGM-154A","AGM-154A","AGM-154A","AGM-154A","AGM-154A","AGM-154A"], fireOrder: [0,1,2,3,4,5,6,7], launcherDragArea: 0.0, launcherMass: 1300, launcherJettisonable: 0, showLongTypeInsteadOfCount: 0, category: 2},
    a158: {name: "8 x AGM-158", content: ["AGM-158","AGM-158","AGM-158","AGM-158","AGM-158","AGM-158","AGM-158","AGM-158"], fireOrder: [0,1,2,3,4,5,6,7], launcherDragArea: 0.0, launcherMass: 1300, launcherJettisonable: 0, showLongTypeInsteadOfCount: 0, category: 2},
    # Unmodeled: Mk-65 naval mines, 4/6-pack GBU-39

    # MPRL (Mixed)
    # Unmodeled: GBU-38/GBU-32/GBU-31, GBU-38

    # Fuel
    fuelfwd: {name: fuelTankFwd.type, content: [fuelTankFwd], fireOrder: [0], launcherDragArea: 0.0, launcherMass: 0, launcherJettisonable: 0, showLongTypeInsteadOfCount: 1, category: 2},
    fuelintmd: {name: fuelTankIntmd.type, content: [fuelTankIntmd], fireOrder: [0], launcherDragArea: 0.0, launcherMass: 0, launcherJettisonable: 0, showLongTypeInsteadOfCount: 1, category: 2},
    fuelaft: {name: fuelTankAft.type, content: [fuelTankAft], fireOrder: [0], launcherDragArea: 0.0, launcherMass: 0, launcherJettisonable: 0, showLongTypeInsteadOfCount: 1, category: 2},

    # Nuclear (MPRL)
    #b617: {name: "8 x B61-7", content: ["B61-7","B61-7","B61-7","B61-7","B61-7","B61-7","B61-7"], fireOrder: [0,1,2,3,4,5,6,7], launcherDragArea: 0.0, launcherMass:1300, launcherJettisonable: 0, showLongTypeInsteadOfCount: 0, category: 2},
    #b6112: {name: "8 x B61-12", content: ["B61-12","B61-12","B61-12","B61-12","B61-12","B61-12","B61-12"], fireOrder: [0,1,2,3,4,5,6,7], launcherDragArea: 0.0, launcherMass:1300, launcherJettisonable: 0, showLongTypeInsteadOfCount: 0, category: 2},
    # Unmodeled: B28, AGM-69, B83

    # Mixed nuclear
    # Note: I don't think this is possible with the current pylon system, as we'd need a mixed fuel tank + weapons on one pylon
    # Unmodeled: AGM-86B/small fuel tank
};

#sets
var bayFset = [pylonSets.empty, pylonSets.mk82, pylonSets.mk82air, pylonSets.c87, pylonSets.c105, pylonSets.mk84, pylonSets.g31, pylonSets.a154, pylonSets.a158, pylonSets.fuelfwd]; # pylonSets.b617, pylonSets.b6112
var bayIset = [pylonSets.empty, pylonSets.mk82, pylonSets.mk82air, pylonSets.c87, pylonSets.c105, pylonSets.mk84, pylonSets.g31, pylonSets.a154, pylonSets.a158, pylonSets.fuelintmd]; # pylonSets.b617, pylonSets.b6112
var bayAset = [pylonSets.empty, pylonSets.mk82, pylonSets.mk82air, pylonSets.c87, pylonSets.c105, pylonSets.mk84, pylonSets.g31, pylonSets.a154, pylonSets.a158, pylonSets.fuelaft]; # pylonSets.b617, pylonSets.b6112

# pylons
# pylonS = stations.InternalStation.new("External 1", 11, [pylonSets.empty], props.globals.getNode("sim/weight[11]/weight-lb",1),func{return getprop("payload/armament/fire-control/serviceable")},func{return getprop("controls/armament/station[3]/selected")});
bay_fwd = stations.Pylon.new("Fwd Bay", 0, [7.53, -5.93, -0.22], bayFset,  4, props.globals.getNode("sim/weight[4]/weight-lb",1),props.globals.getNode("sim/drag[0]/dragarea-sqft",1),func{return getprop("payload/armament/fire-control/serviceable")},func{return getprop("controls/armament/station[0]/selected");});
bay_intmd = stations.Pylon.new("Middle Bay", 1, [7.70, -4.86, -0.38], bayIset,  5, props.globals.getNode("sim/weight[5]/weight-lb",1),props.globals.getNode("sim/drag[1]/dragarea-sqft",1),func{return getprop("payload/armament/fire-control/serviceable")},func{return getprop("controls/armament/station[1]/selected");});
bay_aft = stations.Pylon.new("Aft Bay", 2, [7.65, -3.61, -0.52], bayAset,  6, props.globals.getNode("sim/weight[6]/weight-lb",1),props.globals.getNode("sim/drag[2]/dragarea-sqft",1),func{return getprop("payload/armament/fire-control/serviceable")},func{return getprop("controls/armament/station[2]/selected");});



var pylons = [bay_fwd,bay_intmd,bay_aft];

# The order of first vector in this line is the default pylon order weapons is released in.
# The order of second vector in this line is the order cycle key would cycle through the weapons:
fcs = fc.FireControl.new(pylons, [0,1,2], ["20mm Cannon","LAU-68","AIM-9L","AIM-9M","AIM-9X","AIM-120","AIM-7","MK-82","MK-82AIR","MK-83","MK-84","GBU-12","GBU-24","GBU-31","GBU-54","AGM-65B","AGM-65D","AGM-84","AGM-88","AGM-119","AGM-154A","AGM-158","CBU-87","CBU-105"]);  # "B61-7", "B61-12"

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

