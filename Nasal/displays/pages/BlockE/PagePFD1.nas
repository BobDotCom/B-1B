# Block E page code. Defines PagePFD1, the primary flight display page.

var PagePFD1 = {
	name: DISPLAY_PAGES.pfd,
	isNew: 1,
	supportSOI: 0,
	showFrame: 0,
	needGroup: 1,
	svg: {
		file: "Nasal/displays/PFD1.svg",
		font: DISPLAY_SVG_FONT_FILE,
		keys: [
			"altimeterPressure", "airspeed", "altitude-1k", "altitude",
			"taltitude-1k", "taltitude", "asi", "roll_pointer", "gravity",
			"hdg", "mach", "tmach", "ladder", "ground", "horizon", "tspeed",
			"fpm-indicator", "gforce", "speed", "hsi-hdg", "hsi-crs",
			"target-hdg", "target-crs",
		],
		clipFrame: canvas.Element.PARENT,
	},
	new: func {
		me.instance = {parents:[PagePFD1]};
		me.instance.group = nil;
		return me.instance;
	},
	setup: func {
		printDebug(me.name," on ",me.device.name," is being setup");

			me["gforce"].set("clip", "rect(117px, 156px, 396px, 0px)");
			me["speed"].set("clip", "rect(117px, 156px, 396px, 0px)");

            me.machFunc = func (mach) {
                if (substr(mach, 0, 1) == "0") {
                    return substr(mach, 1);
                }
                return mach;
            }

			# HSI
			me["hsi-hdg"].set("font", DISPLAY_FONT_FILE);
			me["hsi-crs"].set("font", DISPLAY_FONT_FILE);
			me["target-hdg"].set("font", DISPLAY_FONT_FILE);
			me["target-crs"].set("font", DISPLAY_FONT_FILE);




            # Enable text updates (updateText is more efficient than setText, but needs initialization)
            me["altimeterPressure"].enableUpdate();
            me["airspeed"].enableUpdate();
            me["altitude-1k"].enableUpdate();
            me["altitude"].enableUpdate();
            me["taltitude-1k"].enableUpdate();
            me["taltitude"].enableUpdate();
            me["gravity"].enableUpdate();
            me["hdg"].enableUpdate();
            me["mach"].enableUpdate();
            me["tmach"].enableUpdate();
            me["tspeed"].enableUpdate();
			me["target-hdg"].enableUpdate();
			me["target-crs"].enableUpdate();
	},
	enter: func {
		printDebug("Enter ",me.name~" on ",me.device.name);
		if (me.isNew) {
			me.setup();
			me.isNew = 0;
		}
		me.device.resetControls();
		me.device.controls["OSB18"].setControlText("MENU");

	},
	controlAction: func (controlName) {
		printDebug(me.name,": ",controlName," activated on ",me.device.name);
	},
	update: func (noti = nil) {
	    me["altimeterPressure"].updateText(sprintf("%.2f", noti.getproper("inhg")));
	    me["airspeed"].updateText(sprintf("%d", noti.getproper("ias")));
	    me["altitude-1k"].updateText(sprintf("%d", noti.getproper("alt_ft") / 1000)); # XXxxx
	    #me.altitude.setText(sprintf("%03d", math.fmod(noti.getproper("alt_ft"), 1000)));  # xxXXX
	    me["altitude"].updateText(sprintf("%02d0", math.fmod(noti.getproper("alt_ft"), 1000) / 10));  # xxXX0
	    me["taltitude-1k"].updateText(sprintf("%d", noti.getproper("targetAltitude") / 1000)); # XXxxx
	    me["taltitude"].updateText(sprintf("%02d0", math.fmod(noti.getproper("targetAltitude"), 1000) / 10));  # xxXX0
            me["gravity"].updateText(sprintf("%.1f", noti.getproper("Nz")));
            me["hdg"].updateText(sprintf("%03d", noti.getproper("headingMag")));

            # If <1 we want to hide the leading 0, but sprintf doesn't support that directly
            me["mach"].updateText(me.machFunc(sprintf("%.2f/", noti.getproper("mach"))));
            me["tmach"].updateText(me.machFunc(sprintf("%.2f", noti.getproper("targetMach"))));

            # ASI is about 116px per 10deg of pitch
	    #me.asi.setTranslation(0, noti.getproper("pitch")*11.6);
	    me["ladder"].setTranslation(0, noti.getproper("pitch")*11.6);
            me["ground"].setTranslation(0, noti.getproper("pitch")*11.6);
            me["horizon"].setTranslation(0, noti.getproper("pitch")*11.6);
	    #me.asiTicks.setTranslation(0, noti.getproper("pitch")*11.6);
	    #me.asi.setCenter(0, noti.getproper("pitch")*11.6);
	    me["asi"].setRotation(-noti.getproper("roll")*D2R);
	    #me.roll_pointer.setRotation(-noti.getproper("roll")*D2R);
	    me["roll_pointer"].setRotation(-math.clamp(noti.getproper("roll"), -45, 45)*D2R);
	    #print(me.roll_pointer.getCenter());
	    me["tspeed"].updateText(sprintf("%d", noti.getproper("targetSpeed")));

            me["fpm-indicator"].setTranslation(0, -math.clamp(math.clamp((noti.getproper("vFps")*60), -1000, 1000) + (noti.getproper("vFps")*60), -4000, 4000) / 1000 * 35);
            me["gforce"].setTranslation(0, (noti.getproper("Nz")-1)*29);
            me["speed"].setTranslation(0, (noti.getproper("ias")-50)/20*28);

	    # HSI
	    # me["target-hdg"].updateText(sprintf("%03d", noti.getproper("APHeadingBug")));
	},
	exit: func {
		printDebug("Exit ",me.name~" on ",me.device.name);
	},
	links: {
		"OSB18": DISPLAY_PAGES.menu,
	},
	layers: [],
};
