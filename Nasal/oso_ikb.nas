###change settings for sms visible on oso mfd

var ikb_path = props.globals.getNode("instrumentation/ikb/ikb_input",1);
ikb_path.setDoubleValue(0);
var coord_input = [0,1,2,3,4,5,6,7,8];
var coord_pos = 0;
setprop("instrumentation/ikb/coord_pos", coord_pos);
setprop("instrumentation/ikb/ikb_number", 0);

var tgt_input = func(n) {
  coord_pos = getprop("instrumentation/ikb/coord_pos");
  var ikb_number = getprop("instrumentation/ikb/ikb_number");
  var nr = getprop("armament/oso/number-selected");
  var bay = getprop("armament/oso/bay-selected");
  coord_input[coord_pos] = ikb_number;
  if (coord_pos == 0){
    if (ikb_number == 0){
      coord_input[coord_pos] = -1;
    } else {
        coord_input[coord_pos] = 1;
      }
  }

 #var t_input = ""~ coord_input[0] ~""~ coord_input[1] ~""~ coord_input[2] ~""~ coord_input[3] ~"."~ coord_input[4] ~""~ coord_input[5] ~""~ coord_input[6] ~""~ coord_input[7] ~""~ coord_input[8] ~"";
  var t_input = coord_input[0] * (coord_input[1] * 100 + coord_input[2] * 10 + coord_input[3] * 1 + coord_input[4] * 0.1 + coord_input[5] * 0.01 + coord_input[6] * 0.001 + coord_input[7] * 0.0001 + coord_input[8] * 0.00001);
  ikb_path.setDoubleValue(t_input);
  print(t_input);

  if(n == 1){
    setprop("ai/guided/bay"~ bay ~"/bomb["~ nr ~"]/target-latitude-deg", ikb_path.getValue());
    weapons.wpn_info[bay][nr].lat = ikb_path.getValue();
    var talt_m = geo.elevation(wpn_info[bay][nr]["lat"], wpn_info[bay][nr]["lon"]);
    if ((talt_m == "nil") or (talt_m == "")) {
      return(weapons.wpn_info[bay][nr].talt_m = -1);
    } else {
        wpn_info[bay][nr].talt_m = talt_m;
      }
    debug.dump(wpn_info[bay][nr]);
  }
  if(n == 2){
    setprop("ai/guided/bay"~ getprop("armament/oso/bay-selected") ~"/bomb["~ nr ~"]/target-longitude-deg", ikb_path.getValue());
    weapons.wpn_info[bay][nr].lon = ikb_path.getValue();
    var talt_m = geo.elevation(wpn_info[bay][nr]["lat"], wpn_info[bay][nr]["lon"]);
    if ((talt_m == "nil") or (talt_m == "")) {
      return(weapons.wpn_info[bay][nr].talt_m = -1);
    } else {
        wpn_info[bay][nr].talt_m = talt_m;
      }
    debug.dump(wpn_info[bay][nr]);
  }
}

var change_coord_pos = func(n) {
  coord_pos = getprop("instrumentation/ikb/coord_pos");
  coord_pos = coord_pos + n;
  if((coord_pos < 0) or (coord_pos > 8)){
    coord_pos = 0;
  }
  setprop("instrumentation/ikb/coord_pos", coord_pos);
}

var change_ikb_number = func(n) {
  setprop("instrumentation/ikb/ikb_number", n);
  tgt_input(0);
}