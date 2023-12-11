##### Radar properties for display of multiplayer aircraft
##### Sorts aircraft (ai,multiplayer,tanker,carrier) due to distance

### calculates the correct mp distance for radar display
#var 10 = 0.0080;
#var 20 = 0.0040;
#var 40 = 0.0020;
#var 80 = 0.0010;
#var 160 = 0.0005;
#var 320 = 0.00025;
#var 640 = 0.000125;

var Mp = props.globals.getNode("ai/models");
var mp_list = [];
var tgts_list = [];
var tgts_dist = [];
var tgts_ind = [];

var tgt_info = func(){
  #var our_ac_name = getprop("sim/aircraft");
  #var my_radardist = radar.my_maxrange( our_ac_name ) / 1.852; # in kilometers ->* to nm
  #debug.dump(my_radardist);
  tgts_list = [];
  tgts_dist = {};
  tgts_ind = [];
  var raw_list = Mp.getChildren();
  foreach( var c; raw_list ) {
    #debug.dump(c);
    var type = c.getName();
    var index = c.getIndex();

    if (type == "aircraft" or type == "multiplayer" or type == "tanker" or type == "carrier"){
      var radar_av = c.getNode("radar"); 
      if (radar_av != nil or ""){
        var radar_range = c.getNode("radar/range-nm", 1).getValue();
        var in_range = c.getNode("radar/in-range", 1).getValue();
        var range_radar = getprop("instrumentation/radar/range[0]");
        if(radar_range != nil and radar_range > 0 and range_radar > radar_range and in_range == 1){
          append(tgts_list, c);
          #var tc = typeof(c);
          #print(tc);
          var c_name = type ~ "[" ~ index ~ "]";
          #print(c_name);
          tgts_dist[radar_range] = c_name;
          append(tgts_ind, radar_range);
        }

 }

    }
  }

  #debug.dump(tgts_dist);
  #debug.dump(tgts_ind);
  var tgt_ind_sort = sort_array(tgts_ind);
  #debug.dump(tgt_ind_sort);
  mp_list = [];
  for (var i = 0; i < size(tgt_ind_sort); i += 1){
    var tgt_close = tgts_dist[tgt_ind_sort[i]];
    tgt_close = "ai/models/" ~ tgt_close;
    append(mp_list, tgt_close);
  }
  #debug.dump(mp_list);
  
  settimer(tgt_info,3);
  show_radar();
}

#sorting array in ascending order, pass array
var sort_array = func(n){
  var Ta = n;
  var ttemp = 0;
  var tgt_size = size(tgts_ind);
  for (var i = 1; i < tgt_size; i += 1) {
    var k = 0;
    for (var j = i; j > 0; j -= 1) {
      k = j - 1;
      if (Ta[k] > Ta[j]){
        ttemp = Ta[j];
        Ta[j] = Ta[k];
        Ta[k] = ttemp;

      }
    }
  }
  return(Ta);
}

var show_radar = func(){
  var r_init = getprop("controls/switches/radar_init");
  if (r_init == 1) {
    
    #foreach( var c; mp_list ) {
    for (var i = 0; i < size(mp_list); i += 1){
      var c = props.globals.getNode(mp_list[i]);
      #print(mp_list[i]);
      var in_range = c.getNode("radar/in-range", 1).getValue();
      setprop("instrumentation/radar/targets/target["~ i ~"]/in-range", in_range);
      var radar_range = c.getNode("radar/range-nm", 1).getValue();
      setprop("instrumentation/radar/targets/target["~ i ~"]/range-nm", radar_range);
      var radar_bearing = c.getNode("radar/bearing-deg", 1).getValue();
      setprop("instrumentation/radar/targets/target["~ i ~"]/bearing-deg", radar_bearing);
      var radar_heading = c.getNode("orientation/true-heading-deg", 1).getValue();
      setprop("instrumentation/radar/targets/target["~ i ~"]/true-heading-deg", radar_heading);
      # calc draw distance
      var range_radar = getprop("instrumentation/radar/range[0]");
      var factor_range_radar = 0.08 / range_radar;
      var draw_radar = factor_range_radar * radar_range;
      setprop("instrumentation/radar/targets/target["~ i ~"]/draw-range-nm", draw_radar);
      
    }

  }
}


var mplayer = func {
  var r_init = getprop("controls/switches/radar_init");

 if (r_init == 1) {
  #print("init2");
    var i = getprop("controls/switches/radar_i");
    var range_mp = getprop("ai/models/multiplayer[" ~ i ~ "]/distance-to-nm[0]");
    var range_radar = getprop("instrumentation/radar/range[0]");
      if (range_mp == nil) {
        range_mp = 0;
        #setprop("ai/models/multiplayer[" ~ i ~ "]/radar/in-range", 0);
      }
    var factor_range_radar = 0.08 / range_radar;
    var draw_radar = factor_range_radar * range_mp;
    setprop("ai/models/multiplayer[" ~ i ~ "]/radar/draw-range-nm[0]", draw_radar);

      ###calculates the relative altitude compared to the user
      var mp_alt = getprop("ai/models/multiplayer[" ~ i ~ "]/position/altitude-ft");
      var my_alt = getprop("position/altitude-ft");
       if (mp_alt == nil) {
         mp_alt = 0;
         }
      var rel_alt_mp = mp_alt - my_alt;
      setprop("ai/models/multiplayer[" ~ i ~ "]/position/rel-altitude-ft", rel_alt_mp);
      i = i + 1;
      if (i == 13) {
        i = 0;
      }
    setprop("controls/switches/radar_i", i);
  }
  settimer(mplayer, 0.5);
}

setlistener("/sim/signals/fdm-initialized", func {
  setprop("controls/switches/radar_init", 1);
  setprop("controls/switches/radar_i", 0);
  #radar.mplayer();
  tgt_info();
});
