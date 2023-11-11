### fuel loading

var fuelload = func(n) {
  var amount = n / 100;
  var wow = getprop("gear/gear[0]/wow");
  var roll = getprop("gear/gear[0]/rollspeed-ms");

if ((wow == 1) and (roll < 1)) {
  setprop("consumables/fuel/tank[0]/level-gal_us", 5000 * amount);
  setprop("consumables/fuel/tank[1]/level-gal_us", 5000 * amount);
  setprop("consumables/fuel/tank[2]/level-gal_us", 5000 * amount);
  setprop("consumables/fuel/tank[3]/level-gal_us", 5000 * amount);
  setprop("consumables/fuel/tank[4]/level-gal_us", 3333 * amount);
  setprop("consumables/fuel/tank[5]/level-gal_us", 5000 * amount);
  setprop("consumables/fuel/tank[6]/level-gal_us", 1666 * amount);
  setprop("consumables/fuel/tank[7]/level-gal_us", 1666 * amount);
  var dtext = "Fuel loaded!";
  screen.log.write(dtext);
} else {
    var ltext = "You have to stop at an airport to be able to onload fuel!";
    screen.log.write(ltext);
  }
}