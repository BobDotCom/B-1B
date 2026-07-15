# Block E page code. Defines PageTMenu, the top-level B-1B display page menu.

var PageTMenu = {
	name: DISPLAY_PAGES.menu,
	isNew: 1,
	supportSOI: 1,
	soiPrio: 1,
	showFrame: 1,
	needGroup: 0,
	new: func {
		me.instance = {parents:[PageTMenu]};
		me.instance.group = nil;
		return me.instance;
	},
	setup: func {
		printDebug(me.name," on ",me.device.name," is being setup");
	},
	enter: func {
		printDebug("Enter ",me.name~" on ",me.device.name);
		if (me.isNew) {
			me.setup();
			me.isNew = 0;
		}
		me.device.resetControls();
		me.device.controls["OSB1"].setControlText("PFD",1,0,1,0);
		me.device.controls["OSB2"].setControlText("SMS",1,0,1,0);
		me.device.controls["OSB28"].setControlText("BLANK")

	},
	controlAction: func (controlName) {
		printDebug(me.name,": ",controlName," activated on ",me.device.name);
	},
	update: func (noti = nil) {
		
	},
	exit: func {
		printDebug("Exit ",me.name~" on ",me.device.name);
	},
	links: {
		"OSB1":  DISPLAY_PAGES.pfd,
		# "OSB2":  DISPLAY_PAGES.sms,
		"OSB28": DISPLAY_PAGES.blank,
	},
	layers: [],
};
