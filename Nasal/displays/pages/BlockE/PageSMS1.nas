# Block E page code. Defines PageSMS1, the three-bay stores inventory page.

var PageSMS1 = {
	name: DISPLAY_PAGES.sms,
	isNew: 1,
	supportSOI: 0,
	needGroup: 1,
	new: func {
		me.instance = {parents:[PageSMS1]};
		me.instance.group = nil;
		return me.instance;
	},
	setup: func {
		printDebug(me.name," on ",me.device.name," is being setup");
		data.type_update.start();
		me.fwdGrp = me.group.createChild("group")
			.setTranslation((displayWidthHalf/2)-90,displayHeight/7);
		me.midGrp = me.group.createChild("group")
			.setTranslation(displayWidthHalf+25,displayHeight/7);
		me.aftGrp = me.group.createChild("group")
			.setTranslation(displayWidthHalf+270,displayHeight/7);

		me.fwdLabel = me.fwdGrp.createChild("text")
			.setText("Fwd Bay")
			.setTranslation(0,-50);
		me.fwd1 = me.fwdGrp.createChild("text")
			.setFontSize(font.sms.default)
			.setText("Weapon 1: EMPTY");
		me.fwd2 = me.fwdGrp.createChild("text")
			.setText("Weapon 2: EMPTY")
			.setFontSize(font.sms.default)
			.setTranslation(0,25);
		me.fwd3 = me.fwdGrp.createChild("text")
			.setText("Weapon 3: EMPTY")
			.setFontSize(font.sms.default)
			.setTranslation(0,50);
		me.fwd4 = me.fwdGrp.createChild("text")
			.setText("Weapon 4: EMPTY")
			.setFontSize(font.sms.default)
			.setTranslation(0,75);
		me.fwd5 = me.fwdGrp.createChild("text")
			.setText("Weapon 5: EMPTY")
			.setFontSize(font.sms.default)
			.setTranslation(0,100);
		me.fwd6 = me.fwdGrp.createChild("text")
			.setText("Weapon 6: EMPTY")
			.setFontSize(font.sms.default)
			.setTranslation(0,125);
		me.fwd7 = me.fwdGrp.createChild("text")
			.setText("Weapon 7: EMPTY")
			.setFontSize(font.sms.default)
			.setTranslation(0,150);
		me.fwd8 = me.fwdGrp.createChild("text")
			.setText("Weapon 8: EMPTY")
			.setFontSize(font.sms.default)
			.setTranslation(0,175);


		me.midLabel = me.midGrp.createChild("text")
			.setText("Mid Bay")
			.setTranslation(0,-50);
		me.mid1 = me.midGrp.createChild("text")
			.setFontSize(font.sms.default)
			.setText("Weapon 1: EMPTY");
		me.mid2 = me.midGrp.createChild("text")
			.setText("Weapon 2: EMPTY")
			.setFontSize(font.sms.default)
			.setTranslation(0,25);
		me.mid3 = me.midGrp.createChild("text")
			.setText("Weapon 3: EMPTY")
			.setFontSize(font.sms.default)
			.setTranslation(0,50);
		me.mid4 = me.midGrp.createChild("text")
			.setText("Weapon 4: EMPTY")
			.setFontSize(font.sms.default)
			.setTranslation(0,75);
		me.mid5 = me.midGrp.createChild("text")
			.setText("Weapon 5: EMPTY")
			.setFontSize(font.sms.default)
			.setTranslation(0,100);
		me.mid6 = me.midGrp.createChild("text")
			.setText("Weapon 6: EMPTY")
			.setFontSize(font.sms.default)
			.setTranslation(0,125);
		me.mid7 = me.midGrp.createChild("text")
			.setText("Weapon 7: EMPTY")
			.setFontSize(font.sms.default)
			.setTranslation(0,150);
		me.mid8 = me.midGrp.createChild("text")
			.setText("Weapon 8: EMPTY")
			.setFontSize(font.sms.default)
			.setTranslation(0,175);


		me.aftLabel = me.aftGrp.createChild("text")
			.setText("Aft Bay")
			.setTranslation(0,-50);
		me.aft1 = me.aftGrp.createChild("text")
			.setFontSize(font.sms.default)
			.setText("Weapon 1: EMPTY");
		me.aft2 = me.aftGrp.createChild("text")
			.setText("Weapon 2: EMPTY")
			.setFontSize(font.sms.default)
			.setTranslation(0,25);
		me.aft3 = me.aftGrp.createChild("text")
			.setText("Weapon 3: EMPTY")
			.setFontSize(font.sms.default)
			.setTranslation(0,50);
		me.aft4 = me.aftGrp.createChild("text")
			.setText("Weapon 4: EMPTY")
			.setFontSize(font.sms.default)
			.setTranslation(0,75);
		me.aft5 = me.aftGrp.createChild("text")
			.setText("Weapon 5: EMPTY")
			.setFontSize(font.sms.default)
			.setTranslation(0,100);
		me.aft6 = me.aftGrp.createChild("text")
			.setText("Weapon 6: EMPTY")
			.setFontSize(font.sms.default)
			.setTranslation(0,125);
		me.aft7 = me.aftGrp.createChild("text")
			.setText("Weapon 7: EMPTY")
			.setFontSize(font.sms.default)
			.setTranslation(0,150);
		me.aft8 = me.aftGrp.createChild("text")
			.setText("Weapon 8: EMPTY")
			.setFontSize(font.sms.default)
			.setTranslation(0,175);


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

		print("DEBUG:UPDATE RAN");

		me.fwd1.setText(sprintf("Weapon 1: %s", getprop("/ai/guided/bay0/bomb/weapon-type")));
		me.fwd2.setText(sprintf("Weapon 2: %s", getprop("/ai/guided/bay0/bomb[1]/weapon-type")));
		me.fwd3.setText(sprintf("Weapon 3: %s", getprop("/ai/guided/bay0/bomb[2]/weapon-type")));
		me.fwd4.setText(sprintf("Weapon 4: %s", getprop("/ai/guided/bay0/bomb[3]/weapon-type")));
		me.fwd5.setText(sprintf("Weapon 5: %s", getprop("/ai/guided/bay0/bomb[4]/weapon-type")));
		me.fwd6.setText(sprintf("Weapon 6: %s", getprop("/ai/guided/bay0/bomb[5]/weapon-type")));
		me.fwd7.setText(sprintf("Weapon 7: %s", getprop("/ai/guided/bay0/bomb[6]/weapon-type")));
		me.fwd8.setText(sprintf("Weapon 8: %s", getprop("/ai/guided/bay0/bomb[7]/weapon-type")));
		
	},
	exit: func {
		printDebug("Exit ",me.name~" on ",me.device.name);
		data.type_update.stop();
	},
	del: func {
		if (!me.isNew) data.type_update.stop();
	},
	links: {
		"OSB18":  DISPLAY_PAGES.menu,
	},
	layers: [],
};
