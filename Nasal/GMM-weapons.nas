#####  weapon system

###  fwd bay (loaded with 8 GBU-31 2000lb bombs)
var weapon_system = func {
#fwd_load();
}

### weapon dialog
var weapon_select = gui.Dialog.new("dialog","Aircraft/B-1B/Dialogs/weapons.xml");

var fwd_load = func {
#set initial launcher position
setprop("armament/bay-fwd/rot-launcher-pos", 0);
#set initial number of armed weapons
setprop("armament/bay-fwd/racks-armed", 0);
#set weight
setprop("sim/weight[4]/weight-lb", 16000);
#set rack status
setprop("armament/bay-fwd/rack0", 1);
setprop("armament/bay-fwd/rack1", 1);
setprop("armament/bay-fwd/rack2", 1);
setprop("armament/bay-fwd/rack3", 1);
setprop("armament/bay-fwd/rack4", 1);
setprop("armament/bay-fwd/rack5", 1);
setprop("armament/bay-fwd/rack6", 1);
setprop("armament/bay-fwd/rack7", 1);
#set armed/safe status
setprop("armament/bay-fwd/rack0-armed", 0);
setprop("armament/bay-fwd/rack1-armed", 0);
setprop("armament/bay-fwd/rack2-armed", 0);
setprop("armament/bay-fwd/rack3-armed", 0);
setprop("armament/bay-fwd/rack4-armed", 0);
setprop("armament/bay-fwd/rack5-armed", 0);
setprop("armament/bay-fwd/rack6-armed", 0);
setprop("armament/bay-fwd/rack7-armed", 0);
}

var intmd_load = func {
#set initial launcher position
setprop("armament/bay-intmd/rot-launcher-pos", 0);
#set initial number of armed weapons
setprop("armament/bay-intmd/racks-armed", 0);
#set weight
setprop("sim/weight[5]/weight-lb", 16000);
#set rack status
setprop("armament/bay-intmd/rack0", 1);
setprop("armament/bay-intmd/rack1", 1);
setprop("armament/bay-intmd/rack2", 1);
setprop("armament/bay-intmd/rack3", 1);
setprop("armament/bay-intmd/rack4", 1);
setprop("armament/bay-intmd/rack5", 1);
setprop("armament/bay-intmd/rack6", 1);
setprop("armament/bay-intmd/rack7", 1);
#set armed/safe status
setprop("armament/bay-intmd/rack0-armed", 0);
setprop("armament/bay-intmd/rack1-armed", 0);
setprop("armament/bay-intmd/rack2-armed", 0);
setprop("armament/bay-intmd/rack3-armed", 0);
setprop("armament/bay-intmd/rack4-armed", 0);
setprop("armament/bay-intmd/rack5-armed", 0);
setprop("armament/bay-intmd/rack6-armed", 0);
setprop("armament/bay-intmd/rack7-armed", 0);
#set guided status
setprop("armament/bay-intmd/rack0-guided", 1);
setprop("armament/bay-intmd/rack1-guided", 1);
setprop("armament/bay-intmd/rack2-guided", 1);
setprop("armament/bay-intmd/rack3-guided", 1);
setprop("armament/bay-intmd/rack4-guided", 1);
setprop("armament/bay-intmd/rack5-guided", 1);
setprop("armament/bay-intmd/rack6-guided", 1);
setprop("armament/bay-intmd/rack7-guided", 1);
}

var aft_load = func {
#set initial launcher position
setprop("armament/bay-aft/rot-launcher-pos", 0);
#set initial number of armed weapons
setprop("armament/bay-aft/racks-armed", 0);
#set weight
setprop("sim/weight[6]/weight-lb", 16000);
#set rack status
setprop("armament/bay-aft/rack0", 1);
setprop("armament/bay-aft/rack1", 1);
setprop("armament/bay-aft/rack2", 1);
setprop("armament/bay-aft/rack3", 1);
setprop("armament/bay-aft/rack4", 1);
setprop("armament/bay-aft/rack5", 1);
setprop("armament/bay-aft/rack6", 1);
setprop("armament/bay-aft/rack7", 1);
#set armed/safe status
setprop("armament/bay-aft/rack0-armed", 0);
setprop("armament/bay-aft/rack1-armed", 0);
setprop("armament/bay-aft/rack2-armed", 0);
setprop("armament/bay-aft/rack3-armed", 0);
setprop("armament/bay-aft/rack4-armed", 0);
setprop("armament/bay-aft/rack5-armed", 0);
setprop("armament/bay-aft/rack6-armed", 0);
setprop("armament/bay-aft/rack7-armed", 0);
}

#rotate bay launcher
var launcher_fwd_rot = func {
var o = getprop("armament/rot-launcher-selected");
var launcher_pos = getprop("armament/bay-" ~ o ~ "/rot-launcher-pos");
if (launcher_pos >= 8) {
  launcher_pos = 0;
  setprop("armament/bay-" ~ o ~ "/rot-launcher-pos", launcher_pos);
}
launcher_pos = launcher_pos + 1;
interpolate("armament/bay-" ~ o ~ "/rot-launcher-pos",launcher_pos,1);
interpolate("armament/bay-" ~ o ~ "/rot-launcher-pos-anim",launcher_pos,1);
}

#select bay
var launcher_select = func(m,n) {
setprop("armament/rot-launcher-selected", m);
setprop("armament/rot-launcher-selected-1", 0);
setprop("armament/rot-launcher-selected-2", 0);
setprop("armament/rot-launcher-selected-3", 0);
setprop("armament/rot-launcher-selected-" ~ n ~ "", 1);
}

#arm weapons and calculate number of armed weapons/bay
var arm = func(m,n) {
var o = getprop("armament/rot-launcher-selected");
var p = getprop("armament/bay-" ~ o ~ "/rack" ~ m ~ "");
if ((p == 0) or (p == nil)) {return;}
 var r_armed = getprop("armament/bay-" ~ o ~ "/racks-armed");
   if (n == 0){
   var s = -1;
   } else {
     var s = n;
     }
   var r = r_armed + s;
   if (r <= 0) {
     var r = 0;
   }
 setprop("armament/bay-" ~ o ~ "/racks-armed", r);
 setprop("armament/bay-" ~ o ~ "/rack" ~ m ~ "-armed", n);
 #set parameter for guidance
 if (n == 1) {
 setprop("armament/bay-" ~ o ~ "/door-open-required", 1);
 }
}

#launch mechanism
var auto_launcher = func {
var bay_fwd = getprop("doors/bay_fwd/position-norm");
var bay_intmd = getprop("doors/bay_intmd/position-norm");
var bay_aft = getprop("doors/bay_aft/position-norm");
var bay_fwd_open = getprop("armament/bay-fwd/door-open-required");
var bay_intmd_open = getprop("armament/bay-intmd/door-open-required");
var bay_aft_open = getprop("armament/bay-aft/door-open-required");

if ((bay_fwd_open == 1) and (bay_fwd == 1)) {
setprop("armament/sequence1", 0);
launch_fwd();
setprop("armament/bay-fwd/door-open-required",0);
} elsif ((bay_fwd_open == 1) and (bay_fwd == 0)) {
b1b.bay_fwd.open();
setprop("armament/sequence1", 0);
settimer(launch_fwd,3);
setprop("armament/bay-fwd/door-open-required",0);
}

if ((bay_intmd_open == 1) and (bay_intmd == 1)) {
  setprop("armament/sequence2", 0);
  weapons.launch_intmd();
  setprop("armament/bay-intmd/door-open-required",0);
  } elsif ((bay_intmd_open == 1) and (bay_intmd == 0)) {
    b1b.bay_intmd.open();
    setprop("armament/sequence2", 0);
    settimer(launch_intmd,3.33);
    setprop("armament/bay-intmd/door-open-required",0);
    }  elsif ((bay_intmd_open == 0) and (bay_intmd == 1)) {
      weapons.launch_intmd();
      }

if ((bay_aft_open == 1) and (bay_aft == 1)) {
setprop("armament/sequence3", 0);
launch_aft();
setprop("armament/bay-aft/door-open-required",0);
} elsif ((bay_aft_open == 1) and (bay_aft == 0)) {
b1b.bay_aft.open();
setprop("armament/sequence3", 0);
settimer(launch_aft,3.66);
setprop("armament/bay-aft/door-open-required",0);
}

#b1b.bay_fwd.open();
#b1b.bay_intmd.open();
#b1b.bay_aft.open();
#setprop("armament/sequence1", 0);
#setprop("armament/sequence2", 0);
#setprop("armament/sequence3", 0);
#settimer(launch_fwd,3);
#settimer(launch_intmd,3.33);
#settimer(launch_aft,3.66);
}

var launch_fwd = func {

var r_armed = getprop("armament/bay-fwd/racks-armed");
debug.dump(r_armed);
var l = int(getprop("armament/bay-fwd/rot-launcher-pos"));
    if (l >= 8) {
    l = 0;
    }
    setprop("armament/bay-fwd/rot-launcher-pos", l);
    setprop("armament/bay-fwd/rot-launcher-pos-anim", l);

if (r_armed >= 1) {

var l1 = getprop("armament/bay-fwd/rot-launcher-pos");
var rack_armed = getprop("armament/bay-fwd/rack" ~ l1 ~ "-armed");
var rack_guided = getprop("armament/bay-fwd/rack" ~ l1 ~ "-guided");
    #release unguided bomb
    if ((rack_armed == 1) and (rack_guided != 1)) {
    setprop("armament/bay-fwd/rack" ~ l1 ~ "", 0);
    setprop("armament/bay-fwd/rack" ~ l1 ~ "-armed", 0);
    setprop("armament/bay-fwd/rack" ~ l1 ~ "-released",1);
    setprop("armament/bay-fwd/rack" ~ l1 ~ "-released-model",1);
      var r_armed = getprop("armament/bay-fwd/racks-armed");
      var r = r_armed - 1;
      setprop("armament/bay-fwd/racks-armed",r);
    weight_adjust(4);
        l1 = l1 + 1;
    setprop("armament/bay-fwd/rot-launcher-pos", l1);
    interpolate("armament/bay-fwd/rot-launcher-pos-anim",l1,1);
    setprop("armament/bay-fwd/rot-launcher-active",1);
    settimer(launch_fwd,1.5);
    #release guided bomb
    }
    if ((rack_armed == 1) and (rack_guided == 1)) {

    setprop("armament/bay-fwd/rack" ~ l1 ~ "", 0);
    setprop("armament/bay-fwd/rack" ~ l1 ~ "-armed", 0);
    setprop("armament/bay-fwd/rack" ~ l1 ~ "-released",1);
      var r_armed = getprop("armament/bay-fwd/racks-armed");
      var r = r_armed - 1;
      setprop("armament/bay-fwd/racks-armed",r);
    weapons.launch();
    weight_adjust(4);
        l1 = l1 + 1;
    setprop("armament/bay-fwd/rot-launcher-pos", l1);
    interpolate("armament/bay-fwd/rot-launcher-pos-anim",l1,1);

    var nr_rel = getprop("ai/guided/number_for_release");
    if (nr_rel >= 1){
    settimer(launch_fwd,1.5);
    var nr_rel = nr_rel - 1;
    setprop("ai/guided/number_for_release", nr_rel);
    } else {
    setprop("ai/guided/number_for_release", 0);
    #weapon released, but let the launcher rotate, the except next launch signal
    settimer(launch_fwd_done,1.5);
    }
    
    }

    } else {
      setprop("armament/bay-fwd/rot-launcher-active",0);
      }
}
var launch_fwd_done = func {
setprop("armament/bay-fwd/rot-launcher-active",0);
}


var launch_intmd = func {

var r_armed = getprop("armament/bay-intmd/racks-armed");
#debug.dump(r_armed);
var l = int(getprop("armament/bay-intmd/rot-launcher-pos"));
    if (l >= 8) {
    l = 0;
    }
    setprop("armament/bay-intmd/rot-launcher-pos", l);
    setprop("armament/bay-intmd/rot-launcher-pos-anim", l);

if (r_armed >= 1) {

var l2 = getprop("armament/bay-intmd/rot-launcher-pos");
var rack_armed = getprop("armament/bay-intmd/rack" ~ l2 ~ "-armed");
var rack_guided = getprop("armament/bay-intmd/rack" ~ l2 ~ "-guided");

    #release unguided bomb
    if ((rack_armed == 1) and (rack_guided != 1)) {
    setprop("armament/bay-intmd/rack" ~ l2 ~ "", 0);
    setprop("armament/bay-intmd/rack" ~ l2 ~ "-armed", 0);
    setprop("armament/bay-intmd/rack" ~ l2 ~ "-released",1);
    setprop("armament/bay-intmd/rack" ~ l2 ~ "-released-model",1);
      var r_armed = getprop("armament/bay-intmd/racks-armed");
      var r = r_armed - 1;
      setprop("armament/bay-intmd/racks-armed",r);
    weight_adjust(5);
        l2 = l2 + 1;
    setprop("armament/bay-intmd/rot-launcher-pos", l2);
    interpolate("armament/bay-intmd/rot-launcher-pos-anim",l2,1);
    setprop("armament/bay-intmd/rot-launcher-active",1);
    settimer(launch_intmd,1.5);

    #release guided bomb
    }
    if ((rack_armed == 1) and (rack_guided == 1)) {

    setprop("armament/bay-intmd/rack" ~ l2 ~ "", 0);
    setprop("armament/bay-intmd/rack" ~ l2 ~ "-armed", 0);
    setprop("armament/bay-intmd/rack" ~ l2 ~ "-released",1);
      var r_armed = getprop("armament/bay-intmd/racks-armed");
      var r = r_armed - 1;
      setprop("armament/bay-intmd/racks-armed",r);
    weapons.launch();
    weight_adjust(5);
        l2 = l2 + 1;
    setprop("armament/bay-intmd/rot-launcher-pos", l2);
    interpolate("armament/bay-intmd/rot-launcher-pos-anim",l2,1);

    var nr_rel = getprop("ai/guided/number_for_release");
print("forrelease" ~ nr_rel ~ "");
#debug.dump(nr_rel);
    if (nr_rel >= 1){
    #settimer(launch_intmd,1.5);
    var nr_rel = nr_rel - 1;
    setprop("ai/guided/number_for_release", nr_rel);
    settimer(launch_intmd_done,1.5);
    } else {
    setprop("ai/guided/number_for_release", 0);
    #weapon released, but let the launcher rotate, then accept next launch signal
    settimer(launch_intmd_done,1.5);
    }
    
    }

    } else {
      setprop("armament/bay-intmd/rot-launcher-active",0);
      }
}
var launch_intmd_done = func {
setprop("armament/bay-intmd/rot-launcher-active",0);
print("launcher_stopped");
}


var launch_aft = func {
var n = getprop("armament/sequence3");
var l = int(getprop("armament/bay-aft/rot-launcher-pos"));
    if (l >= 8) {
    l = 0;
    }
    setprop("armament/bay-aft/rot-launcher-pos", l);
    setprop("armament/bay-aft/rot-launcher-pos-anim", l);

if (n <= 7) {

var l3 = getprop("armament/bay-aft/rot-launcher-pos");
var rack_armed = getprop("armament/bay-aft/rack" ~ l3 ~ "-armed");
    if (rack_armed == 1) {
    setprop("armament/bay-aft/rack" ~ l3 ~ "", 0);
    setprop("armament/bay-aft/rack" ~ l3 ~ "-armed", 0);
    setprop("armament/bay-aft/rack" ~ l3 ~ "-released",1);
    setprop("armament/bay-aft/rack" ~ l3 ~ "-released-model",1);
    weight_adjust(6);
    }
    n = n + 1;
    l3 = l3 + 1;
    setprop("armament/sequence3", n);
    setprop("armament/bay-aft/rot-launcher-pos", l3);
    interpolate("armament/bay-aft/rot-launcher-pos-anim",l3,1);
    settimer(launch_aft,1.5);
  }
}

var launch_aft = func {

#var n = getprop("armament/sequence2");
var r_armed = getprop("armament/bay-aft/racks-armed");
debug.dump(r_armed);
var l = int(getprop("armament/bay-aft/rot-launcher-pos"));
    if (l >= 8) {
    l = 0;
    }
    setprop("armament/bay-aft/rot-launcher-pos", l);
    setprop("armament/bay-aft/rot-launcher-pos-anim", l);

if (r_armed >= 1) {

var l3 = getprop("armament/bay-aft/rot-launcher-pos");
var rack_armed = getprop("armament/bay-aft/rack" ~ l3 ~ "-armed");
var rack_guided = getprop("armament/bay-aft/rack" ~ l3 ~ "-guided");
    #release unguided bomb
    if ((rack_armed == 1) and (rack_guided != 1)) {
    setprop("armament/bay-aft/rack" ~ l3 ~ "", 0);
    setprop("armament/bay-aft/rack" ~ l3 ~ "-armed", 0);
    setprop("armament/bay-aft/rack" ~ l3 ~ "-released",1);
    setprop("armament/bay-aft/rack" ~ l3 ~ "-released-model",1);
      var r_armed = getprop("armament/bay-aft/racks-armed");
      var r = r_armed - 1;
      setprop("armament/bay-aft/racks-armed",r);
    weight_adjust(5);
        l3 = l3 + 1;
    setprop("armament/bay-aft/rot-launcher-pos", l3);
    interpolate("armament/bay-aft/rot-launcher-pos-anim",l3,1);
    setprop("armament/bay-aft/rot-launcher-active",1);
    settimer(launch_aft,1.5);
    #release guided bomb
    }
    if ((rack_armed == 1) and (rack_guided == 1)) {

    setprop("armament/bay-aft/rack" ~ l3 ~ "", 0);
    setprop("armament/bay-aft/rack" ~ l3 ~ "-armed", 0);
    setprop("armament/bay-aft/rack" ~ l3 ~ "-released",1);
      var r_armed = getprop("armament/bay-aft/racks-armed");
      var r = r_armed - 1;
      setprop("armament/bay-aft/racks-armed",r);
    weapons.launch();
    weight_adjust(5);
        l3 = l3 + 1;
    setprop("armament/bay-aft/rot-launcher-pos", l3);
    interpolate("armament/bay-aft/rot-launcher-pos-anim",l3,1);

    var nr_rel = getprop("ai/guided/number_for_release");
    if (nr_rel >= 1){
    settimer(launch_aft,1.5);
    var nr_rel = nr_rel - 1;
    setprop("ai/guided/number_for_release", nr_rel);
    } else {
    setprop("ai/guided/number_for_release", 0);
    #weapon released, but let the launcher rotate, the except next launch signal
    settimer(launch_aft_done,1.5);
    }
    
    }

    } else {
      setprop("armament/bay-aft/rot-launcher-active",0);
      }
}
var launch_aft_done = func {
setprop("armament/bay-aft/rot-launcher-active",0);
}


# subtract weight of released bombs from bomb bays
var weight_adjust = func(n) {
var weight_bay = getprop("sim/weight[" ~ n ~ "]/weight-lb");
if (weight_bay >= 2000) {
  var weight_bay_new = weight_bay - 2000;
  setprop("sim/weight[" ~ n ~ "]/weight-lb", weight_bay_new);
}
}

## Add listener for bomb impact (from vulcan b2)
setlistener("ai/models/model-impact", func(n) {
    var impact = n.getValue();
    var solid = getprop(impact ~ "/material/solid");

    if (solid){
      var long = getprop(impact ~ "/impact/longitude-deg");
      var lat = getprop(impact ~ "/impact/latitude-deg");

#      geo.put_model("Aircraft/B-1B/Models/Nuke/crater.ac",lat, long);
      geo.put_model("Aircraft/B-1B/Models/Marshmallow/marshmallow-man.xml",lat, long);
    }
});

# adjust sniper pod
var sniper_pod = func(n) {
var pod_pos = getprop("armament/sniper-pod/position-norm");
  if ((pod_pos <= 4) and (n == 1)) {
    var pod_pos_new = pod_pos + n;
    interpolate("armament/sniper-pod/position-norm",pod_pos_new,1);
  }
  if ((pod_pos >= 1) and (n == -1)) {
    var pod_pos_new = pod_pos + n;
    interpolate("armament/sniper-pod/position-norm",pod_pos_new,1);
  }
# to reset
  if ((pod_pos >= 0.01) and (pod_pos <= 0.99)) {
    interpolate("armament/sniper-pod/position-norm",0,1);
  }
}

var wave_3sec = func {
var status = getprop("sim/wave/status");
if (status != 1){
status = 0;
setprop("sim/wave/status",0);
}
if (status == 0){
setprop("sim/wave/status_1",2);
interpolate("sim/wave/status_1",1,10);
var n = getprop("sim/wave/status_1");
interpolate("sim/wave/status",n,10);#3 is the time in sec

} elsif (status == 1){
setprop("sim/wave/status_2",-1);
interpolate("sim/wave/status_2",0,10);
var n = getprop("sim/wave/status_2");
interpolate("sim/wave/status",n,10);#3 is the time in sec

}
settimer(wave_3sec,10.1)
}