#####  engine and apu fire animation loop

var fire_loop = func {
var eng1_fire = getprop("controls/engines/engine[0]/on-fire");
var eng2_fire = getprop("controls/engines/engine[1]/on-fire");
var eng3_fire = getprop("controls/engines/engine[2]/on-fire");
var eng4_fire = getprop("controls/engines/engine[3]/on-fire");
var apul_fire = getprop("controls/APU/APUL-fire");
var apur_fire = getprop("controls/APU/APUR-fire");

if (eng1_fire == 1) {
#print ("engine 1 fire");
var eng1_disc = getprop("controls/engines/engine[0]/fire-bottle-discharge");
  if (eng1_disc == 1) {
    setprop("controls/engines/engine[0]/cutoff", 1);
    settimer(eng1_ext, 15);
  }
}
if (eng2_fire == 1) {
#print ("engine 2 fire");
var eng2_disc = getprop("controls/engines/engine[1]/fire-bottle-discharge");
  if (eng2_disc == 1) {
    setprop("controls/engines/engine[1]/cutoff", 1);
    settimer(eng2_ext, 15);
  }
}
if (eng3_fire == 1) {
#print ("engine 3 fire");
var eng3_disc = getprop("controls/engines/engine[2]/fire-bottle-discharge");
  if (eng3_disc == 1) {
    setprop("controls/engines/engine[2]/cutoff", 1);
    settimer(eng3_ext, 15);
  }
}
if (eng4_fire == 1) {
#print ("engine 4 fire");
var eng4_disc = getprop("controls/engines/engine[3]/fire-bottle-discharge");
  if (eng4_disc == 1) {
    setprop("controls/engines/engine[3]/cutoff", 1);
    settimer(eng4_ext, 15);
  }
}

if (apul_fire == 1) {
#print ("apul fire");
var apul_disc = getprop("controls/APU/APUL-fire-bottle-discharge");
  if (apul_disc == 1) {
    settimer(apul_ext, 15);
  }
}
if (apur_fire == 1) {
#print ("apur fire");
var apur_disc = getprop("controls/APU/APUR-fire-bottle-discharge");
  if (apur_disc == 1) {
    settimer(apur_ext, 15);
  }
}

### check if engine was damaged and prevent starting
if (getprop("controls/engines/engine[0]/damaged", 1) == 1) {
setprop("controls/engines/engine[0]/cutoff", 1);
}
if (getprop("controls/engines/engine[1]/damaged", 1) == 1) {
setprop("controls/engines/engine[1]/cutoff", 1);
}
if (getprop("controls/engines/engine[2]/damaged", 1) == 1) {
setprop("controls/engines/engine[2]/cutoff", 1);
}
if (getprop("controls/engines/engine[3]/damaged", 1) == 1) {
setprop("controls/engines/engine[3]/cutoff", 1);
}
if (getprop("controls/APU/APUL-damaged", 1) == 1) {
setprop("controls/APU/APUL_running", 0);
}
if (getprop("controls/APU/APUR-damaged", 1) == 1) {
setprop("controls/APU/APUR_running", 0);
}

settimer(fire_loop, 3);
}

### extinguish fire and mark engine damaged
var eng1_ext = func {
setprop("controls/engines/engine[0]/damaged", 1);
setprop("controls/engines/engine[0]/on-fire", 0);
}

var eng2_ext = func {
setprop("controls/engines/engine[1]/damaged", 1);
setprop("controls/engines/engine[1]/on-fire", 0);
}

var eng3_ext = func {
setprop("controls/engines/engine[2]/damaged", 1);
setprop("controls/engines/engine[2]/on-fire", 0);
}

var eng4_ext = func {
setprop("controls/engines/engine[3]/damaged", 1);
setprop("controls/engines/engine[3]/on-fire", 0);
}

var apul_ext = func {
setprop("controls/APU/APUL-damaged", 1);
setprop("controls/APU/APUL-fire", 0);
}
var apur_ext = func {
setprop("controls/APU/APUR-damaged", 1);
setprop("controls/APU/APUR-fire", 0);
}