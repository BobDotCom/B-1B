##### rain animation loop

setlistener("/sim/signals/fdm-initialized", func {

setprop("environment/rain/rain", 1);
settimer(rain_loop, 1);
settimer(check_clouds, 2);
});

var rain_loop = func {
var rain = getprop("environment/rain/rain");
var speed = getprop("velocities/airspeed-kt");
if (rain >= 50) {
setprop("environment/rain/rain", 1);
settimer(rain_loop, 0.5);
} else {
  var rain_new = (rain + 1);
  setprop("environment/rain/rain", rain_new);
  settimer(rain_loop, 0.5);
  }
}

# this loop checks if there are clouds and if we are within/below them to allow rain
var check_clouds = func {
var calt = getprop("position/altitude-ft");
var layer0_cover = getprop("environment/clouds/layer[0]/coverage");
var layer1_cover = getprop("environment/clouds/layer[1]/coverage");

if (layer1_cover == 'clear') {
  if (layer0_cover == 'clear') {
  setprop("environment/rain/above_clouds", 1);
  } else {
    var layer0_alt = getprop("environment/clouds/layer[0]/elevation-ft");
    var layer0_thick = getprop("environment/clouds/layer[0]/thickness-ft");
    var cloud_alt = layer0_alt + layer0_thick;
      if (calt > cloud_alt) {
      setprop("environment/rain/above_clouds", 1);
      } elsif (calt < cloud_alt) {
        setprop("environment/rain/above_clouds", 0);
        }
    }
} else {
  var layer1_alt = getprop("environment/clouds/layer[1]/elevation-ft");
  var layer1_thick = getprop("environment/clouds/layer[1]/thickness-ft");
  var cloud_alt = layer1_alt + layer1_thick;
    if (calt > cloud_alt) {
    setprop("environment/rain/above_clouds", 1);
    } elsif (calt < cloud_alt) {
      setprop("environment/rain/above_clouds", 0);
      }
  }

settimer(check_clouds, 2);
}