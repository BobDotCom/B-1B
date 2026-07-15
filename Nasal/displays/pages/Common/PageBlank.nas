# Shared Block D/Block E page code. Defines PageBlank, the B-1B display OFF page.

var PageBlank = {
	name: DISPLAY_PAGES.blank,
	isNew: 1,
	supportSOI: 0,
	needGroup: 1,
	new: func {
		me.instance = {parents:[PageBlank]};
		me.instance.group = nil;
		return me.instance;
	},
	setup: func {
		printDebug(me.name," on ",me.device.name," is being setup");
		me.pageText = me.group.createChild("text")
			.set("z-index", zIndex.deviceObs.text)
			.setColor(colorText1)
			.setAlignment("center-center")
			.setTranslation(displayWidthHalf, displayHeightHalf)
			.setFontSize(me.device.fontSize*3)
			.setText("OFF");
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
            if (controlName == "OSB16") {
                me.device.swap();
            }
	},
	update: func (noti = nil) {			
	},
	exit: func {
		printDebug("Exit ",me.name~" on ",me.device.name);
	},
	links: {
		"OSB17": DISPLAY_PAGES.blank,
		"OSB18": DISPLAY_PAGES.menu,
	},
	layers: [],
};
