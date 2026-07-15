# Shared Block D/Block E page code. Defines PageOSB for assigning a page to a display control.

var PageOSB = {
	name: DISPLAY_PAGES.osb,
	isNew: 1,
	supportSOI: 0,
	showFrame: 0,
	needGroup: 1,
	new: func {
		me.instance = {parents:[PageOSB]};
		me.instance.group = nil;
		return me.instance;
	},
	setup: func {
		printDebug(me.name," on ",me.device.name," is being setup");
		me.pageText = me.group.createChild("text")
			.set("z-index", zIndex.deviceObs.text)
			.setColor(colorText1)
			.setAlignment("center-center")
			.setTranslation(displayWidthHalf, displayHeight*0.30)
			.setFontSize(me.device.fontSize)
			.setText("Select desired OSB");
	},
	enter: func {
		printDebug("Enter ",me.name~" on ",me.device.name);
		if (me.isNew) {
			me.setup();
			me.isNew = 0;
		}
		me.device.resetControls();
		me.device.controls["OSB10"].setControlText("FCR");
		me.device.controls["OSB11"].setControlText("WPN");
		me.device.controls["OSB12"].setControlText("SMS");
		me.device.controls["OSB13"].setControlText("HSD");
		me.device.controls["OSB14"].setControlText("DTE");
		me.device.controls["OSB15"].setControlText("HAS");
		me.device.controls["OSB16"].setControlText("FCR\nMODE");
		me.device.controls["OSB17"].setControlText("MENU");
		me.device.controls["OSB19"].setControlText("CANCEL");
	},
	controlAction: func (controlName) {
		printDebug(me.name,": ",controlName," activated on ",me.device.name);
		if (controlName == "OSB19") {
			me.device.system.selectPage(me.device.system.osbSelect[1].name);
		} elsif (controlName == "OSB10") {
				me.device.system.osbSelect[1].links[me.device.system.osbSelect[0]] = DISPLAY_OSB_ASSIGNMENT_PAGES.fcr;
                me.device.system.selectPage(me.device.system.osbSelect[1].name);
            } elsif (controlName == "OSB11") {
				me.device.system.osbSelect[1].links[me.device.system.osbSelect[0]] = DISPLAY_OSB_ASSIGNMENT_PAGES.weapons;
                me.device.system.selectPage(me.device.system.osbSelect[1].name);
            } elsif (controlName == "OSB12") {
				me.device.system.osbSelect[1].links[me.device.system.osbSelect[0]] = DISPLAY_OSB_ASSIGNMENT_PAGES.stores;
                me.device.system.selectPage(me.device.system.osbSelect[1].name);
            } elsif (controlName == "OSB13") {
				me.device.system.osbSelect[1].links[me.device.system.osbSelect[0]] = DISPLAY_OSB_ASSIGNMENT_PAGES.hsd;
                me.device.system.selectPage(me.device.system.osbSelect[1].name);
            } elsif (controlName == "OSB14") {
				me.device.system.osbSelect[1].links[me.device.system.osbSelect[0]] = DISPLAY_OSB_ASSIGNMENT_PAGES.dte;
                me.device.system.selectPage(me.device.system.osbSelect[1].name);
            } elsif (controlName == "OSB15") {
				me.device.system.osbSelect[1].links[me.device.system.osbSelect[0]] = DISPLAY_OSB_ASSIGNMENT_PAGES.has;
                me.device.system.selectPage(me.device.system.osbSelect[1].name);
            } elsif (controlName == "OSB16") {
				me.device.system.osbSelect[1].links[me.device.system.osbSelect[0]] = DISPLAY_OSB_ASSIGNMENT_PAGES.fcrMode;
                me.device.system.selectPage(me.device.system.osbSelect[1].name);
            } elsif (controlName == "OSB17") {
                me.device.system.osbSelect[1].links[me.device.system.osbSelect[0]] = DISPLAY_PAGES.menu;
                me.device.system.selectPage(me.device.system.osbSelect[1].name);
            }
	},
	update: func (noti = nil) {			
	},
	exit: func {
		printDebug("Exit ",me.name~" on ",me.device.name);
	},
	links: {
	},
	layers: [],
};
