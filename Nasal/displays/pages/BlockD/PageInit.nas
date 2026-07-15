# Block D page code. Defines PageInit, the VSD-style primary flight display page.

var PageInit = {
	name: DISPLAY_PAGES.init,
	isNew: 1,
	supportSOI: 0,
	needGroup: 1,
	svg: {
		file: "Nasal/displays/vsd_v2.svg",
		font: DISPLAY_SVG_FONT_FILE,
		keys: ["pitch_ladder", "ils_group", "gs_group", "hdg_scale"],
		clipFrame: canvas.Element.GLOBAL,
	},
	new: func {
		me.instance = {parents:[PageInit]};
		me.instance.group = nil;
		return me.instance;
	},
	setup: func {
		printDebug(me.name," on ",me.device.name," is being setup");

		me.speed = me.group.getElementById("speed");
		me.hdg = me.group.getElementById("hdg");
		me.altitude = me.group.getElementById("altitude");
		me.navMode = me.group.getElementById("nav_mode");
		me.navIdent = me.group.getElementById("nav_ident");
		me.navDist = me.group.getElementById("nav_dist");
		me.ilsDiamond = me.group.getElementById("ils_diamond");
		me.gsDiamond = me.group.getElementById("gs_diamond");
		me.navHDG = me.group.getElementById("middle_line");
		me.hdgT1 = me.group.getElementById("hdg_one");
		me.hdgT2 = me.group.getElementById("hdg_two");
		me.hdgT3 = me.group.getElementById("hdg_three");
		me.hdgT4 = me.group.getElementById("hdg_four");
		me.hdgT5 = me.group.getElementById("hdg_five");
		me.hdgT6 = me.group.getElementById("hdg_six");
		me.hdgT7 = me.group.getElementById("hdg_seven");
		me.hdgTape = me.group.getElementById("hdg_scale");
		# me.ladder = me.group.getElementById("pitch_ladder");
		me.asi = me.group.getElementById("asi");
		me.rollArrow = me.group.getElementById("roll_arrow");
		me.gsGroup = me.group.getElementById("gs_group");
		me.ilsGroup = me.group.getElementById("ils_group");
		me.gsGroup.setVisible(0);
		me.ilsGroup.setVisible(0);

		me.speed.enableUpdate();
		me.hdg.enableUpdate();
		me.altitude.enableUpdate();
		displayValues.vsd.terrainCenter = me.asi.getCenter();
		me.asiTrans = me.asi.createTransform();
		me.asiRot = me.asi.createTransform();
		me.hdgT1.enableUpdate();
		me.hdgT2.enableUpdate();
		me.hdgT3.enableUpdate();
		me.hdgT4.enableUpdate();
		me.hdgT5.enableUpdate();
		me.hdgT6.enableUpdate();
		me.hdgT7.enableUpdate();


		me.pageText = me.group.createChild("text")
			.set("z-index", zIndex.deviceObs.text)
			.setColor(0,1,0)
			.setAlignment("center-center")
			.setTranslation(displayWidthHalf, displayHeightHalf)
			.setFontSize(me.device.fontSize*3)
			.setText("");
	},
	enter: func {
		printDebug("Enter ",me.name~" on ",me.device.name);
		if (me.isNew) {
			me.setup();
			me.isNew = 0;
		}
		me.device.resetControls();
	},
	controlAction: func (controlName) {
		printDebug(me.name,": ",controlName," activated on ",me.device.name);
            if (controlName == "OSB16") {
                me.device.swap();
            }
	},
	update: func (noti = nil) {	
		# simulate minimum reading of 30kts IAS
		if (noti.getproper("ias") <= 30) {
			me.speed.updateText("0");
		}else{
			me.speed.updateText(sprintf("%03d", noti.getproper("ias")));
		}

		me.altitude.updateText(sprintf("%01d",math.round(noti.getproper("alt_ft"),10)));
		me.asiTrans.setTranslation(0,noti.getproper("pitch")*6.3);
		me.asiRot.setRotation(-noti.getproper("roll")*D2R, displayValues.vsd.terrainCenter);
		me.rollArrow.setRotation(-noti.getproper("roll")*D2R, displayValues.vsd.terrainCenter);
		me.hdg.updateText(sprintf("%03d",noti.getproper("headingMag")));

		# hdg tape code + functions adapted from Octal450's MD-11 IESI

		
		displayValues.hdg.indicatedHdg = noti.getproper("headingMag");
		displayValues.hdg.offset = displayValues.hdg.indicatedHdg / 10 - int(displayValues.hdg.indicatedHdg / 10);
		displayValues.hdg.middleText = roundAbout(displayValues.hdg.indicatedHdg / 10);
		displayValues.hdg.middleOffset = nil;

		if (displayValues.hdg.middleText == 36){
			displayValues.hdg.middleText = 0;
		}

            displayValues.hdg.l1 = displayValues.hdg.middleText == 0 ? 35 : displayValues.hdg.middleText - 1;
            displayValues.hdg.r1 = displayValues.hdg.middleText == 35 ? 0 : displayValues.hdg.middleText + 1;
            displayValues.hdg.l2 = displayValues.hdg.l1 == 0 ? 35 : displayValues.hdg.l1 - 1;
            displayValues.hdg.r2 = displayValues.hdg.r1 == 35 ? 0 : displayValues.hdg.r1 + 1;
            displayValues.hdg.l3 = displayValues.hdg.l2 == 0 ? 35 : displayValues.hdg.l2 - 1;
            displayValues.hdg.r3 = displayValues.hdg.r2 == 35 ? 0 : displayValues.hdg.r2 + 1;
		# L3 + R3 are outside the clip ares intentionally
		# This is so there is a smooth transition for heading numbers "appearing"

		if (displayValues.hdg.offset > 0.5) {
			displayValues.hdg.middleOffset = -(displayValues.hdg.offset - 1) * 45.5;
		} else {
			displayValues.hdg.middleOffset = -displayValues.hdg.offset * 45.5;
		}
		me.hdgTape.setTranslation(displayValues.hdg.middleOffset, 0);
		me.hdgT1.setText(hdgText(displayValues.hdg.l3));
		me.hdgT2.setText(hdgText(displayValues.hdg.l2));
		me.hdgT3.setText(hdgText(displayValues.hdg.l1));
		me.hdgT4.setText(hdgText(displayValues.hdg.middleText));
		me.hdgT5.setText(hdgText(displayValues.hdg.r1));
		me.hdgT6.setText(hdgText(displayValues.hdg.r2));
		me.hdgT7.setText(hdgText(displayValues.hdg.r3));
		#ILS (Also from MD-11)

		displayValues.nav.headingNeedleDeflectionNorm = noti.getproper("nav0HdgDeflectionN");
		displayValues.nav.navLoc = noti.getproper("nav0HasLoc");
		displayValues.nav.selectedMhz = noti.getproper("nav0Freq");
		displayValues.nav.signalQuality = noti.getproper("nav0SignalQuality");
		displayValues.nav.inRange = noti.getproper("nav0InRange");			
		if (displayValues.nav.selectedMhz != 0) {
			if (displayValues.nav.navLoc and displayValues.nav.signalQuality >= 0.99) {
				me.ilsDiamond.setTranslation(displayValues.nav.headingNeedleDeflectionNorm * 134, 0);
				me.ilsDiamond.show();
			} else {
				me.ilsDiamond.hide();
			}
			if (displayValues.nav.inRange) {
				me.ilsGroup.setVisible(1);
			} else {me.ilsGroup.setVisible(0);}
		} else {
			me.ilsDiamond.hide();
		}
		
		
		# ILS G/S
		displayValues.nav.gsNeedleDeflectionNorm = noti.getproper("gs0NeedleDeflectN");
		displayValues.nav.gsInRange = noti.getproper("nav0GSInRange");
		displayValues.nav.hasGs = noti.getproper("nav0HasGS");		
		if (displayValues.nav.selectedMhz != 0) {
			if (displayValues.nav.gsInRange and displayValues.nav.hasGs and displayValues.nav.signalQuality >= 0.99) {
				me.gsDiamond.setTranslation(0, displayValues.nav.gsNeedleDeflectionNorm * -106.4);
				me.gsDiamond.show();
			} else {
				me.gsDiamond.hide();
			}
			if (displayValues.nav.gsInRange) {
				me.gsGroup.setVisible(1);
			} else {me.gsGroup.setVisible(0);}
			# me.gsGroup.setVisible(1);
		} else {
			me.gsDiamond.hide();
		}
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
