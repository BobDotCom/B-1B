# this file calculates the Center of Gravity(CG) (mass), the mean aerodynamic center(MAC)
# and gives the position of CG to leading edge in %MAC

#first collect data for CG
#for distances datum=nose=0 then counted backwards to tail (eg: -45)
#weight and center of weight of the empty aircraft: estimated
var cg_dist = func {
var acm = 172000;
var acp_e = -25.4;
# weights and position (from yasim file)
var w1m = getprop("sim/weight[0]/weigth-lb");
if (w1m == nil){w1m = 0;}
var w1p = -26.6;
var w2m = getprop("sim/weight[1]/weigth-lb");
if (w2m == nil){w2m = 0;}
var w2p = -31.0;
var w3m = getprop("sim/weight[2]/weigth-lb");
if (w3m == nil){w3m = 0;}
var w3p = -26.2;
var w4m = getprop("sim/weight[3]/weigth-lb");
if (w4m == nil){w4m = 0;}
var w4p = -29.5;
var w5m = getprop("sim/weight[4]/weigth-lb");
if (w5m == nil){w5m = 0;}
var w5p = -15.3;
var w6m = getprop("sim/weight[5]/weigth-lb");
if (w6m == nil){w6m = 0;}
var w6p = -20.0;
var w7m = getprop("sim/weight[6]/weigth-lb");
if (w7m == nil){w7m = 0;}
var w7p = -35.2;
#var w8m = getprop("sim/weight[7]/weigth-lb");
#if (w8m == nil){w8m = 0;}
#var w8p = -20.0;
#var w9m = getprop("sim/weight[8]/weigth-lb");
#if (w9m == nil){w9m = 0;}
#var w9p = -36.0;
# fuel weights and position (from yasim file)
var f1m = getprop("consumables/fuel/tank[0]/level-lbs");
var f1p = -26.2;
var f2m = getprop("consumables/fuel/tank[1]/level-lbs");
var f2p = -26.2;
var f3m = getprop("consumables/fuel/tank[2]/level-lbs");
var f3p = -12.0;
var f4m = getprop("consumables/fuel/tank[3]/level-lbs");
var f4p = -18.5;
var f5m = getprop("consumables/fuel/tank[4]/level-lbs");
var f5p = -27.0;
var f6m = getprop("consumables/fuel/tank[5]/level-lbs");
var f6p = -34.0;
var f7m = getprop("consumables/fuel/tank[6]/level-lbs");
var f7p = -23.0;
var f8m = getprop("consumables/fuel/tank[7]/level-lbs");
var f8p = -23.0;
#calculate the distance of cg from datum (in meters)
var dist_cg = (acm * acp_e + w1m * w1p + w2m * w2p + w3m * w3p + w4m * w4p + w5m * w5p + w5m * w5p + w6m * w6p + w7m * w7p + f1m * f1p + f2m * f2p + f3m * f3p + f4m * f4p + f5m * f5p + f6m * f6p + f7m * f7p + f8m * f8p) / (getprop("yasim/gross-weight-lbs"));
setprop("instrumentation/cg/dist_cg_from_datum_m", dist_cg);
var dist_wing = 20.57;# 19.56
var cg_dist_wing = ((dist_cg) + dist_wing) * (-1);
setprop("instrumentation/cg/cg_dist_wing", cg_dist_wing);

#calculated data for MAC
var mac15 = 5.17;
var mac25 = 5.45;
var mac45 = 6.12;
var mac55 = 6.78;
var mac67 = 8.13;
var wingsw = getprop("controls/flight/wing-sweep");
if (wingsw == 1) {
var macxx = mac15;
}
if (wingsw == 0.8) {
var macxx = mac25;
}
if (wingsw == 0.42) {
var macxx = mac45;
}
if (wingsw == 0.23) {
var macxx = mac55;
}
if (wingsw == 0) {
var macxx = mac67;
}
#calculate %MAC of cg to wing start depending on wingsweep
var cg_mac = ((cg_dist_wing * 100) / macxx);
setprop("/instrumentation/cg/cg_mac", cg_mac);
settimer(cg_dist, 0.5);
}

##
#automated cg adjuster using fuel, depending on desired cg
##
var cg_adjust = func {
var cg_on = getprop("controls/switches/cg-adjust");
if (cg_on == 1) {
  #setprop("/sim/freeze/fuel", 1);
  var cg_macf = getprop("instrumentation/cg/cg_mac");
  var cg_mac_set = getprop("instrumentation/cg/cg_mac_set");

  var fuel_fwd = getprop("consumables/fuel/tank[3]/level-lbs");
  var fuel_aft = getprop("consumables/fuel/tank[5]/level-lbs");
  #var fuel_fwd1 = props.globals.getNode("consumables/fuel/tank[3]/level-lbs",1);
  #var fuel_aft1 = props.globals.getNode("consumables/fuel/tank[5]/level-lbs",1);
  var fuel_fwd_cap = getprop("consumables/fuel/tank[3]/capacity-gal_us");
  var fuel_aft_cap = getprop("consumables/fuel/tank[5]/capacity-gal_us");
  var fuel_dens = getprop("consumables/fuel/tank[3]/density-ppg");

  var utime = 1;
  var ffrate = (200 * utime);# in lb/sec
  var fuel_fwd_caplb = fuel_fwd_cap * fuel_dens;
  var fuel_aft_caplb = fuel_aft_cap * fuel_dens;
  var fuel_fwd_space = fuel_fwd_caplb - fuel_fwd;
  var fuel_aft_space = fuel_aft_caplb - fuel_aft;


  if (cg_macf > cg_mac_set) {
  if (((fuel_fwd + ffrate) <= fuel_fwd_caplb) and ((fuel_aft) >= (0 + ffrate))) {
    var fuel_fwd_new = (fuel_fwd + ffrate) / fuel_dens;
    var fuel_aft_new = (fuel_aft - ffrate) / fuel_dens;

    setprop("/consumables/fuel/tank[3]/level-gal_us", fuel_fwd_new);
    setprop("/consumables/fuel/tank[5]/level-gal_us", fuel_aft_new);
    #print ("weight dist1");
  }
  }
    if (cg_macf < cg_mac_set) {
  if (((fuel_fwd) >= (0 + ffrate)) and ((fuel_aft + ffrate) <= fuel_aft_caplb)) {
    var fuel_fwd_new = (fuel_fwd - ffrate) / fuel_dens;
    var fuel_aft_new = (fuel_aft + ffrate) / fuel_dens;

    setprop("/consumables/fuel/tank[3]/level-gal_us", fuel_fwd_new);
    setprop("/consumables/fuel/tank[5]/level-gal_us", fuel_aft_new);
    #print ("weight dist2");
  }
    }
    #setprop("/sim/freeze/fuel", 0);
    settimer(cg_adjust, utime);
  }
}