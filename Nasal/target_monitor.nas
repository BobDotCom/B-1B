# target_monitor.xml updating.

UPDATE_PERIOD = 0.25;
#print("target monitor updated");

var update_target_monitor = func () {
	#print("in func");
	var n = getprop("armament/oso/bay-selected");
	var distance = 0;
	var bearing = 0;
	
	if (n == nil) { n = 0 };
	
	for (var i = 0; i < 8; i += 1) {
		if ( getprop("ai/guided/bay" ~ n ~ "/bomb[" ~ i ~ "]/target-distance") == nil ) {
			distance = 0;
		} else {
			distance = getprop("ai/guided/bay" ~ n ~ "/bomb[" ~ i ~ "]/target-distance");
		}
		if ( getprop("ai/guided/bay" ~ n ~ "/bomb[" ~ i ~ "]/target-bearing") == nil ) {
			bearing = 0;
		} else {
			bearing = getprop("ai/guided/bay" ~ n ~ "/bomb[" ~ i ~ "]/target-bearing");
		}
	  setprop("ai/guided/targetting/bomb[" ~ i ~ "]/target-distance", distance);
	  setprop("ai/guided/targetting/bomb[" ~ i ~ "]/target-bearing", bearing);
	}
}
	
var loop = func {
	call(update_target_monitor, [] );
	settimer(loop, UPDATE_PERIOD, 1);
}

loop();