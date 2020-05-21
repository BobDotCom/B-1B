## Adapted from script shared by Warty at https://forum.flightgear.org/viewtopic.php?f=10&t=28665
## (C) pinto aka Justin Nicholson - 2016
## GPL v3

print("loading blacklist.nas...");

var view_distance = 500; # in nautical miles

var callsignsToIgnore = [
	"thegood",
	"hermano",
];

var planesToIgnore = [
];

var updateRate = 2;

var ignoreLoop = func () {
	var listMP = props.globals.getNode("ai/models/").getChildren("multiplayer");
	foreach (m; listMP) {
		var thisCallsign = m.getValue("callsign");
		var thisPlane = m.getValue("model-short");
		if ( size(callsignsToIgnore) > 0 ) {
			foreach(csToIgnore; callsignsToIgnore){
				if(thisCallsign == csToIgnore){
					setInvisible(m);
				}
			}
		}
		if ( size(planesToIgnore) > 0 ) {
			foreach(plToIgnore; planesToIgnore){
				if(thisPlane == plToIgnore){
					setInvisible(m);
				} 
			}
		}
	}
	settimer( func { ignoreLoop(); }, updateRate);
}

var setInvisible = func (m) {
	var currentlyInvisible = m.getValue("controls/invisible");
	if(!currentlyInvisible){
		var thisCallsign = m.getValue("callsign");
		multiplayer.dialog.toggle_ignore(thisCallsign);
		m.setValue("controls/invisible",1);
		screen.log.write("Automatically ignoring " ~ thisCallsign ~ ".");
	}
}

print("ignoring the following callsigns:");
if (size(callsignsToIgnore) > 0 ) {
	for ( var i = 0; i < size(callsignsToIgnore); i = i + 1 ) {
		print( callsignsToIgnore[i] );
	}
}

print("ignoring the following airplanes:");
if (size(planesToIgnore) > 0 ) {
	for ( var i = 0; i < size(planesToIgnore); i = i + 1 ) {
		print( planesToIgnore[i] );
	}
}

print("end blacklist.nas ignore list.");	


settimer( func{
	setprop("/sim/multiplay/visibility-range-nm",view_distance);
	print("set mp visibility to " ~ view_distance);
}, 15);

settimer( func { ignoreLoop(); }, 5);
